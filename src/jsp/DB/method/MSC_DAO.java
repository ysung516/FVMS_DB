package jsp.DB.method;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import jsp.Bean.model.MSC_Bean;
import jsp.Bean.model.MemberBean;

public class MSC_DAO {
	public MSC_DAO() {}
	
	//전체 관리자 일정 가져오기
	public ArrayList<MSC_Bean> allMSC() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MSC_Bean> msc = new ArrayList<MSC_Bean>();
		
		try {
			StringBuffer query = new StringBuffer();
			query.append("select * from manager_schedule");
			
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MSC_Bean mb = new MSC_Bean();
				mb.setNo(rs.getInt("no"));
				mb.setID(rs.getString("ID"));
				mb.setTeam(rs.getString("팀"));
				mb.setName(rs.getString("이름"));
				mb.setDate(rs.getString("날짜"));
				mb.setAMplace(rs.getString("오전장소"));
				mb.setPMplace(rs.getString("오후장소"));
				mb.setLevel(rs.getInt("level"));
				msc.add(mb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return msc;
	}
	
	//id, date로 해당 관리자 일정 데이터 no 가져오기
	//관리자 일정 같은 날짜에 ID가 중복되는지 확인
	public int returnNo (String id, String date) {
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
			if(rs.next()) {
				no = rs.getInt("no");
			}
			else {return 0;}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return no;
	}
	
	//특정 관리자 일정 가져오기
	public MSC_Bean getMSCList_set (int no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MSC_Bean msc = new MSC_Bean();
		
		try {
			StringBuffer query = new StringBuffer();
			query.append("select * from manager_schedule where no=?");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
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
		}
		
		return msc;
	}
	
	//관리자 일정 추가
	public int insert_MSC (String id, String amPlace, String pmPlace
			, String date, String team, String name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		MemberDAO memberDao = new MemberDAO();
		MemberBean mb = memberDao.returnMember(id);
		int level = mb.getLevel();
		int rs = 0;
		
		try {
				conn = DBconnection.getConnection();
				pstmt = conn.prepareStatement("insert into manager_schedule(ID, 팀, 이름, 날짜, 오전장소, 오후장소, level) "
						+ "values(?, ?, ?, ?, ?, ?, ?)");
				pstmt.setString(1, id);
				pstmt.setString(2, team);
				pstmt.setString(3, name);
				pstmt.setString(4, date);
				pstmt.setString(5, amPlace);
				pstmt.setString(6, pmPlace);
				pstmt.setInt(7, level);
				rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return rs;
	}
	
	//관리자 일정 삭제
	public int delete_MSC (int no) {
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
		}
		
		return result;
	}
	
	//관리자 일정 수정
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
		}
		
		return result;
	}
	
	// 관리자 일주일 일정 추가
	public List weekAdd_MSC(String[] AmPlace_arr, String[] PmPlace_arr, String[] date_arr, 
			String team, String sessionID, String sessionName) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		MemberDAO memberDao = new MemberDAO();
		MemberBean mb = memberDao.returnMember(sessionID);
		int level = mb.getLevel();
        List<String> print= new ArrayList();
		String add_date[] = {"","","","",""};
		String update_date[] = {"","","","",""};
		
		int rs = 0;
		for(int i = 0; i<5; i++)
			if(returnNo(sessionID, date_arr[i]) == 0) {
				insert_MSC(sessionID, AmPlace_arr[i], PmPlace_arr[i], date_arr[i], team, sessionName);
				add_date[i] = date_arr[i];
			} else {
				update_MSC(returnNo(sessionID, date_arr[i]), AmPlace_arr[i], PmPlace_arr[i], date_arr[i]);
				update_date[i] = date_arr[i];
			}
		
		
		print.add("====일정 추가====");
		for(int i=0; i<5; i++){
			if(add_date[i] != "")
				print.add(add_date[i]);
		}
		print.add("====일정 수정====");
		for(int i=0; i<5; i++){
			if(update_date[i] != "")
				print.add(update_date[i]);
		}
		
		return print;
	}
	
}
