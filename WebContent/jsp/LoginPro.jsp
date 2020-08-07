<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.io.PrintWriter"
    import = "jsp.DB.method.*"
    import = "jsp.Bean.model.*"
    %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리 JSP</title>
</head>
<body>

 <%
  
     String ID = request.getParameter("ID").toLowerCase();
     String PW = request.getParameter("PW");
     String sessionName;
     String permission;
     PrintWriter script =  response.getWriter();
     
     MemberDAO memberDao = new MemberDAO();
     MemberBean member = memberDao.returnMember(ID);
   
    if (memberDao.logincheck(ID, PW) == 1){
	      script.print("<script> location.href = '../jsp/manager_schedule/manager_schedule.jsp'; </script>");
	      session.setAttribute("sessionID", ID);
	      sessionName = member.getNAME();
	      session.setAttribute("sessionName", sessionName);
	      permission = member.getPermission();
	      session.setAttribute("permission", permission);
     } else 
      script.print("<script> alert('아이디 혹은 비밀번호가 틀립니다.'); history.back(); </script>");

 %>

</body>
</html>