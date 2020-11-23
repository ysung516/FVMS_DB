package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import jsp.Bean.model.WorkPlaceBean;

public class ManagerDAO {
	
	public ManagerDAO() {}
	
	public ArrayList<WorkPlaceBean> getWorkPlaceList(int year){
		
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    ArrayList<WorkPlaceBean> list = new ArrayList<WorkPlaceBean>();
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("select * from workPlace where year=?");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setInt(1, year);
	    	rs = pstmt.executeQuery();
	    	while(rs.next()) {
	    		WorkPlaceBean wp = new WorkPlaceBean();
	    		wp.setPlace(rs.getString("place"));
	    		wp.setColor(rs.getString("color"));
	    		wp.setCost(rs.getInt("cost"));
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

	public int save_WorkPlace(String [] place, String [] color, String [] cost, int count, int year) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "insert into workPlace(place,color,cost,year) values(?,?,?,?) ";
	    	if(count > 1) {
	    		for(int i=0; i<count-1; i++) {
	    			query += ",(?,?,?,?)";
	    		}
	    		query += ";";
	    	}
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, place[0]);
	    	pstmt.setString(2, color[0]);
	    	pstmt.setInt(3, Integer.parseInt(cost[0]));
	    	pstmt.setInt(4, year);
	    	if(count > 1) {
	    		int cnt = 5;
	    		for(int j=0; j<count-1; j++) {
	    			pstmt.setString(cnt, place[j+1]);
	    			cnt ++;
	    			pstmt.setString(cnt, color[j+1]);
	    			cnt ++;
	    			pstmt.setInt(cnt, Integer.parseInt(cost[j+1]));
	    			cnt++;
	    			pstmt.setInt(cnt, year);
	    			cnt++;
	    		}
	    	}
	    	rs = pstmt.executeUpdate();
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
	    	backup2();
			e.printStackTrace();
		}finally {
			drop_backup();
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    
		return rs;
	}
	
	public int backup(int year) {
		Connection conn = null;
		PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "insert into backupWP (select * from workPlace where year = ?)";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setInt(1, year);
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
	
	public int backup2() {
		Connection conn = null;
		PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "insert into workPlace (select * from backupWP)";
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
	
	public int nextYear_copy(int year) {
		Connection conn = null;
		PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "insert into workPlace (select place, color, cost, (year+1) as year from workPlace where year = ?)";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setInt(1, year);
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
	
	public int drop_PlaceTable(int year) {
		backup(year);
		Connection conn = null;
		PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "delete from workPlace where year = ?";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setInt(1, year);
	    	rs = pstmt.executeUpdate();
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
	    	drop_backup();
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    return rs;
	}
	
	public int drop_backup() {
		Connection conn = null;
		PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "TRUNCATE backupWP";
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

}
