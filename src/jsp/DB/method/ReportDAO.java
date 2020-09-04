package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import jsp.Bean.model.ProjectBean;
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
			 String name, String specialty, String note, int projectNo) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		
		try {
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement("insert into report(id, 이름, 프로젝트명, 작성일, 금주계획, 금주진행, 차주계획, 특이사항, 비고, 프로젝트no)"
					+ "values(?,?,?,?,?,?,?,?,?,?)");
			pstmt.setString(1, user_id);
			pstmt.setString(2, name);
			pstmt.setString(3, title);
			pstmt.setString(4, writeDate);
			pstmt.setString(5, weekPlan);
			pstmt.setString(6, weekPro);
			pstmt.setString(7, nextPlan);
			pstmt.setString(8, specialty);
			pstmt.setString(9, note);
			pstmt.setInt(10, projectNo);
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
	    		report.setProjectNo(rs.getInt("프로젝트no"));
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
	    		report.setProjectNo(rs.getInt("프로젝트no"));
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
			String nextPlan, String specialty, String note, String date) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    
	    try {
	    	String query = "update report set 금주계획=?, 작성일=?, 금주진행=?, 차주계획=?, 특이사항=?, 비고=? "
	    			+ "where no =?";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, weekPlan);
	    	pstmt.setString(2, date);
	    	pstmt.setString(3, weekPro);
	    	pstmt.setString(4, nextPlan);
	    	pstmt.setString(5, specialty);
	    	pstmt.setString(6, note);
	    	pstmt.setInt(7, no);
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
	
	// 주간보고서가 작성되지 않은 프로젝트의 no와 제목 가져오기
	public ArrayList<ProjectBean> getUnwrittenReport(){
		ArrayList<ProjectBean> list = new ArrayList<ProjectBean>();
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	    	String query = "SELECT a.no, a.프로젝트명, a.PM, a.투입명단 FROM project a left outer join report b on a.no = b.프로젝트no "
	    			+ "where b.프로젝트no is null AND a.주간보고서사용=1";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	while(rs.next()) {
	    		ProjectBean project = new ProjectBean();
	    		project.setPROJECT_NAME(rs.getString("프로젝트명"));
	    		project.setNO(rs.getInt("no"));
	    		project.setPROJECT_MANAGER(rs.getNString("PM"));
	    		project.setWORKER_LIST(rs.getNString("투입명단"));
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
	
	// 작성되지 않은 보고서만 가져오기
	public ArrayList<String[]> getUnwrittenReportarr(){
		ArrayList<String[]> list = new ArrayList<String[]>();
		//HashMap<Integer, String> mapData = new HashMap<Integer, String>();
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	    	String query = "SELECT a.* FROM project a left outer join report b on a.no = b.프로젝트no "
	    			+ "where b.프로젝트no is null AND a.주간보고서사용=1";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	while(rs.next()) {
	    		String[] data = new String[4];
	    		data[0] = Integer.toString(rs.getInt("no"));
	    		data[1] = rs.getString("프로젝트명");
	    		data[2] = rs.getString("PM");
	    		data[3] = rs.getString("투입명단");
	    		list.add(data);
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
	public int backUp() {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("INSERT INTO reportBackUp SELECT * FROM report");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
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
	
	// 주간보고서 삭제
	public int deleteAllreport() {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("truncate report;");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
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
	
	// 백업보고서 삭제
	public int deleteAllbackUp() {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("truncate reportBackUp;");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
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
	    		report.setWeekPlan(rs.getString("금주계획"));
	    		report.setWeekPro(rs.getString("금주진행"));
	    		report.setNextPlan(rs.getString("차주계획"));
	    		report.setSpecialty(rs.getString("특이사항"));
	    		report.setNote(rs.getString("비고"));
	    		report.setProjectNo(rs.getInt("프로젝트no"));
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
