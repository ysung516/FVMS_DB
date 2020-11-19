<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="java.util.ArrayList" import="java.util.Arrays"
	import="java.util.List" import="jsp.DB.method.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		PrintWriter script =  response.getWriter();
		String date_arr[] = new String[5];
		String AmPlace_arr[] = new String[5];
		String PmPlace_arr[] = new String[5];
		
		MSC_DAO mscDao = new MSC_DAO();
		MemberDAO memberDao = new MemberDAO();
		String team = memberDao.returnMember(sessionID).getTEAM();
		
		String monDate = request.getParameter("date1");
		String tueDate = request.getParameter("date2");
		String wedDate = request.getParameter("date3");
		String thuDate = request.getParameter("date4");
		String friDate = request.getParameter("date5");
		
		String AMother = "미입력";
		String PMother = "미입력";
		
		//save date
		date_arr[0] = monDate;
		date_arr[1] = tueDate;
		date_arr[2] = wedDate;
		date_arr[3] = thuDate;
		date_arr[4] = friDate;
		
		//mon
		if(!(request.getParameter("amselboxDirect_mon") == "")){
			AMother = request.getParameter("amselboxDirect_mon");	
		}
		
		if(!(request.getParameter("pmselboxDirect_mon") == "")){
			PMother = request.getParameter("pmselboxDirect_mon");	
		}
		
		
		AmPlace_arr[0] = request.getParameter("amPlaceSel_mon");
		if(AmPlace_arr[0] != null && AmPlace_arr[0].equals("기타")){
			AmPlace_arr[0] = AMother;
		}
		
		PmPlace_arr[0] = request.getParameter("pmPlaceSel_mon");
		if(PmPlace_arr[0] != null && PmPlace_arr[0].equals("기타")){
			PmPlace_arr[0] = PMother;
		}
		
		//tue
		if(!(request.getParameter("amselboxDirect_tue") == "")){
			AMother = request.getParameter("amselboxDirect_tue");	
		}
		
		if(!(request.getParameter("pmselboxDirect_tue") == "")){
			PMother = request.getParameter("pmselboxDirect_tue");	
		}
		
		
		AmPlace_arr[1] = request.getParameter("amPlaceSel_tue");
		if(AmPlace_arr[1] != null && AmPlace_arr[1].equals("기타")){
			AmPlace_arr[1] = AMother;
		}
		
		PmPlace_arr[1] = request.getParameter("pmPlaceSel_tue");
		if(PmPlace_arr[1] != null && PmPlace_arr[1].equals("기타")){
			PmPlace_arr[1] = PMother;
		}
		
		//wed
		if(!(request.getParameter("amselboxDirect_wed") == "")){
			AMother = request.getParameter("amselboxDirect_wed");	
		}
		
		if(!(request.getParameter("pmselboxDirect_wed") == "")){
			PMother = request.getParameter("pmselboxDirect_wed");	
		}
		
		
		AmPlace_arr[2] = request.getParameter("amPlaceSel_wed");
		if(AmPlace_arr[2] != null && AmPlace_arr[2].equals("기타")){
			AmPlace_arr[2] = AMother;
		}
		
		PmPlace_arr[2] = request.getParameter("pmPlaceSel_wed");
		if(PmPlace_arr[2] != null && PmPlace_arr[2].equals("기타")){
			PmPlace_arr[2] = PMother;
		}
		
		//thu
		if(!(request.getParameter("amselboxDirect_thu") == "")){
			AMother = request.getParameter("amselboxDirect_thu");	
		}
		
		if(!(request.getParameter("pmselboxDirect_thu") == "")){
			PMother = request.getParameter("pmselboxDirect_thu");	
		}
		
		
		AmPlace_arr[3] = request.getParameter("amPlaceSel_thu");
		if(AmPlace_arr[3] != null && AmPlace_arr[3].equals("기타")){
			AmPlace_arr[3] = AMother;
		}
		
		PmPlace_arr[3] = request.getParameter("pmPlaceSel_thu");
		if(PmPlace_arr[3] != null && PmPlace_arr[3].equals("기타")){
			PmPlace_arr[3] = PMother;
		}
	
		//fri
		if(!(request.getParameter("amselboxDirect_fri") == "")){
			AMother = request.getParameter("amselboxDirect_fri");	
		}
		
		if(!(request.getParameter("pmselboxDirect_fri") == "")){
			PMother = request.getParameter("pmselboxDirect_fri");	
		}
		
		
		AmPlace_arr[4] = request.getParameter("amPlaceSel_fri");
		if(AmPlace_arr[4] != null && AmPlace_arr[4].equals("기타")){
			AmPlace_arr[4] = AMother;
		}
		
		PmPlace_arr[4] = request.getParameter("pmPlaceSel_fri");
		if(PmPlace_arr[4] != null && PmPlace_arr[4].equals("기타")){
			PmPlace_arr[4] = PMother;
		}
		
		List<String> print = mscDao.weekAdd_MSC(AmPlace_arr, PmPlace_arr, date_arr, sessionID);
		if(print.isEmpty() == false){
			%><script> alert('<%for(String value : print){out.print(value);%>'+'\n'+'<%}%>'+'\n일정이 입력되었습니다.'); 
							location.href = 'manager_schedule.jsp'; </script>
	<%
		}	else  %><script> alert('일정 입력이 실패되었습니다.'); location.href = 'manager_schedule.jsp'; </script>

</body>
</html>