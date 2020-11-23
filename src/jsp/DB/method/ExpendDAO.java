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
		public ArrayList<String> getTeamData(){
			ArrayList<String> list = new ArrayList<String>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				StringBuffer query = new StringBuffer();
		    	query.append("select * from team order by teamNum");
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
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
		
		public ArrayList<ExpendBean> getExpend_sure(String team, String year){
			ArrayList<ExpendBean> list = new ArrayList<ExpendBean>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				StringBuffer query = new StringBuffer();
		    	query.append("SELECT career.*,project.팀_매출,project.프로젝트명, member.이름, member.직급, member.소속, rank.expend_sure "
		    			+ "FROM career,project,member,rank "
		    			+ "where career.id = member.id and member.직급 = rank.rank and career.projectNo = project.no "
		    			+ "and project.팀_매출 = ? and project.year = ? and project.상태 != '8.Dropped' and member.소속 = '슈어소프트테크' order by career.projectNo;");
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	pstmt.setString(1, team);
		    	pstmt.setString(2, year);
		    	rs = pstmt.executeQuery();
		    	while(rs.next()) {
		    		
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
		
		public ArrayList<ExpendBean> getExpend_coop(String team){
			ArrayList<ExpendBean> list = new ArrayList<ExpendBean>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				StringBuffer query = new StringBuffer();
		    	query.append("select * from ");
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	rs = pstmt.executeQuery();
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
		public String [] cal_manmoth(String start, String end, String year) {
			String [] result = new String[2];
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
			
			result[0] = String.format("%.1f", (fh_mm/30.0));
			result[1] = String.format("%.1f", (sh_mm/30.5));
			
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
