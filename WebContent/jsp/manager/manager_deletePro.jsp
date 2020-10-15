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
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		
		String id = request.getParameter("id");
		MemberDAO memberDao = new MemberDAO();
		
		if(memberDao.deleteMember(id) == 1){
			script.print("<script> alert('회원이 삭제되었습니다.'); location.href = 'manager.jsp'; </script>");
		}else{
			script.print("<script> alert('삭제 실패했습니다.'); history.back(); </script>");
		}
	%>
</body>
</html>