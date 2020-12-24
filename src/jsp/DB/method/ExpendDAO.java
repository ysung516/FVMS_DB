package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;

import jsp.Bean.model.*;

public class ExpendDAO {
	
	// 년도별 팀 이름 변경
	public ArrayList<String> getTeamName(int year){
		ArrayList<String> list = new ArrayList<String>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Date nowDate = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy");
		int nowYear = Integer.parseInt(sf.format(nowDate));
		
		try {
			StringBuffer query = new StringBuffer();
	    	query.append("SELECT a.팀 FROM member as a, team as d "
					+ "WHERE a.year ="+ nowYear +" "+ " AND a.팀 = " + "(SELECT d.* FROM d.teamName WHERE d.year = a.year)"
					+ "ORDER BY d.teamNum, FIELD(a.소속, '슈어소프트테크') DESC, a.소속, c.num, b.rank_id, a.입사일");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setInt(1, year);
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		list.add(rs.getString("teamName"));
	    	}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return list;
	}
	
	// 팀 데이터 가져오기
		public ArrayList<String> getTeamData(String year){
			ArrayList<String> list = new ArrayList<String>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				StringBuffer query = new StringBuffer();
		    	query.append("select * from team where year = ? order by teamNum");
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	pstmt.setString(1, year);
		    	rs = pstmt.executeQuery();
		    	
		    	while(rs.next()) {
		    		list.add(rs.getString("teamName"));
		    	}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
			return list;
		}
		
		// 슈어 인력 인건비 계산
		public ArrayList<Expend_TeamBean> getExpend_sure(String team, String year){
			ArrayList<Expend_TeamBean> list = new ArrayList<Expend_TeamBean>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String DF_end = year+"-12-31"; 
			
			
			try {
				StringBuffer query = new StringBuffer();
		    	query.append("SELECT member.id, member.팀, member.이름, member.소속, rank_period.rank, rank_period.start, rank_period.end, rank.expend_sure "
		    			+ "from member, rank_period, rank "
		    			+ "where rank_period.rank = rank.rank and member.id = rank_period.id and member.소속 = '슈어소프트테크' and member.팀 = ?");
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	pstmt.setString(1, team);
		    	rs = pstmt.executeQuery();
		    	while(rs.next()) {
		    		
		    		Expend_TeamBean exTeam = new Expend_TeamBean();
		    		exTeam.setId(rs.getString("id"));
		    		exTeam.setName(rs.getString("이름"));
		    		exTeam.setTeam(rs.getString("팀"));
		    		exTeam.setPart(rs.getString("소속"));
		    		exTeam.setRank(rs.getString("rank"));
		    		exTeam.setExpend(rs.getInt("expend_sure"));
		    		exTeam.setStart(rs.getString("start"));
		    		if(rs.getString("end").equals("now")) {
		    			exTeam.setEnd(DF_end);
		    		} else {
		    			exTeam.setEnd(rs.getString("end"));
		    		}
		    		
		    		float [] result = cal_manmoth(exTeam.getStart(), exTeam.getEnd(), year);
		    		exTeam.setFh_mm(result[0]);
		    		exTeam.setSh_mm(result[1]);
		    		
		    		exTeam.setFh_expend( (exTeam.getFh_mm() * exTeam.getExpend()) );
		    		exTeam.setSh_expend( (exTeam.getSh_mm() * exTeam.getExpend()) );
		    		list.add(exTeam);
		    	}
		    		
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
			
			return list;
		}
		
		
		// 외주인력 인건비 계산
		public ArrayList<Expend_CoopBean> getExpend_coop(String team, int year){
			ArrayList<Expend_CoopBean> list = new ArrayList<Expend_CoopBean>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				StringBuffer query = new StringBuffer();
				query.append("SELECT career.id, career.start, career.end"
						+ ", member.이름, member.직급, member.소속"
						+ ",project.프로젝트명, project.팀_매출, rank.expend_coop "
		    			+ "FROM career,project,member,rank "
		    			+ "where career.id = member.id and member.직급 = rank.rank and career.projectNo = project.no "
		    			+ "and project.팀_매출 = ? and project.year = ? and member.소속 != '슈어소프트테크'");
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	pstmt.setString(1, team);
		    	pstmt.setInt(2, year);
		    	
		    	rs = pstmt.executeQuery();
		    	while(rs.next()) {
		    		Expend_CoopBean exCoop = new Expend_CoopBean();
		    		exCoop.setId(rs.getString("id"));
		    		exCoop.setStart(rs.getString("start"));
		    		exCoop.setEnd(rs.getString("end"));
		    		exCoop.setName(rs.getString("이름"));
		    		exCoop.setTeam(rs.getString("팀_매출"));
		    		exCoop.setRank(rs.getString("직급"));
		    		exCoop.setPart(rs.getString("소속"));
		    		exCoop.setProjectName(rs.getString("프로젝트명"));
		    		exCoop.setExpend(rs.getInt("expend_coop"));
		    		float [] result = cal_manmoth(exCoop.getStart(), exCoop.getEnd(), Integer.toString(year));
		    		exCoop.setFh_mm(result[0]);
		    		exCoop.setSh_mm(result[1]);
		    		exCoop.setFh_ex( (exCoop.getFh_mm() * exCoop.getExpend()) );
		    		exCoop.setSh_ex( (exCoop.getSh_mm() * exCoop.getExpend()) );
		    		list.add(exCoop);
		    	}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
			
			return list;
		}
		
		// 상반기 파견비용 계산
		public ArrayList<DPcostBean> getExpend_dp_FH(String team, int year){
			ArrayList<DPcostBean> list = new ArrayList<DPcostBean>();
			LinkedHashMap<String, DPcostBean> map = new LinkedHashMap<String,DPcostBean>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				StringBuffer query = new StringBuffer();
				query.append("select career.start, career.end, project.프로젝트명, project.근무지, workPlace.cost, member.이름, member.직급,member.id "
						+ "from career, project, workPlace, member, rank "
						+ "where career.id = member.id and career.projectNo = project.no and project.근무지 = workPlace.place and member.직급=rank.rank "
						+ "and project.year = ?  and member.팀 = ? and member.소속 = '슈어소프트테크' "
						+ "order by rank.rank_id, member.이름");
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	pstmt.setInt(1, year);
		    	pstmt.setString(2, team);
		    	rs = pstmt.executeQuery();
		    	while(rs.next()) {
		    		DPcostBean dpCost = new DPcostBean();
		    		dpCost.setId(rs.getString("id"));
		    		dpCost.setName(rs.getString("이름"));
		    		dpCost.setRank(rs.getString("직급"));
		    		dpCost.setProject(rs.getString("프로젝트명"));
		    		dpCost.setPlace(rs.getString("근무지"));
		    		dpCost.setCost(rs.getInt("cost"));
		    		dpCost.setStart(rs.getString("start"));
		    		dpCost.setEnd(rs.getString("end"));
		    		float [] result = cal_manmoth(dpCost.getStart(), dpCost.getEnd(), Integer.toString(year));
		    		dpCost.setFh_mm(result[0]);
		    		dpCost.setSh_mm(result[1]);
		    		dpCost.setFh_ex( (dpCost.getFh_mm() * dpCost.getCost()) );
		    		dpCost.setSh_ex( (dpCost.getSh_mm() * dpCost.getCost()) );
		    	
		    		if(map.get(dpCost.getId()) == null) {
		    			map.put(dpCost.getId(),dpCost);
		    		} else {
		    			if(map.get(dpCost.getId()).getFh_ex() <= dpCost.getFh_ex() ) {
			    			map.put(dpCost.getId(),dpCost);
			    		} 
		    		} 
		    	}
		    	list.addAll(map.values());
		    	
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
			
			return list;
		}
		
		// 하반기 파견비용 계산
		public ArrayList<DPcostBean> getExpend_dp_SH(String team, int year){
			ArrayList<DPcostBean> list = new ArrayList<DPcostBean>();
			LinkedHashMap<String, DPcostBean> map = new LinkedHashMap<String,DPcostBean>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				StringBuffer query = new StringBuffer();
				query.append("select career.start, career.end, project.프로젝트명, project.근무지, workPlace.cost, member.이름, member.직급,member.id "
						+ "from career, project, workPlace, member, rank "
						+ "where career.id = member.id and career.projectNo = project.no and project.근무지 = workPlace.place and member.직급=rank.rank "
						+ "and project.year = ?  and member.팀 = ? and member.소속 = '슈어소프트테크' "
						+ "order by rank.rank_id, member.이름");
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	pstmt.setInt(1, year);
		    	pstmt.setString(2, team);
		    	rs = pstmt.executeQuery();
		    	while(rs.next()) {
		    		DPcostBean dpCost = new DPcostBean();
		    		dpCost.setId(rs.getString("id"));
		    		dpCost.setName(rs.getString("이름"));
		    		dpCost.setRank(rs.getString("직급"));
		    		dpCost.setProject(rs.getString("프로젝트명"));
		    		dpCost.setPlace(rs.getString("근무지"));
		    		dpCost.setCost(rs.getInt("cost"));
		    		dpCost.setStart(rs.getString("start"));
		    		dpCost.setEnd(rs.getString("end"));
		    		float [] result = cal_manmoth(dpCost.getStart(), dpCost.getEnd(), Integer.toString(year));
		    		dpCost.setFh_mm(result[0]);
		    		dpCost.setSh_mm(result[1]);
		    		dpCost.setFh_ex( (dpCost.getFh_mm() * dpCost.getCost()) );
		    		dpCost.setSh_ex( (dpCost.getSh_mm() * dpCost.getCost()) );
		    		
		    		if(map.get(dpCost.getId()) == null) {
		    			map.put(dpCost.getId(),dpCost);
		    		} else {
		    			if(map.get(dpCost.getId()).getSh_ex() <= dpCost.getSh_ex() ) {
			    			map.put(dpCost.getId(),dpCost);
			    		} 
		    		}
		    	}
		    	list.addAll(map.values());
		    	
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
			
			return list;
		}
		
		// 직급별 단가 가져오기
		public ArrayList<Rank_CostBean> getRankCost(){
			ArrayList<Rank_CostBean> list = new ArrayList<Rank_CostBean>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				StringBuffer query = new StringBuffer();
				query.append("select * from rank where rank != '-' and rank != '인턴'");
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	rs = pstmt.executeQuery();
		    	while(rs.next()) {
		    		Rank_CostBean rank = new Rank_CostBean();
		    		rank.setRank(rs.getString("rank"));
		    		rank.setCompensation(rs.getInt("compensation"));
		    		rank.setExpend_sure(rs.getInt("expend_sure"));
		    		rank.setExpend_coop(rs.getInt("expend_coop"));
		    		list.add(rank);
		    	}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
			
			return list;
		}
		
		// 장비 구매 내역
		public ArrayList<Eq_PurchaseBean> getPurchaseList(String team, int year, int semi){
			ArrayList<Eq_PurchaseBean> list = new ArrayList<Eq_PurchaseBean>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				StringBuffer query = new StringBuffer();
				query.append("select * from eq_purchase where team=? and year=? and semi=?");
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	pstmt.setString(1, team);
		    	pstmt.setInt(2, year);
		    	pstmt.setInt(3, semi);
		    	rs = pstmt.executeQuery();
		    	while(rs.next()) {
		    		Eq_PurchaseBean purchase = new Eq_PurchaseBean();
		    		purchase.setTeam(rs.getString("team"));
		    		purchase.setName(rs.getString("name"));
		    		purchase.setCost(rs.getFloat("cost"));
		    		purchase.setDate(rs.getString("date"));
		    		purchase.setCount(rs.getInt("count"));
		    		purchase.setSum( (purchase.getCost() * purchase.getCount()) );
		    		list.add(purchase);
		    	}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
			
			return list;
		}
		
		// 외근 비용 처리 내역
		public ArrayList<Outside_ExpendBean> getOutside_Expend(String team, int year, int semi){
			ArrayList<Outside_ExpendBean> list = new ArrayList<Outside_ExpendBean>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				StringBuffer query = new StringBuffer();
				query.append("select outside_expend.*, member.이름, member.직급 from outside_expend, member "
						+ "where outside_expend.id = member.id and outside_expend.year=? and outside_expend.semi=? and member.팀=?");
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	pstmt.setInt(1, year);
		    	pstmt.setInt(2, semi);
		    	pstmt.setString(3, team);
		    	rs = pstmt.executeQuery();
		    	while(rs.next()) {
		    		Outside_ExpendBean outex = new Outside_ExpendBean();
		    		outex.setNo(rs.getInt("no"));
		    		outex.setId(rs.getString("id"));
		    		outex.setName(rs.getString("이름"));
		    		outex.setRank(rs.getString("직급"));
		    		outex.setContent(rs.getString("content"));
		    		outex.setCost(rs.getFloat("cost"));
		    		outex.setDate(rs.getString("date"));
		    		outex.setSemi(rs.getInt("semi"));
		    		outex.setYear(rs.getInt("year"));
		    		list.add(outex);
		    	}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
			
			return list;
		}
		
		//외근비용 저장
		public int save_outex(String [] id, String [] content, String [] date, String [] cost, int year, int semi, int cnt) {
			Connection conn = null;
		    PreparedStatement pstmt = null;
		    int rs = 0;
		    try {
		    	String query = "insert into outside_expend(id,content,cost,date,semi,year) values(?,?,?,?,?,?) ";
		    	if(cnt > 1) {
		    		for(int i=0; i<cnt-1; i++) {
		    			query += ",(?,?,?,?,?,?)";
		    		}
		    		query += ";";
		    	}
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	pstmt.setString(1, id[0]);
		    	pstmt.setString(2, content[0]);
		    	pstmt.setFloat(3, Float.parseFloat(cost[0]));
		    	pstmt.setString(4, date[0]);
		    	pstmt.setInt(5, semi);
		    	pstmt.setInt(6, year);
		    	if(cnt > 1) {
		    		int cnt_query = 7;
		    		for(int j=0; j<cnt-1; j++) {
		    			pstmt.setString(cnt_query, id[j+1]);
		    			cnt_query ++;
		    			pstmt.setString(cnt_query, content[j+1]);
		    			cnt_query ++;
		    			pstmt.setFloat(cnt_query, Float.parseFloat(cost[j+1]));
		    			cnt_query ++;
		    			pstmt.setString(cnt_query, date[j+1]);
		    			cnt_query ++;
		    			pstmt.setInt(cnt_query, semi);
		    			cnt_query ++;
		    			pstmt.setInt(cnt_query, year);
		    			cnt_query ++;
		    		}
		    	}
		    	rs = pstmt.executeUpdate();
		    }catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
		    
			return rs;
		}
		
	
		public int drop_outexTable(int year, int semi) {
			Connection conn = null;
			PreparedStatement pstmt = null;
		    int rs = 0;
		    try {
		    	String query = "delete from outside_expend where semi=? and year = ?";
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	pstmt.setInt(1, semi);
		    	pstmt.setInt(2, year);
		    	rs = pstmt.executeUpdate();
		    }catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
		    return rs;
		}
		
		public int[] update_CostData(int step1, int step2, int step3, int step4, String attr) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int rs[] = new int[4];
	   
			try {
		    	StringBuffer query = new StringBuffer();
		    	query.append("update rank set "+attr+"=? where rank_id=?;");
		    	conn = DBconnection.getConnection();
		    	conn.setAutoCommit(false);
		    	pstmt = conn.prepareStatement(query.toString());
		    	
		    	pstmt.setInt(1, step1);
		    	pstmt.setInt(2, 0);
		    	pstmt.addBatch();
		    	
		    	pstmt.setInt(1, step2);
		    	pstmt.setInt(2, 1);
		       	pstmt.addBatch();
		    	
		    	pstmt.setInt(1, step3);
		    	pstmt.setInt(2, 2);
		       	pstmt.addBatch();
		       	
		    	pstmt.setInt(1, step4);
		    	pstmt.setInt(2, 3);
		       	pstmt.addBatch();
		       	
		    	rs =pstmt.executeBatch();
		    	conn.commit();
		    	
		    }catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
		    
			return rs;
		}
		
		public int save_eqPurchase(String team, String [] name, String [] date, String [] cost, String [] count, int year, int semi, int cnt) {
			Connection conn = null;
		    PreparedStatement pstmt = null;
		    int rs = 0;
		    try {
		    	String query = "insert into eq_purchase(team,name,cost,date,count,semi,year) values(?,?,?,?,?,?,?) ";
		    	if(cnt > 1) {
		    		for(int i=0; i<cnt-1; i++) {
		    			query += ",(?,?,?,?,?,?,?)";
		    		}
		    		query += ";";
		    	}
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	pstmt.setString(1, team);
		    	pstmt.setString(2, name[0]);
		    	pstmt.setFloat(3, Float.parseFloat(cost[0]));
		    	pstmt.setString(4, date[0]);
		    	pstmt.setInt(5, Integer.parseInt(count[0]));
		    	pstmt.setInt(6, semi);
		    	pstmt.setInt(7, year);
		    	if(cnt > 1) {
		    		int cnt_query = 8;
		    		for(int j=0; j<cnt-1; j++) {
		    			pstmt.setString(cnt_query, team);
		    			cnt_query ++;
		    			pstmt.setString(cnt_query, name[j+1]);
		    			cnt_query ++;
		    			pstmt.setFloat(cnt_query, Float.parseFloat(cost[j+1]));
		    			cnt_query ++;
		    			pstmt.setString(cnt_query, date[j+1]);
		    			cnt_query ++;
		    			pstmt.setInt(cnt_query, Integer.parseInt(count[j+1]));
		    			cnt_query ++;
		    			pstmt.setInt(cnt_query, semi);
		    			cnt_query ++;
		    			pstmt.setInt(cnt_query, year);
		    			cnt_query ++;
		    		}
		    	}
		    	rs = pstmt.executeUpdate();
		    }catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
		    
			return rs;
		}
		
		public int drop_EQpurchaseTable(String team, int year, int semi) {
			Connection conn = null;
			PreparedStatement pstmt = null;
		    int rs = 0;
		    try {
		    	String query = "delete from eq_purchase where team=? and semi=? and year = ?";
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	pstmt.setString(1, team);
		    	pstmt.setInt(2, semi);
		    	pstmt.setInt(3, year);
		    	rs = pstmt.executeUpdate();
		    }catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
		    return rs;
		}
		
		
		// 모든 회원정보 가져오기
		public ArrayList<MemberBean> getMemberData(String team) {
			Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    ArrayList<MemberBean> list = new ArrayList<MemberBean>(); 
		    
		    try {
		    	StringBuffer query = new StringBuffer();
		    	query.append("SELECT a.* FROM member as a, rank as b, position as c, team as d "
		    			+ "WHERE a.직급=b.rank AND a.직책=c.position AND a.팀 = d.teamName and a.팀=? and a.소속 = '슈어소프트테크'"
		    			+ "ORDER BY d.teamNum, FIELD(a.소속, '슈어소프트테크') DESC, a.소속, c.num, b.rank_id, a.입사일");
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	pstmt.setString(1, team);
		    	rs = pstmt.executeQuery();
		    	while(rs.next()) {
		    		MemberBean member = new MemberBean();
		    		member.setID(rs.getString("id"));
		    		member.setPASSWORD(rs.getString("pw"));
		    		member.setPART(rs.getString("소속"));
		    		member.setTEAM(rs.getString("팀"));
		    		member.setNAME(rs.getString("이름"));
		    		member.setRANK(rs.getString("직급"));
		    		member.setPosition(rs.getString("직책"));
		    		member.setADDRESS(rs.getString("거주지"));
		    		member.setComDate(rs.getString("입사일"));
		    		member.setMOBILE(rs.getString("mobile"));
		    		member.setGMAIL(rs.getString("gmail"));	
		    		member.setCareer(rs.getString("프로젝트수행이력"));
		    		member.setLevel(rs.getInt("level"));
		    		member.setPermission(rs.getString("permission"));
		    		member.setWorkEx(rs.getInt("경력"));
		    		list.add(member);
		    	}
		    }  catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
		    
		    return list;
		}
		
		
		
		// 상반기, 하반기 manmonth 계산
		public float [] cal_manmoth(String start, String end, String year) {
			float [] result = new float[2];
			long fh_mm = 0;
			long sh_mm = 0;
			
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			//int nowYear = Integer.parseInt(Date.split("-")[0]);
			
			int nowYear = Integer.parseInt(year);
			String startDate = "";
			String endDate = "";
			Date sDate;
			Date eDate;

			//상반기
			String fh_date = nowYear+"-06-30";
			//하반기
			String sh_date = nowYear+"-07-01";
			
			if(Integer.parseInt(start.split("-")[0]) < nowYear) {
				startDate = nowYear+"-01-01";
			} else if(Integer.parseInt(start.split("-")[0]) == nowYear) {
				startDate = start;
			} else {
				startDate = start;
			}
			
			if(Integer.parseInt(end.split("-")[0]) > nowYear) {
				endDate = nowYear+"-12-31";
		
			} else if(Integer.parseInt(end.split("-")[0]) == nowYear) {
				endDate = end;
			} else {
				endDate = end;
			}
			
			
			if(Integer.parseInt(endDate.split("-")[1]) < 07) {
				fh_date = endDate;
			}
			
			if(Integer.parseInt(startDate.split("-")[1]) > 06) {
				sh_date = startDate;
			}
			
			
			try {
				sDate = sf.parse(startDate);
				eDate = sf.parse(endDate);
				fh_mm = (long) ((sf.parse(fh_date).getTime() - sDate.getTime()) / (24*60*60*1000));
				sh_mm = (long) ((eDate.getTime() - sf.parse(sh_date).getTime()) / (24*60*60*1000));

			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			if(Integer.parseInt(start.split("-")[0]) > nowYear) {
				fh_mm = 0;
				sh_mm = 0;
			} else if((Integer.parseInt(start.split("-")[0]) == nowYear && Integer.parseInt(start.split("-")[1]) > 06)) {
				fh_mm = 0;
			}
			
			if(Integer.parseInt(end.split("-")[0]) < nowYear ) {
				fh_mm = 0;
				sh_mm = 0;
			} else if((Integer.parseInt(end.split("-")[0]) == nowYear && Integer.parseInt(end.split("-")[1]) < 07)) {
				sh_mm = 0;
			}
			
			result[0] = Float.parseFloat(String.format("%.1f", (fh_mm/30.1)));  
			result[1] = Float.parseFloat(String.format("%.1f", (sh_mm/30.3)));
			
			return result;
		}
		
		
}
