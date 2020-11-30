package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import jsp.Bean.model.MSC_Bean;
import jsp.Bean.model.MemberBean;

public class MSC_DAO {
	public MSC_DAO() {
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		MSC_DAO test = new MSC_DAO();

	}

	// 전체 관리자 일정 가져오기
	public ArrayList<MSC_Bean> allMSC() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MSC_Bean> msc = new ArrayList<MSC_Bean>();
		HashMap<String, String> color = getColor();
		try {
			StringBuffer query = new StringBuffer();
			query.append("select member.팀, member.이름, member.level, manager_schedule.* "
					+ "from manager_schedule, member " + "where  manager_schedule.ID = member.ID and member.퇴사일 = '-'");

			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MSC_Bean mb = new MSC_Bean();
				mb.setNo(rs.getInt("no"));
				mb.setID(rs.getString("ID"));
				mb.setTeam(rs.getString("팀"));
				mb.setName(rs.getString("이름"));
				mb.setDate(rs.getString("날짜"));
				mb.setAMplace(rs.getString("오전장소"));
				mb.setPMplace(rs.getString("오후장소"));
				if (color.get(rs.getString("오전장소")) != null) {
					mb.setAMcolor(color.get(rs.getString("오전장소")));
				} else {
					mb.setAMcolor("#ffffff");
				}

				if (color.get(rs.getString("오후장소")) != null) {
					mb.setPMcolor(color.get(rs.getString("오후장소")));
				} else {
					mb.setPMcolor("#ffffff");
				}
				mb.setLevel(rs.getInt("level"));
				msc.add(mb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return msc;
	}

	// 근무지 색상 가져오기
	public HashMap<String, String> getColor() {
		HashMap<String, String> color = new LinkedHashMap<String, String>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			StringBuffer query = new StringBuffer();
			query.append("SELECT * from workPlace");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				color.put(rs.getString("place"), rs.getString("color"));
			}
			color.put("휴가", "#cadeb5");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return color;
	}

	// id, date로 해당 관리자 일정 데이터 no 가져오기
	// 관리자 일정 같은 날짜에 ID가 중복되는지 확인
	public int returnNo(String id, String date) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int no = 0;

		try {
			StringBuffer query = new StringBuffer();
			query.append("select no from manager_schedule where ID=? and 날짜=?");

			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, date);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				no = rs.getInt("no");
			} else {
				return 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return no;
	}

	// 특정 관리자 일정 가져오기
	public MSC_Bean getMSCList_set(int no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MSC_Bean msc = new MSC_Bean();

		try {
			StringBuffer query = new StringBuffer();
			query.append(
					"select member.팀, member.이름, member.level, manager_schedule.* " + "from manager_schedule, member "
							+ "where  manager_schedule.ID = member.ID and manager_schedule.no = ?");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				msc.setNo(rs.getInt("no"));
				msc.setID(rs.getString("ID"));
				msc.setTeam(rs.getString("팀"));
				msc.setName(rs.getString("이름"));
				msc.setDate(rs.getString("날짜"));
				msc.setAMplace(rs.getString("오전장소"));
				msc.setPMplace(rs.getString("오후장소"));
				msc.setLevel(rs.getInt("level"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return msc;
	}

	// 관리자 일정 추가
	public int insert_MSC(String id, String amPlace, String pmPlace, String date) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement("insert into manager_schedule(ID, 날짜, 오전장소, 오후장소) " + "values(?, ?, ?, ?)");
			pstmt.setString(1, id);
			pstmt.setString(2, date);
			pstmt.setString(3, amPlace);
			pstmt.setString(4, pmPlace);
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return rs;
	}

	// 관리자 일정 삭제
	public int delete_MSC(int no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement("delete from manager_schedule where no=?");
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

	// 관리자 일정 수정
	public int update_MSC(int no, String amPlace, String pmPlace, String date) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement("update manager_schedule set 날짜=?, 오전장소=?, 오후장소=? where no=?");
			pstmt.setString(1, date);
			pstmt.setString(2, amPlace);
			pstmt.setString(3, pmPlace);
			pstmt.setInt(4, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return result;
	}

	// 관리자 일주일 일정 추가
	public ArrayList<String> weekAdd_MSC(String[] AmPlace_arr, String[] PmPlace_arr, String[] date_arr,
			String sessionID) {

		ArrayList<String> print = new ArrayList<String>();
		String add_date[] = { "", "", "", "", "" };
		String update_date[] = { "", "", "", "", "" };

		for (int i = 0; i < 5; i++)
			if (returnNo(sessionID, date_arr[i]) == 0) {
				insert_MSC(sessionID, AmPlace_arr[i], PmPlace_arr[i], date_arr[i]);
				add_date[i] = date_arr[i];
			} else {
				update_MSC(returnNo(sessionID, date_arr[i]), AmPlace_arr[i], PmPlace_arr[i], date_arr[i]);
				update_date[i] = date_arr[i];
			}

		print.add("====일정 추가====");
		for (int i = 0; i < 5; i++) {
			if (add_date[i] != "")
				print.add(add_date[i]);
		}
		print.add("====일정 수정====");
		for (int i = 0; i < 5; i++) {
			if (update_date[i] != "")
				print.add(update_date[i]);
		}

		return print;
	}

}
