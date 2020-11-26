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
		String part = request.getParameter("part");
		System.out.print(part);
		String team = request.getParameter("team");
		String permission = request.getParameter("permission");
		String rank = request.getParameter("rank");
		String position = request.getParameter("position");
		String mobile = request.getParameter("mobile");
		String gmail = request.getParameter("gmail");
		String address = request.getParameter("address");
		String comDate = request.getParameter("comDate");
		String career = request.getParameter("career");
		String workEx  = request.getParameter("workEx");
		
		String originRank = request.getParameter("originRank");
		
		MemberDAO memberDao = new MemberDAO();
		
		if(memberDao.managerUpdate(id, address, comDate, mobile, gmail, career, part, team, permission, rank, position, workEx, originRank) == 1){
			script.print("<script> alert('회원 정보 수정 되었습니다..'); location.href = 'manager.jsp'; </script>");
		}
		else{
			script.print("<script> alert('회의 정보 수정에 실패했습니다.'); history.back(); </script>");
		}
		
	%>
	<%=workEx %>
</body>
</html>