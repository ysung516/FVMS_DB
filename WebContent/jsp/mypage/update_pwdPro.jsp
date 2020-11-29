<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="java.util.ArrayList"
	import="java.util.List" import="jsp.DB.method.*"
	import="jsp.Bean.model.*"%>
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
	
	String sessionID = session.getAttribute("sessionID").toString();
	String sessionName = session.getAttribute("sessionName").toString();
	
	
	 // 출력
	 String [] line;
	
	
	 String now_pwd = request.getParameter("now_pwd");
	 String next_pwd = request.getParameter("next_pwd");
	 
	 MemberDAO memberDao = new MemberDAO();
	 MemberBean member = memberDao.returnMember(sessionID);
	  
   
	 if(memberDao.logincheck(sessionID, now_pwd) == 1){
		
			 if(memberDao.changePW(sessionID, next_pwd)==1){
				 script.print("<script> alert('비밀번호가 변경 되었습니다.'); location.href = 'mypage.jsp'</script>");
			 }else{
				 script.print("<script> alert('변경 실패!!');  history.back(); </script>");
			 }

	 } else{
		 script.print("<script> alert('현재 비밀번호가 일지하지 않습니다. 다시 입력 해주세요');  history.back(); </script>");
	 }
	 
%>


</body>
</html>
