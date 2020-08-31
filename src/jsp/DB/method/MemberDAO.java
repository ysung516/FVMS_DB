package jsp.DB.method;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import jsp.Bean.model.MemberBean;

public class MemberDAO {
	
	public MemberDAO() {}
	
	// 모든 회원정보 가져오기
	public ArrayList<MemberBean> getMemberData() {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    ArrayList<MemberBean> list = new ArrayList<MemberBean>(); 
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("SELECT a.* FROM member as a, rank as b, position as c, team as d WHERE a.직급=b.rank AND a.직책=c.position AND a.팀 = d.teamName ORDER BY d.teamNum, FIELD(a.소속, '슈어소프트테크') DESC, a.소속, c.num, b.rank_id");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	while(rs.next()) {
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
	    		member.setWyear(rs.getString("연차"));
	    		member.setMOBILE(rs.getString("mobile"));
	    		member.setGMAIL(rs.getString("gmail"));	
	    		member.setCareer(rs.getString("프로젝트수행이력"));
	    		member.setLevel(rs.getInt("level"));
	    		member.setPermission(rs.getString("permission"));
	    		list.add(member);
	    	}
	    }  catch (SQLException e) {
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
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    ArrayList<MemberBean> list = new ArrayList<MemberBean>(); 
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("SELECT a.* FROM member as a, rank as b, position as c, team as d WHERE a.직급=b.rank AND a.직책=c.position AND a.팀 = d.teamName ORDER BY FIELD(a.소속, '슈어소프트테크') DESC, a.소속, a.이름, d.teamNum, c.num, b.rank_id");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	while(rs.next()) {
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
	    		member.setWyear(rs.getString("연차"));
	    		member.setMOBILE(rs.getString("mobile"));
	    		member.setGMAIL(rs.getString("gmail"));	
	    		member.setCareer(rs.getString("프로젝트수행이력"));
	    		member.setLevel(rs.getInt("level"));
	    		member.setPermission(rs.getString("permission"));
	    		list.add(member);
	    	}
	    }  catch (SQLException e) {
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
	public ArrayList<MemberBean> getMemberData_rank() {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    ArrayList<MemberBean> list = new ArrayList<MemberBean>(); 
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("SELECT a.* FROM member as a, rank as b, position as c, team as d WHERE a.직급=b.rank AND a.직책=c.position AND a.팀 = d.teamName ORDER BY b.rank_id, d.teamNum, FIELD(a.소속, '슈어소프트테크') DESC, a.소속, c.num");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	while(rs.next()) {
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
	    		member.setWyear(rs.getString("연차"));
	    		member.setMOBILE(rs.getString("mobile"));
	    		member.setGMAIL(rs.getString("gmail"));	
	    		member.setCareer(rs.getString("프로젝트수행이력"));
	    		member.setLevel(rs.getInt("level"));
	    		member.setPermission(rs.getString("permission"));
	    		list.add(member);
	    	}
	    }  catch (SQLException e) {
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
	public MemberBean returnMember (String id) {
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
	    	if(rs.next()) {
	    		member.setID(rs.getString("id"));
	    		member.setPART(rs.getString("소속"));
	    		member.setTEAM(rs.getString("팀"));
	    		member.setNAME(rs.getString("이름"));
	    		member.setRANK(rs.getString("직급"));
	    		member.setPosition(rs.getString("직책"));
	    		member.setADDRESS(rs.getString("거주지"));
	    		member.setComDate(rs.getString("입사일"));
	    		member.setWyear(rs.getString("연차"));
	    		member.setMOBILE(rs.getString("mobile"));
	    		member.setGMAIL(rs.getString("gmail"));	
	    		member.setCareer(rs.getString("프로젝트수행이력"));
	    		member.setLevel(rs.getInt("level"));
	    		member.setPermission(rs.getString("permission"));
	    	}

	    }  catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    
	    return member; 
	}

	// 로그인 체크
	public int logincheck(String id, String pw) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    String dbPW = "";
	    int x = -1;
		try {
			StringBuffer query = new StringBuffer();
			query.append("SELECT AES_DECRYPT(UNHEX(pw), 'suresoft') AS pw FROM member WHERE id=?");

	        conn = DBconnection.getConnection();
	        pstmt = conn.prepareStatement(query.toString());
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            
            if(rs.next())
            {
            	dbPW = rs.getString("pw");
            	if(dbPW.equals(pw)) {
            		x = 1;	// 인증성공
            	} else {
            		x = 0;	// 인증실패
            	}
            } else {
            	x = -1;	// 해당 아이디 없음
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
	
		
	//비밀번호 수정
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
	    
	      }  catch (SQLException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	   } finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	      return rs;
	 }

	 //관리자페이지에서 회원 수정
	 public int managerUpdate(String id, String address, String comeDate, String wyear, String mobile,
			 String gmail, String career, String part, String team, String permission, String rank, String position) {
		 Connection conn = null;
		 PreparedStatement pstmt = null;
	     int rs = 0;
	   
	      try {
	       String query = "update member set 거주지 = ?, 입사일 = ?, 연차 = ?, mobile = ?, gmail = ?, 프로젝트수행이력 = ?, "
	       		+ "소속=?,팀=?,permission=?,직급=?,직책=? where id = ?";
	       conn = DBconnection.getConnection();
	       pstmt = conn.prepareStatement(query.toString());
	       
	       pstmt.setString(1, address);
	       pstmt.setString(2, comeDate);
	       pstmt.setString(3, wyear);
	       pstmt.setString(4, mobile);
	       pstmt.setString(5, gmail);
	       pstmt.setString(6, career);
	       pstmt.setString(7, part);
	       pstmt.setString(8, team);
	       pstmt.setString(9, permission);
	       pstmt.setString(10, rank);
	       pstmt.setString(11, position);
	       pstmt.setString(12, id);
	       rs = pstmt.executeUpdate();
	       
	      }  catch (SQLException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	    
	   } finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	      return rs;
	 }
	 
	 // 마이페이지 수정
	 public int mypageUpdate(String id, String address, String comeDate, String wyear, String mobile,
			 String gmail, String career) {
		 Connection conn = null;
		 PreparedStatement pstmt = null;
	     int rs = 0;
	   
	      try {
	       String query = "update member set 거주지 = ?, 입사일 = ?, 연차 = ?, mobile = ?, gmail = ?, 프로젝트수행이력 = ? where id = ?";
	       conn = DBconnection.getConnection();
	       pstmt = conn.prepareStatement(query.toString());
	       
	       pstmt.setString(1, address);
	       pstmt.setString(2, comeDate);
	       pstmt.setString(3, wyear);
	       pstmt.setString(4, mobile);
	       pstmt.setString(5, gmail);
	       pstmt.setString(6, career);
	       pstmt.setString(7, id);
	       rs = pstmt.executeUpdate();
	       
	      }  catch (SQLException e) {
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
		    }catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
	     return rs;
	 }

	 // 회원등록 등록
	 public int insertMember(String name, String id, String pw, String part, String team, 
			 String rank, String position, String permission) {
		 Connection conn = null;
		 PreparedStatement pstmt = null;
	     int rs = 0;
	     
	     try {
	    	 	String query = "insert into member(id, pw, 소속, 팀, 이름, 직급, 직책, permission)"
	    	 			+ "values(?,HEX(AES_ENCRYPT('"+pw+"', 'suresoft')),?,?,?,?,?,?)";
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	pstmt.setString(1, id);
		    	//pstmt.setString(2, pw);
		    	pstmt.setString(2, part);
		    	pstmt.setString(3, team);
		    	pstmt.setString(4, name);
		    	pstmt.setString(5, rank);
		    	pstmt.setString(6, position);
		    	pstmt.setString(7, permission);
		    	rs = pstmt.executeUpdate();
	     }catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
		 return rs;
	 }
	 
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
            
            if(rs.next()) {
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
	    		member.setWyear(rs.getString("연차"));
	    		member.setMOBILE(rs.getString("mobile"));
	    		member.setGMAIL(rs.getString("gmail"));	
	    		member.setCareer(rs.getString("프로젝트수행이력"));
	    		member.setLevel(rs.getInt("level"));
	    		member.setPermission(rs.getString("permission"));
	    		teamMem.add(member);
	    	}
	     }catch (SQLException e) {
	    	 e.printStackTrace();
	     } finally {
	    	 if(rs != null) try {rs.close();} catch(SQLException ex) {}
	    	 if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
	    	 if(conn != null) try {conn.close();} catch(SQLException ex) {}
	     }
	     
		 return teamMem;
	 }

	 //비밀번호 초기화
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
	 
	      }  catch (SQLException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	    
	   } finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	      return rs;
	 }
	
		 
}	//end 
