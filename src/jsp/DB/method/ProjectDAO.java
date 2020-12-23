package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import jsp.Bean.model.*;

public class ProjectDAO {
	SimpleDateFormat sf = new SimpleDateFormat("yyyy");

	public ProjectDAO() {
	}

	// 프로젝트번호로 해당 데이터 가져오기
	public ProjectBean getProjectBean_no(int no, int year) {
		ProjectBean project = new ProjectBean();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			StringBuffer query = new StringBuffer();
			query.append("select * from project where no=? and year=?");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setInt(1, no);
			pstmt.setInt(2, year);
			rs = pstmt.executeQuery();

			if (rs.next()) {
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
				project.setYear(rs.getInt("year"));
				project.setCopy(rs.getString("copy"));
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

	// 시트에 동기화할 리스트 가져오기 (웹이 아닌 sheetMethod에서 사용)
	public ArrayList<ProjectBean> getProject_synchronization() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ProjectBean> pjList = new ArrayList<ProjectBean>();
		try {
			Date nowDate = new Date();
			int nowYear = Integer.parseInt(sf.format(nowDate));
			StringBuffer query = new StringBuffer();
			query.append("select * from project where year=" + nowYear + " and 실적보고 = 1 and year=? order by 상태");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setInt(1, nowYear);
			rs = pstmt.executeQuery();

			while (rs.next()) {
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
				project.setYear(rs.getInt("year"));
				project.setCopy(rs.getString("copy"));
				pjList.add(project);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return pjList;
	}

	// 주간보고서사용하는 프로젝트 개수
	public int useReportProject() {
		int num = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Date nowDate = new Date();
			int nowYear = Integer.parseInt(sf.format(nowDate));
			StringBuffer query = new StringBuffer();
			query.append("select count(*) from project where 주간보고서사용=1 and year =?");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setInt(1, nowYear);
			rs = pstmt.executeQuery();
			if (rs.next())
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

	// 해당 년도 팀 데이터 가져오기
	public ArrayList<String> getTeamData(String year) {
		ArrayList<String> list = new ArrayList<String>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			StringBuffer query = new StringBuffer();
			query.append("select * from team where year=" + year + " order by teamNum");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
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
	public int setProject(String TEAM_ORDER, String TEAM_SALES, String RPOJECT_CODE, String PROJECT_NAME, String STATE,
			String PART, String CLIENT, String CLIENT_PART, float MAN_MONTH, float PROJECT_DESOPIT,
			float FH_ORDER_PROJECTIONS, float FH_ORDER, float FH_SALES_PROJECTIONS, float FH_SALES,
			float SH_ORDER_PROJECTIONS, float SH_ORDER, float SH_SALES_PROJECTIONS, float SH_SALES,
			String PROJECT_START, String PROJECT_END, String CLIENT_PTB, String WORK_PLACE, String WORK,
			String PROJECT_MANAGER, String WORKER_LIST, String ASSESSMENT_TYPE, float EMPLOY_DEMAND,
			float OUTSOURCE_DEMAND, int REPORT_CHECK, int RESULT_REPORT, String copy, int year)

	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int no = 0;

		try {

			StringBuffer query = new StringBuffer();
			query.append("insert into project(팀_수주,팀_매출,프로젝트코드,프로젝트명,상태,실,고객사,고객부서,ManMonth,프로젝트계약금액_백만,"
					+ "상반기예상수주,상반기수주,상반기예상매출,상반기매출,하반기예상수주,하반기수주,하반기예상매출,하반기매출,착수,종료,고객담당자,근무지,"
					+ "업무,PM,투입명단,평가유형,채용수요,외주수요,주간보고서사용,실적보고,year,copy) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
			pstmt.setInt(31, year);
			pstmt.setString(32, copy);
			pstmt.executeUpdate();
			// no 반환
			rs = pstmt.executeQuery("select last_insert_id()");
			if (rs.next()) {
				no = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return no;
	}

	// 프로젝트 수정
	public int updateProject(String TEAM_ORDER, String TEAM_SALES, String RPOJECT_CODE, String PROJECT_NAME,
			String STATE, String PART, String CLIENT, String CLIENT_PART, float MAN_MONTH, float PROJECT_DESOPIT,
			float FH_ORDER_PROJECTIONS, float FH_ORDER, float FH_SALES_PROJECTIONS, float FH_SALES,
			float SH_ORDER_PROJECTIONS, float SH_ORDER, float SH_SALES_PROJECTIONS, float SH_SALES,
			String PROJECT_START, String PROJECT_END, String CLIENT_PTB, String WORK_PLACE, String WORK,
			String PROJECT_MANAGER, String WORKER_LIST, String ASSESSMENT_TYPE, float EMPLOY_DEMAND,
			float OUTSOURCE_DEMAND, int REPORT_CHECK, int RESULT_REPORT, int NO, int year, String copy)

	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			StringBuffer query = new StringBuffer();
			query.append(
					"UPDATE project SET 팀_수주=?,팀_매출=?,프로젝트코드=?,프로젝트명=?,상태=?,실=?,고객사=?,고객부서=?,ManMonth=?,프로젝트계약금액_백만=?,"
							+ "상반기예상수주=?,상반기수주=?,상반기예상매출=?,상반기매출=?,하반기예상수주=?,하반기수주=?,하반기예상매출=?,하반기매출=?,착수=?,종료=?,고객담당자=?,근무지=?,"
							+ "업무=?,PM=?,투입명단=?,평가유형=?,채용수요=?,외주수요=?,주간보고서사용=?,실적보고=?, copy=? WHERE no=? and year=?;");
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
			pstmt.setString(31, copy);
			pstmt.setInt(32, NO);
			pstmt.setInt(33, year);
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return rs;
	}

	// 프로젝트 리스트 가져오기
	public ArrayList<ProjectBean> getProjectList(int year) {
		ArrayList<ProjectBean> projectList = new ArrayList<ProjectBean>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			StringBuffer query = new StringBuffer();
			query.append("select * from project where year=? order by 상태, 착수 DESC, 종료 DESC");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setInt(1, year);
			rs = pstmt.executeQuery();

			while (rs.next()) {
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
				project.setCopy(rs.getString("copy"));
				if (rs.getString("상태").contains("6.진행중") == true) {
					project.setColor("#D24F4F");
				} else if (rs.getString("상태").contains("7.종료") == true
						|| rs.getString("상태").contains("8.Dropped") == true) {
					project.setColor("#848484");
				} else {
					project.setColor("#358DCC");
				}

				projectList.add(project);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return projectList;
	}

	// 팀 정렬로 프로젝트 가져오기
	public HashMap<String, ArrayList<Project_sch_Bean>> getProjectList_team() {
		MemberDAO memberDao = new MemberDAO();
		Date nowTime = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy");
		int year = Integer.parseInt(sf.format(nowTime));
		LinkedHashMap<Integer, String> teamList = memberDao.getTeam();
		ArrayList<MemberBean> memberList = memberDao.getMemberData(year);

		HashMap<String, ArrayList<Project_sch_Bean>> projectList = new HashMap<>();
		for (int key : teamList.keySet()) {
			projectList.put(teamList.get(key), new ArrayList<Project_sch_Bean>());
		}

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Date nowDate = new Date();
			int nowYear = Integer.parseInt(sf.format(nowDate));
			StringBuffer query = new StringBuffer();
			query.append("select * from project where 상태 != '8.Dropped' and year=?");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setInt(1, nowYear);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Project_sch_Bean project = new Project_sch_Bean();
				String team = "";
				String[] workerIdArray = {};
				String pmInfo = "";

				if (rs.getString("상태").contains("1") || rs.getString("상태").contains("2")
						|| rs.getString("상태").contains("3")) {
					project.setTEAM(rs.getString("팀_수주"));
					team = rs.getString("팀_수주");
				} else {
					project.setTEAM(rs.getString("팀_매출"));
					team = rs.getString("팀_매출");
				}
				project.setTEAM_ORDER(rs.getString("팀_수주"));
				project.setTEAM_SALES(rs.getString("팀_매출"));
				project.setPROJECT_NAME(rs.getString("프로젝트명"));
				project.setSTATE(rs.getString("상태"));
				project.setCLIENT(rs.getString("고객사"));
				project.setPROJECT_START(rs.getString("착수"));
				project.setPROJECT_END(rs.getString("종료"));
				if (rs.getString("PM") != null) {
					pmInfo = rs.getString("PM");
					for (int c = 0; c < memberList.size(); c++) {
						if (pmInfo.equals(memberList.get(c).getID())) {
							pmInfo = memberList.get(c).getNAME();
						}
					}
					project.setPROJECT_MANAGER(pmInfo);
				}
				if (rs.getString("투입명단") != null) {
					workerIdArray = rs.getString("투입명단").split(" ");
					String workerString = "";
					for (int a = 0; a < workerIdArray.length; a++) {
						for (int b = 0; b < memberList.size(); b++) {
							if (workerIdArray[a].equals(memberList.get(b).getID())) {
								workerString += memberList.get(b).getNAME();
							}
						}
						workerString += " ";
					}
					project.setWORKER_LIST(workerString);
				}
				project.setNO(rs.getInt("no"));
				if (rs.getString("상태").contains("6.진행중") == true) {
					project.setColor("#D24F4F");
				} else if (rs.getString("상태").contains("7.종료") == true
						|| rs.getString("상태").contains("8.Dropped") == true) {
					project.setColor("#848484");
				} else {
					project.setColor("#358DCC");
				}

				projectList.get(team).add(project);
			}
		} catch (SQLException e) {
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

	/*
		팝업창으로 프로젝트 수정 관련 함수
	*/
	// 프로젝트 조회에서 업데이트
	public int updateData(int no, String data, String attr, int year) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement("update project set " + attr + "=? where no=? and year=?");
			pstmt.setString(1, data);
			pstmt.setInt(2, no);
			pstmt.setInt(3, year);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return result;
	}

	// 탭 저장
	public int updateAttrList(String list, String ID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement("update member set saveAttr=? where id=?");
			pstmt.setString(1, list);
			pstmt.setString(2, ID);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return result;
	}

	public int updateCheck(int no, int check, String attr, int year) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement("update project set " + attr + "=? where no=? and year=?");
			pstmt.setInt(1, check);
			pstmt.setInt(2, no);
			pstmt.setInt(3, year);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return result;
	}

	public int updateState(int no, String state, int year) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement("update project set 상태=? where no=? and year=?");
			pstmt.setString(1, state);
			pstmt.setInt(2, no);
			pstmt.setInt(3, year);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return result;
	}

	public int updateTeam(int no, String team, String what, int year) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		String sel = "팀_" + what;

		try {
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement("update project set " + sel + "=? where no=? and year=?");
			pstmt.setString(1, team);
			pstmt.setInt(2, no);
			pstmt.setInt(3, year);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return result;
	}

	public int updatePM(int no, String pm) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement("update project set PM=? where no=?");
			pstmt.setString(1, pm);
			pstmt.setInt(2, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return result;
	}

	public int updateWorker(int no, String worker) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement("update project set 투입명단=? where no=?");
			pstmt.setString(1, worker);
			pstmt.setInt(2, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return result;
	}
	/*	팝업창으로 프로젝트 수정 관련 함수 끝 */

	// 프로젝트 dropped으로 상태 변경 시 값 초기화
	public int projectDropped(int NO) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			StringBuffer query = new StringBuffer();
			query.append("UPDATE project SET ManMonth=?,프로젝트계약금액_백만=?,상반기예상수주=?,상반기수주=?,상반기예상매출=?,상반기매출=?,"
					+ "하반기예상수주=?,하반기수주=?,하반기예상매출=?,하반기매출=?,채용수요=?,외주수요=?,주간보고서사용=?, copy=? WHERE no=?;");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setFloat(1, 0);
			pstmt.setFloat(2, 0);
			pstmt.setFloat(3, 0);
			pstmt.setFloat(4, 0);
			pstmt.setFloat(5, 0);
			pstmt.setFloat(6, 0);
			pstmt.setFloat(7, 0);
			pstmt.setFloat(8, 0);
			pstmt.setFloat(9, 0);
			pstmt.setFloat(10, 0);
			pstmt.setFloat(11, 0);
			pstmt.setFloat(12, 0);
			pstmt.setInt(13, 0);
			pstmt.setString(14, "0");
			pstmt.setInt(15, NO);

			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return rs;
	}

	// career테이블 투입인력 조회
	public ArrayList<CareerBean> getCarrer(String projectNo) {
		ArrayList<CareerBean> careerList = new ArrayList<CareerBean>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			StringBuffer query = new StringBuffer();
			query.append(
					"select career.* from rank ,career, member where career.id = member.id and member.직급 = rank.rank and projectNo = ? and pm = 0 order by field(member.소속,'슈어소프트테크')desc, member.소속, rank.rank_id, member.이름");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, projectNo);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				CareerBean career = new CareerBean();
				career.setId(rs.getString("id"));
				career.setProjectNo(rs.getInt("projectNo"));
				career.setStart(rs.getString("start"));
				career.setEnd(rs.getString("end"));
				career.setPm(rs.getString("pm"));
				careerList.add(career);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return careerList;
	}

	// career 테이블 PM 조회
	public ArrayList<CareerBean> getCarrerPM(String projectNo) {
		ArrayList<CareerBean> careerList = new ArrayList<CareerBean>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			StringBuffer query = new StringBuffer();
			query.append(
					"select career.* from rank ,career, member where career.id = member.id and member.직급 = rank.rank and projectNo = ? and pm = 1 order by field(member.소속,'슈어소프트테크')desc, member.소속, rank.rank_id, member.이름");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, projectNo);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				CareerBean career = new CareerBean();
				career.setId(rs.getString("id"));
				career.setProjectNo(rs.getInt("projectNo"));
				career.setStart(rs.getString("start"));
				career.setEnd(rs.getString("end"));
				career.setPm(rs.getString("pm"));
				careerList.add(career);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return careerList;
	}

	// career 삭제
	public int deleteCareer(int no, String pm) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement("delete from career where projectNo=? and pm=?");
			pstmt.setInt(1, no);
			pstmt.setString(2, pm);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return result;
	}

	// career 작성
	public int setCareer(String[] id, int projectNo, String[] start, String[] end, String pm)

	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			conn = DBconnection.getConnection();
			for (int i = 0; i < id.length; i++) {
				pstmt = conn.prepareStatement("insert into career(id,projectNo,start,end,pm) values(?,?,?,?,?)");
				pstmt.setString(1, id[i]);
				pstmt.setInt(2, projectNo);
				pstmt.setString(3, start[i]);
				pstmt.setString(4, end[i]);
				pstmt.setString(5, pm);
				rs = pstmt.executeUpdate();
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return rs;
	}

	// 전년도 프로젝트 복사
	public int copy_preYearData(){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int no = 0;

		try {
			int nowYear = maxYear();
			StringBuffer query = new StringBuffer();
			query.append(
					"insert into project (select 팀_수주, 팀_매출, 프로젝트코드, 프로젝트명, 상태, 실, 고객사, 고객부서, ManMonth, 프로젝트계약금액_백만, 상반기예상수주, 상반기수주, 상반기예상매출, 상반기매출, 하반기예상수주,"
							+ "하반기수주, 하반기예상매출, 하반기매출, 착수, 종료, 고객담당자, 근무지, 업무, PM, 투입명단, 평가유형, 채용수요, 외주수요, 주간보고서사용, 실적보고,no, (year+1) as year, copy"
							+ " from project where year = " + nowYear + " and copy = 1)");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return no;
	}
	
	// 전년도 프로젝트 삭제
	public int delete_preYearData(){
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result =0;
		
		try {
			int nowYear = maxYear();
			conn = DBconnection.getConnection();
			String sql = "DELETE FROM project WHERE year = " + nowYear;
			pstmt= conn.prepareStatement(sql);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {

			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return result;
	}


	public int minYear() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int year = 0;

		try {
			StringBuffer query = new StringBuffer();
			query.append("select min(year) from project");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				year = rs.getInt("min(year)");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
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
			query.append("select max(year) from project");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				year = rs.getInt("max(year)");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return year;
	}

	// 전체 년도 스프레드시트 SureSoft-PMS에 저장될 시트 리스트 가져오기
	public LinkedHashMap<String, String> getSpreadSheetList() {
		LinkedHashMap<String, String> list = new LinkedHashMap<String, String>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			StringBuffer query = new StringBuffer();
			query.append("select * from spreadSheet order by year;");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				list.put(rs.getString("year"), rs.getString("sheetName"));
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

	// 해당 년도 스프레드시트 SureSoft-PMS에 저장될 시트 이름 가져오기
	public String getSpreadSheetYear(String year) {
		String fileName = new String();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			StringBuffer query = new StringBuffer();
			query.append("select * from spreadSheet where year=?;");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, year);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				fileName = rs.getString("sheetName");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return fileName;
	}
	
	/*
		스프레드시트 리스트 관리
	*/
	// 1. spreadsheet 테이블 복사
	public int copySheetToSheetBackup() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			String query = "CREATE TABLE IF NOT EXISTS spreadBackUp SELECT * FROM spreadSheet;";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return rs;
	}

	// 2. spreadsheet 테이블 비우기
	public int truncateSpreadSheet() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			String query = "TRUNCATE TABLE spreadSheet;";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return rs;
	}

	// 3. 백업 테이블 spreadsheet 테이블로 복사
	public int copySheetBackUpToSheet() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			String query = "INSERT INTO spreadSheet SELECT * FROM spreadBackUp;";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return rs;
	}

	// 4. 백업테이블 삭제
	public int dropSheetBackUp() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			String query = "DROP TABLE spreadBackUp;";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return rs;
	}

	// 스프레드시트 테이블 수정(삭제 후 새로 만드는 방법으로 수정)
	public int insertSpreadSheet(String year[], String[] sheet, int cnt) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			copySheetToSheetBackup(); // 1. 백업테이블로 복사
			truncateSpreadSheet(); // 2. 스프레드시트 테이블 비우기
			StringBuffer query = new StringBuffer();
			query.append("insert into spreadSheet(year, sheetName) values(?,?)");
			if (cnt > 1) {
				for (int i = 0; i < cnt - 1; i++) {
					query.append(",(?,?)");
				}
			}
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, year[0]);
			pstmt.setString(2, sheet[0]);
			if (cnt > 1) {
				int count = 3;
				for (int i = 0; i < cnt - 1; i++) {
					pstmt.setString(count, year[i + 1]);
					count++;
					pstmt.setString(count, sheet[i + 1]);
					count++;
				}
			}
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			truncateSpreadSheet(); // 스프레드시트 테이블 비우기
			copySheetBackUpToSheet(); // 백업테이블에서 스프레드시트 테이블로 복사
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
			// 백업 테이블 삭제
			dropSheetBackUp();
		}

		return rs;
	}
} // end