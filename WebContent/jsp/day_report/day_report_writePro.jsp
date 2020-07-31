<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "jsp.sheet.method.*"
    import = "jsp.Bean.model.*"
    import = "java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head> 
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		sheetMethod method = new sheetMethod();
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../../html/login.html' </script>");
		}
	
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		method.saveUser_info(sessionID);
		MemberBean member = method.getMember();
		
		String title = request.getParameter("TITLE"); 
		String writeDate = request.getParameter("WRITE_DATE").toString();
		String weekPlan = request.getParameter("WeekPlan");
		String weekPro = request.getParameter("WeekPro");
		String nextPlan = request.getParameter("NextPlan");
		String name = member.getNAME(); 
		String rank = member.getRANK();
		String team = member.getTEAM();
		String user_id = member.getID();
		
		if (method.save_DayReport(title, writeDate, weekPlan, weekPro, nextPlan, user_id, name, rank, team) == 1){
			script.print("<script> alert('보고서 작성이 완료되었습니다.'); location.href = 'day_report.jsp'</script>");
			
		} else script.print("<script> alert('제목 혹은 작성일이 입력되지 않았습니다.'); history.back(); </script>");
%>
</body>
</html>