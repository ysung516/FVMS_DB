package jsp.DB.method;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import jsp.Bean.model.MemberBean;

public class MemberDAO {
	

	public MemberDAO() {}
	
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
	    		member.setPosition( rs.getString("직책"));
	    		member.setADDRESS(rs.getString("거주지"));
	    		member.setComDate(rs.getString("입사일"));
	    		member.setWyear(rs.getInt("연차"));
	    		member.setCareer(rs.getString("프로제트수행이력"));
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

	
}
