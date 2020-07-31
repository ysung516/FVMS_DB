<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "jsp.sheet.method.*"
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
		sheetMethod method = new sheetMethod();
		String sessionID = (String)session.getAttribute("sessionID");
		
		method.saveUser_info(sessionID);
		MemberBean member = method.getMember();
	
		Date nowTime = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		
		String MeetName = request.getParameter("MeetName");
		String writer = member.getNAME();
		String date = sf.format(nowTime);
		String MeetDate = request.getParameter("MeetDate");
		String MeetPlace = request.getParameter("MeetPlace");
		String attendees = request.getParameter("attendees");
		String meetnote = request.getParameter("meetnote");
		String nextplan = request.getParameter("nextplan");
		System.out.println(nextplan);
		if(method.saveMeet(sessionID, MeetName, writer, MeetDate, MeetPlace,
				attendees, meetnote, nextplan, date) == 1){
			script.print("<script> alert('회의록 작성이 완료되었습니다.'); location.href = 'meeting.jsp'</script>");
		}
			else script.print("<script> alert('빈칸을 모두 채워주세요.'); history.back();</script>");
	%>

		
</body>
</html>