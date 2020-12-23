<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import= "java.io.PrintWriter"
    import = "jsp.DB.method.*"
    import ="jsp.Mean.model.*"
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
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	
	ProjectDAO projectDao = new ProjectDAO();
	
	if (session.getAttribute("sessionID") == null){
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	} else{
		if (permission != 0){
			script.print("<script> alert('관리자가 아닙니다.'); history.back(); </script>");
		} else {
			projectDao.delete_preYearData();
			script.print("<script> alert('삭제 되었습니다.'); location.href = 'project.jsp' </script>");
		}
	}	
	
	%>
</body>
</html>