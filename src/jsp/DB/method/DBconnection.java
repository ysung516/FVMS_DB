package jsp.DB.method;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class DBconnection {
	
	private static final String USERNAME = "dsc05157";
	private static final String PASSWORD = "suresoft0!";
	//private static final String URL = "jdbc:mysql://localhost:3306/dsc05157?serverTimezone=UTC"; //서버
	private static final String URL = "jdbc:mysql://dsc05157.cafe24.com:3306/dsc05157?serverTimezone=UTC"; //로컬
	public static Connection getConnection(){
		Connection conn = null; 
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("클래스 적재 실패!!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("연결 실패!!");
		}
            return conn;
    }


}
