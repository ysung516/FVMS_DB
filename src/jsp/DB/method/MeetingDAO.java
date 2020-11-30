package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import jsp.Bean.model.MeetBean;
import jsp.Bean.model.nextPlanBean;

public class MeetingDAO {

	public MeetingDAO() {}
	
	// 회의 일시로 정렬해서 회의록 리스트 가져오기
	public ArrayList<MeetBean> getMeetBean(){
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
		ArrayList<MeetBean> MeetList = new ArrayList<MeetBean>();
		
		try {
			StringBuffer query = new StringBuffer();
	    	query.append("select * from meeting_log order by 회의일시;");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		MeetBean meet = new MeetBean();
	    		meet.setNo(rs.getInt("no"));
	    		meet.setId(rs.getString("ID"));
	    		meet.setMeetName(rs.getString("회의명"));
	    		meet.setWriter(rs.getString("작성자"));
	    		meet.setDate(rs.getString("작성날짜"));
	    		meet.setMeetDate(rs.getString("회의일시"));
	    		meet.setMeetPlace(rs.getString("회의장소"));
	    		meet.setAttendees(rs.getString("참석자"));
	    		meet.setP_meetnote(rs.getString("회의내용"));
	    		meet.setP_nextplan(rs.getString("향후일정"));
	    		meet.setAttendees_ex(rs.getString("외부참석자"));
	    		meet.setIssue(rs.getString("이슈사항"));
	    		MeetList.add(meet);
	    	}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return MeetList;
	}
	
	// 키값으로 특정회의록 가져오기
	public MeetBean getMeetList(int no) {
		MeetBean meet = new MeetBean();
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("select * from meeting_log where no=?");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setInt(1, no);
	    	rs = pstmt.executeQuery();
	    	
	    	if(rs.next()) {
	    		meet.setMeetName(rs.getString("회의명"));
	    		meet.setId(rs.getString("ID"));
	    		meet.setWriter(rs.getString("작성자"));
	    		meet.setDate(rs.getString("작성날짜"));
	    		meet.setMeetDate(rs.getString("회의일시"));
	    		meet.setMeetPlace(rs.getString("회의장소"));
	    		meet.setAttendees(rs.getString("참석자"));
	    		meet.setP_meetnote(rs.getString("회의내용"));
	    		meet.setP_nextplan(rs.getString("향후일정"));
	    		meet.setAttendees_ex(rs.getString("외부참석자"));
	    		meet.setIssue(rs.getString("이슈사항"));
	    	}
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    
	    return meet;
	}

	// 회의록  향후일정 리스트 가져오기
	public ArrayList<nextPlanBean> getNextPlan(String writeTime){
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
		ArrayList<nextPlanBean> nextPlanList = new ArrayList<nextPlanBean>();
		
		try {
			StringBuffer query = new StringBuffer();
	    	query.append("select * from meeting_nextplan where writeTime = ?");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, writeTime);
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		nextPlanBean nextPlan = new nextPlanBean();
	    		nextPlan.setNo(rs.getInt("no"));
	    		nextPlan.setItem(rs.getString("item"));
	    		nextPlan.setDeadline(rs.getString("deadline"));
	    		nextPlan.setPM(rs.getString("pm"));
	    		nextPlanList.add(nextPlan);
	    	}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return nextPlanList;
	}
	
	// 회의록 작성
	public int saveMeet(String id, String MeetName, String writer, String MeetDate, String MeetPlace,
			String attendees, String meetNote, String nextPlan, String date,String attendees_ex, String issue) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    
	    try {
	    	String query = "insert into meeting_log (ID,회의명,작성자,작성날짜,회의일시,회의장소,참석자,회의내용,향후일정,외부참석자,이슈사항)"
	    			+ "values(?,?,?,?,?,?,?,?,?,?,?)";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, id);
	    	pstmt.setString(2, MeetName);
	    	pstmt.setString(3, writer);
	    	pstmt.setString(4, date);
	    	pstmt.setString(5, MeetDate);
	    	pstmt.setString(6, MeetPlace);
	    	pstmt.setString(7, attendees);
	    	pstmt.setString(8, meetNote);
	    	pstmt.setString(9, nextPlan);
	    	pstmt.setString(10, attendees_ex);
	    	pstmt.setString(11, issue);
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
	
	// 회의록 수정
	public int updateMeet(int no, String MeetName, String MeetDate, String MeetPlace, String attendees,String attendees_ex, String meetNote, String issue) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "update meeting_log set 회의명=?, 회의일시=?, 회의장소=?, 참석자=?, 외부참석자=?, 회의내용=?, 이슈사항=? where no =?";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, MeetName);
	    	pstmt.setString(2, MeetDate);
	    	pstmt.setString(3, MeetPlace);
	    	pstmt.setString(4, attendees);
	    	pstmt.setString(5, attendees_ex);
	    	pstmt.setString(6, meetNote);
	    	pstmt.setString(7, issue);
	    	pstmt.setInt(8, no);
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
	
	// 회의록 삭제
	public int deleteMeet(int no) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    
	    try {
	    	String query = "delete from meeting_log where no =?";
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
	
	// 향후일정 테이블에 데이터 넣기
	public int insertNextPlanData(String writeTime, String [] item, String [] deadline, String [] pm, int count) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "insert into meeting_nextplan(writeTime,no,item,deadline,pm) values(?,?,?,?,?)";
	    	if(count > 1) {
	    		for(int i=0; i<count-1; i++) {
		    		query += ",(?,?,?,?,?)";
		    	}
	    		query += ";";
	    	}
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, writeTime);
	    	pstmt.setInt(2, 1);
	    	pstmt.setString(3, item[0]);
	    	pstmt.setString(4, deadline[0]);
	    	pstmt.setString(5, pm[0]);
	    	
	    	if(count > 1) {
	    		int cnt = 6;
	    		for(int j=0; j<count-1; j++) {
	    			pstmt.setString(cnt, writeTime);
		    		cnt++;
	    			pstmt.setInt(cnt, j+2);
		    		cnt++;
		    		pstmt.setString(cnt, item[j+1]);
		    		cnt++;
			    	pstmt.setString(cnt, deadline[j+1]);
			    	cnt++;
			    	pstmt.setString(cnt, pm[j+1]);
			    	cnt++;
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
	
	// 향후테이블 삭제
	public int dropNextPlanTable(String name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "delete from meeting_nextplan where writeTime=?";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, name);
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
	
	// 회의록테이블의 향후일정 데이터 업데이트 
	public int updateNextPlan(int no, String np) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "update meeting_log set 향후일정=? where no =?";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, np);
	    	pstmt.setInt(2, no);
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
	
	// row 개수 가져오기
	public int getRowCount() {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int row = 0;
	    try {
	    	String query = "SELECT no FROM meeting_log ORDER BY no DESC LIMIT 1;";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	if(rs.next()) {
	    		row = rs.getInt("no");
	    	}
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    return row;
	}
}	// end DAO
