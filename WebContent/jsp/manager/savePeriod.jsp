<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.PrintWriter"
    import="jsp.Bean.model.*" import="jsp.DB.method.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
request.setCharacterEncoding("UTF-8");
PrintWriter script =  response.getWriter();
if (session.getAttribute("sessionID") == null){
	script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
}
String sessionID = session.getAttribute("sessionID").toString();
String sessionName = session.getAttribute("sessionName").toString();

String id = request.getParameter("id");

String comeDate = request.getParameter("comDate");
String outDate = request.getParameter("outDate");

int cnt = Integer.parseInt(request.getParameter("cnt"));

String[] rank = new String[cnt];
String[] start = new String[cnt];
String[] end = new String[cnt];

for(int i=0; i<cnt; i++){
	rank = request.getParameterValues("rank");
	start = request.getParameterValues("startDate");
	end = request.getParameterValues("endDate");
}

// 
for(int i=0; i<cnt; i++){
	if(end[i].equals("")){
		end[i] = "now";
	}
}
if(outDate.equals("")){
	outDate = "-";
}

MemberDAO memberDao = new MemberDAO();

int count = 0;
for(int i=0; i<cnt; i++){
	count += memberDao.updatePeriod(rank[i], start[i], end[i], id);
}

if(count == cnt){
	if(memberDao.updateComeOutDate(comeDate, outDate, id) == 1){
		script.print("<script language='javascript'> alert('인사 내역이 수정되었습니다.'); location.href = 'personalManage.jsp?id="+id+"';</script>");
	} else{
		script.print("<script> alert('인사 내역 수정에 실패하였습니다.'); history.back();</script>");
	}
} else{
	script.print("<script> alert('인사 내역 수정에 실패하였습니다.'); history.back();</script>");
}

%>
</head>
<body>

</body>
</html>