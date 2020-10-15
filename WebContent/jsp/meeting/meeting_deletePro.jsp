<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.DB.method.*" import="jsp.Bean.model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
		}
	
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		
		MeetingDAO meetDao = new MeetingDAO();
		int no = Integer.parseInt(request.getParameter("no"));
		String nextplan = meetDao.getMeetList(no).getP_nextplan();
		
		if(meetDao.deleteMeet(no) == 1){
			if(!(nextplan.equals("-"))){
				meetDao.dropNextPlanTable(nextplan);	
			}
			script.print("<script> alert('회의록이 삭제되었습니다.'); location.href = 'meeting.jsp'; </script>");
		} else{
			script.print("<script> alert('삭제 실패!!'); location.href = 'meeting.jsp'; </script>");
		}
	%>
</body>
</html>