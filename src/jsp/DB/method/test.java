package jsp.DB.method;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import jsp.Bean.model.MemberBean;

public class test {

	public static void main(String[] args) throws SQLException, ClassNotFoundException {
		
		Connection conn = null; // 데이터베이스에 접근하기 위한 객체
		// 생성자
		String dbURL = "jdbc:mysql://dsc05157.cafe24.com:3306/dsc05157?serverTimezone=UTC";
		String dbID = "dsc05157";
		String dbPassword = "suresoft0!";

			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			String query = "select * from members";
			ResultSet rs; // 정보를 담을 수 있는 변수를 생성
			Statement st = conn.createStatement();
			rs = st.executeQuery(query);
		
			while(rs.next()) {
				String id = rs.getString("id");
				System.out.format("%s\n",id);
			}
			st.close();
		} 
		
		
	}
	

