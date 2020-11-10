package jsp.DB.method;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import jsp.Bean.model.*;

public class SummaryDAO {
	public SummaryDAO() {}
	
	// 프로젝트이 데이터
	public ArrayList<ProjectBean> getProjectList(){
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    ArrayList<ProjectBean> list = new ArrayList<ProjectBean>();
	    
	    try {
	    	Date now = new Date();
	    	SimpleDateFormat sf = new SimpleDateFormat("yyyy");
	    	String year = sf.format(now);
	    	StringBuffer query = new StringBuffer();
	    	query.append("SELECT * from project where 실적보고 = 1 and year ="+year+" ;");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		ProjectBean project = new ProjectBean();
	    		project.setTEAM_ORDER(rs.getString("팀_수주"));
	    		project.setTEAM_SALES(rs.getString("팀_매출"));
	    		project.setPROJECT_NAME(rs.getString("프로젝트명"));
	    		project.setMAN_MONTH(rs.getFloat("ManMonth"));
	    		project.setFH_ORDER_PROJECTIONS(rs.getFloat("상반기예상수주"));
	    		project.setFH_ORDER(rs.getFloat("상반기수주"));
	    		project.setFH_SALES_PROJECTIONS(rs.getFloat("상반기예상매출"));
	    		project.setFH_SALES(rs.getFloat("상반기매출"));
	    		project.setSH_ORDER_PROJECTIONS(rs.getFloat("하반기예상수주"));
	    		project.setSH_ORDER(rs.getFloat("하반기수주"));
	    		project.setSH_SALES_PROJECTIONS(rs.getFloat("하반기예상매출"));
	    		project.setSH_SALES(rs.getFloat("하반기매출"));
	    		project.setNO(rs.getInt("no"));
	    		list.add(project);
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
	
	// 상반기, 하반기 manmonth 계산
	public String [] cal_manmoth(String start, String end) {
		String [] result = new String[2];
		long fh_mm = 0;
		long sh_mm = 0;
		Date nowDate = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String Date = sf.format(nowDate);
		int nowYear = Integer.parseInt(Date.split("-")[0]);
		String startDate = "";
		String endDate = "";
		Date sDate;
		Date eDate;

		//상반기
		String fh_date = nowYear+"-06-30";
		//하반기
		String sh_date = nowYear+"-07-01";
		
		if(Integer.parseInt(start.split("-")[0]) < nowYear) {
			startDate = nowYear+"-01-01";
		} else if(Integer.parseInt(start.split("-")[0]) == nowYear) {
			startDate = start;
		} else {
			startDate = start;
		}
		
		if(Integer.parseInt(end.split("-")[0]) > nowYear) {
			endDate = nowYear+"-12-31";
	
		} else if(Integer.parseInt(end.split("-")[0]) == nowYear) {
			endDate = end;
		} else {
			endDate = end;
		}
		
		
		if(Integer.parseInt(endDate.split("-")[1]) < 07) {
			fh_date = endDate;
		}
		
		if(Integer.parseInt(startDate.split("-")[1]) > 06) {
			sh_date = startDate;
		}
		
		
		try {
			sDate = sf.parse(startDate);
			eDate = sf.parse(endDate);
			fh_mm = (long) ((sf.parse(fh_date).getTime() - sDate.getTime()) / (24*60*60*1000));
			sh_mm = (long) ((eDate.getTime() - sf.parse(sh_date).getTime()) / (24*60*60*1000));

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		if(Integer.parseInt(start.split("-")[0]) > nowYear) {
			fh_mm = 0;
			sh_mm = 0;
		} else if((Integer.parseInt(start.split("-")[0]) == nowYear && Integer.parseInt(start.split("-")[1]) > 06)) {
			fh_mm = 0;
		}
		
		if(Integer.parseInt(end.split("-")[0]) < nowYear ) {
			fh_mm = 0;
			sh_mm = 0;
		} else if((Integer.parseInt(end.split("-")[0]) == nowYear && Integer.parseInt(end.split("-")[1]) < 07)) {
			sh_mm = 0;
		}
		
		result[0] = String.format("%.1f", (fh_mm/30.0));
		result[1] = String.format("%.1f", (sh_mm/30.5));
		
		return result;
	}
	
	public ArrayList<CMSBean> getCMS_minusList(String projectTeam){
		ArrayList<CMSBean> list = new ArrayList<CMSBean>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Date now = new Date();
	    	SimpleDateFormat sf = new SimpleDateFormat("yyyy");
	    	String year = sf.format(now);
			StringBuffer query = new StringBuffer();
	    	query.append("select project.no, project.프로젝트명, project.팀_매출, member.팀, member.이름, member.직급, career.start, career.end, rank.compensation "
	    			+ "from project, career, member, rank "
	    			+ "where project.year = ? and project.상태 != '8.Dropped' and project.실적보고 = 1 and member.소속 = '슈어소프트테크' and project.no = career.projectNo and career.id = member.id and rank.rank = member.직급"
	    			+ " and project.팀_매출 != member.팀 and project.팀_매출 = ? and (project.상반기매출 != 0 or project.하반기매출 != 0)");
	    	conn = DBconnection.getConnection(); 
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, year);
	    	pstmt.setString(2, projectTeam);
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		CMSBean cms = new CMSBean();
	    		cms.setNo(rs.getString("no"));	    		
	    		cms.setProjectName(rs.getString("프로젝트명"));
	    		cms.setSalesTeam(rs.getString("팀_매출"));
	    		cms.setTeam(rs.getString("팀"));
	    		cms.setName(rs.getString("이름"));
	    		cms.setRank(rs.getString("직급"));
	    		cms.setStart(rs.getString("start"));
	    		cms.setEnd(rs.getString("end"));
	    		cms.setFH_MM(Float.parseFloat(cal_manmoth(rs.getString("start"), rs.getString("end"))[0]));
	    		cms.setSH_MM(Float.parseFloat(cal_manmoth(rs.getString("start"), rs.getString("end"))[1]));
	    		cms.setFH_MM_CMS((cms.getFH_MM() * rs.getInt("compensation")/100));
	    		cms.setSH_MM_CMS((cms.getSH_MM() * rs.getInt("compensation")/100));
	    		list.add(cms);
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
	
	public ArrayList<CMSBean> getCMS_plusList(String team){
		ArrayList<CMSBean> list = new ArrayList<CMSBean>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Date now = new Date();
	    	SimpleDateFormat sf = new SimpleDateFormat("yyyy");
	    	String year = sf.format(now);
			StringBuffer query = new StringBuffer();
	    	query.append("select project.no, project.프로젝트명, project.팀_매출, member.팀, member.이름, member.직급, career.start, career.end, rank.compensation "
	    			+ "from project, career, member, rank "
	    			+ "where project.year = ? and project.상태 != '8.Dropped' and project.실적보고 = 1 and member.소속 = '슈어소프트테크' and project.no = career.projectNo and career.id = member.id and rank.rank = member.직급"
	    			+ " and project.팀_매출 != member.팀 and member.팀 = ? and (project.상반기매출 != 0 or project.하반기매출 != 0)");
	    	conn = DBconnection.getConnection(); 
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setString(1, year);
	    	pstmt.setString(2, team);
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		CMSBean cms = new CMSBean();
	    		cms.setNo(rs.getString("no"));	    		
	    		cms.setProjectName(rs.getString("프로젝트명"));
	    		cms.setSalesTeam(rs.getString("팀_매출"));
	    		cms.setTeam(rs.getString("팀"));
	    		cms.setName(rs.getString("이름"));
	    		cms.setRank(rs.getString("직급"));
	    		cms.setStart(rs.getString("start"));
	    		cms.setEnd(rs.getString("end"));
	    		cms.setFH_MM(Float.parseFloat(cal_manmoth(rs.getString("start"), rs.getString("end"))[0]));
	    		cms.setSH_MM(Float.parseFloat(cal_manmoth(rs.getString("start"), rs.getString("end"))[1]));
	    		cms.setFH_MM_CMS((cms.getFH_MM() * rs.getInt("compensation")/100));
	    		cms.setSH_MM_CMS((cms.getSH_MM() * rs.getInt("compensation")/100));
	    		list.add(cms);
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
	
	
	
	// summary 수주/매출 테이블용 career 데이터
	public ArrayList<careerSummary_Bean> getCareerSummary(){
		ArrayList<careerSummary_Bean> list = new ArrayList<careerSummary_Bean>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Date now = new Date();
	    	SimpleDateFormat sf = new SimpleDateFormat("yyyy");
	    	String year = sf.format(now);
			StringBuffer query = new StringBuffer();
	    	query.append("SELECT career.id, member.이름, career.projectNo, member.팀, rank.compensation FROM career, member, rank, project "
	    			+ "where project.no = career.projectNo and project.year = 2020 and member.직급 = rank.rank and career.id = member.id and member.소속 = '슈어소프트테크' "
	    			+ "group by id, projectNo;");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		careerSummary_Bean cs = new careerSummary_Bean();
	    		cs.setId(rs.getString(1));
	    		cs.setName(rs.getString(2));
	    		cs.setNo(rs.getInt(3));
	    		cs.setTeam(rs.getString(4));
	    		cs.setCompensation(rs.getInt(5));
	    		list.add(cs);
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
	
	// 팀별 목포 수주,매출 데이터 가져오기
	public ArrayList<TeamBean> getTagetData(){
		ArrayList<TeamBean> list = new ArrayList<TeamBean>();
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("SELECT * from team");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		TeamBean team = new TeamBean();
	    		team.setTeamNum(rs.getInt("teamNum"));
	    		team.setTeamName(rs.getString("teamName"));
	    		team.setFH_targetOrder(rs.getFloat("상반기목표수주"));
	    		team.setFH_targetSales(rs.getFloat("상반기목표매출"));
	    		team.setSH_targetOrder(rs.getFloat("하반기목표수주"));
	    		team.setSH_targetSales(rs.getFloat("하반기목표매출"));
	    		list.add(team);
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
	
	// 목표 수주,매출 저장
	public int[] saveTargetData(float FH_chassis_PJ, float FH_body_PJ, float FH_control_PJ, float FH_safe_PJ, float FH_auto_PJ, float FH_vt_PJ,
			float FH_chassis_SALES, float FH_body_SALES, float FH_control_SALES, float FH_safe_SALES, float FH_auto_SALES, float FH_vt_SALES,
			float SH_chassis_PJ, float SH_body_PJ, float SH_control_PJ, float SH_safe_PJ, float SH_auto_PJ, float SH_vt_PJ,
			float SH_chassis_SALES, float SH_body_SALES, float SH_control_SALES, float SH_safe_SALES, float SH_auto_SALES, float SH_vt_SALES) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int[] rs = new int[6];
	
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("update team set 상반기목표수주=?, 상반기목표매출=?, 하반기목표수주=?, 하반기목표매출=? where teamName=?;");
	    	conn = DBconnection.getConnection();
	    	conn.setAutoCommit(false);
	    	pstmt = conn.prepareStatement(query.toString());
	    	pstmt.setFloat(1, FH_chassis_PJ);
	    	pstmt.setFloat(2, FH_chassis_SALES);
	    	pstmt.setFloat(3, SH_chassis_PJ);
	    	pstmt.setFloat(4, SH_chassis_SALES);
	    	pstmt.setString(5, "샤시힐스검증팀");
	    	pstmt.addBatch();
	    	
	    	pstmt.setFloat(1, FH_body_PJ);
	    	pstmt.setFloat(2, FH_body_SALES);
	    	pstmt.setFloat(3, SH_body_PJ);
	    	pstmt.setFloat(4, SH_body_SALES);
	    	pstmt.setString(5, "바디힐스검증팀");
	       	pstmt.addBatch();
	    	
	    	pstmt.setFloat(1, FH_control_PJ);
	    	pstmt.setFloat(2, FH_control_SALES);
	    	pstmt.setFloat(3, SH_control_PJ);
	    	pstmt.setFloat(4, SH_control_SALES);
	    	pstmt.setString(5, "제어로직검증팀");
	       	pstmt.addBatch();
	       	
	    	pstmt.setFloat(1, FH_safe_PJ);
	    	pstmt.setFloat(2, FH_safe_SALES);
	    	pstmt.setFloat(3, SH_safe_PJ);
	    	pstmt.setFloat(4, SH_safe_SALES);
	    	pstmt.setString(5, "기능안전검증팀");
	       	pstmt.addBatch();
	    	
	    	pstmt.setFloat(1, FH_auto_PJ);
	    	pstmt.setFloat(2, FH_auto_SALES);
	    	pstmt.setFloat(3, SH_auto_PJ);
	    	pstmt.setFloat(4, SH_auto_SALES);
	    	pstmt.setString(5, "자율주행검증팀");
	       	pstmt.addBatch();
	    	
	    	pstmt.setFloat(1, FH_vt_PJ);
	    	pstmt.setFloat(2, FH_vt_SALES);
	    	pstmt.setFloat(3, SH_vt_PJ);
	    	pstmt.setFloat(4, SH_vt_SALES);
	    	pstmt.setString(5, "미래차검증전략실");
	       	pstmt.addBatch();
	       	
	    	rs =pstmt.executeBatch();
	    	conn.commit();
	    	
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    return rs;	    
	}
	
	public HashMap<String, Integer> getRank(){
		HashMap<String, Integer> rank = new HashMap<String, Integer>();
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("SELECT * from rank");
	    	conn = DBconnection.getConnection();
	    	pstmt = conn.prepareStatement(query.toString());
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		rank.put(rs.getString("rank"), rs.getInt("compensation"));
	    	}
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    
		return rank;
	}
	
	public int[] changeRankCompensation(int step1, int step2, int step3, int step4) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs[] = new int[4];
   
		try {
	    	StringBuffer query = new StringBuffer();
	    	query.append("update rank set compensation=? where rank_id=?;");
	    	conn = DBconnection.getConnection();
	    	conn.setAutoCommit(false);
	    	pstmt = conn.prepareStatement(query.toString());
	    	
	    	pstmt.setInt(1, step1);
	    	pstmt.setInt(2, 0);
	    	pstmt.addBatch();
	    	
	    	pstmt.setInt(1, step2);
	    	pstmt.setInt(2, 1);
	       	pstmt.addBatch();
	    	
	    	pstmt.setInt(1, step3);
	    	pstmt.setInt(2, 2);
	       	pstmt.addBatch();
	       	
	    	pstmt.setInt(1, step4);
	    	pstmt.setInt(2, 3);
	       	pstmt.addBatch();
	       	
	    	rs =pstmt.executeBatch();
	    	conn.commit();
	    	
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	    
		return rs;
	}
	
	public static void main(String[] args) {
	 //TODO Auto-generated method stub
		/*SummaryDAO te = new SummaryDAO();
		
		ArrayList<CMSBean> list = new ArrayList<CMSBean>();
		list = te.getCMS_minusList("기능안전검증팀");
		for(int i=0; i<list.size(); i++) {
			System.out.println(list.get(i).getNo());
			System.out.println(list.get(i).getProjectName());
			System.out.println(list.get(i).getSalesTeam());
			System.out.println(list.get(i).getTeam());
			System.out.println(list.get(i).getName());
			System.out.println(list.get(i).getRank());
			System.out.println(list.get(i).getStart());
			System.out.println(list.get(i).getEnd());
			System.out.println(list.get(i).getFH_MM());
			System.out.println(list.get(i).getSH_MM());
			System.out.println(list.get(i).getFH_MM_CMS());
			System.out.println(list.get(i).getSH_MM_CMS());
			System.out.println("----------------------------------------");
		}
		*/
		
		//System.out.println(te.cal_manmoth("2019-09-02", "2019-12-20")[0]);
		//System.out.println(te.cal_manmoth("2019-09-02", "2019-12-20")[1]);
		
}

	
}
