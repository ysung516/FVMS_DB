 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "jsp.sheet.method.*"
    import = "jsp.Bean.model.*"
    import = "java.io.PrintWriter"
    import = "java.util.Date"
    import = "java.text.SimpleDateFormat"%>
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
		
		String title = request.getParameter("TITLE"); 
		String writeDate = sf.format(nowTime);
		String weekPlan = request.getParameter("WeekPlan");
		String weekPro = request.getParameter("WeekPro");
		String nextPlan = request.getParameter("NextPlan");
		String note = request.getParameter("note");
		String specialty = request.getParameter("specialty");
		String name = member.getNAME(); 
		String user_id = member.getID();
		
		if (method.saveReport(title, writeDate, weekPlan, weekPro, nextPlan, user_id, name, specialty, note) == 1){
			script.print("<script> alert('보고서 작성이 완료되었습니다.'); location.href = 'report.jsp'</script>");
			
		} else script.print("<script> alert('제목 혹은 작성일이 입력되지 않았습니다.'); history.back(); </script>");
%>
</body>
</html>