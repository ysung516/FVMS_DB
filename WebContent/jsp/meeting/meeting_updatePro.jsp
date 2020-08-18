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
		
		MeetingDAO meetDao = new MeetingDAO();
		int no = Integer.parseInt(request.getParameter("no"));
		String MeetName = request.getParameter("MeetName");
		String writer = request.getParameter("writer");
		String MeetDate = request.getParameter("MeetDate");
		String MeetPlace = request.getParameter("MeetPlace");
		String attendees = request.getParameter("attendees");
		String attendees_ex = request.getParameter("attendees_ex");
		String meetNote = request.getParameter("MeetNote");
		String issue = request.getParameter("issue");
		int count = Integer.parseInt(request.getParameter("count"));
		int rowCount = meetDao.getRowCount();
		String nextplan = meetDao.getMeetList(no).getP_nextplan();
		String [] item = new String[count];
		String [] deadline = new String[count];
		String [] pm = new String[count];
		System.out.println(count);
		if(!(meetDao.getMeetList(no).getP_nextplan().equals("-"))){
			meetDao.dropNextPlanTable(nextplan);	
			meetDao.updateNextPlan(no, "-");
		}
			
			
		/*

		if(meetDao.updateMeet(no, MeetName, MeetDate, MeetPlace, attendees, meetNote, nextPlan) == 1){
			script.print("<script> alert('회의록이 수정되었습니다.'); location.href = 'meeting.jsp'; </script>");
		}
		else{
			script.print("<script> alert('회의록 수정에 실패했습니다.'); history.back(); </script>");
		}*/
		
		if(MeetName == null || MeetName == ""){
			script.print("<script> alert('회의명을 작성해주세요.'); history.back();</script>");
		} else{
			
			if(meetDao.updateMeet(no, MeetName, MeetDate, MeetPlace, attendees, attendees_ex, meetNote, issue)== 1){
				if(count > 0){
					System.out.print('1');
					String nextPlanTableName = "nextPlan"+ (rowCount);
					meetDao.updateNextPlan(no, nextPlanTableName);
					for(int i=0; i<count; i++){
						item[i] = request.getParameter("item"+(i+1));
						deadline[i] = request.getParameter("deadline"+(i+1));
						pm[i] = request.getParameter("pm"+(i+1));
					}	
					meetDao.createNextPlanTable(nextPlanTableName);
					meetDao.insertNextPlanData(nextPlanTableName, item, deadline, pm, count);
				}
				
				script.print("<script> alert('회의록 수정 되었습니다.'); location.href = 'meeting.jsp'</script>");
			}
				else script.print("<script> alert('수정 실패!!'); history.back();</script>");
		}
	%>
</body>
</html>