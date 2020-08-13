package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import jsp.Bean.model.ReportBean;

public class ReportDAO {
	public ReportDAO() {}
	
	
	// 등록날짜로 유효기간 보여주기
	public String validDate(String writeDate) {
	   Calendar cal = Calendar.getInstance();
	   SimpleDateFormat dateFmt = new SimpleDateFormat("MM-dd");
	    String date = writeDate;
	    String MonDate = "";
	    String FriDate = "";
	    String returnDate = "";
	   int y = Integer.parseInt(date.split("-")[0]);
	   int m = Integer.parseInt(date.split("-")[1]) - 1;
	   int w = Integer.parseInt(date.split("-")[2]);

	   cal.set(Calendar.YEAR,y);
	   cal.set(Calendar.MONTH,m);
	   cal.set(Calendar.DATE, w);
	   
	   if(cal.getTime().toString().split(" ")[0].equals("Sun")) {
	     cal.set(Calendar.DATE, w-7);
	     cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
	     MonDate = dateFmt.format(cal.getTime());
	     cal.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
	     FriDate = dateFmt.format(cal.getTime());
	     returnDate = MonDate + " ~ " + FriDate;
	   }
	   else {
		   cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		   MonDate = dateFmt.format(cal.getTime());
		   cal.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
		   FriDate = dateFmt.format(cal.getTime());
		   returnDate = MonDate + "	 ~ " + FriDate;
	   }
	   return returnDate;
	} 
	
	
	// 보고서 작성
	public int saveReport(String title, String writeDate,
			 String weekPlan, String weekPro, String nextPlan, String user_id, 
			 String name, String specialty, String note) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		
		try {
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement("insert into report(id, 이름, 프로젝트명, 작성일, 금주계획, 금주진행, 차주계획, 특이사항, 비고)"
					+ "values(?,?,?,?,?,?,?,?,?)");
			pstmt.setString(1, user_id);
			pstmt.setString(2, name);
			pstmt.setString(3, title);
			pstmt.setString(4, writeDate);
			pstmt.setString(5, weekPlan);
			pstmt.setString(6, weekPro);
			pstmt.setString(7, nextPlan);
			pstmt.setString(8, specialty);
			pstmt.setString(9, note);
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return rs;
	}
	
	// 전체 보고서 리스트 목록 가져오기
	public ArrayList<ReportBean> getReportList(){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ReportBean> reportList = new ArrayList<ReportBean>();
		
		try {
			StringBuffer query = new StringBuffer();
	    	query.append("select * from report");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		ReportBean report = new ReportBean();
	    		report.setNo(rs.getInt("no"));
	    		report.setId(rs.getString("id"));
	    		report.setName(rs.getString("이름"));
	    		report.setTitle(rs.getString("프로젝트명"));
	    		report.setDate(rs.getString("작성일"));
	    		report.setWeekPlan(rs.getString("금주계획"));
	    		report.setWeekPro(rs.getString("금주진행"));
	    		report.setNextPlan(rs.getString("차주계획"));
	    		report.setSpecialty(rs.getString("특이사항"));
	    		report.setNote(rs.getString("비고"));
	    		reportList.add(report);
	    	}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return reportList;
	}
	
	// 키값으로 특정보고서 가져오기
	public ReportBean getReportBean(int no) {
		ReportBean report = new ReportBean();
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("select * from report where no=?");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setInt(1, no);
	    	rs = pstmt.executeQuery();
	    	
	    	if(rs.next()) {
	    		report.setId(rs.getString("id"));
	    		report.setName(rs.getString("이름"));
	    		report.setTitle(rs.getString("프로젝트명"));
	    		report.setDate(rs.getString("작성일"));
	    		report.setWeekPlan(rs.getString("금주계획"));
	    		report.setWeekPro(rs.getString("금주진행"));
	    		report.setNextPlan(rs.getString("차주계획"));
	    		report.setSpecialty(rs.getString("특이사항"));
	    		report.setNote(rs.getString("비고"));
	    	}
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    
	    return report;
	}
	
	// 보고서 수정
	public int updateReport(int no, String weekPlan, String weekPro,
			String nextPlan, String specialty, String note) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    
	    try {
	    	String query = "update report set 금주계획=?, 금주진행=?, 차주계획=?, 특이사항=?, 비고=? "
	    			+ "where no =?";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, weekPlan);
	    	pstmt.setString(2, weekPro);
	    	pstmt.setString(3, nextPlan);
	    	pstmt.setString(4, specialty);
	    	pstmt.setString(5, note);
	    	pstmt.setInt(6, no);
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
		
	// 보고서 삭제
	public int deleteReport(int no) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    
	    try {
	    	String query = "delete from report where no =?";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setInt(1, no);
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
	
	// 작성되지 않은 보고서만 가져오기
	public ArrayList<String> getUnwrittenReport(){
		ArrayList<String> list = new ArrayList<String>();
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	    	String query = "SELECT a.프로젝트명 FROM project a left outer join report b on a.프로젝트명 = b.프로젝트명 "
	    			+ "where b.프로젝트명 is null";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	while(rs.next()) {
	    		list.add(rs.getString("프로젝트명"));
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
	
	// 보고서 백업
	public void backUp() {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("INSERT INTO reportBackUp SELECT * FROM report");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	}
	
	// 주간보고서 삭제
	public void deleteAllreport() {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("truncate report;");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.executeUpdate();
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	}
	
	// 백업보고서 삭제
	public void deleteAllbackUp() {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("truncate reportBackUp;");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.executeUpdate();
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	}
	
	// 보고서 작성시 저번주 데이터 가져오기
	public ArrayList<ReportBean> loadData() {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    ArrayList<ReportBean> reportList = new ArrayList<ReportBean>();
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("select * from reportBackUp");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	while(rs.next()) {
	    		ReportBean report = new ReportBean();
	    		report.setTitle(rs.getString("프로젝트명"));
	    		report.setNextPlan(rs.getString("차주계획"));
	    		report.setSpecialty(rs.getString("특이사항"));
	    		report.setNote(rs.getString("비고"));
	    		reportList.add(report);
	    	}
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    return reportList;
	}
	

	
}	// end DAO
