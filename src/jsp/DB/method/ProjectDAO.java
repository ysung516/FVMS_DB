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
	    		project.setTEAM_ORDER(rs.getString(1));
	    		project.setTEAM_SALES(rs.getString(2));
	    		project.setPROJECT_CODE(rs.getString(3));
	    		project.setPROJECT_NAME(rs.getString(4));
	    		project.setSTATE(rs.getString(5));
	    		project.setPART(rs.getString(6));
	    		project.setCLIENT(rs.getString(7));
	    		project.setClIENT_PART(rs.getString(8));
	    		project.setMAN_MONTH(rs.getFloat(9));
	    		project.setPROJECT_DESOPIT(rs.getFloat(10));
	    		project.setFH_ORDER_PROJECTIONS(rs.getFloat(11));
	    		project.setFH_ORDER(rs.getFloat(12));
	    		project.setFH_SALES_PROJECTIONS(rs.getFloat(13));
	    		project.setFH_SALES(rs.getFloat(14));
	    		project.setSH_ORDER_PROJECTIONS(rs.getFloat(15));
	    		project.setSH_ORDER(rs.getFloat(16));
	    		project.setSH_SALES_PROJECTIONS(rs.getFloat(17));
	    		project.setSH_SALES(rs.getFloat(18));
	    		project.setPROJECT_START(rs.getString(19));
	    		project.setPROJECT_END(rs.getString(20));
	    		project.setCLIENT_PTB(rs.getString(21));
	    		project.setWORK_PLACE(rs.getString(22));
	    		project.setWORK(rs.getString(23));
	    		project.setPROJECT_MANAGER(rs.getString(24));
	    		project.setWORKER_LIST(rs.getString(25));
	    		project.setASSESSMENT_TYPE(rs.getString(26));
	    		project.setEMPLOY_DEMAND(rs.getFloat(27));
	    		project.setOUTSOURCE_DEMAND(rs.getFloat(28));
	    		project.setREPORTCHECK(rs.getInt(29));
	    		project.setRESULT_REPORT(rs.getInt(30));
	    		project.setNO(rs.getInt(31));
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
	    	query.append("select * from team order by teamNum");
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
		String TEAM_ORDER,
		String TEAM_SALES,
		String RPOJECT_CODE,
		String PROJECT_NAME,
		String STATE,
		String PART,
		String CLIENT,
		String CLIENT_PART,
		float MAN_MONTH,
		float PROJECT_DESOPIT,
		float FH_ORDER_PROJECTIONS,
		float FH_ORDER, 
		float FH_SALES_PROJECTIONS, 
		float FH_SALES,
		float SH_ORDER_PROJECTIONS,
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
		int RESULT_REPORT) 
	
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		
		try {
			StringBuffer query = new StringBuffer();
	    	query.append("insert into project(팀_수주,팀_매출,프로젝트코드,프로젝트명,상태,실,고객사,고객부서,ManMonth,프로젝트계약금액_백만,"
	    			+ "상반기예상수주,상반기수주,상반기예상매출,상반기매출,하반기예상수주,하반기수주,하반기예상매출,하반기매출,착수,종료,고객담당자,근무지,"
	    			+ "업무,PM,투입명단,평가유형,채용수요,외주수요,주간보고서사용,실적보고) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, TEAM_ORDER);
	    	pstmt.setString(2, TEAM_SALES);
	    	pstmt.setString(3, RPOJECT_CODE);
	    	pstmt.setString(4, PROJECT_NAME);
	    	pstmt.setString(5, STATE);
	    	pstmt.setString(6, PART);
	    	pstmt.setString(7, CLIENT);
	    	pstmt.setString(8, CLIENT_PART);
	    	pstmt.setFloat(9, MAN_MONTH);
	    	pstmt.setFloat(10, PROJECT_DESOPIT);
	    	pstmt.setFloat(11, FH_ORDER_PROJECTIONS);
	    	pstmt.setFloat(12, FH_ORDER);
	    	pstmt.setFloat(13, FH_SALES_PROJECTIONS);
	    	pstmt.setFloat(14, FH_SALES);
	    	pstmt.setFloat(15, SH_ORDER_PROJECTIONS);
	    	pstmt.setFloat(16, SH_ORDER);
	    	pstmt.setFloat(17, SH_SALES_PROJECTIONS);
	    	pstmt.setFloat(18, SH_SALES);
	    	pstmt.setString(19, PROJECT_START);
	    	pstmt.setString(20, PROJECT_END);
	    	pstmt.setString(21, CLIENT_PTB);
	    	pstmt.setString(22, WORK_PLACE);
	    	pstmt.setString(23, WORK);
	    	pstmt.setString(24, PROJECT_MANAGER);
	    	pstmt.setString(25, WORKER_LIST);
	    	pstmt.setString(26, ASSESSMENT_TYPE);
	    	pstmt.setFloat(27, EMPLOY_DEMAND);
	    	pstmt.setFloat(28, OUTSOURCE_DEMAND);
	    	pstmt.setInt(29, REPORT_CHECK);
	    	pstmt.setInt(30, RESULT_REPORT);
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
		String TEAM_ORDER,
		String TEAM_SALES,
		String RPOJECT_CODE,
		String PROJECT_NAME,
		String STATE,
		String PART,
		String CLIENT,
		String CLIENT_PART,
		float MAN_MONTH,
		float PROJECT_DESOPIT,
		float FH_ORDER_PROJECTIONS,
		float FH_ORDER, 
		float FH_SALES_PROJECTIONS, 
		float FH_SALES,
		float SH_ORDER_PROJECTIONS,
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
		int RESULT_REPORT,
		int NO) 
	
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		
		try {
			StringBuffer query = new StringBuffer();
	    	query.append("UPDATE project SET 팀_수주=?,팀_매출=?,프로젝트코드=?,프로젝트명=?,상태=?,실=?,고객사=?,고객부서=?,ManMonth=?,프로젝트계약금액_백만=?,"
	    			+ "상반기예상수주=?,상반기수주=?,상반기예상매출=?,상반기매출=?,하반기예상수주=?,하반기수주=?,하반기예상매출=?,하반기매출=?,착수=?,종료=?,고객담당자=?,근무지=?,"
	    			+ "업무=?,PM=?,투입명단=?,평가유형=?,채용수요=?,외주수요=?,주간보고서사용=?,실적보고=? WHERE no=?;");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, TEAM_ORDER);
	    	pstmt.setString(2, TEAM_SALES);
	    	pstmt.setString(3, RPOJECT_CODE);
	    	pstmt.setString(4, PROJECT_NAME);
	    	pstmt.setString(5, STATE);
	    	pstmt.setString(6, PART);
	    	pstmt.setString(7, CLIENT);
	    	pstmt.setString(8, CLIENT_PART);
	    	pstmt.setFloat(9, MAN_MONTH);
	    	pstmt.setFloat(10, PROJECT_DESOPIT);
	    	pstmt.setFloat(11, FH_ORDER_PROJECTIONS);
	    	pstmt.setFloat(12, FH_ORDER);
	    	pstmt.setFloat(13, FH_SALES_PROJECTIONS);
	    	pstmt.setFloat(14, FH_SALES);
	    	pstmt.setFloat(15, SH_ORDER_PROJECTIONS);
	    	pstmt.setFloat(16, SH_ORDER);
	    	pstmt.setFloat(17, SH_SALES_PROJECTIONS);
	    	pstmt.setFloat(18, SH_SALES);
	    	pstmt.setString(19, PROJECT_START);
	    	pstmt.setString(20, PROJECT_END);
	    	pstmt.setString(21, CLIENT_PTB);
	    	pstmt.setString(22, WORK_PLACE);
	    	pstmt.setString(23, WORK);
	    	pstmt.setString(24, PROJECT_MANAGER);
	    	pstmt.setString(25, WORKER_LIST);
	    	pstmt.setString(26, ASSESSMENT_TYPE);
	    	pstmt.setFloat(27, EMPLOY_DEMAND);
	    	pstmt.setFloat(28, OUTSOURCE_DEMAND);
	    	pstmt.setInt(29, REPORT_CHECK);
	    	pstmt.setInt(30, RESULT_REPORT);
	    	pstmt.setInt(31, NO);
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
	    	query.append("select * from project order by 상태, 착수");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		ProjectBean project = new ProjectBean();
	    		project.setTEAM_ORDER(rs.getString("팀_수주"));
	    		project.setTEAM_SALES(rs.getString("팀_매출"));
	    		project.setPROJECT_CODE(rs.getString("프로젝트코드"));
	    		project.setPROJECT_NAME(rs.getString("프로젝트명"));
	    		project.setSTATE(rs.getString("상태"));
	    		project.setPART(rs.getString("실"));
	    		project.setCLIENT(rs.getString("고객사"));
	    		project.setClIENT_PART(rs.getString("고객부서"));
	    		project.setMAN_MONTH(rs.getFloat("ManMonth"));
	    		project.setPROJECT_DESOPIT(rs.getFloat("프로젝트계약금액_백만"));
	    		project.setFH_ORDER_PROJECTIONS(rs.getFloat("상반기예상수주"));
	    		project.setFH_ORDER(rs.getFloat("상반기수주"));
	    		project.setFH_SALES_PROJECTIONS(rs.getFloat("상반기예상매출"));
	    		project.setFH_SALES(rs.getFloat("상반기매출"));
	    		project.setSH_ORDER_PROJECTIONS(rs.getFloat("하반기예상수주"));
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
	    		project.setRESULT_REPORT(rs.getInt("실적보고"));
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
