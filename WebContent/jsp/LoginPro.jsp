<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "jsp.sheet.method.*"
    import = "java.io.PrintWriter"
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
     PrintWriter script =  response.getWriter();
     sheetMethod method = new sheetMethod();
    if (method.loginCheck(ID, PW) == 1){
	      script.print("<script> location.href = '../jsp/manager_schedule/manager_schedule.jsp'; </script>");
	      session.setAttribute("sessionID", ID);
	      method.saveUser_info(ID);
	      sessionName = method.getMember().getNAME();
	      session.setAttribute("sessionName", sessionName);
     
     } else 
      script.print("<script> alert('아이디 혹은 비밀번호가 틀립니다.'); history.back(); </script>");
    
  
 %>

</body>
</html>