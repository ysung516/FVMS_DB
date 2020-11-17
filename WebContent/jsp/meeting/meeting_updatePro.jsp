<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.DB.method.*" import="jsp.Bean.model.*"
	import="java.util.Date" import="java.text.SimpleDateFormat"
	import="jsp.smtp.method.*"%>
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
		
		Date nowTime = new Date();
		PostMan post = new PostMan();
		SimpleDateFormat sf2 = new SimpleDateFormat("yyyyMMddahhmmss");
		
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
		String nextplan = meetDao.getMeetList(no).getP_nextplan();
		String [] item = new String[count];
		String [] deadline = new String[count];
		String [] pm = new String[count];
		String nextPlanTableName;
		
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd a hh:mm");
		String date = sf.format(nowTime);
		String content = "회의명 : " + MeetName +"\n"
				+ "회의일시 : " +  MeetDate + "\n"
				+ "회의장소 : " + MeetPlace + "\n"
				+ "작성자 : " + writer + "\n"
				+ "수정날짜 : " + date + "\n"
				+ "참석자 : " + attendees + "\n"
				+ "외부참석자 : " + attendees_ex + "\n\n" 
				+ "회의내용 : " + meetNote + "\n\n"
				+ "이슈사항 : " + issue + "\n\n"
				+ "향후일정 : \n";
		
		
		
		if(!(nextplan.equals("-"))){
			if(count > 0){
				nextPlanTableName = nextplan;
				meetDao.dropNextPlanTable(nextPlanTableName);
			}else{
				nextPlanTableName = "-";
				meetDao.dropNextPlanTable(nextplan);
			}
			
		} else {
			if(count > 0){
				nextPlanTableName = sf2.format(nowTime);				
			}else{
				nextPlanTableName = "-";
			}
		}
		
		if(MeetName == null || MeetName == ""){
			script.print("<script> alert('회의명을 작성해주세요.'); history.back();</script>");
		} else{
			
			if(meetDao.updateMeet(no, MeetName, MeetDate, MeetPlace, attendees, attendees_ex, meetNote, issue)== 1){
				meetDao.updateNextPlan(no, nextPlanTableName);
				System.out.println(count);
				if(count > 0){
					for(int i=0; i<count; i++){
						item[i] = request.getParameter("item"+(i+1));
						deadline[i] = request.getParameter("deadline"+(i+1));
						pm[i] = request.getParameter("pm"+(i+1));
					}	
					meetDao.insertNextPlanData(nextPlanTableName, item, deadline, pm, count);
					System.out.println(1);
				}
				
				script.print("<script> alert('회의록 수정 되었습니다.'); location.href = 'meeting.jsp'</script>");
				post.textPost2(content, MeetName, sessionID);
			}
				else script.print("<script> alert('수정 실패!!'); history.back();</script>");
		}
	%>
</body>
</html>