<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="jsp.Bean.model.*"
	import="java.io.PrintWriter" import="jsp.DB.method.*"%>
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
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	}
	String sessionID = (String)session.getAttribute("sessionID");
	
	int no = Integer.parseInt(request.getParameter("no"));
	String endDate = request.getParameter("endDate");
	
	ProjectDAO projectDao = new ProjectDAO();
	
	
	
	if(projectDao.updateData(no, endDate, "종료") == 1){
		script.print("<script> alert('수정되었습니다.'); location.href = 'project.jsp#"+no+"종료'</script>");
	}else{
		script.print("<script> alert('실패하였습니다.'); location.href = 'project.jsp#"+no+"종료'</script>");
	}
%>
</body>
</html>