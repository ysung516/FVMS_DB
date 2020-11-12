<%@page import="Selenium.method.SeleniumExample"%>
<%@page import="com.thoughtworks.selenium.Selenium"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.DB.method.*" import="jsp.Bean.model.*"
	import="Selenium.method.*"
	import="java.util.ArrayList"
	import="java.util.HashMap"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인력 동기화</title>
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

	String coopStr = "";
	String vtStr = "";
	
	SeleniumExample selenium = new SeleniumExample();
	HashMap<String, ArrayList<MemberBean>> coopData = selenium.crawldata();
	for(String key : coopData.keySet()){
		if(key.equals("false")){
			coopStr = "실패!!";
		}else if(key.equals("suc")){
			for(MemberBean mem : coopData.get(key)){
				coopStr += mem.getID() + " ";
				coopStr += mem.getNAME() + " ";
				coopStr += mem.getPART() + "\n";
			}
		}
	}
	HashMap<String, ArrayList<MemberBean>> vtData = selenium.vtdata();
	for(String key : vtData.keySet()){
		if(key.equals("false")){
			coopStr = "실패!!";
		}else if(key.equals("suc")){
			for(MemberBean mem : vtData.get(key)){
				vtStr += mem.getID() + " ";
				vtStr += mem.getNAME() + " ";
				vtStr += mem.getTEAM() + "\n";
			}
		}
	}
	System.out.println(coopStr);
	System.out.println("------------------------");
	System.out.println(vtStr);
	
	%><script> alert('성공하였습니다.'); location.href = 'manager.jsp'; </script>
</body>
</html>