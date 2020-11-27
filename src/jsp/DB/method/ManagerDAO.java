package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;

import jsp.Bean.model.WorkPlaceBean;
import jsp.Bean.model.rankPeriodBean;

public class ManagerDAO {
	
	public ManagerDAO() {}
	
	public ArrayList<WorkPlaceBean> getWorkPlaceList(int year){
		
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    ArrayList<WorkPlaceBean> list = new ArrayList<WorkPlaceBean>();
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("select * from workPlace where year=?");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setInt(1, year);
	    	rs = pstmt.executeQuery();
	    	while(rs.next()) {
	    		WorkPlaceBean wp = new WorkPlaceBean();
	    		wp.setPlace(rs.getString("place"));
	    		wp.setColor(rs.getString("color"));
	    		wp.setCost(rs.getInt("cost"));
	    		list.add(wp);
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

	public int save_WorkPlace(String [] place, String [] color, String [] cost, int count, int year) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "insert into workPlace(place,color,cost,year) values(?,?,?,?) ";
	    	if(count > 1) {
	    		for(int i=0; i<count-1; i++) {
	    			query += ",(?,?,?,?)";
	    		}
	    		query += ";";
	    	}
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, place[0]);
	    	pstmt.setString(2, color[0]);
	    	pstmt.setInt(3, Integer.parseInt(cost[0]));
	    	pstmt.setInt(4, year);
	    	if(count > 1) {
	    		int cnt = 5;
	    		for(int j=0; j<count-1; j++) {
	    			pstmt.setString(cnt, place[j+1]);
	    			cnt ++;
	    			pstmt.setString(cnt, color[j+1]);
	    			cnt ++;
	    			pstmt.setInt(cnt, Integer.parseInt(cost[j+1]));
	    			cnt++;
	    			pstmt.setInt(cnt, year);
	    			cnt++;
	    		}
	    	}
	    	rs = pstmt.executeUpdate();
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
	    	backup2();
			e.printStackTrace();
		}finally {
			drop_backup();
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    
		return rs;
	}
	
	public int backup(int year) {
		Connection conn = null;
		PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "insert into backupWP (select * from workPlace where year = ?)";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setInt(1, year);
	    	rs = pstmt.executeUpdate();
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    return rs;
	}
	
	public int backup2() {
		Connection conn = null;
		PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "insert into workPlace (select * from backupWP)";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeUpdate();
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    return rs;
	}
	
	public int nextYear_copy(int year) {
		Connection conn = null;
		PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "insert into workPlace (select place, color, cost, (year+1) as year from workPlace where year = ?)";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setInt(1, year);
	    	rs = pstmt.executeUpdate();
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    return rs;
	}
	
	public int drop_PlaceTable(int year) {
		backup(year);
		Connection conn = null;
		PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "delete from workPlace where year = ?";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setInt(1, year);
	    	rs = pstmt.executeUpdate();
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
	    	drop_backup();
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    return rs;
	}
	
	public int drop_backup() {
		Connection conn = null;
		PreparedStatement pstmt = null;
	    int rs = 0;
	    try {
	    	String query = "TRUNCATE backupWP";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeUpdate();
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    return rs;
	}
	
	
	public int minYear() {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int year = 0;
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("select min(year) from workPlace");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	if(rs.next()) {
	    		year = rs.getInt("min(year)");
	    	}
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    return year;
	}
	
	public int maxYear() {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int year = 0;
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("select max(year) from workPlace");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	if(rs.next()) {
	    		year = rs.getInt("max(year)");
	    	}
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    return year;
	}
	
	public int teamCopy_next() {
		SummaryDAO summaryDao = new SummaryDAO();
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    int maxYear = summaryDao.maxYear();
	    Date date =  new Date();
	    SimpleDateFormat sf = new SimpleDateFormat("yyyy");
	    int year = Integer.parseInt(sf.format(date)) + 1;
	    
	    if(maxYear < year) {
		    try {
		    	String query = "INSERT INTO team(teamName, teamNum, year) SELECT teamName, teamNum, year+1 FROM team WHERE year = DATE_FORMAT(now(), '%Y');";
		    	conn = DBconnection.getConnection();
		    	pstmt = conn.prepareStatement(query.toString());
		    	rs = pstmt.executeUpdate();
		    }catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null) try {conn.close();} catch(SQLException ex) {}
			}
	    }else {
	    	rs = 0;
	    }
	    
	    System.out.println(rs);
	    
		return rs;
	}
	
	/*
	  팀 수정 함수 시작
	*/
	
	//1. team테이블 복사
	public int copyTeamToTeamBackup(String year) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    
	    try {
	    	String query ="CREATE TABLE IF NOT EXISTS teamBackUp SELECT * FROM team WHERE year="+year+";";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeUpdate();
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    
	    return rs;
	}
	
	//2. 팀 테이블에서 해당 연도 데이터만 삭제
	public int deleteTeam(String year) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    
	    try {
	    	String query ="DELETE FROM team WHERE year="+year+";";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeUpdate();
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    
	    return rs;
	}
	
	//3. 백업 테이블 team 테이블로 복사
	public int copyTeamBackUpToTeam(String year) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    
	    try {
	    	String query ="INSERT INTO team SELECT * FROM teamBackUp;";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeUpdate();
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    
	    return rs;
	}
	
	//4. 백업테이블 삭제
	public int dropTeamBackUp() {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    
	    try {
	    	String query ="DROP TABLE teamBackUp;";
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeUpdate();
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    
	    return rs;
	}
	
	// 팀수정
	public int teamSet(String year, String[] teamNum, String[] teamName, 
			String[] fh_order, String[] fh_sale, String[] sh_order, String[] sh_sale, int count) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int rs = 0;
	    System.out.println(sh_order.length);
	    try {
			copyTeamToTeamBackup(year);	// 1. 백업테이블로 복사
			deleteTeam(year); // 2. 해당 년도 데이터 삭제
	    	//insert
	    	String query = "insert into team(teamName, teamNum, 상반기목표수주, 상반기목표매출, 하반기목표수주, 하반기목표매출 ,year) values(?,?,?,?,?,?,?) ";
	    	if(count > 1) {
	    		for(int i=0; i<count-1; i++) {
	    			query += ",(?,?,?,?,?,?,?)";
	    		}
	    		query += ";";
	    	}
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, teamName[0]);
	    	pstmt.setString(2, teamNum[0]);
	    	pstmt.setFloat(3, Float.parseFloat(fh_order[0]));
	    	pstmt.setFloat(4, Float.parseFloat(fh_sale[0]));
	    	pstmt.setFloat(5, Float.parseFloat(sh_order[0]));
	    	pstmt.setFloat(6, Float.parseFloat(sh_sale[0]));
	    	pstmt.setString(7, year);
	    	if(count > 1) {
	    		int cnt = 8;
	    		for(int j=0; j<count-1; j++) {
	    	    	pstmt.setString(cnt, teamName[j+1]);
	    			cnt ++;
	    	    	pstmt.setString(cnt, teamNum[j+1]);
	    			cnt ++;
	    	    	pstmt.setFloat(cnt, Float.parseFloat(fh_order[j+1]));
	    			cnt ++;
	    	    	pstmt.setFloat(cnt, Float.parseFloat(fh_sale[j+1]));
	    			cnt ++;
	    	    	pstmt.setFloat(cnt, Float.parseFloat(sh_order[j+1]));
	    			cnt ++;
	    	    	pstmt.setFloat(cnt, Float.parseFloat(sh_sale[j+1]));
	    			cnt ++;
	    	    	pstmt.setString(cnt, year);
	    			cnt++;
	    		}
	    	}
	    	rs = pstmt.executeUpdate();
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			// 현재 year데이터 다 지우고 백업 테이블 복사
			deleteTeam(year); // 해당 년도 데이터 삭제
			copyTeamBackUpToTeam(year);
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
			// 백업 테이블 삭제
			dropTeamBackUp();
		}
	    
	    return rs;
	}
	
	// rank_period 테이블 가져오기
	public ArrayList<rankPeriodBean> getPeriod(String id){
		ArrayList<rankPeriodBean> list = new ArrayList<rankPeriodBean>();
		
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("select * from rank_period where id=? order by start");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, id);
	    	rs = pstmt.executeQuery();

	    	while(rs.next()) {
	    		rankPeriodBean bean = new rankPeriodBean();
	    		bean.setId(rs.getString("id"));
	    		bean.setRank(rs.getString("rank"));
	    		bean.setStart("start");
	    		bean.setEnd("end");
	    		
	    		list.add(bean);
	    	}
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    
		return list;
	}
}
