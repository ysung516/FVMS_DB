<%@page import="org.apache.catalina.valves.rewrite.RewriteCond"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
	String id = request.getParameter("id");
%>
<head>
<meta charset="UTF-8">
<title><%=id %> 프로젝트 수행이력</title>
</head>

<style>
	#dataTable{
		width: 100%;
		border: 1px solid;
    	border-collapse: collapse;
    	
	}
	th, td{
		border: 1px solid;
	}
</style>

<body>
<h3 style="text-align: center;"><%=id %> 프로젝트 수행이력</h3>
<div>
	<table id="dataTable">
		<thead id="Theader">
			<tr>
				<th style="width:40%;">프로젝트명</th>
				<th style="width:25%;">시작날짜</th>
				<th style="width:25%;">종료날짜</th>
				<th style="width:10%;">PM</th>
			</tr>
		</thead>
		<tbody id="Tcontent">
			<tr>
				<td>1</td>
				<td>2</td>
				<td>3</td>
				<td>4</td>
			</tr>
		</tbody>
	</table>
</div>
</body>
</html>