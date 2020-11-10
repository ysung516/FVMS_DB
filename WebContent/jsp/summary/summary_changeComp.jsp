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
	SummaryDAO summaryDao = new SummaryDAO();
	
	if(request.getParameter("1step").equals("") || request.getParameter("2step").equals("") || 
			request.getParameter("3step").equals("") || request.getParameter("4step").equals("")){
		script.print("<script> alert('빈 칸이 있습니다'); history.back(); </script>");
	}else{
		int step1 = Integer.parseInt(request.getParameter("1step"));
		int step2 = Integer.parseInt(request.getParameter("2step"));
		int step3 = Integer.parseInt(request.getParameter("3step"));
		int step4 = Integer.parseInt(request.getParameter("4step"));
		int result[] = new int[4];
		result = summaryDao.changeRankCompensation(step1, step2, step3, step4);
		System.out.print(result[0] + result[1] + result[2] + result[3]);
		if(result[0]==1 && result[1]==1 && result[2]==1 && result[3]==1){
			script.print("<script> alert('변경을 완료하였습니다'); location.href = 'summary.jsp'; </script>");
		} else{
			script.print("<script> alert('변경을 실패하였습니다'); history.back(); </script>");
		}
	}

%>
</body>
</html>