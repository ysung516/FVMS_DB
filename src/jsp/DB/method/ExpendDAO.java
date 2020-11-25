package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import jsp.Bean.model.*;

public class ExpendDAO {
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
			result[1] = Float.parseFloat(String.format("%.1f", (sh_mm/30.2)));
			
			return result;
		}
		
		/*
		
		public int minYear() {
			Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    int year = 0;
		    
		    try {
		    	StringBuffer query = new StringBuffer();
		    	query.append("select min(year) from workPlace");
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
		
		public int maxYear() {
			Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    int year = 0;
		    
		    try {
		    	StringBuffer query = new StringBuffer();
		    	query.append("select max(year) from workPlace");
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
		
		*/
		
}
