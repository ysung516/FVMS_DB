<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
	import="java.io.PrintWriter" 
    import="jsp.Bean.model.*" import="jsp.DB.method.*"
	import="java.util.LinkedHashMap"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">

<title>Sheet List Management</title><!-- Custom fonts for this template-->

<%
request.setCharacterEncoding("UTF-8");

PrintWriter script =  response.getWriter();
if (session.getAttribute("sessionID") == null){
	script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
}

String nowYear = request.getParameter("year");

ProjectDAO projectDao = new ProjectDAO();
LinkedHashMap<String, String> sheetList = projectDao.getSpreadSheetList();
%>

<style>
body {
	text-align: center;
}

h5 {
	margin: 20px;
}

table {
	margin-left: auto; 
	margin-right: auto;
	width: 500px;
}

td, th {
	border: 1px solid white;
	padding: 5px;
}

.nameTH {
	background-color: #aed6ff;
}

.nameTD {
	background-color: #e0e0e0;
}

.year {
	width: 70px;
}
</style>

<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script>
function addTR(){
	var cnt = $('#tbody tr').length;
	var year = $('.year:last').val();
	var next = Number(year)+1;
	var innerHTML = "";
	innerHTML += '<tr>';
	innerHTML += '<td class="nameTD"><input type="number" class="year" name="year" value="'+next+'" step="1" min="2019"></td>';
	innerHTML += '<td class="nameTD"><input name="sheetName" value=""></td>';
	innerHTML += '<td><input type="button" style="font-size: x-small;" value="-" class="btn btn-primary delTR" onclick="delTR(this);"></td>';
	innerHTML += '</tr>';
	
	$('#tbody').append(innerHTML);
	$('#count').val(cnt+1);
}

function delTR(){
	$(document).on("click",".delTR",function(){	
		var str =""
		var tdArr = new Array();
		var btn = $(this);
		var tr = btn.parent().parent();
		var td = tr.children();
		var delID = td.eq(0).text();
		tr.remove();
		$('#count').val($('#tbody tr').length);
	});
}
</script>

</head>
<body>
<h5>스프레드시트 시트 관리</h5>
<form method="POST" action="sheetManage_Pro.jsp">
<div id="table-responsive">
	<input type="hidden" id="count" name="count" value="<%=sheetList.size()%>">
	<table>
		<thead>
			<tr>
				<th class="nameTH" style="width: 90px;">년도</th>
				<th class="nameTH">시트이름</th>
				<th style="width: 50px;"><input type="button" style="font-size: x-small;" value="+" class="btn btn-primary" onclick="addTR();"></th>
			</tr>
		</thead>
		<tbody id="tbody">
			<%for(String key : sheetList.keySet()){ %>
			<tr>
				<td class="nameTD"><input type="number" class="year" name="year" value="<%=key %>" step="1"></td>
				<td class="nameTD"><input name="sheetName" value="<%=sheetList.get(key) %>"></td>
				<td><input type="button" style="font-size: x-small;" value="-" class="btn btn-primary delTR" onclick="delTR(this);"></td>
			</tr>
			<%} %>
		</tbody>
	</table>
</div>
<input style="margin: 20px;" type="submit" class="btn btn-primary" value="저장">
</form>
</body>
</html>