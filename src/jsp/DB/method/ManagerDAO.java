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
	
	
	
	
	
	
	
	
	
	
}
