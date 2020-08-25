package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import jsp.Bean.model.ProjectBean;
import jsp.Bean.model.StateOfProBean;
import jsp.Bean.model.TeamBean;

public class SummaryDAO {
	public SummaryDAO() {}
	
	// 단계가 1,2,3인 프로젝트이 데이터
	public ArrayList<ProjectBean> getProjectData_OrderTeam(){
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    ArrayList<ProjectBean> list = new ArrayList<ProjectBean>();
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("SELECT * from project where 상태 like '1%' OR 상태 like '2%' OR 상태 like '3%';");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		ProjectBean project = new ProjectBean();
	    		project.setTEAM_ORDER(rs.getString("팀_수주"));
	    		project.setMAN_MONTH(rs.getFloat("ManMonth"));
	    		project.setFH_ORDER_PROJECTIONS(rs.getFloat("상반기예상수주"));
	    		project.setFH_ORDER(rs.getFloat("상반기수주"));
	    		project.setFH_SALES_PROJECTIONS(rs.getFloat("상반기예상매출"));
	    		project.setFH_SALES(rs.getFloat("상반기매출"));
	    		project.setSH_ORDER_PROJECTIONS(rs.getFloat("하반기예상수주"));
	    		project.setSH_ORDER(rs.getFloat("하반기수주"));
	    		project.setSH_SALES_PROJECTIONS(rs.getFloat("하반기예상매출"));
	    		project.setSH_SALES(rs.getFloat("하반기매출"));
	    		project.setNO(rs.getInt("no"));
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
	// 단계가 4,5,6,7,8인 프로젝트이 데이터
	public ArrayList<ProjectBean> getProjectData_SalesTeam(){
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    ArrayList<ProjectBean> list = new ArrayList<ProjectBean>();
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("select * from project where 상태 like '4%' OR 상태 like '5%' OR 상태 like '6%' OR 상태 like '7%' OR 상태 like '8%';");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		ProjectBean project = new ProjectBean();
	    		project.setTEAM_SALES(rs.getString("팀_매출"));
	    		project.setMAN_MONTH(rs.getFloat("ManMonth"));
	    		project.setFH_ORDER_PROJECTIONS(rs.getFloat("상반기예상수주"));
	    		project.setFH_ORDER(rs.getFloat("상반기수주"));
	    		project.setFH_SALES_PROJECTIONS(rs.getFloat("상반기예상매출"));
	    		project.setFH_SALES(rs.getFloat("상반기매출"));
	    		project.setSH_ORDER_PROJECTIONS(rs.getFloat("하반기예상수주"));
	    		project.setSH_ORDER(rs.getFloat("하반기수주"));
	    		project.setSH_SALES_PROJECTIONS(rs.getFloat("하반기예상매출"));
	    		project.setSH_SALES(rs.getFloat("하반기매출"));
	    		project.setNO(rs.getInt("no"));
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
	
	// 상태별 total
	public int State_ProjectCount(String state) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int cnt = 0;
	    try {
	    	StringBuffer query = new StringBuffer();
	    	conn = DBconnection.getConnection();
	    	query.append("SELECT count(*) from project where 상태 = ?;");
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, state);
	    	
	    	rs = pstmt.executeQuery();
	    	if(rs.next()) {
	    		cnt = rs.getInt(1);
	    	}
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    return cnt;
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
	
	// 팀별 목포 수주,매출 데이터 가져오기
	public ArrayList<TeamBean> getTagetData(){
		ArrayList<TeamBean> list = new ArrayList<TeamBean>();
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("SELECT * from team");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		TeamBean team = new TeamBean();
	    		team.setTeamNum(rs.getInt("teamNum"));
	    		team.setTeamName(rs.getString("teamName"));
	    		team.setFH_targetOrder(rs.getFloat("상반기목표수주"));
	    		team.setFH_targetSales(rs.getFloat("상반기목표매출"));
	    		team.setSH_targetOrder(rs.getFloat("하반기목표수주"));
	    		team.setSH_targetSales(rs.getFloat("하반기목표매출"));
	    		list.add(team);
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
	
	// 목표 수주,매출 저장
	public int[] saveTargetData(float FH_chassis_PJ, float FH_body_PJ, float FH_control_PJ, float FH_safe_PJ, float FH_auto_PJ, float FH_vt_PJ,
			float FH_chassis_SALES, float FH_body_SALES, float FH_control_SALES, float FH_safe_SALES, float FH_auto_SALES, float FH_vt_SALES,
			float SH_chassis_PJ, float SH_body_PJ, float SH_control_PJ, float SH_safe_PJ, float SH_auto_PJ, float SH_vt_PJ,
			float SH_chassis_SALES, float SH_body_SALES, float SH_control_SALES, float SH_safe_SALES, float SH_auto_SALES, float SH_vt_SALES) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int[] rs = new int[6];
	
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("update team set 상반기목표수주=?, 상반기목표매출=?, 하반기목표수주=?, 하반기목표매출=? where teamName=?;");
	    	conn = DBconnection.getConnection();
	    	conn.setAutoCommit(false);
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setFloat(1, FH_chassis_PJ);
	    	pstmt.setFloat(2, FH_chassis_SALES);
	    	pstmt.setFloat(3, SH_chassis_PJ);
	    	pstmt.setFloat(4, SH_chassis_SALES);
	    	pstmt.setString(5, "샤시힐스검증팀");
	    	pstmt.addBatch();
	    	
	    	pstmt.setFloat(1, FH_body_PJ);
	    	pstmt.setFloat(2, FH_body_SALES);
	    	pstmt.setFloat(3, SH_body_PJ);
	    	pstmt.setFloat(4, SH_body_SALES);
	    	pstmt.setString(5, "바디힐스검증팀");
	       	pstmt.addBatch();
	    	
	    	pstmt.setFloat(1, FH_control_PJ);
	    	pstmt.setFloat(2, FH_control_SALES);
	    	pstmt.setFloat(3, SH_control_PJ);
	    	pstmt.setFloat(4, SH_control_SALES);
	    	pstmt.setString(5, "제어로직검증팀");
	       	pstmt.addBatch();
	       	
	    	pstmt.setFloat(1, FH_safe_PJ);
	    	pstmt.setFloat(2, FH_safe_SALES);
	    	pstmt.setFloat(3, SH_safe_PJ);
	    	pstmt.setFloat(4, SH_safe_SALES);
	    	pstmt.setString(5, "기능안전검증팀");
	       	pstmt.addBatch();
	    	
	    	pstmt.setFloat(1, FH_auto_PJ);
	    	pstmt.setFloat(2, FH_auto_SALES);
	    	pstmt.setFloat(3, SH_auto_PJ);
	    	pstmt.setFloat(4, SH_auto_SALES);
	    	pstmt.setString(5, "자율주행검증팀");
	       	pstmt.addBatch();
	    	
	    	pstmt.setFloat(1, FH_vt_PJ);
	    	pstmt.setFloat(2, FH_vt_SALES);
	    	pstmt.setFloat(3, SH_vt_PJ);
	    	pstmt.setFloat(4, SH_vt_SALES);
	    	pstmt.setString(5, "미래차검증전략실");
	       	pstmt.addBatch();
	       	
	    	rs =pstmt.executeBatch();
	    	conn.commit();
	    	
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
