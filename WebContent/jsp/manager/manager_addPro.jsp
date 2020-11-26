<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.DB.method.*" import="jsp.Bean.model.*"
	import="java.text.SimpleDateFormat"
	import="java.util.Date"%>
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
		
		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sf.format(date);
		
		if(request.getParameter("id")=="" || request.getParameter("name")=="" || request.getParameter("pw")==""){
			script.print("<script> alert('*표시 부분은 반드시 작성해야합니다.'); history.back(); </script>");
		}else{
			MemberDAO memberDao = new MemberDAO();
			
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String part = request.getParameter("part");
			String team = request.getParameter("team");
			String rank = request.getParameter("rank");
			String position = request.getParameter("position");
			String permission = request.getParameter("permission");
			String mobile = "-";
			String gmail = "-";
			
			if(memberDao.returnMember(id).getID()!= null){
				script.print("<script> alert('사용중인 아이디 입니다.'); history.back(); </script>");
			} else{
				if(memberDao.insertMember(name, id, pw, part, team, rank, position, permission, mobile, gmail) == 1){
					if(memberDao.insertRankPeriod(id, rank, today) == 1){
						script.print("<script> alert('회원이 등록 되었습니다..'); location.href = 'manager.jsp'; </script>");
					}
				}
				else{
					script.print("<script> alert('회원 등록에 실패했습니다.'); history.back(); </script>");
				}
			}
		}

	%>
</body>
</html>