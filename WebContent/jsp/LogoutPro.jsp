<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "jsp.sheet.method.*"
    import = "java.io.PrintWriter"
    %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃 처리 JSP</title>
</head>
<body>

 <%
 	session.invalidate();
	response.sendRedirect("../html/login.html");
 %>

</body>
</html>