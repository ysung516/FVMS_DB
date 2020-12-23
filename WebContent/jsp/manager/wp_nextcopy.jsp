<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.DB.method.*" import="jsp.Bean.model.*"
	import="java.util.ArrayList" import="java.util.List"
	import="java.text.SimpleDateFormat" import="java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
		}
		int year = Integer.parseInt(request.getParameter("year"));
		//System.out.println(request.getParameter("year"));
		//System.out.println(request.getParameter("cnt"));
		
		
		int cnt = Integer.parseInt(request.getParameter("cnt"));
		
		ManagerDAO managerDao = new ManagerDAO();
		
		if(managerDao.nextYear_copy(year-1) == cnt){
			script.print("<script> alert('근무지가 저장 되었습니다.'); location.href = 'workPlace_manage.jsp?year="+year+"'</script>");
		} else{
			script.print("<script> alert('복사 실패!!'); history.back();</script>");
		}
	%>
</body>
</html>