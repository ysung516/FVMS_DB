<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.DB.method.*"%>
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
		
		if(request.getParameter("FH_chassis_PJ") == "" || request.getParameter("FH_body_PJ") == "" || request.getParameter("FH_control_PJ") == "" ||
				request.getParameter("FH_safe_PJ") == "" || request.getParameter("FH_auto_PJ") == "" || request.getParameter("FH_vt_PJ") == "" ||
				request.getParameter("FH_chassis_SALES") == "" || request.getParameter("FH_body_SALES") == "" || request.getParameter("FH_control_SALES") == "" || 
				request.getParameter("FH_safe_SALES") == "" || request.getParameter("FH_auto_SALES") == "" || request.getParameter("FH_vt_SALES") == "" ||
				request.getParameter("SH_chassis_PJ") == "" || request.getParameter("SH_body_PJ") == "" ||  request.getParameter("SH_control_PJ") == "" ||
				request.getParameter("SH_safe_PJ") == "" || request.getParameter("SH_auto_PJ") == "" ||  request.getParameter("SH_vt_PJ") == "" ||
				request.getParameter("SH_chassis_SALES") == "" || request.getParameter("SH_body_SALES") == "" || request.getParameter("SH_control_SALES") == "" ||
				request.getParameter("SH_safe_SALES") == "" || request.getParameter("SH_auto_SALES") == "" || request.getParameter("SH_vt_SALES") == "")
		{
			script.print("<script> alert('입력되지않은 값이 있습니다.'); history.back(); </script>");
		} else{
			SummaryDAO summaryDao = new SummaryDAO();
			float FH_chassis_PJ = Float.valueOf(request.getParameter("FH_chassis_PJ"));
			float FH_body_PJ = Float.valueOf(request.getParameter("FH_body_PJ"));
			float FH_control_PJ = Float.valueOf(request.getParameter("FH_control_PJ"));
			float FH_safe_PJ = Float.valueOf(request.getParameter("FH_safe_PJ"));
			float FH_auto_PJ = Float.valueOf(request.getParameter("FH_auto_PJ"));
			float FH_vt_PJ = Float.valueOf(request.getParameter("FH_vt_PJ"));
			float FH_chassis_SALES = Float.valueOf(request.getParameter("FH_chassis_SALES"));
			float FH_body_SALES = Float.valueOf(request.getParameter("FH_body_SALES"));
			float FH_control_SALES = Float.valueOf(request.getParameter("FH_control_SALES"));
			float FH_safe_SALES = Float.valueOf(request.getParameter("FH_safe_SALES"));
			float FH_auto_SALES = Float.valueOf(request.getParameter("FH_auto_SALES"));
			float FH_vt_SALES = Float.valueOf(request.getParameter("FH_vt_SALES"));
			float SH_chassis_PJ = Float.valueOf(request.getParameter("SH_chassis_PJ"));
			float SH_body_PJ = Float.valueOf(request.getParameter("SH_body_PJ"));
			float SH_control_PJ = Float.valueOf(request.getParameter("SH_control_PJ"));
			float SH_safe_PJ = Float.valueOf(request.getParameter("SH_safe_PJ"));
			float SH_auto_PJ = Float.valueOf(request.getParameter("SH_auto_PJ"));
			float SH_vt_PJ = Float.valueOf(request.getParameter("SH_vt_PJ"));
			float SH_chassis_SALES = Float.valueOf(request.getParameter("SH_chassis_SALES"));
			float SH_body_SALES = Float.valueOf(request.getParameter("SH_body_SALES"));
			float SH_control_SALES = Float.valueOf(request.getParameter("SH_control_SALES"));
			float SH_safe_SALES = Float.valueOf(request.getParameter("SH_safe_SALES"));
			float SH_auto_SALES = Float.valueOf(request.getParameter("SH_auto_SALES"));
			float SH_vt_SALES = Float.valueOf(request.getParameter("SH_vt_SALES"));
			
			int check [] = new int[6];
			int cnt = 0;
			check = summaryDao.saveTargetData(FH_chassis_PJ, FH_body_PJ, FH_control_PJ, FH_safe_PJ, FH_auto_PJ, FH_vt_PJ, FH_chassis_SALES, FH_body_SALES, FH_control_SALES, FH_safe_SALES, FH_auto_SALES, FH_vt_SALES, SH_chassis_PJ, SH_body_PJ, SH_control_PJ, SH_safe_PJ, SH_auto_PJ, SH_vt_PJ, SH_chassis_SALES, SH_body_SALES, SH_control_SALES, SH_safe_SALES, SH_auto_SALES, SH_vt_SALES);
			for(int i=0; i<check.length; i++){
				if (check[i] == 1){
					cnt ++;
				} else	break; 
			}
				
			if(cnt == 6){
				script.print("<script> alert('저장 성공!!'); location.href='summary.jsp'; </script>");
			} else {
				script.print("<script> alert('저장 실패!!'); history.back(); </script>");
			}
		}

	%>
</body>
</html>