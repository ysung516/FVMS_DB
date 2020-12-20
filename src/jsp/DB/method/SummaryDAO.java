package jsp.DB.method;

import jsp.Bean.model.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;

import java.util.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class SummaryDAO {
	public SummaryDAO() {}
	
	// 해당 년도 프로젝트 중 실적보고할 프로젝트 리스트 가져오기
	public ArrayList<ProjectBean> getProjectList(String year){
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    ArrayList<ProjectBean> list = new ArrayList<ProjectBean>();
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("SELECT * from project where 실적보고 = 1 and year ="+year+" ;");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		ProjectBean project = new ProjectBean();
	    		project.setTEAM_ORDER(rs.getString("팀_수주"));
	    		project.setTEAM_SALES(rs.getString("팀_매출"));
	    		project.setPROJECT_NAME(rs.getString("프로젝트명"));
	    		project.setMAN_MONTH(rs.getFloat("ManMonth"));
	    		project.setFH_ORDER_PROJECTIONS(rs.getFloat("상반기예상수주"));
	    		project.setFH_ORDER(rs.getFloat("상반기수주"));
	    		project.setFH_SALES_PROJECTIONS(rs.getFloat("상반기예상매출"));
	    		project.setFH_SALES(rs.getFloat("상반기매출"));
	    		project.setSH_ORDER_PROJECTIONS(rs.getFloat("하반기예상수주"));
	    		project.setSH_ORDER(rs.getFloat("하반기수주"));
	    		project.setSH_SALES_PROJECTIONS(rs.getFloat("하반기예상매출"));
	    		project.setSH_SALES(rs.getFloat("하반기매출"));
	    		project.setNO(rs.getInt("no"));
	    		list.add(project);
	    	}
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    return list;
	}
	
	// 상반기, 하반기 manmonth 계산
	public String [] cal_manmoth(String start, String end, String year) {
		String [] result = new String[2];
		long fh_mm = 0;
		long sh_mm = 0;
		Date nowDate = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String Date = sf.format(nowDate);
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
		
		result[0] = String.format("%.1f", (fh_mm/30.1));
		result[1] = String.format("%.1f", (sh_mm/30.3));
		
		return result;
	}
	
	// id의 직급 내역 가져오기 linkedlist에 담고 최신순으로 먼저 담기게
	public LinkedList<LinkedList<String>> rankList_id(String id){
		LinkedList<LinkedList<String>> reMap = new LinkedList<LinkedList<String>>();

		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String nowDate = sf.format(date);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String query = "SELECT * FROM rank_period where id =? order by start desc;";
			conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, id);
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		LinkedList<String> period = new LinkedList<String>();
	    		period.add(rs.getString("rank"));
	    		period.add(rs.getString("start"));
	    		if(rs.getString("end").equals("now")) {
	    			period.add(nowDate);	// 오늘날짜 넣으면 안됨 
	    		}else {
	    			period.add(rs.getString("end"));
	    		}
	    		reMap.add(period);
	    	}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return reMap;
	}
	
	// 날짜별 직급으로 비용 계산
	public float[] cal_cost(String id, String nowRank, String start, String end, String year) throws ParseException {
		float [] result = null;
		String [] cal_mm = null;
		LinkedList<LinkedList<String>> myRankList = rankList_id(id);	// id의 직급 내역 리스트 : [직급,start,end]로 된 리스트의 리스트
		HashMap<String, Integer> rankCostList = getRank();	// 직급별 비용 리스트 <직급, 비용>
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date startPro = sf.parse(start);
			Date endPro = sf.parse(end);
			
			// 1) 프로젝트 기간동안 계속 현재 직급
			if( startPro.after(sf.parse(myRankList.get(0).get(1))) || startPro.equals(sf.parse(myRankList.get(0).get(1))) ) {	
				result = new float[2];
				cal_mm = cal_manmoth(start, end, year);
				//기존과 동일한 방식으로 진행, 비용의 단위가 만 단위이기 때문에 시스템 상에 백만 단위로 계산해주어야함(/100)
				result[0] = Float.parseFloat(cal_mm[0]) * rankCostList.get(nowRank) / 100;
				result[1] = Float.parseFloat(cal_mm[1]) * rankCostList.get(nowRank) / 100;
				return result;
			}
			// 2) 프로젝트 수행 중 직급 변경
			else if( startPro.before(sf.parse(myRankList.get(0).get(1))) 
					&& ( endPro.after(sf.parse(myRankList.get(0).get(1))) || endPro.equals(sf.parse(myRankList.get(0).get(1)))) ){
				result = new float[2];
				// 1. 현재직급 ~ 플젝종료날짜
				cal_mm = cal_manmoth(myRankList.get(0).get(1), end, year);
				result[0] = Float.parseFloat(cal_mm[0]) * rankCostList.get(nowRank) / 100;
				result[1] = Float.parseFloat(cal_mm[1]) * rankCostList.get(nowRank) / 100;
				// 2. 이전직급 ~ 플젝시작날짜
				for(int i = 1; i < myRankList.size(); i++) {
					if( startPro.after(sf.parse(myRankList.get(i).get(1))) ||  startPro.equals(sf.parse(myRankList.get(i).get(1))) ) {
						cal_mm = cal_manmoth(start, myRankList.get(i).get(2), year);
						result[0] += Float.parseFloat(cal_mm[0]) * rankCostList.get(myRankList.get(i).get(0)) / 100;
						result[1] += Float.parseFloat(cal_mm[1]) * rankCostList.get(myRankList.get(i).get(0)) / 100;
						return result;
					} else if( startPro.before(sf.parse(myRankList.get(i).get(1))) ) {
						cal_mm = cal_manmoth(myRankList.get(i).get(1), myRankList.get(i).get(2), year);
						result[0] += Float.parseFloat(cal_mm[0]) * rankCostList.get(myRankList.get(i).get(0)) / 100;
						result[1] += Float.parseFloat(cal_mm[1]) * rankCostList.get(myRankList.get(i).get(0)) / 100;
						continue;
					}
				}
			}
			// 3) 현재 직급에서 수행하지 않은 프로젝트
			else if( endPro.before(sf.parse(myRankList.get(0).get(1))) ) {
				result = new float[2];
				result[0] = 0;
				result[1] = 0;
				// 이 경우 모두 이전 직급에서 진행된 프로젝트
				for(int i = 1; i < myRankList.size(); i++) {
					if( startPro.after(sf.parse(myRankList.get(i).get(1))) || startPro.equals(sf.parse(myRankList.get(i).get(1))) ) {
						cal_mm = cal_manmoth(start, end, year);
						if(endPro.after(sf.parse(myRankList.get(i).get(2)))) {
							cal_mm = cal_manmoth(start, myRankList.get(i).get(2), year);
						}
						result[0] += Float.parseFloat(cal_mm[0]) * rankCostList.get(myRankList.get(i).get(0)) / 100;
						result[1] += Float.parseFloat(cal_mm[1]) * rankCostList.get(myRankList.get(i).get(0)) / 100;
						return result;
					} else if( startPro.before(sf.parse(myRankList.get(i).get(1))) 
							&& ( endPro.after(sf.parse(myRankList.get(i).get(1))) || endPro.equals(sf.parse(myRankList.get(i).get(1)))) ) {
						cal_mm = cal_manmoth(myRankList.get(i).get(1), end, year);
						result[0] += Float.parseFloat(cal_mm[0]) * rankCostList.get(myRankList.get(i).get(0)) / 100;
						result[1] += Float.parseFloat(cal_mm[1]) * rankCostList.get(myRankList.get(i).get(0)) / 100;
						continue;
					} else if( endPro.before(sf.parse(myRankList.get(i).get(1))) ) {
						continue;
					}
				}
			}
		} catch (Exception e) {

            // TODO: handle exception

        }
		return result;
	}
	
	// 매출보정 시 마이너스 될 리스트
	public ArrayList<CMSBean> getCMS_minusList(String projectTeam, String year){
		ArrayList<CMSBean> list = new ArrayList<CMSBean>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			StringBuffer query = new StringBuffer();
	    	query.append("select project.no, project.프로젝트명, project.팀_매출, member.id, member.팀, member.이름, member.직급, career.start, career.end, rank.compensation "
	    			+ "from project, career, member, rank "
	    			+ "where project.year = ? and project.상태 != '8.Dropped' and project.실적보고 = 1 and member.소속 = '슈어소프트테크' and "
	    			+ "project.no = career.projectNo and career.id = member.id and rank.rank = member.직급"
	    			+ " and project.팀_매출 != member.팀 and project.팀_매출 = ? and (project.상반기매출 != 0 or project.하반기매출 != 0)");
	    	conn = DBconnection.getConnection(); 
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, year);
	    	pstmt.setString(2, projectTeam);
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		String id = rs.getString("id");
	    		CMSBean cms = new CMSBean();
	    		cms.setNo(rs.getString("no"));	    		
	    		cms.setProjectName(rs.getString("프로젝트명"));
	    		cms.setSalesTeam(rs.getString("팀_매출"));
	    		cms.setTeam(rs.getString("팀"));
	    		cms.setName(rs.getString("이름"));
	    		cms.setRank(rs.getString("직급"));
	    		cms.setStart(rs.getString("start"));
	    		cms.setEnd(rs.getString("end"));
	    		cms.setFH_MM(Float.parseFloat(cal_manmoth(rs.getString("start"), rs.getString("end"), year)[0]));
	    		cms.setSH_MM(Float.parseFloat(cal_manmoth(rs.getString("start"), rs.getString("end"), year)[1]));
	    		//지금까지 직급 내역으로 계산
	    		float[] result = new float[2];
	    		try {
	    			result = cal_cost(id, rs.getString("직급"), rs.getString("start"), rs.getString("end"), year);
	    		}catch(Exception e){
	    			result[0] = 0;
	    			result[1] = 1;
	    		}
	    		cms.setFH_MM_CMS(result[0]);
	    		cms.setSH_MM_CMS(result[1]);
	    		list.add(cms);
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
	
	// 매출보정 시 플러스 될 리스트
	public ArrayList<CMSBean> getCMS_plusList(String team, String year){
		ArrayList<CMSBean> list = new ArrayList<CMSBean>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			StringBuffer query = new StringBuffer();
	    	query.append("select project.no, project.프로젝트명, project.팀_매출,member.id, member.팀, member.이름, member.직급, career.start, career.end, rank.compensation "
	    			+ "from project, career, member, rank "
	    			+ "where project.year = ? and project.상태 != '8.Dropped' and project.실적보고 = 1 and member.소속 = '슈어소프트테크' and project.no = career.projectNo and career.id = member.id and rank.rank = member.직급"
	    			+ " and project.팀_매출 != member.팀 and member.팀 = ? and (project.상반기매출 != 0 or project.하반기매출 != 0)");
	    	conn = DBconnection.getConnection(); 
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, year);
	    	pstmt.setString(2, team);
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		String id = rs.getString("id");
	    		CMSBean cms = new CMSBean();
	    		cms.setNo(rs.getString("no"));	    		
	    		cms.setProjectName(rs.getString("프로젝트명"));
	    		cms.setSalesTeam(rs.getString("팀_매출"));
	    		cms.setTeam(rs.getString("팀"));
	    		cms.setName(rs.getString("이름"));
	    		cms.setRank(rs.getString("직급"));
	    		cms.setStart(rs.getString("start"));
	    		cms.setEnd(rs.getString("end"));
	    		cms.setFH_MM(Float.parseFloat(cal_manmoth(rs.getString("start"), rs.getString("end"), year)[0]));
	    		cms.setSH_MM(Float.parseFloat(cal_manmoth(rs.getString("start"), rs.getString("end"), year)[1]));
	    		//지금까지 직급 내역으로 계산
	    		float[] result = new float[2];
	    		try {
	    			result = cal_cost(id, rs.getString("직급"), rs.getString("start"), rs.getString("end"), year);
	    		}catch(Exception e){
	    			result[0] = 0;
	    			result[1] = 1;
	    		}
	    		cms.setFH_MM_CMS(result[0]);
	    		cms.setSH_MM_CMS(result[1]);
	    		list.add(cms);
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
	
	// summary 수주/매출 테이블용 career 데이터
	public ArrayList<careerSummary_Bean> getCareerSummary(){
		ArrayList<careerSummary_Bean> list = new ArrayList<careerSummary_Bean>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Date now = new Date();
	    	SimpleDateFormat sf = new SimpleDateFormat("yyyy");
	    	String year = sf.format(now);
			StringBuffer query = new StringBuffer();
	    	query.append("SELECT career.id, member.이름, career.projectNo, member.팀, rank.compensation FROM career, member, rank, project "
	    			+ "where project.no = career.projectNo and project.year = 2020 and member.직급 = rank.rank and career.id = member.id and member.소속 = '슈어소프트테크' "
	    			+ "group by id, projectNo;");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		careerSummary_Bean cs = new careerSummary_Bean();
	    		cs.setId(rs.getString(1));
	    		cs.setName(rs.getString(2));
	    		cs.setNo(rs.getInt(3));
	    		cs.setTeam(rs.getString(4));
	    		cs.setCompensation(rs.getInt(5));
	    		list.add(cs);
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
	/*
	// 팀별 목포 수주,매출 데이터 가져오기
	public ArrayList<TeamBean> getTagetData(){
			ArrayList<TeamBean> List = new ArrayList<TeamBean>();
			Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    try {
		    	StringBuffer query = new StringBuffer();
		    	query.append("SELECT * from team");
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	rs = pstmt.executeQuery();
		    	
		    	while(rs.next()) {
		    		TeamBean team = new TeamBean();
		    		team.setTeamNum(rs.getInt("teamNum"));
		    		team.setTeamName(rs.getString("teamName"));
		    		team.setFH_targetOrder(rs.getFloat("상반기목표수주"));
		    		team.setFH_targetSales(rs.getFloat("상반기목표매출"));
		    		team.setSH_targetOrder(rs.getFloat("하반기목표수주"));
		    		team.setSH_targetSales(rs.getFloat("하반기목표매출"));
		    		List.add(team);
		    	}
		    }catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
		    return List;
	}
		*/
	// 팀별 목표 수주,매출 데이터 가져오기
	public LinkedHashMap<String, TeamBean> getTargetData(String year){
		LinkedHashMap<String, TeamBean> reList = new LinkedHashMap<String, TeamBean>();
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("SELECT * from team where year="+year+" order by teamNum");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		TeamBean team = new TeamBean();
	    		team.setTeamNum(rs.getInt("teamNum"));
	    		team.setTeamName(rs.getString("teamName"));
	    		team.setFH_targetOrder(rs.getFloat("상반기목표수주"));
	    		team.setFH_targetSales(rs.getFloat("상반기목표매출"));
	    		team.setSH_targetOrder(rs.getFloat("하반기목표수주"));
	    		team.setSH_targetSales(rs.getFloat("하반기목표매출"));
	    		reList.put(rs.getString("teamName"), team);
	    	}
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    return reList;
	}
	
	// 목표 수주,매출 저장
	public int[] saveTargetData(HashMap<String, LinkedList<LinkedList<Float>>> dataList, String year) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int[] rs = new int[dataList.size()];
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("update team set 상반기목표수주=?, 상반기목표매출=?, 하반기목표수주=?, 하반기목표매출=? where teamName=? and year=?;");
	    	conn = DBconnection.getConnection();
	    	conn.setAutoCommit(false);
	    	pstmt = conn.prepareStatement(query.toString());
	    	
	    	for(String key : dataList.keySet()) {
	    		pstmt.setFloat(1, dataList.get(key).get(0).get(0));
		    	pstmt.setFloat(2, dataList.get(key).get(0).get(1));
		    	pstmt.setFloat(3, dataList.get(key).get(1).get(0));
		    	pstmt.setFloat(4, dataList.get(key).get(1).get(1));
		    	pstmt.setString(5, key);
		    	pstmt.setString(6, year);
		    	pstmt.addBatch();
	    	}
	       	
	    	rs = pstmt.executeBatch();
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
	
	// 직급과 기준값 가져오기
	public HashMap<String, Integer> getRank(){
		HashMap<String, Integer> rank = new LinkedHashMap<String, Integer>();
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("SELECT * from rank order by rank_id");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		rank.put(rs.getString("rank"), rs.getInt("compensation"));
	    	}
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    
		return rank;
	}
	
	// 직급 별 기준 값 변경
	public int[] changeRankCompensation(int step1, int step2, int step3, int step4) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs[] = new int[4];
   
		try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("update rank set compensation=? where rank_id=?;");
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
	
	// 팀 데이터 중 가장 작은 년도 가져오기
	public int minYear() {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int year = 0;
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("select min(year) from team");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	if(rs.next()) {
	    		year = rs.getInt("min(year)");
	    	}
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    return year;
	}
	
	// 팀 데이터 중 가장 최신 년도 가져오기
	public int maxYear() {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int year = 0;
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("select max(year) from team");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	if(rs.next()) {
	    		year = rs.getInt("max(year)");
	    	}
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    return year;
	}
	
}
