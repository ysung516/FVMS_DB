 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "jsp.Bean.model.*"
    import = "java.io.PrintWriter"
    import = "java.util.Date"
    import = "jsp.DB.method.*"
    import = "java.text.SimpleDateFormat"%>
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
		
		ReportDAO reportDao = new ReportDAO();
		MemberDAO memberDao = new MemberDAO();
		ProjectDAO projectDao = new ProjectDAO();
		String sessionID = (String)session.getAttribute("sessionID");
		MemberBean member = memberDao.returnMember(sessionID);
		
		Date nowTime = new Date();
		if(request.getParameter("TITLE") == null){
			script.print("<script> alert('보고서 제목이 입력되지 않았습니다.'); history.back(); </script>");
		}	else {
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd-a-hh:mm");
				int projectNo = Integer.parseInt(request.getParameter("TITLE"));
				String title = projectDao.getProjectBean_no(projectNo).getPROJECT_NAME();
				String writeDate = sf.format(nowTime);
				String weekPlan = request.getParameter("WeekPlan");
				String weekPro = request.getParameter("WeekPro");
				String nextPlan = request.getParameter("NextPlan");
				String note = request.getParameter("note");
				String specialty = request.getParameter("specialty");
				String name = member.getNAME(); 
				String user_id = member.getID();
				if (reportDao.saveReport(title, writeDate, weekPlan, weekPro, nextPlan, user_id, name, specialty, note, projectNo) == 1){
					script.print("<script> alert('보고서 작성이 완료되었습니다.'); location.href = 'report.jsp'</script>");
					
				} else script.print("<script> alert('보고서작성 실패!!'); history.back(); </script>");
		}	 
%>
</body>
</html>