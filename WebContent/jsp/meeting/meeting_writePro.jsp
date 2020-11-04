<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="jsp.DB.method.*" import="jsp.Bean.model.*"
	import="java.io.PrintWriter" import="java.util.Date"
	import="java.text.SimpleDateFormat" import="jsp.smtp.method.*"%>
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
		
		ExcelExporter excel = new ExcelExporter();
		PostMan post = new PostMan();
		String sessionID = (String)session.getAttribute("sessionID");
		String sessionName = (String)session.getAttribute("sessionName");
		MeetingDAO meetDao = new MeetingDAO();
		MemberDAO memberDao = new MemberDAO();
		
		Date nowTime = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd a hh:mm");
		SimpleDateFormat sf2 = new SimpleDateFormat("yyyyMMddahhmmss");
		
		String MeetName = request.getParameter("MeetName");
		String writer = sessionName;
		String date = sf.format(nowTime);
		String MeetDate = request.getParameter("MeetDate");
		
		String MeetPlace = request.getParameter("MeetPlace");
		String attendees = request.getParameter("attendees");
		String attendees_ex = request.getParameter("attendees_ex");
		String meetnote = request.getParameter("meetnote");
		String issue = request.getParameter("issue");
		int count = Integer.parseInt(request.getParameter("count"));
		String nextplan = "-";
		String content = "회의명 : " + MeetName +"\n"
						+ "회의일시 : " +  MeetDate + "\n"
						+ "회의장소 : " + MeetPlace + "\n"
						+ "작성자 : " + writer + "\n"
						+ "작성날짜 : " + date + "\n"
						+ "참석자 : " + attendees + "\n"
						+ "외부참석자 : " + attendees_ex + "\n\n" 
						+ "회의내용 : " + meetnote + "\n\n"
						+ "이슈사항 : " + issue + "\n\n"
						+ "향후일정 : \n";
		
						
		
		
		if(count != 0){
			nextplan = sf2.format(nowTime);
		}	
		
		String [] item = new String[count];
		String [] deadline = new String[count];
		String [] pm = new String[count];
		

		if(MeetName == null || MeetName == ""){
			script.print("<script> alert('회의명을 작성해주세요.'); history.back();</script>");
		} else{
			
			if(meetDao.saveMeet(sessionID, MeetName, writer, MeetDate, MeetPlace, attendees, meetnote, nextplan, date, attendees_ex, issue) == 1){
				if(count > 0){
					for(int i=0; i<count; i++){
						item[i] = request.getParameter("item"+(i+1));
						deadline[i] = request.getParameter("deadline"+(i+1));
						pm[i] = request.getParameter("pm"+(i+1));
						content += "항목 :" + request.getParameter("item"+(i+1)) +"   "
						+ "기한 : " + request.getParameter("deadline"+(i+1)) +"   "
						+ "담당자 : " + request.getParameter("pm"+(i+1)) +"\n"; 
					}	
					meetDao.insertNextPlanData(nextplan, item, deadline, pm, count);
					
				}
				script.print("<script> alert('회의록 작성이 되었습니다.'); location.href = 'meeting.jsp'</script>");
				post.textPost(content, MeetName, sessionID);
			}
				else script.print("<script> alert('작성 실패!!'); history.back();</script>");
		}
		
	%>


</body>
</html>