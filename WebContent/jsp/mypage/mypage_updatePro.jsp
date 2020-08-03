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
<title>Insert title here</title>
</head>
<body>


<%
	request.setCharacterEncoding("UTF-8");
	
	 PrintWriter script =  response.getWriter(); 
	 if (session.getAttribute("sessionID") == null){
	  script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../../html/login.html' </script>");
	 }
	
	 String sessionID = session.getAttribute("sessionID").toString();
	 String sessionName = session.getAttribute("sessionName").toString();
	 session.setMaxInactiveInterval(15*60);

	
	 String address = request.getParameter("address");
	 String comeDate = request.getParameter("comeDate");
	 String wyear = request.getParameter("wyear");
	 String career = request.getParameter("career");
	 
	MemberDAO memberDao = new MemberDAO();
	  
    if (memberDao.mypageUpdate(sessionID ,address, comeDate, wyear, career) == 1){
        script.print("<script> alert('정보가 변경 되었습니다.'); location.href = 'mypage.jsp'</script>");
        script.print("<script> alert('정보가 변경되지 않았습니다.');  history.back(); </script>");
        System.out.print(address);
        System.out.print(comeDate);
        System.out.print(wyear);
        System.out.print(career);
      } else {
       script.print("<script> alert('정보가 변경되지 않았습니다.');  history.back(); </script>");
       System.out.print(address);
       System.out.print(comeDate);
       System.out.print(wyear);
       System.out.print(career);
       }

%>


</body>
</html> 