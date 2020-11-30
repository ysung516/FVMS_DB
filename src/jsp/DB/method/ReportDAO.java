package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import jsp.Bean.model.ProjectBean;
import jsp.Bean.model.ReportBean;

public class ReportDAO {
	public ReportDAO() {
	}

	// 주차 계산
	public String getWeekly(String writeDate) throws ParseException {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sf2 = new SimpleDateFormat("yyyy-MM-dd-a-hh:mm");
		Date t1 = sf2.parse(writeDate);

		String[] dates = writeDate.split("-");
		int year = Integer.parseInt(dates[0]);
		int month = Integer.parseInt(dates[1]);
		int day = Integer.parseInt(dates[2]);
		int time = 0;
		String ampm = dates[3];
		if (ampm.equals("오후")) {
			time = Integer.parseInt(dates[4].split(":")[0]) + 12;
		} else {
			time = Integer.parseInt(dates[4].split(":")[0]);
		}

		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month - 1, day);

		int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK); // 수요일마다 주차 +1 (수요일==4)
		int weekly = 0; // 해당 달 주차

		if (dayOfWeek < 4) {
			weekly = calendar.get(Calendar.WEEK_OF_MONTH) - 1;
		} else if (dayOfWeek == 4) {
			if (time >= 19) {
				weekly = calendar.get(Calendar.WEEK_OF_MONTH);
			} else {
				weekly = calendar.get(Calendar.WEEK_OF_MONTH) - 1;
			}
		} else if (dayOfWeek > 4) {
			weekly = calendar.get(Calendar.WEEK_OF_MONTH);
		}

		if (weekly == 0) {
			cal.setTime(t1);
			cal.add(Calendar.MONTH, -1);
			int endWeek = cal.getActualMaximum(Calendar.WEEK_OF_MONTH);

			year = cal.get(Calendar.YEAR);
			month = month - 1;
			weekly = endWeek;
		}

		String ymw = year + "/" + month + "/" + weekly;

		return ymw;
	}

	// 등록날짜로 유효기간 보여주기
	public String validDate(String writeDate) {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat dateFmt = new SimpleDateFormat("MM-dd");
		String date = writeDate;
		String MonDate = "";
		String FriDate = "";
		String returnDate = "";
		int y = Integer.parseInt(date.split("-")[0]);
		int m = Integer.parseInt(date.split("-")[1]) - 1;
		int w = Integer.parseInt(date.split("-")[2]);

		cal.set(Calendar.YEAR, y);
		cal.set(Calendar.MONTH, m);
		cal.set(Calendar.DATE, w);

		if (cal.getTime().toString().split(" ")[0].equals("Sun")) {
			cal.set(Calendar.DATE, w - 7);
			cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
			MonDate = dateFmt.format(cal.getTime());
			cal.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
			FriDate = dateFmt.format(cal.getTime());
			returnDate = MonDate + " ~ " + FriDate;
		} else {
			cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
			MonDate = dateFmt.format(cal.getTime());
			cal.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
			FriDate = dateFmt.format(cal.getTime());
			returnDate = MonDate + "	 ~ " + FriDate;
		}
		return returnDate;
	}

	// 보고서 작성
	public int saveReport(String title, String writeDate, String weekPlan, String weekPro, String nextPlan,
			String user_id, String name, String specialty, String note, int projectNo, String weekly,
			String final_check) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(
					"insert into weekly_Report (id, 이름, 프로젝트명, 작성일, 금주계획, 금주진행, 차주계획, 특이사항, 비고, 프로젝트no, 주차, final)"
							+ "values(?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setString(1, user_id);
			pstmt.setString(2, name);
			pstmt.setString(3, title);
			pstmt.setString(4, writeDate);
			pstmt.setString(5, weekPlan);
			pstmt.setString(6, weekPro);
			pstmt.setString(7, nextPlan);
			pstmt.setString(8, specialty);
			pstmt.setString(9, note);
			pstmt.setInt(10, projectNo);
			pstmt.setString(11, weekly);
			pstmt.setString(12, final_check);
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return rs;
	}

	// 금주차 보고서 리스트 목록 가져오기
	public ArrayList<ReportBean> getReportList(String weekly) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ReportBean> reportList = new ArrayList<ReportBean>();

		try {
			StringBuffer query = new StringBuffer();
			query.append("select * from weekly_Report where 주차 = ?");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, weekly);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReportBean report = new ReportBean();
				report.setNo(rs.getInt("no"));
				report.setId(rs.getString("id"));
				report.setName(rs.getString("이름"));
				report.setTitle(rs.getString("프로젝트명"));
				report.setDate(rs.getString("작성일"));
				report.setWeekPlan(rs.getString("금주계획"));
				report.setWeekPro(rs.getString("금주진행"));
				report.setNextPlan(rs.getString("차주계획"));
				report.setSpecialty(rs.getString("특이사항"));
				report.setNote(rs.getString("비고"));
				report.setProjectNo(rs.getInt("프로젝트no"));
				report.setWeekly(rs.getString("주차"));
				report.setFinal_Check(rs.getString("final"));
				reportList.add(report);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return reportList;
	}

	// 키값으로 특정보고서 가져오기
	public ReportBean getReportBean(int no) {
		ReportBean report = new ReportBean();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			StringBuffer query = new StringBuffer();
			query.append("select * from weekly_Report where no=?");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				report.setId(rs.getString("id"));
				report.setName(rs.getString("이름"));
				report.setTitle(rs.getString("프로젝트명"));
				report.setDate(rs.getString("작성일"));
				report.setWeekPlan(rs.getString("금주계획"));
				report.setWeekPro(rs.getString("금주진행"));
				report.setNextPlan(rs.getString("차주계획"));
				report.setSpecialty(rs.getString("특이사항"));
				report.setNote(rs.getString("비고"));
				report.setProjectNo(rs.getInt("프로젝트no"));
				report.setWeekly(rs.getString("주차"));
				report.setFinal_Check(rs.getString("final"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return report;
	}

	// 전주차 보고서 가져오기
	public ReportBean getReportBackUp(int no, String weekly) {
		ReportBean report = new ReportBean();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			StringBuffer query = new StringBuffer();
			query.append(
					"select * from weekly_Report where 주차 = (select max(주차) from weekly_Report where 주차 < ?) and 프로젝트no=?");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, weekly);
			pstmt.setInt(2, no);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				report.setId(rs.getString("id"));
				report.setName(rs.getString("이름"));
				report.setTitle(rs.getString("프로젝트명"));
				report.setDate(rs.getString("작성일"));
				report.setWeekPlan(rs.getString("금주계획"));
				report.setWeekPro(rs.getString("금주진행"));
				report.setNextPlan(rs.getString("차주계획"));
				report.setSpecialty(rs.getString("특이사항"));
				report.setNote(rs.getString("비고"));
				report.setProjectNo(rs.getInt("프로젝트no"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return report;
	}

	// 보고서 수정
	public int updateReport(int no, String weekPlan, String weekPro, String nextPlan, String specialty, String note,
			String date, String weekly, String final_check) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			String query = "update weekly_Report set 금주계획=?, 작성일=?, 금주진행=?, 차주계획=?, 특이사항=?, 비고=?, 주차=?,final=? "
					+ "where no =?";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, weekPlan);
			pstmt.setString(2, date);
			pstmt.setString(3, weekPro);
			pstmt.setString(4, nextPlan);
			pstmt.setString(5, specialty);
			pstmt.setString(6, note);
			pstmt.setString(7, weekly);
			pstmt.setString(8, final_check);
			pstmt.setInt(9, no);
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

	// 보고서 삭제
	public int deleteReport(int no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			String query = "delete from weekly_Report where no =?";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setInt(1, no);
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

	// 주간보고서가 작성되지 않은 프로젝트의 no와 제목 가져오기
	public ArrayList<ProjectBean> getUnwrittenReport(String weekly) {
		ArrayList<ProjectBean> list = new ArrayList<ProjectBean>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int year = Integer.parseInt(weekly.split("/")[0]);

		try {
			String query = "SELECT a.no, a.프로젝트명, a.PM, a.투입명단 FROM project a left outer join (select * from weekly_Report where 주차 = ?)"
					+ " b on a.no = b.프로젝트no where b.프로젝트no is null AND a.주간보고서사용=1 and a.year = ?";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, weekly);
			pstmt.setInt(2, year);
			rs = pstmt.executeQuery();
			while (rs.next()) {

				ProjectBean project = new ProjectBean();
				project.setPROJECT_NAME(rs.getString("프로젝트명"));
				project.setNO(rs.getInt("no"));
				project.setPROJECT_MANAGER(rs.getNString("PM"));
				project.setWORKER_LIST(rs.getNString("투입명단"));
				list.add(project);
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

	public String minYear() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String year = "";

		try {
			StringBuffer query = new StringBuffer();
			query.append("select min(작성일) from weekly_Report");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				year = rs.getString("min(작성일)").split("-")[0];
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

} // end DAO
