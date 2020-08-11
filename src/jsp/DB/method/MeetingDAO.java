package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import jsp.Bean.model.MeetBean;

public class MeetingDAO {

	public MeetingDAO() {}
	
	
	// 회의록 리스트 가져오기
	public ArrayList<MeetBean> getMeetBean(){
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
		ArrayList<MeetBean> MeetList = new ArrayList<MeetBean>();
		
		try {
			StringBuffer query = new StringBuffer();
	    	query.append("select * from meeting_log");
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
	
	// 회의록 작성
	public int saveMeet(String id, String MeetName, String writer, String MeetDate, String MeetPlace,
			String attendees, String meetNote, String nextPlan, String date) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    
	    try {
	    	String query = "insert into meeting_log (ID,회의명,작성자,작성날짜,회의일시,회의장소,참석자,회의내용,향후일정)"
	    			+ "values(?,?,?,?,?,?,?,?,?)";
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
	public int updateMeet(int no, String MeetName, String MeetDate, String MeetPlace, String attendees, String meetNote, String  nextPlan) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "update meeting_log set 회의명=?, 회의일시=?, 회의장소=?, 참석자=?, 회의내용=?, 향후일정=? where no =?";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, MeetName);
	    	pstmt.setString(2, MeetDate);
	    	pstmt.setString(3, MeetPlace);
	    	pstmt.setString(4, attendees);
	    	pstmt.setString(5, meetNote);
	    	pstmt.setString(6, nextPlan);
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
	
}	// end DAO
