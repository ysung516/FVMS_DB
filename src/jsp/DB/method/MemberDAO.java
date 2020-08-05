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
	    	query.append("select * from member");
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
	    	}
	    }  catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	        query.append("SELECT pw FROM member WHERE id=?");
	        
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
		}
	
		return x;
	 }
	
	//비밀번호 체크
		 public int pwdCheck(String id, String now_pwd, String next_pwd, String pwd) {
			  
			  int x = -1;
			  

			  if(now_pwd.equals(pwd)){
			      
			      Connection conn = null;
			      PreparedStatement pstmt = null;
			      int rs = 0;
			     
			      try {
			       String query = new String();
			       query = "UPDATE member SET pw = ? WHERE id = ?";
			       
			       conn = DBconnection.getConnection();
			       pstmt = conn.prepareStatement(query);
			       pstmt.setString(1, next_pwd);
			       pstmt.setString(2, id);
			       rs = pstmt.executeUpdate();

			       x = 1;
			    
			      }  catch (SQLException e) {
			    // TODO Auto-generated catch block
			    e.printStackTrace();
			   }
			      
			     } else {
			      
			      x = -1;
			     }
			  
			  return x;
			 }

		 //마이페이지 수정
		 public int mypageUpdate(String id, String address, String comeDate, String wyear, String mobile, String gmail, String career) {
			 Connection conn = null;
			 PreparedStatement pstmt = null;
		      int rs = 0;
		   
		      try {
		       String query = "UPDATE member SET 거주지 = ?, 입사일 = ?, 연차 = ?, mobile = ?, gmail = ?, 프로젝트수행이력 = ? WHERE id = ?";
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
		    return 0;
		   }
		     
			if(rs == 1) {
				return 1;
			}
			else {
				return 0;
			}
		    
		 }
	
	
}
