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

	PrintWriter script = response.getWriter();
	if (session.getAttribute("sessionID") == null) {
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	}

	String sessionID = session.getAttribute("sessionID").toString();
	String sessionName = session.getAttribute("sessionName").toString();
	session.setMaxInactiveInterval(60*240);

	// form 안에 있던 input 태그 name으로 값 가져오기
	String address = request.getParameter("address");
	String comeDate = request.getParameter("comDate");
	String career = request.getParameter("career");
	String mobile = request.getParameter("mobile");
	String gmail = request.getParameter("gmail");
	String workEx = request.getParameter("workEx");

	MemberDAO memberDao = new MemberDAO();

	if (memberDao.mypageUpdate(sessionID, address, comeDate, mobile, gmail, career, workEx) == 1) {	// 내 정보 수정하기
		script.print("<script> alert('정보가 변경 되었습니다.'); location.href = 'mypage.jsp'</script>");
	} else {
		script.print("<script> alert('정보가 변경되지 않았습니다.');  history.back(); </script>");
	}
%>

</body>
</html>
