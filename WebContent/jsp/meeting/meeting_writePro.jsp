<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "jsp.DB.method.*"
    import = "jsp.Bean.model.*"
    import = "java.io.PrintWriter"
    import = "java.util.Date"
    import = "java.text.SimpleDateFormat"
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
		

		String sessionID = (String)session.getAttribute("sessionID");
		String sessionName = (String)session.getAttribute("sessionName");
		MeetingDAO meetDao = new MeetingDAO();
		
		Date nowTime = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		
		String MeetName = request.getParameter("MeetName");
		String writer = sessionName;
		String date = sf.format(nowTime);
		String MeetDate = request.getParameter("MeetDate");
		String MeetPlace = request.getParameter("MeetPlace");
		String attendees = request.getParameter("attendees");
		String meetnote = request.getParameter("meetnote");
		String nextplan = request.getParameter("nextplan");
		if(MeetName == null || MeetName == ""){
			script.print("<script> alert('회의명을 작성해주세요.'); history.back();</script>");
		} else{
			
			if(meetDao.saveMeet(sessionID, MeetName, writer, MeetDate, MeetPlace, attendees, meetnote, nextplan, date) == 1){
				script.print("<script> alert('회의록 작성이 되었습니다.'); location.href = 'meeting.jsp'</script>");
			}
				else script.print("<script> alert('작성 실패!!'); history.back();</script>");
		}
		
		
	%>

		
</body>
</html>