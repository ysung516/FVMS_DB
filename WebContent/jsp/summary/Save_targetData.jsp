<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.DB.method.*"
	import="java.util.LinkedHashMap"
	import="java.util.LinkedList"
	import="java.util.HashMap"%>
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

		String year = request.getParameter("nowYear");
		
		SummaryDAO summaryDao = new SummaryDAO();
		MemberDAO memberDao = new MemberDAO();
		LinkedHashMap<Integer, String> teamList = memberDao.getTeam_year(year);
		// 디비 처리 함수로 보내줄 해시맵 HashMap<팀명, 상하반기<수주매출<값>>>
		HashMap<String, LinkedList<LinkedList<Float>>> dataList = new HashMap<String, LinkedList<LinkedList<Float>>>();
		int checkNull = 0;

		for(int key : teamList.keySet()){
			dataList.put(teamList.get(key), new LinkedList<LinkedList<Float>>());
			if(request.getParameter("FH_" + Integer.toString(key) +"_PJ") == "" || request.getParameter("SH_" + Integer.toString(key) +"_PJ") == ""
					|| request.getParameter("FH_" + Integer.toString(key) +"_SALES") == "" || request.getParameter("SH_" + Integer.toString(key) +"_SALES") == ""){
				script.print("<script> alert('입력되지않은 값이 있습니다.'); history.back(); </script>");
			}else{
				checkNull++;
				LinkedList<Float> order = new LinkedList<Float>();
				LinkedList<Float> sale = new LinkedList<Float>();
				order.add(Float.valueOf(request.getParameter("FH_" + Integer.toString(key) +"_PJ")));
				order.add(Float.valueOf(request.getParameter("SH_" + Integer.toString(key) +"_PJ")));
				sale.add(Float.valueOf(request.getParameter("FH_" + Integer.toString(key) +"_SALES")));
				sale.add(Float.valueOf(request.getParameter("SH_" + Integer.toString(key) +"_SALES")));
				dataList.get(teamList.get(key)).add(order);
				dataList.get(teamList.get(key)).add(sale);

				System.out.println(teamList.get(key) + "=====================");
				System.out.println(Float.valueOf(request.getParameter("FH_" + Integer.toString(key) +"_PJ")));
				System.out.println(Float.valueOf(request.getParameter("SH_" + Integer.toString(key) +"_PJ")));
				System.out.println(Float.valueOf(request.getParameter("FH_" + Integer.toString(key) +"_SALES")));
				System.out.println(Float.valueOf(request.getParameter("SH_" + Integer.toString(key) +"_SALES")));
			}
		}
		
		if(checkNull == teamList.size()){
			int check [] = new int[teamList.size()];
			int cnt = 0;
			check = summaryDao.saveTargetData(dataList, year);
			for(int i=0; i<check.length; i++){
				if (check[i] == 1){
					cnt ++;
				} else break; 
			}
				
			if(cnt == teamList.size()){
				script.print("<script> alert('저장 성공!!'); location.href='summary.jsp'; </script>");
			} else {
				script.print("<script> alert('저장 실패!!'); history.back(); </script>");
			}
		}
	%>
</body>
</html>