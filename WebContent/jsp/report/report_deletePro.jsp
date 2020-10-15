<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.DB.method.*" import="jsp.Bean.model.*"%>
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
		int permission = Integer.parseInt(session.getAttribute("permission").toString());
		if(permission > 2){
			script.print("<script> alert('접근 권한이 없습니다.'); history.back(); </script>");
		}
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		
		int no = Integer.parseInt(request.getParameter("no"));
		ReportDAO reportDao = new ReportDAO();
		if(reportDao.deleteReport(no)==1){
			script.print("<script> alert('보고서가 삭제되었습니다.'); location.href = 'report.jsp'; </script>");
		}else{
			script.print("<script> alert('삭제 실패했습니다.'); history.back(); </script>");
		}	
	%>
</body>
</html>