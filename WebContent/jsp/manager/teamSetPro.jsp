<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.PrintWriter"
    import="jsp.Bean.model.*" import="jsp.DB.method.*"
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
	if (session.getAttribute("sessionID") == null){
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	}
	String sessionID = session.getAttribute("sessionID").toString();
	String sessionName = session.getAttribute("sessionName").toString();
	
	int count = Integer.parseInt(request.getParameter("count"));
	String [] teamNum = new String[count-1];
	String [] teamName = new String[count-1];
	
	for(int i = 0; i < count; i++){
		teamNum = request.getParameterValues("teamNum");
		teamName = request.getParameterValues("teamName");
	}
	
	ManagerDAO managerDao = new ManagerDAO();
%>
</body>
</html>