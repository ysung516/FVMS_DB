package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import jsp.Bean.model.StateOfProBean;

public class SummaryDAO {
	public SummaryDAO() {}
	
	//단계가 1,2,3인 프로젝트의 팀정보
	public ArrayList<StateOfProBean> StateProjectNum_sales() {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    ArrayList<StateOfProBean> list = new ArrayList<StateOfProBean>();
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("SELECT 팀_수주, 상태, count(*) from project where 상태 like '1%' OR 상태 like '2%' OR 상태 like '3%' group by 팀_수주, 상태;");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		StateOfProBean stateBean = new StateOfProBean();
	    		stateBean.setTeam(rs.getString(1));
	    		stateBean.setState(rs.getString(2));
	    		stateBean.setCnt(rs.getInt(3));
	    		list.add(stateBean);
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
	
	//단계가 4,5,6,7,8인 프로젝트의 팀정보
	public ArrayList<StateOfProBean> StateProjectNum_order() {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    ArrayList<StateOfProBean> list = new ArrayList<StateOfProBean>();
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("SELECT 팀_매출, 상태, count(*) from project where 상태 like '4%' OR 상태 like '5%' OR 상태 like '6%' OR 상태 like '7%' OR 상태 like '8%' group by 팀_매출, 상태;");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		StateOfProBean stateBean = new StateOfProBean();
	    		stateBean.setTeam(rs.getString(1));
	    		stateBean.setState(rs.getString(2));
	    		stateBean.setCnt(rs.getInt(3));
	    		list.add(stateBean);
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
	
	//프로젝트 단계별 합
	public ArrayList<int[]> stateNum() {
		ArrayList<int[]> list = new ArrayList<int[]>();
		
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("SELECT 상태, count(*) from project group by 상태;");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		int[] stateNum = {0,0};
	    		//String[] str = rs.getString(1).split("");
	    		//stateNum[0] = Integer.parseInt(str.split(".")[0]);
	    		stateNum[1] = rs.getInt(2);
	    		list.add(stateNum);
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
}
