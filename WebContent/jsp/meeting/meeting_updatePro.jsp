<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.io.PrintWriter"
    import = "jsp.DB.method.*"
    import = "jsp.Bean.model.*"
    %>
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
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../../html/login.html' </script>");
		}
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		
		int no = Integer.parseInt(request.getParameter("no"));
		String MeetName = request.getParameter("MeetName");
		String writer = request.getParameter("writer");
		String MeetDate = request.getParameter("MeetDate");
		String MeetPlace = request.getParameter("MeetPlace");
		String attendees = request.getParameter("attendees");
		String meetNote = request.getParameter("MeetNote");
		String nextPlan = request.getParameter("nextPlan");
	
		
		MeetingDAO meetDao = new MeetingDAO();
		if(meetDao.updateMeet(no, MeetName, MeetDate, MeetPlace, attendees, meetNote, nextPlan) == 1){
			script.print("<script> alert('회의록이 수정되었습니다.'); location.href = 'meeting.jsp'; </script>");
		}
		else{
			script.print("<script> alert('회의록 수정에 실패했습니다.'); history.back(); </script>");
		}
	%>
</body>
</html>