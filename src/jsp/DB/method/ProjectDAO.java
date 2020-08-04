package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jsp.Bean.model.ProjectBean;

public class ProjectDAO {
	public ProjectDAO() {}
	
	// 프로젝트명으로 해당 데이터 가져오기
	public ProjectBean getProjectBean_name(String projectName) {
		ProjectBean project = new ProjectBean();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			StringBuffer query = new StringBuffer();
	    	query.append("select * from project where 프로젝트명=?");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, projectName);
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
	    	}
	    	
	    	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return project;
	}
	
	
	
	
}
