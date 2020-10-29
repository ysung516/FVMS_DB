package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import jsp.Bean.model.CareerBean;
import jsp.Bean.model.ProjectBean;
import jsp.Bean.model.schBean;

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
		
		// 7,8 단계인 프로젝트를 제외하고 가져오기
		public ArrayList<schBean> getProject_except8(){
			ArrayList<schBean> schList = new ArrayList<schBean>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ProjectDAO projectDao = new ProjectDAO();
			MemberDAO memberDao = new MemberDAO();
			try {
				StringBuffer query = new StringBuffer();
		    	query.append("SELECT career.*, career.projectNo, project.프로젝트명, member.이름, member.팀, member.직책, member.소속, member.직급 "
		    			+ "FROM career, member, project, team "
		    			+ "where career.id = member.id and career.projectNo = project.no and member.팀 = team.teamName "
		    			+ "and project.상태 != '8.dropped'  "
		    			+ "group by career.id, career.projectNo "
		    			+ "order by team.teamNum, field(member.소속,'슈어소프트테크')desc,"
		    			+ "member.소속,field(member.직책,'실장','팀장','-'), "
		    			+ "field(member.직급,'수석','책임','선임','전임','인턴','-'), member.이름");
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	rs = pstmt.executeQuery();
		    	
				while(rs.next()) {
					schBean sch = new schBean();
					sch.setId(rs.getString("id"));
					sch.setProjectNo(rs.getInt("projectNo"));
					
					ProjectBean project = projectDao.getProjectBean_no(rs.getInt("projectNo"));
					sch.setWorkList(project.getWORKER_LIST());
					sch.setPm(project.getPROJECT_MANAGER());
					//sch.setPm(memberDao.returnMember(project.getPROJECT_MANAGER()).getNAME());
					
					sch.setProjectName(rs.getString("프로젝트명"));
					sch.setStart(rs.getString("start"));
					sch.setEnd(rs.getString("end"));
					sch.setName(rs.getString("이름"));
					sch.setTeam(rs.getString("팀"));
					sch.setRank(rs.getString("직급"));
					//sch.setPm(rs.getString("pm"));
					schList.add(sch);
				}
			}catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
			return schList;
		}

}
