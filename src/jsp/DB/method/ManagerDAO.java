package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import jsp.Bean.model.WorkPlaceBean;

public class ManagerDAO {
	
	public ManagerDAO() {}
	
	public ArrayList<WorkPlaceBean> getWorkPlaceList(){
		
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    ArrayList<WorkPlaceBean> list = new ArrayList<WorkPlaceBean>();
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("select * from workPlace");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	while(rs.next()) {
	    		WorkPlaceBean wp = new WorkPlaceBean();
	    		wp.setNo(rs.getInt("no"));
	    		wp.setPlace(rs.getString("place"));
	    		wp.setColor(rs.getString("color"));
	    		list.add(wp);
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

	// 회의록 작성
	public int save_WorkPlace(String [] place, String [] color, int count) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    
	    try {
	    	String query = "insert into workPlace(place,color) values(?,?) ";
	    	if(count > 1) {
	    		for(int i=0; i<count-1; i++) {
	    			query += ",(?,?)";
	    		}
	    		query += ";";
	    	}
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, place[0]);
	    	pstmt.setString(2, color[0]);
	    	
	    	if(count > 1) {
	    		int cnt = 3;
	    		for(int j=0; j<count-1; j++) {
	    			pstmt.setString(cnt, place[j+1]);
	    			cnt ++;
	    			pstmt.setString(cnt, color[j+1]);
	    			cnt ++;
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
	    System.out.println(rs);
		return rs;
	}
	
	// 향후테이블 삭제
	public int drop_PlaceTable() {
		Connection conn = null;
		PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "TRUNCATE workPlace";
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

}
