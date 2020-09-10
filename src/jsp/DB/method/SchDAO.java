package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import jsp.Bean.model.ProjectBean;

public class SchDAO {
	public SchDAO() {}
	// 프로젝트 리스트 가져오기
		public ArrayList<ProjectBean> getProjectList_sch(){
			ArrayList<ProjectBean> projectList = new ArrayList<ProjectBean>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				StringBuffer query = new StringBuffer();
		    	query.append("select * from project where 상태 != '8.Dropped'");
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

}
