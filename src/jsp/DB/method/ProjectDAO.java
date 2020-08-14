package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.cj.protocol.Resultset;

import jsp.Bean.model.ProjectBean;

public class ProjectDAO {
	public ProjectDAO() {}
	// 프로젝트명으로 해당 데이터 가져오기
	public ProjectBean getProjectBean_no(int no) {
		ProjectBean project = new ProjectBean();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			StringBuffer query = new StringBuffer();
	    	query.append("select * from project where no=?");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setInt(1, no);
	    	rs = pstmt.executeQuery();
	    	
	    	if(rs.next()) {
	    		project.setTEAM(rs.getString(1));
	    		project.setPROJECT_CODE(rs.getString(2));
	    		project.setPROJECT_NAME(rs.getString(3));
	    		project.setSTATE(rs.getString(4));
	    		project.setPART(rs.getString(5));
	    		project.setCLIENT(rs.getString(6));
	    		project.setClIENT_PART(rs.getString(7));
	    		project.setMAN_MONTH(rs.getFloat(8));
	    		project.setPROJECT_DESOPIT(rs.getFloat(9));
	    		project.setFH_ORDER(rs.getFloat(10));
	    		project.setFH_SALES_PROJECTIONS(rs.getFloat(11));
	    		project.setFH_SALES(rs.getFloat(12));
	    		project.setSH_ORDER(rs.getFloat(13));
	    		project.setSH_SALES_PROJECTIONS(rs.getFloat(14));
	    		project.setSH_SALES(rs.getFloat(15));
	    		project.setPROJECT_START(rs.getString(16));
	    		project.setPROJECT_END(rs.getString(17));
	    		project.setCLIENT_PTB(rs.getString(18));
	    		project.setWORK_PLACE(rs.getString(19));
	    		project.setWORK(rs.getString(20));
	    		project.setPROJECT_MANAGER(rs.getString(21));
	    		project.setWORKER_LIST(rs.getString(22));
	    		project.setASSESSMENT_TYPE(rs.getString(23));
	    		project.setEMPLOY_DEMAND(rs.getFloat(24));
	    		project.setOUTSOURCE_DEMAND(rs.getFloat(25));
	    		project.setREPORTCHECK(rs.getInt(26));
	    		project.setNO(rs.getInt(27));
	    	}
	    	
	    	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return project;
	}
		
	// 프로젝트명으로 해당 데이터 가져오기
//	public ProjectBean getProjectBean_name(String projectName) {
//		ProjectBean project = new ProjectBean();
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		try {
//			StringBuffer query = new StringBuffer();
//	    	query.append("select * from project where 프로젝트명=?");
//	    	conn = DBconnection.getConnection();
//	    	pstmt = conn.prepareStatement(query.toString());
//	    	pstmt.setString(1, projectName);
//	    	rs = pstmt.executeQuery();
//	    	
//	    	if(rs.next()) {
//	    		project.setTEAM(rs.getString(1));
//	    		project.setPROJECT_CODE(rs.getString(2));
//	    		project.setPROJECT_NAME(rs.getString(3));
//	    		project.setSTATE(rs.getString(4));
//	    		project.setPART(rs.getString(5));
//	    		project.setCLIENT(rs.getString(6));
//	    		project.setClIENT_PART(rs.getString(7));
//	    		project.setMAN_MONTH(rs.getFloat(8));
//	    		project.setPROJECT_DESOPIT(rs.getFloat(9));
//	    		project.setFH_ORDER(rs.getFloat(10));
//	    		project.setFH_SALES_PROJECTIONS(rs.getFloat(11));
//	    		project.setFH_SALES(rs.getFloat(12));
//	    		project.setSH_ORDER(rs.getFloat(13));
//	    		project.setSH_SALES_PROJECTIONS(rs.getFloat(14));
//	    		project.setSH_SALES(rs.getFloat(15));
//	    		project.setPROJECT_START(rs.getString(16));
//	    		project.setPROJECT_END(rs.getString(17));
//	    		project.setCLIENT_PTB(rs.getString(18));
//	    		project.setWORK_PLACE(rs.getString(19));
//	    		project.setWORK(rs.getString(20));
//	    		project.setPROJECT_MANAGER(rs.getString(21));
//	    		project.setWORKER_LIST(rs.getString(22));
//	    		project.setASSESSMENT_TYPE(rs.getString(23));
//	    		project.setEMPLOY_DEMAND(rs.getFloat(24));
//	    		project.setOUTSOURCE_DEMAND(rs.getFloat(25));
//	    		project.setREPORTCHECK(rs.getInt(26));
//	    		project.setNO(rs.getInt(27));
//	    	}
//	    	
//	    	
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} finally {
//			if(rs != null) try {rs.close();} catch(SQLException ex) {}
//			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
//			if(conn != null) try {conn.close();} catch(SQLException ex) {}
//		}
//		return project;
//	}
//	
//	// 프로젝트코드로 해당 데이터 가져오기
//	public ProjectBean getProjectBean_code(String projectCode) {
//		ProjectBean project = new ProjectBean();
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		try {
//			StringBuffer query = new StringBuffer();
//	    	query.append("select * from project where 프로젝트코드=?");
//	    	conn = DBconnection.getConnection();
//	    	pstmt = conn.prepareStatement(query.toString());
//	    	pstmt.setString(1, projectCode);
//	    	rs = pstmt.executeQuery();
//	    	
//	    	if(rs.next()) {
//	    		project.setTEAM(rs.getString(1));
//	    		project.setPROJECT_CODE(rs.getString(2));
//	    		project.setPROJECT_NAME(rs.getString(3));
//	    		project.setSTATE(rs.getString(4));
//	    		project.setPART(rs.getString(5));
//	    		project.setCLIENT(rs.getString(6));
//	    		project.setClIENT_PART(rs.getString(7));
//	    		project.setMAN_MONTH(rs.getFloat(8));
//	    		project.setPROJECT_DESOPIT(rs.getFloat(9));
//	    		project.setFH_ORDER(rs.getFloat(10));
//	    		project.setFH_SALES_PROJECTIONS(rs.getFloat(11));
//	    		project.setFH_SALES(rs.getFloat(12));
//	    		project.setSH_ORDER(rs.getFloat(13));
//	    		project.setSH_SALES_PROJECTIONS(rs.getFloat(14));
//	    		project.setSH_SALES(rs.getFloat(15));
//	    		project.setPROJECT_START(rs.getString(16));
//	    		project.setPROJECT_END(rs.getString(17));
//	    		project.setCLIENT_PTB(rs.getString(18));
//	    		project.setWORK_PLACE(rs.getString(19));
//	    		project.setWORK(rs.getString(20));
//	    		project.setPROJECT_MANAGER(rs.getString(21));
//	    		project.setWORKER_LIST(rs.getString(22));
//	    		project.setASSESSMENT_TYPE(rs.getString(23));
//	    		project.setEMPLOY_DEMAND(rs.getFloat(24));
//	    		project.setOUTSOURCE_DEMAND(rs.getFloat(25));
//	    		project.setREPORTCHECK(rs.getInt(26));
//	    		project.setNO(rs.getInt(27));
//	    	}
//	    	
//	    	
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} finally {
//			if(rs != null) try {rs.close();} catch(SQLException ex) {}
//			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
//			if(conn != null) try {conn.close();} catch(SQLException ex) {}
//		}
//		return project;
//	}
	
	//주간보고서사용하는 프로젝트 개수
	public int useReportProject() {
		int num =0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			StringBuffer query = new StringBuffer();
	    	query.append("select count(*) from project where 주간보고서사용=1");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	if(rs.next())
	    		num = rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return num;
	}
	
	// 팀 데이터 가져오기
	public ArrayList<String> getTeamData(){
		ArrayList<String> list = new ArrayList<String>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			StringBuffer query = new StringBuffer();
	    	query.append("select * from team");
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
	
	// 프로젝트 작성
	public int setProject(
		String TEAM,
		String RPOJECT_CODE,
		String PROJECT_NAME,
		String STATE,
		String PART,
		String CLIENT,
		String CLIENT_PART,
		float MAN_MONTH,
		float PROJECT_DESOPIT,
		float FH_ORDER, 
		float FH_SALES_PROJECTIONS, 
		float FH_SALES,
		float SH_ORDER,
		float SH_SALES_PROJECTIONS,
		float SH_SALES,
		String PROJECT_START,
		String PROJECT_END,
		String CLIENT_PTB,
		String WORK_PLACE,
		String WORK,
		String PROJECT_MANAGER,
		String WORKER_LIST,
		String ASSESSMENT_TYPE,
		float EMPLOY_DEMAND,
		float OUTSOURCE_DEMAND,
		int REPORT_CHECK) 
	
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		
		try {
			StringBuffer query = new StringBuffer();
	    	query.append("insert into project(팀,프로젝트코드,프로젝트명,상태,실,고객사,고객부서,ManMonth,프로젝트계약금액_백만,"
	    			+ "상반기수주,상반기예상매출,상반기매출,하반기수주,하반기예상매출,하반기매출,착수,종료,고객담당자,근무지,"
	    			+ "업무,PM,투입명단,평가유형,채용수요,외주수요,주간보고서사용) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, TEAM);
	    	pstmt.setString(2, RPOJECT_CODE);
	    	pstmt.setString(3, PROJECT_NAME);
	    	pstmt.setString(4, STATE);
	    	pstmt.setString(5, PART);
	    	pstmt.setString(6, CLIENT);
	    	pstmt.setString(7, CLIENT_PART);
	    	pstmt.setFloat(8, MAN_MONTH);
	    	pstmt.setFloat(9, PROJECT_DESOPIT);
	    	pstmt.setFloat(10, FH_ORDER);
	    	pstmt.setFloat(11, FH_SALES_PROJECTIONS);
	    	pstmt.setFloat(12, FH_SALES);
	    	pstmt.setFloat(13, SH_ORDER);
	    	pstmt.setFloat(14, SH_SALES_PROJECTIONS);
	    	pstmt.setFloat(15, SH_SALES);
	    	pstmt.setString(16, PROJECT_START);
	    	pstmt.setString(17, PROJECT_END);
	    	pstmt.setString(18, CLIENT_PTB);
	    	pstmt.setString(19, WORK_PLACE);
	    	pstmt.setString(20, WORK);
	    	pstmt.setString(21, PROJECT_MANAGER);
	    	pstmt.setString(22, WORKER_LIST);
	    	pstmt.setString(23, ASSESSMENT_TYPE);
	    	pstmt.setFloat(24, EMPLOY_DEMAND);
	    	pstmt.setFloat(25, OUTSOURCE_DEMAND);
	    	pstmt.setInt(26, REPORT_CHECK);
	    	rs = pstmt.executeUpdate();
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return rs;
	}
	
	// 프로젝트 수정
	public int updateProject(
		String TEAM,
		String RPOJECT_CODE,
		String PROJECT_NAME,
		String STATE,
		String PART,
		String CLIENT,
		String CLIENT_PART,
		float MAN_MONTH,
		float PROJECT_DESOPIT,
		float FH_ORDER, 
		float FH_SALES_PROJECTIONS, 
		float FH_SALES,
		float SH_ORDER,
		float SH_SALES_PROJECTIONS,
		float SH_SALES,
		String PROJECT_START,
		String PROJECT_END,
		String CLIENT_PTB,
		String WORK_PLACE,
		String WORK,
		String PROJECT_MANAGER,
		String WORKER_LIST,
		String ASSESSMENT_TYPE,
		float EMPLOY_DEMAND,
		float OUTSOURCE_DEMAND,
		int REPORT_CHECK,
		int NO) 
	
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		
		try {
			StringBuffer query = new StringBuffer();
	    	query.append("UPDATE project SET 팀=?,프로젝트코드=?,프로젝트명=?,상태=?,실=?,고객사=?,고객부서=?,ManMonth=?,프로젝트계약금액_백만=?,"
	    			+ "상반기수주=?,상반기예상매출=?,상반기매출=?,하반기수주=?,하반기예상매출=?,하반기매출=?,착수=?,종료=?,고객담당자=?,근무지=?,"
	    			+ "업무=?,PM=?,투입명단=?,평가유형=?,채용수요=?,외주수요=?,주간보고서사용=? WHERE no=?");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, TEAM);
	    	pstmt.setString(2, RPOJECT_CODE);
	    	pstmt.setString(3, PROJECT_NAME);
	    	pstmt.setString(4, STATE);
	    	pstmt.setString(5, PART);
	    	pstmt.setString(6, CLIENT);
	    	pstmt.setString(7, CLIENT_PART);
	    	pstmt.setFloat(8, MAN_MONTH);
	    	pstmt.setFloat(9, PROJECT_DESOPIT);
	    	pstmt.setFloat(10, FH_ORDER);
	    	pstmt.setFloat(11, FH_SALES_PROJECTIONS);
	    	pstmt.setFloat(12, FH_SALES);
	    	pstmt.setFloat(13, SH_ORDER);
	    	pstmt.setFloat(14, SH_SALES_PROJECTIONS);
	    	pstmt.setFloat(15, SH_SALES);
	    	pstmt.setString(16, PROJECT_START);
	    	pstmt.setString(17, PROJECT_END);
	    	pstmt.setString(18, CLIENT_PTB);
	    	pstmt.setString(19, WORK_PLACE);
	    	pstmt.setString(20, WORK);
	    	pstmt.setString(21, PROJECT_MANAGER);
	    	pstmt.setString(22, WORKER_LIST);
	    	pstmt.setString(23, ASSESSMENT_TYPE);
	    	pstmt.setFloat(24, EMPLOY_DEMAND);
	    	pstmt.setFloat(25, OUTSOURCE_DEMAND);
	    	pstmt.setInt(26, REPORT_CHECK);
	    	pstmt.setInt(27, NO);
	    	rs = pstmt.executeUpdate();
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return rs;
	}
	
	// 프로젝트 리스트 가져오기
	public ArrayList<ProjectBean> getProjectList(){
		ArrayList<ProjectBean> projectList = new ArrayList<ProjectBean>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			StringBuffer query = new StringBuffer();
	    	query.append("select * from project");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		ProjectBean project = new ProjectBean();
	    		project.setTEAM(rs.getString("팀"));
	    		project.setPROJECT_CODE(rs.getString("프로젝트코드"));
	    		project.setPROJECT_NAME(rs.getString("프로젝트명"));
	    		project.setSTATE(rs.getString("상태"));
	    		project.setPART(rs.getString("실"));
	    		project.setCLIENT(rs.getString("고객사"));
	    		project.setClIENT_PART(rs.getString("고객부서"));
	    		project.setMAN_MONTH(rs.getFloat("ManMonth"));
	    		project.setPROJECT_DESOPIT(rs.getFloat("프로젝트계약금액_백만"));
	    		project.setFH_ORDER(rs.getFloat("상반기수주"));
	    		project.setFH_SALES_PROJECTIONS(rs.getFloat("상반기예상매출"));
	    		project.setFH_SALES(rs.getFloat("상반기매출"));
	    		project.setSH_ORDER(rs.getFloat("하반기수주"));
	    		project.setSH_SALES_PROJECTIONS(rs.getFloat("하반기예상매출"));
	    		project.setSH_SALES(rs.getFloat("하반기매출"));
	    		project.setPROJECT_START(rs.getString("착수"));
	    		project.setPROJECT_END(rs.getString("종료"));
	    		project.setCLIENT_PTB(rs.getString("고객담당자"));
	    		project.setWORK_PLACE(rs.getString("근무지"));
	    		project.setWORK(rs.getString("업무"));
	    		project.setPROJECT_MANAGER(rs.getString("PM"));
	    		project.setWORKER_LIST(rs.getString("투입명단"));
	    		project.setASSESSMENT_TYPE(rs.getString("평가유형"));
	    		project.setEMPLOY_DEMAND(rs.getFloat("채용수요"));
	    		project.setOUTSOURCE_DEMAND(rs.getFloat("외주수요"));
	    		project.setREPORTCHECK(rs.getInt("주간보고서사용"));
	    		project.setNO(rs.getInt("no"));
	    		projectList.add(project);
	    	}
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return projectList;
	}
	
	// 프로젝트 삭제
	public int deleteProject(int no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement("delete from project where no=?");
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return result;
	}
	
	
	
}	// end 
