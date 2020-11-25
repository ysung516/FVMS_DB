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
		
		String year = request.getParameter("year");
		
		MemberDAO memberDao = new MemberDAO();
		int teamcnt = memberDao.getTeam().size();
		ManagerDAO managerDao = new ManagerDAO();
		
		int result = managerDao.teamCopy_next();
		if(result == teamcnt){
			script.print("<script> alert('팀이 복사되었습니다.'); location.href = 'teamSet.jsp?selectYear="+year+"'</script>");
		} else if(result == 0){
			script.print("<script> alert('"+year+"년 데이터가 이미 존재합니다.'); history.back();</script>");
		} else{
			script.print("<script> alert('복사 실패!!'); history.back();</script>");
		}
	%>
</body>
</html>