<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="jsp.sheet.method.*"
	import="java.io.PrintWriter"%>
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
	if (session.getAttribute("sessionID") == null){
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	} else{
		if (permission != 0){
			script.print("<script> alert('관리자가 아닙니다.'); history.back(); </script>");
		} else{
			
			sheetMethod.synchronization(request.getParameter("spreadsheet"));
			script.print("<script> alert('동기화 되었습니다.'); location.href = 'project.jsp' </script>");
		}
	}	
	
	%>

</body>
</html>