package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import jsp.Bean.model.CareerBean;
import jsp.Bean.model.MemberBean;
import jsp.Bean.model.ProjectBean;
import jsp.Bean.model.schBean;

public class SchDAO {
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy");
	int year = Integer.parseInt(sf.format(nowTime));

	public SchDAO() {
	}

	// 7,8 단계인 프로젝트를 제외하고 가져오기
	public ArrayList<schBean> getProject_except8() {
		ArrayList<schBean> schList = new ArrayList<schBean>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDAO memberDao = new MemberDAO();

		Date nowTime = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy");
		int year = Integer.parseInt(sf.format(nowTime));
		ArrayList<MemberBean> memberList = memberDao.getMemberData(year);
		try {
			StringBuffer query = new StringBuffer();
			query.append(
					"SELECT career.*,project.PM as PPM,project.상태, project.투입명단, project.프로젝트명, member.이름, member.팀, member.직책, member.소속, member.직급 "
							+ "FROM career, member, project, team "
							+ "where career.id = member.id and career.projectNo = project.no and member.팀 = team.teamName "
							+ "and project.상태 != '8.dropped' and project.상태 != '7.종료' and project.year = " + year + " "
							+ "group by career.id, career.projectNo "
							+ "order by team.teamNum, field(member.소속,'슈어소프트테크')desc,"
							+ "member.소속,field(member.직책,'실장','팀장','-'), "
							+ "field(member.직급,'수석','책임','선임','전임','인턴','-'), member.이름");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				schBean sch = new schBean();
				sch.setId(rs.getString("id"));
				sch.setProjectNo(rs.getInt("projectNo"));
				String[] workerList_ID = rs.getString("투입명단").split(" ");
				String workerList_NAME = "";
				for (int i = 0; i < memberList.size(); i++) {
					if (memberList.get(i).getID().equals(rs.getString("PPM"))) {
						sch.setPm(memberList.get(i).getNAME());
						break;
					}
				}
				for (int j = 0; j < workerList_ID.length; j++) {
					for (int k = 0; k < memberList.size(); k++) {
						if (workerList_ID[j].equals(memberList.get(k).getID())) {
							workerList_NAME += memberList.get(k).getNAME() + " ";
							break;
						}
					}
				}
				sch.setState(rs.getString("상태"));
				sch.setWorkList(workerList_NAME);
				sch.setProjectName(rs.getString("프로젝트명"));
				sch.setStart(rs.getString("start"));
				sch.setEnd(rs.getString("end"));
				sch.setName(rs.getString("이름"));
				sch.setTeam(rs.getString("팀"));
				sch.setRank(rs.getString("직급"));
				if (rs.getString("상태").contains("6.진행중") == true) {
					sch.setColor("#D24F4F");
				} else if (rs.getString("상태").contains("7.종료") == true
						|| rs.getString("상태").contains("8.Dropped") == true) {
					sch.setColor("#848484");
				} else {
					sch.setColor("#358DCC");
				}
				schList.add(sch);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return schList;
	}

	// career 테이블 중 해당 id의 목록 가져오기
	public ArrayList<CareerBean> getCareer_id(String id) {
		ArrayList<CareerBean> careerList = new ArrayList<CareerBean>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			StringBuffer query = new StringBuffer();
			query.append(
					"select career.*, project.프로젝트명,project.상태 from career,project where career.projectNo=project.no and career.id = ? and project.상태 != '8.Dropped' and project.year = "
							+ year + " " + "order by field(project.상태,'6.진행중')desc");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CareerBean career = new CareerBean();
				career.setId(rs.getString("id"));
				career.setProjectNo(rs.getInt("projectNo"));
				career.setProjectName(rs.getString("프로젝트명"));
				career.setProjectState(rs.getString("상태"));
				career.setStart(rs.getString("start"));
				career.setEnd(rs.getString("end"));
				career.setPm(rs.getString("pm"));
				if (rs.getString("상태").contains("6.진행중") == true) {
					career.setColor("#D24F4F");
				} else if (rs.getString("상태").contains("7.종료") == true
						|| rs.getString("상태").contains("8.Dropped") == true) {
					career.setColor("#848484");
				} else {
					career.setColor("#358DCC");
				}
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
}
