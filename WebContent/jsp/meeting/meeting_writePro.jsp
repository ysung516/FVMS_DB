<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "jsp.DB.method.*"
    import = "jsp.Bean.model.*"
    import = "java.io.PrintWriter"
    import = "java.util.Date"
    import = "java.text.SimpleDateFormat"
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
		

		String sessionID = (String)session.getAttribute("sessionID");
		String sessionName = (String)session.getAttribute("sessionName");
		MeetingDAO meetDao = new MeetingDAO();
		
		Date nowTime = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		
		String MeetName = request.getParameter("MeetName");
		String writer = sessionName;
		String date = sf.format(nowTime);
		String MeetDate = request.getParameter("MeetDate");
		String MeetPlace = request.getParameter("MeetPlace");
		String attendees = request.getParameter("attendees");
		String attendees_ex = request.getParameter("attendees-ex");
		String meetnote = request.getParameter("meetnote");
		String issue = request.getParameter("issue");
		int count = Integer.parseInt(request.getParameter("count"));
		int rowCount = meetDao.getRowCount();
		String nextplan = "-";
		
		if(count != 0){
			nextplan = "nextPlan"+Integer.toString(rowCount + 1);
		}	
		
		String [] item = new String[count];
		String [] deadline = new String[count];
		String [] pm = new String[count];
		
		
		
		if(MeetName == null || MeetName == ""){
			script.print("<script> alert('회의명을 작성해주세요.'); history.back();</script>");
		} else{
			
			if(meetDao.saveMeet(sessionID, MeetName, writer, MeetDate, MeetPlace, attendees, meetnote, nextplan, date, attendees_ex, issue) == 1){
				if(count > 0){
					String nextPlanTableName = "nextPlan"+ (rowCount + 1);
					for(int i=0; i<count; i++){
						item[i] = request.getParameter("item"+(i+1));
						deadline[i] = request.getParameter("deadline"+(i+1));
						pm[i] = request.getParameter("pm"+(i+1));
					}	
					meetDao.createNextPlanTable(nextPlanTableName);
					meetDao.insertNextPlanData(nextPlanTableName, item, deadline, pm, count);
				}
				
				script.print("<script> alert('회의록 작성이 되었습니다.'); location.href = 'meeting.jsp'</script>");
			}
				else script.print("<script> alert('작성 실패!!'); history.back();</script>");
		}
		
	%>

		
</body>
</html>