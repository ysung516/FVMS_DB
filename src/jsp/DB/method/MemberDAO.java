package jsp.DB.method;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.DateFormat;
import java.util.Calendar;

import jsp.Bean.model.MemberBean;

public class MemberDAO {

	public MemberDAO() {
	}

	// 모든 회원정보 가져오기 : 팀>소속>직책>직급>일사일 순
	public ArrayList<MemberBean> getMemberData(int year) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();
		


		try {
			StringBuffer query = new StringBuffer();
			query.append("SELECT a.* FROM member as a, rank as b, position as c, team as d "
					+ "WHERE a.직급=b.rank AND a.직책=c.position AND a.팀 = d.teamName And d.year = " + year + " "
					+ "ORDER BY d.teamNum, FIELD(a.소속, '슈어소프트테크') DESC, a.소속, c.num, b.rank_id, a.입사일");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberBean member = new MemberBean();
				member.setID(rs.getString("id"));
				member.setPASSWORD(rs.getString("pw"));
				member.setPART(rs.getString("소속"));
				member.setTEAM(rs.getString("팀"));
				member.setNAME(rs.getString("이름"));
				member.setRANK(rs.getString("직급"));
				member.setPosition(rs.getString("직책"));
				member.setADDRESS(rs.getString("거주지"));
				member.setComDate(rs.getString("입사일"));
				member.setMOBILE(rs.getString("mobile"));
				member.setGMAIL(rs.getString("gmail"));
				member.setCareer(rs.getString("프로젝트수행이력"));
				member.setLevel(rs.getInt("level"));
				member.setPermission(rs.getString("permission"));
				member.setWorkEx(rs.getInt("경력"));
				list.add(member);
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

	// 모든 회원정보 가져오기 : 재직자>팀>소속>직책>직급>입사일 순 -> 즉, 퇴사자는 제일 마지막
	public ArrayList<MemberBean> getMemberDataEndOut(int year) {
		Date nowDate = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy");
		String nowYear = sf.format(nowDate);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();

		try {
			StringBuffer query = new StringBuffer();
			query.append("SELECT a.* FROM member as a, rank as b, position as c, team as d "
					+ "WHERE a.직급=b.rank AND a.직책=c.position AND a.팀 = d.teamName AND d.year="+nowYear+" " + "AND a.year = " + nowYear +" "
					+ "ORDER BY a.퇴사일, d.teamNum, FIELD(a.소속, '슈어소프트테크') DESC, a.소속, c.num, b.rank_id, a.입사일;");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberBean member = new MemberBean();
				member.setID(rs.getString("id"));
				member.setPASSWORD(rs.getString("pw"));
				member.setPART(rs.getString("소속"));
				member.setTEAM(rs.getString("팀"));
				member.setNAME(rs.getString("이름"));
				member.setRANK(rs.getString("직급"));
				member.setPosition(rs.getString("직책"));
				member.setADDRESS(rs.getString("거주지"));
				member.setComDate(rs.getString("입사일"));
				member.setOutDate(rs.getString("퇴사일"));
				member.setMOBILE(rs.getString("mobile"));
				member.setGMAIL(rs.getString("gmail"));
				member.setCareer(rs.getString("프로젝트수행이력"));
				member.setLevel(rs.getInt("level"));
				member.setPermission(rs.getString("permission"));
				member.setWorkEx(rs.getInt("경력"));
				list.add(member);
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

	// 퇴사 제외 모든 회원정보 가져오기
	public ArrayList<MemberBean> getMemberDataWithoutOut(int year) {
		Date nowDate = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy");
		String nowYear = sf.format(nowDate);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();

		try {
			StringBuffer query = new StringBuffer();
			query.append("SELECT a.* FROM member as a, rank as b, position as c, team as d "
					+ "WHERE a.직급=b.rank AND a.직책=c.position AND a.팀 = d.teamName AND 퇴사일 = '-' AND d.year="+nowYear+" " + "AND a.year = " + nowYear + " "
					+ "ORDER BY d.teamNum, FIELD(a.소속, '슈어소프트테크') DESC, a.소속, c.num, b.rank_id, a.입사일");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberBean member = new MemberBean();
				member.setID(rs.getString("id"));
				member.setPASSWORD(rs.getString("pw"));
				member.setPART(rs.getString("소속"));
				member.setTEAM(rs.getString("팀"));
				member.setNAME(rs.getString("이름"));
				member.setRANK(rs.getString("직급"));
				member.setPosition(rs.getString("직책"));
				member.setADDRESS(rs.getString("거주지"));
				member.setComDate(rs.getString("입사일"));
				member.setMOBILE(rs.getString("mobile"));
				member.setGMAIL(rs.getString("gmail"));
				member.setCareer(rs.getString("프로젝트수행이력"));
				member.setLevel(rs.getInt("level"));
				member.setPermission(rs.getString("permission"));
				member.setWorkEx(rs.getInt("경력"));
				list.add(member);
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

	// 현재 프로젝트에 참여중인 인원만
	public ArrayList<MemberBean> getMemberDataInPro() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();

		try {
			StringBuffer query = new StringBuffer();
			query.append("SELECT distinct a.* FROM member as a, rank as b, position as c, team as d, career as e "
					+ "WHERE a.직급=b.rank AND a.직책=c.position AND a.팀 = d.teamName AND a.id = e.id AND e.start < now() and e.end > now() "
					+ "ORDER BY d.teamNum, FIELD(a.소속, '슈어소프트테크') DESC, a.소속, c.num, b.rank_id, a.입사일;");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberBean member = new MemberBean();
				member.setID(rs.getString("id"));
				member.setPASSWORD(rs.getString("pw"));
				member.setPART(rs.getString("소속"));
				member.setTEAM(rs.getString("팀"));
				member.setNAME(rs.getString("이름"));
				member.setRANK(rs.getString("직급"));
				member.setPosition(rs.getString("직책"));
				member.setADDRESS(rs.getString("거주지"));
				member.setComDate(rs.getString("입사일"));
				member.setMOBILE(rs.getString("mobile"));
				member.setGMAIL(rs.getString("gmail"));
				member.setCareer(rs.getString("프로젝트수행이력"));
				member.setLevel(rs.getInt("level"));
				member.setPermission(rs.getString("permission"));
				member.setWorkEx(rs.getInt("경력"));
				list.add(member);
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

	// 모든 회원정보 가져오기(소속순)
	public ArrayList<MemberBean> getMemberData_part() {
		Date nowDate = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy");
		String nowYear = sf.format(nowDate);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();

		try {
			StringBuffer query = new StringBuffer();
			query.append("SELECT a.* FROM member as a, rank as b, position as c, team as d "
					+ "WHERE a.직급=b.rank AND a.직책=c.position AND a.팀 = d.teamName AND d.year="+nowYear+" "
					+ "ORDER BY a.퇴사일, FIELD(a.소속, '슈어소프트테크') DESC, a.소속, a.이름, d.teamNum, c.num, b.rank_id");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberBean member = new MemberBean();
				member.setID(rs.getString("id"));
				member.setPASSWORD(rs.getString("pw"));
				member.setPART(rs.getString("소속"));
				member.setTEAM(rs.getString("팀"));
				member.setNAME(rs.getString("이름"));
				member.setRANK(rs.getString("직급"));
				member.setPosition(rs.getString("직책"));
				member.setADDRESS(rs.getString("거주지"));
				member.setComDate(rs.getString("입사일"));
				member.setMOBILE(rs.getString("mobile"));
				member.setGMAIL(rs.getString("gmail"));
				member.setCareer(rs.getString("프로젝트수행이력"));
				member.setLevel(rs.getInt("level"));
				member.setPermission(rs.getString("permission"));
				member.setWorkEx(rs.getInt("경력"));
				list.add(member);
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

	// 모든 회원정보 가져오기(직급순)
	public ArrayList<MemberBean> getMemberData_rank(int year) {
		Date nowDate = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy");
		String nowYear = sf.format(nowDate);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();

		try {
			StringBuffer query = new StringBuffer();
			query.append("SELECT a.* FROM member as a, rank as b, position as c, team as d "
					+ "WHERE a.직급=b.rank AND a.직책=c.position AND a.팀 = d.teamName AND d.year="+nowYear+" " +"AND a.year = "+ nowYear + " "
					+ "ORDER BY a.퇴사일, b.rank_id, d.teamNum, FIELD(a.소속, '슈어소프트테크') DESC, a.소속, c.num");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberBean member = new MemberBean();
				member.setID(rs.getString("id"));
				member.setPASSWORD(rs.getString("pw"));
				member.setPART(rs.getString("소속"));
				member.setTEAM(rs.getString("팀"));
				member.setNAME(rs.getString("이름"));
				member.setRANK(rs.getString("직급"));
				member.setPosition(rs.getString("직책"));
				member.setADDRESS(rs.getString("거주지"));
				member.setComDate(rs.getString("입사일"));
				member.setMOBILE(rs.getString("mobile"));
				member.setGMAIL(rs.getString("gmail"));
				member.setCareer(rs.getString("프로젝트수행이력"));
				member.setLevel(rs.getInt("level"));
				member.setPermission(rs.getString("permission"));
				member.setWorkEx(rs.getInt("경력"));
				list.add(member);
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

	// ID로 회원정보 가져오기
	public MemberBean returnMember(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		MemberBean member = new MemberBean();

		try {
			StringBuffer query = new StringBuffer();
			query.append("select * from member where id=?");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				member.setID(rs.getString("id"));
				member.setPART(rs.getString("소속"));
				member.setTEAM(rs.getString("팀"));
				member.setNAME(rs.getString("이름"));
				member.setRANK(rs.getString("직급"));
				member.setPosition(rs.getString("직책"));
				member.setADDRESS(rs.getString("거주지"));
				member.setComDate(rs.getString("입사일"));
				member.setOutDate(rs.getString("퇴사일"));
				member.setMOBILE(rs.getString("mobile"));
				member.setGMAIL(rs.getString("gmail"));
				member.setCareer(rs.getString("프로젝트수행이력"));
				member.setLevel(rs.getInt("level"));
				member.setPermission(rs.getString("permission"));
				member.setSaveAttr(rs.getString("saveAttr"));
				member.setWorkEx(rs.getInt("경력"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return member;
	}

	/*
	 *비밀번호 암호화
		현재 암호화키로 'suresoft' 사용
		- 암호화
			HEX(AES_ENCRYPY('문자열', '암호화키'))
		- 복호화
			AES_DECRYPT(UNHEX(필드명), '암호화키')
	*/
	// 로그인 체크
	public int logincheck(String id, String pw) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String dbPW = "";
		int x = -1;
		try {
			StringBuffer query = new StringBuffer();
			query.append("SELECT AES_DECRYPT(UNHEX(pw), 'suresoft') AS pw FROM member WHERE id=? AND 퇴사일 = '-'");

			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbPW = rs.getString("pw");
				if (dbPW.equals(pw)) {
					x = 1; // 인증성공
				} else {
					x = 0; // 인증실패
				}
			} else {
				x = -1; // 해당 아이디 없음
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return x;
	}

	// 비밀번호 수정
	public int changePW(String id, String next_pwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			String query = new String();
			query = "UPDATE member SET pw = HEX(AES_ENCRYPT(?, 'suresoft')) WHERE id = ?";

			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, next_pwd);
			pstmt.setString(2, id);
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

	// 관리자페이지에서 회원 수정
	public int managerUpdate(String id, String address, String comeDate, String mobile, String gmail, String career,
			String part, String team, String permission, String rank, String position, String workEx,
			String originRank) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			String query = "update member set 거주지 = ?, 입사일 = ?, mobile = ?, gmail = ?, 프로젝트수행이력 = ?, "
					+ "소속=?, 팀=?, permission=?, 직급=?, 직책=?, 경력=? where id = ?";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());

			pstmt.setString(1, address);
			pstmt.setString(2, comeDate);
			pstmt.setString(3, mobile);
			pstmt.setString(4, gmail);
			pstmt.setString(5, career);
			pstmt.setString(6, part);
			pstmt.setString(7, team);
			pstmt.setString(8, permission);
			pstmt.setString(9, rank);
			pstmt.setString(10, position);
			pstmt.setInt(11, Integer.parseInt(workEx));
			pstmt.setString(12, id);
			rs = pstmt.executeUpdate();

			if (!originRank.equals(rank)) {
				updateRankPeriod(id, originRank);
				insertRankPeriod(id, rank);
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

	/*
	 	직급을 수정하게 되면 원래 직급의 end가 현재날자로 바뀌고 새로운 직급 데이터가 추가되어야함
	*/
	// 직급 수정시 period 테이블 update
	public int updateRankPeriod(String id, String originRank) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sf.format(date);

		try {
			String query = "update rank_period set end=? where id=? and rank=?";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());

			pstmt.setString(1, today);
			pstmt.setString(2, id);
			pstmt.setString(3, originRank);
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

	// 직급 수정 시 period 테이블 insert
	public int insertRankPeriod(String id, String rank) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, 1);
		String tomorrow = df.format(cal.getTime());

		try {
			String query = "insert into rank_period(id, rank, start) values(?,?,?)";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, rank);
			pstmt.setString(3, tomorrow);
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return rs;
	}

	// period 테이블 전체 수정
	public int updatePeriod(String rank, String start, String end, String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			String query = "update rank_period set start=?, end=? where id=? and rank=?";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());

			pstmt.setString(1, start);
			pstmt.setString(2, end);
			pstmt.setString(3, id);
			pstmt.setString(4, rank);
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

	// 입사일 퇴사일 수정
	public int updateComeOutDate(String comeDate, String outDate, String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			String query = "update member set 입사일=?, 퇴사일=? where id=?";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, comeDate);
			pstmt.setString(2, outDate);
			pstmt.setString(3, id);

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

	// 퇴사처리
	public int resignMember(String id, String rank) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sf.format(date);

		try {
			updateRankPeriod(id, rank);
			String query = "update member set 퇴사일 = ? where id = ?";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());

			pstmt.setString(1, today);
			pstmt.setString(2, id);
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
	
	// 마이페이지 수정
	public int mypageUpdate(String id, String address, String comeDate, String mobile, String gmail, String career,
			String workEx) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			String query = "update member set 거주지 = ?, 입사일 = ?, mobile = ?, gmail = ?, 프로젝트수행이력 = ?, 경력 = ? where id = ?";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());

			pstmt.setString(1, address);
			pstmt.setString(2, comeDate);
			pstmt.setString(3, mobile);
			pstmt.setString(4, gmail);
			pstmt.setString(5, career);
			pstmt.setInt(6, Integer.parseInt(id));
			pstmt.setString(7, id);
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

	// 회원삭제
	public int deleteMember(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		try {
			String query = "delete from member where id =?";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeUpdate();
			deleteMemberRank(id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return rs;
	}

	// 회원 삭제 시 rank_period 테이블에서도 데이터 삭제
	public int deleteMemberRank(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			String query = "delete from rank_period where id=?";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return rs;
	}

	// 회원등록 등록
	public int insertMember(String name, String id, String pw, String part, String team, String rank, String position,
			String permission, String mobile, String gmail) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			String query = "insert into member(id, pw, 소속, 팀, 이름, 직급, 직책, permission, mobile, gmail)"
					+ "values(?,HEX(AES_ENCRYPT('" + pw + "', 'suresoft')),?,?,?,?,?,?,?,?)";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, id);
			// pstmt.setString(2, pw);
			pstmt.setString(2, part);
			pstmt.setString(3, team);
			pstmt.setString(4, name);
			pstmt.setString(5, rank);
			pstmt.setString(6, position);
			pstmt.setString(7, permission);
			pstmt.setString(8, mobile);
			pstmt.setString(9, gmail);
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return rs;
	}

	/*
	 	관리자 페이지 엑셀 동기화 관련 함수
	*/
	// 동기화 시 존재 회원 휴대전화 업데이트
	public int updateMobileExcel(String id, String phone) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			String query = "update member SET mobile=? where id =?";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, phone);
			pstmt.setString(2, id);

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

	// 동기화 시 존재 회원 입사일 업데이트
	public int updateComeDateExcel(String id, String comeDate) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			String query = "update member SET 입사일=? where id =?";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, comeDate);
			pstmt.setString(2, id);

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

	// 엑셀 동기화로 회원 등록
	public int plusNewMember(String name, String id, String pw, String part, String team, String rank, String position,
			String permission, String mobile, String gmail, String comeDate) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		// insertRankPeriod(id, rank, comeDate);

		try {
			String query = "insert into member(id, pw, 소속, 팀, 이름, 직급, 직책, permission, mobile, gmail, 입사일)"
					+ "values(?,HEX(AES_ENCRYPT('" + pw + "', 'suresoft')),?,?,?,?,?,?,?,?,?)";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, id);
			// pstmt.setString(2, pw);
			pstmt.setString(2, part);
			pstmt.setString(3, team);
			pstmt.setString(4, name);
			pstmt.setString(5, rank);
			pstmt.setString(6, position);
			pstmt.setString(7, permission);
			pstmt.setString(8, mobile);
			pstmt.setString(9, gmail);
			pstmt.setString(10, comeDate);
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			// deleteRankPeriod(id, rank);
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return rs;
	}

	// 엑셀 동기화로 회원 등록 시 rank_period 테이블에도 추가
	public int insertRankPeriod(String id, String rank, String start) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		if (start.equals("") || start == null) {
			start = sf.format(date);
		}

		try {
			String query = "insert into rank_period(id, rank, start) values(?,?,?)";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, rank);
			pstmt.setString(3, start);
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return rs;
	}

	// 엑셀 동기화 오류 시 rank_period 테이블에서도 데이터 삭제
	public int deleteRankPeriod(String id, String rank) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		System.out.println("빼기");
		try {
			String query = "delete from rank_period where id=?, rank=?";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, rank);
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return rs;
	}

	// 해당 팀의 멤버 가져오기
	public ArrayList<MemberBean> teamMember(String team) {
		ArrayList<MemberBean> teamMem = new ArrayList<MemberBean>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			StringBuffer query = new StringBuffer();

			query.append("SELECT * FROM member WHERE team=?");

			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, team);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				MemberBean member = new MemberBean();
				member.setID(rs.getString("id"));
				member.setPASSWORD(rs.getString("pw"));
				member.setPART(rs.getString("소속"));
				member.setTEAM(rs.getString("팀"));
				member.setNAME(rs.getString("이름"));
				member.setRANK(rs.getString("직급"));
				member.setPosition(rs.getString("직책"));
				member.setADDRESS(rs.getString("거주지"));
				member.setComDate(rs.getString("입사일"));
				member.setMOBILE(rs.getString("mobile"));
				member.setGMAIL(rs.getString("gmail"));
				member.setCareer(rs.getString("프로젝트수행이력"));
				member.setLevel(rs.getInt("level"));
				member.setPermission(rs.getString("permission"));
				member.setWorkEx(rs.getInt("경력"));
				teamMem.add(member);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return teamMem;
	}

	// 비밀번호 초기화
	public int pwdReset(String id, String pw) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;

		try {
			String query = "update member  SET pw = HEX(AES_ENCRYPT(?, 'suresoft')) where id = ?";
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, pw);
			pstmt.setString(2, id);

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

	// 현재 프로젝트 참여중인 협력업체 회원정보 가져오기
	public ArrayList<MemberBean> getMember_cooperation() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();

		try {
			StringBuffer query = new StringBuffer();
			query.append(
					"select career.id, member.소속, project.팀_매출 as 팀, member.이름, member.직급, member.직책, member.거주지, member.입사일, member.mobile, member.gmail, member.프로젝트수행이력, member.level, member.permission as 팀 "
					+ "from career, member, project, rank "
					+ "where member.직급 = rank.rank and career.projectNo = project.no and career.id = member.id and career.start < now() and career.end > now() and member.소속 != '슈어소프트테크' and member.직급 != '인턴' and project.상태 != '8.Dropped' and project.상태 != '7.종료' group by career.id "
					+ "order by member.소속, rank.rank_id;");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberBean member = new MemberBean();
				member.setID(rs.getString("id"));
				member.setPART(rs.getString("소속"));
				member.setTEAM(rs.getString("팀"));
				member.setNAME(rs.getString("이름"));
				member.setRANK(rs.getString("직급"));
				member.setPosition(rs.getString("직책"));
				member.setADDRESS(rs.getString("거주지"));
				member.setComDate(rs.getString("입사일"));
				member.setMOBILE(rs.getString("mobile"));
				member.setGMAIL(rs.getString("gmail"));
				member.setCareer(rs.getString("프로젝트수행이력"));
				member.setLevel(rs.getInt("level"));
				list.add(member);
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

	// 협력업체 회원정보 가져오기
	public ArrayList<MemberBean> getMember_coop() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();

		try {
			StringBuffer query = new StringBuffer();
			query.append("select id, 이름, 소속 from member where 소속 != '슈어소프트테크' and 직급 != '인턴';");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberBean member = new MemberBean();
				member.setID(rs.getString("id"));
				member.setPART(rs.getString("소속"));
				member.setNAME(rs.getString("이름"));
				list.add(member);
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

	// 협력업체 별로 현재 프로젝트에 참여 중인 인원 수 가져오기
	public HashMap<String, Integer> getNum_cooperation() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		HashMap<String, Integer> coopNum = new HashMap<String, Integer>();

		try {
			StringBuffer query = new StringBuffer();
			query.append(
					"select count(distinct career.id) as 인원수, member.소속 from career, member, project where career.projectNo = project.no and career.id = member.id and career.id in (select distinct id from career) and career.start < now() and career.end > now() and member.소속 != '슈어소프트테크' and member.직급 != '인턴' and project.상태 != '8.Dropped' and project.상태 != '7.종료' group by member.소속;");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				coopNum.put(rs.getString("소속"), rs.getInt("인원수"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}

		return coopNum;
	}

	// 현재 년도 팀 가져오기
	public LinkedHashMap<Integer, String> getTeam() {
		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy");
		String year = sf.format(date);

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LinkedHashMap<Integer, String> list = new LinkedHashMap<Integer, String>();
		try {
			StringBuffer query = new StringBuffer();
			query.append("select * from team where year=? order by teamNum;");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, year);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.put(rs.getInt("teamNum"), rs.getString("teamName"));
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

	// 년도별 팀 가져오기
	public LinkedHashMap<Integer, String> getTeam_year(String year) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LinkedHashMap<Integer, String> list = new LinkedHashMap<Integer, String>();
		try {
			StringBuffer query = new StringBuffer();
			query.append("select * from team where year=" + year + " order by teamNum;");
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.put(rs.getInt("teamNum"), rs.getString("teamName"));
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

	// 전화 번호 000-0000-0000 양식으로 변경
	public String phone(String src) {
		if (src == null) {
			return "";
		}
		if (src.length() == 8) {
			return src.replaceFirst("^([0-9]{4})([0-9]{4})$", "$1-$2");
		} else if (src.length() == 12) {
			return src.replaceFirst("(^[0-9]{4})([0-9]{4})([0-9]{4})$", "$1-$2-$3");
		} else {
			return src.replaceFirst("(^02|[0-9]{3})([0-9]{3,4})([0-9]{4})$", "$1-$2-$3");
		}
	}
} // end
