<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="jsp.sheet.method.*"
	import="jsp.DB.method.*" import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		int num = Integer.parseInt(request.getParameter("num"));
		PrintWriter script =  response.getWriter();
		MSC_DAO mscDao = new MSC_DAO();
		
		if(mscDao.delete_MSC(num) == 1){
			script.print("<script> alert('일정이 삭제되었습니다'); location.href = 'manager_schedule.jsp'; </script>");
		} else script.print("<script> alert('삭제되지 않았습니다.'); history.back(); </script>");
	%>
</body>
</html>