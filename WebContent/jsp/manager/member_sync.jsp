<%@page import="org.json.JSONObject"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="org.json.JSONArray"%>
<%@page import="jxl.*"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFDateUtil"%>

<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>

<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>

<%@page import="org.apache.poi.ss.usermodel.Sheet"%>

<%@page import="org.apache.poi.ss.usermodel.Workbook"%>

<%@page import="org.apache.poi.ss.usermodel.Row"%>

<%@page import="org.apache.poi.ss.usermodel.Cell"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.PrintWriter"
    import="jsp.Bean.model.*" import="jsp.DB.method.*"
    import="java.io.File"
    import="com.oreilly.servlet.MultipartRequest"
    import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"
    import="java.util.ArrayList" import="java.util.List"
   	import="java.util.LinkedHashMap"
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>file upload</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	PrintWriter script =  response.getWriter();
	
	// excel => json
	//경로설정
	String path = "../webapps/ROOT/upload";	//서버
	//String path = "C:/Users/User/git/FVMS_DB/WebContent/upload";	//로컬
	
	//파일받기
	MultipartRequest multipartRequest = new MultipartRequest(request, path, 1024*1024*30, "utf-8", new DefaultFileRenamePolicy());
	
	//파일 원래 이름 저장
	String originalFileName = multipartRequest.getOriginalFileName("file1");
	
	//파일 업로드
	File file = multipartRequest.getFile("file1");
	FileInputStream excelFile = new FileInputStream(file);
	
	JSONArray jsonArray = new JSONArray();
	
	Workbook workbook = null;
	workbook = new HSSFWorkbook(excelFile);
	
	Row row = null;
	Cell cell = null;
	JSONObject data = null;
	
	Sheet sheet = workbook.getSheetAt(0);
	List<String> titleList = new ArrayList<String>();
	
	int i = 0;
	while(sheet.getRow(i) != null){
		row = sheet.getRow(i);
		if(row == null || row.getCell(0).getStringCellValue().equals("")) break;
		data = new JSONObject();
		
		int max = sheet.getRow(0).getPhysicalNumberOfCells();
		for(int c = 0; c<max;c++){
			cell = row.getCell(c);
			if(row.getCell(c) != null)
				row.getCell(c).setCellType(HSSFCell.CELL_TYPE_STRING);
			
			if(i==0){
				titleList.add(cell.getStringCellValue());
			}else{
				if(cell==null|| cell.getCellType() == Cell.CELL_TYPE_BLANK){
					data.put(titleList.get(c), "");
				}else{ // 데이터 삽입
					data.put(titleList.get(c), cell.getStringCellValue()==null? "":cell.getStringCellValue());
				}
			}
		}
		
		if(i != row.getFirstCellNum()){
			jsonArray.put(data);
		}
		
		i++;
	}
	
	workbook.close();
	file.delete();
	
	
	MemberDAO memberDao = new MemberDAO();
	int year = Integer.parseInt(request.getParameter("year"));
	ArrayList<MemberBean> memList = memberDao.getMemberData(year);
	LinkedHashMap<Integer, String> teamList = memberDao.getTeam();
	
	//추가할 멤버 리스트
	ArrayList<MemberBean> list = new ArrayList<MemberBean>();
	
	int cocount = 0;
	int vtcount = 0;
	int result = 0;
	
	try{
		for(int a=0; a<jsonArray.length(); a++){
			String name = "";
			String id = "";
			String part = "-";
			String team = "-";
			String rank = "-";
			String mobile = "-";
			String gmail = "-";
			String permission = "3";
			String comeDate = "";
			
			int cnt = 0;
			JSONObject obj = jsonArray.getJSONObject(a);
			id = obj.getString("이메일").split("@")[0];
			for(MemberBean coop : memList){
				if(coop.getID().trim().equals(id.trim())){
					cnt = 1;
					if(!coop.getMOBILE().equals(obj.getString("휴대전화"))){
						mobile = obj.getString("휴대전화");
						if(!mobile.equals("") && !mobile.contains("-") && mobile.charAt(0) != '0'){	// 휴대폰 번호에 하이픈이 없어서 맨 앞에 0이 지워졌을 경우
							mobile = "0" + mobile;
							mobile = memberDao.phone(mobile);
						}
						memberDao.updateMobileExcel(id, mobile);
					}
					if(!coop.getComDate().equals(obj.getString("입사일"))){
						comeDate = obj.getString("입사일");
						memberDao.updateComeDateExcel(id, comeDate);
					}
					break;
				}
			}
			if(cnt == 0){
				name = obj.getString("이름");
				part = obj.getString("부서명");
				int partCheck = 0;
				team = obj.getString("그룹").replace(" ", "");
				int teamCheck = 0;
				mobile = obj.getString("휴대전화");
				if(!mobile.equals("") && !mobile.contains("-") && mobile.charAt(0) != '0'){	// 휴대폰 번호에 하이픈이 없어서 맨 앞에 0이 지워졌을 경우
					mobile = "0" + mobile;
					mobile = memberDao.phone(mobile);
				}
				gmail = obj.getString("이메일");
				comeDate = obj.getString("입사일");
				rank = obj.getString("직위");
				if(!(rank.equals("인턴") || rank.equals("전임") || rank.equals("선임") || rank.equals("책임") || rank.equals("수석"))){
					rank = "-";
				}
				for(int teamNum : teamList.keySet()){	// 본사 직원일 때
					if(team.replace(" ", "").equals(teamList.get(teamNum))){
						teamCheck = 1;
						part = "슈어소프트테크";
						// permission = "2";
						break;
					}
				}
				if(teamCheck == 0){
					team = teamList.get(0);
				}
				
				result = memberDao.plusNewMember(name, id, "12345", part, team, rank, "-", permission, mobile, gmail, comeDate);
				
				cocount += result;
			}

		}
		script.print("<script> alert('회원 추가를 성공하였습니다.'); location.href = 'manager.jsp'; </script>");
	}catch(Exception e){
		System.out.println(e.getMessage());
		script.print("<script> alert('회원 추가를 실패하였습니다.'); history.back(); </script>");
	}
%>
</body>
</html>