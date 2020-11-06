<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="jsp.Bean.model.*"
	import="java.io.PrintWriter" 
	import="jsp.DB.method.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
		}
		
		int projectNo = Integer.parseInt(request.getParameter("no"));
		int year = Integer.parseInt(request.getParameter("year"));
		String data = request.getParameter("data2");
		String attr = request.getParameter("attribute");
		
		ProjectDAO projectDao = new ProjectDAO();
		
		projectDao.updateData(projectNo, data, attr,year); 
	%>
</body>
</html>