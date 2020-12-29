<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="jsp.DB.method.*"
	import="java.util.ArrayList"
	import="java.text.SimpleDateFormat"
	import="java.util.Date"
	import="java.math.BigDecimal"
	%>
<!DOCTYPE html>
<html lang="en">

<head>

<%
	PrintWriter script = response.getWriter();
	if (session.getAttribute("sessionID") == null) {
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	}
	
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	if (permission > 2) {
		script.print("<script> alert('접근 권한이 없습니다.'); history.back(); </script>");
	}
	ProjectDAO projectDao = new ProjectDAO();
	MemberDAO memberDao = new MemberDAO();
	
	Date nowDate = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy");
	int year = Integer.parseInt(sf.format(nowDate));
	
	int maxYear = projectDao.maxYear();
	int yearCount = maxYear - projectDao.minYear() + 1;
	
	if (request.getParameter("selectYear") != null) {
		year = Integer.parseInt(request.getParameter("selectYear"));
	}
	
	String sessionID = session.getAttribute("sessionID").toString();
	String sessionName = session.getAttribute("sessionName").toString();
	
	ArrayList<ProjectBean> projectList = projectDao.getProjectList(year);
	String sheetName = projectDao.getSpreadSheetYear(Integer.toString(year));
	
	ArrayList<MemberBean> memberList = memberDao.getMemberData(year);
	MemberBean myInfo = memberDao.returnMember(sessionID);
	
	
	ArrayList<String[]> workerIdList = new ArrayList<String[]>();
	ArrayList<String> PMnameList = new ArrayList<String>();
	String[] workerIdArray = {};
	String pmInfo = "";
	
	// 투입명단 id >> 이름으로 변경
	for (int i = 0; i < projectList.size(); i++) {
		if (projectList.get(i).getWORKER_LIST() != null) {
			workerIdArray = projectList.get(i).getWORKER_LIST().split(" ");
			for (int a = 0; a < workerIdArray.length; a++) {
		for (int b = 0; b < memberList.size(); b++) {
			if (workerIdArray[a].equals(memberList.get(b).getID())) {
				workerIdArray[a] = memberList.get(b).getNAME();
			}
		}
			}
			workerIdList.add(workerIdArray);
		}
	}
	
	// PM ID >> 이름 변경
	for (int i = 0; i < projectList.size(); i++) {
		if (projectList.get(i).getWORKER_LIST() != null) {
			pmInfo = projectList.get(i).getPROJECT_MANAGER();
			for (int b = 0; b < memberList.size(); b++) {
		if (pmInfo.equals(memberList.get(b).getID())) {
			pmInfo = memberList.get(b).getNAME();
		}
			}
			PMnameList.add(pmInfo);
		}
	}

%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - Project</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<style>
.btn-primary{
	font-size:small;
	margin:5px;
}
.project_form{
		display: inline; 
		float: right;
}
.sidebar .nav-item {
	word-break: keep-all;
}

#sidebarToggle {
	display: none;
}

.sidebar {
	position: relative;
	z-index: 997;
}

.cb {
	height: 18px;
	width: 18px;
	vertical-align: baseline;
}

.check_div {
	padding: 5px;
	width: fit-content;
	margin-bottom: 5px;
	border-radius: 6px;
	border: 0px;
	color: white;
	background-color: #4e73df;
}

.check_div:active {
	padding: 5px;
	width: fit-content;
	margin-bottom: 5px;
	border-radius: 6px;
	box-shadow: 0px 0 3px 3px #324dd2;
	color: white;
	background-color: #4e73df;
}

.check_table {
	display: none;
}

*:focus {
	outline: none;
}

#project_btn {
	position: fixed;
	bottom: 0;
	padding: 10px;
	width: 100%;
	text-align: center;
	background-color: #fff;
	border-top: 1px solid;
}

.loading {
	position: fixed;
	text-align: center;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	font-size: 8px;
	background-color: #4e73df6b;
	background-image: linear-gradient(181deg, #3d5482 16%, #6023b654 106%);
	background-size: cover;
	z-index: 1000;
	color: #ffffffc4;
}

.loading #load {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

.table {
	border: 1px solid;
	border-collapse: collapse;
	white-space: nowrap;
}

.table td, .test-table th {
	border: 1px solid;
	width: 90px;
}

.table thead th {
	position: sticky;
	top: 0;
	background-color: yellow;
	border: 1px solid;
}

.table-responsive {
	width: 100%;
	height: 100vh;
	overflow: auto;
}

.textover {
	width: 18vw;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

#dataTable {
	width: 40%;
}

#dataTable td:hover {
	background-color: black;
}

#dataTable th:hover {
	background-color: purple;
}

.labelST {
	margin-left: 15px;
}

.labelST:hover {
	color: red;
}

@media ( max-width :765px) {
	.project_form{
		display: none; 

}
	.project_form2{
		display: none; 

}
	#sidebarToggle {
		display: block;
	}
	.textover {
		width: 46vw;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.sidebar .nav-item {
		white-space: nowrap !important;
		font-size: x-large !important;
	}
	#accordionSidebar {
		width: 100%;
		height: 100%;
		text-align: center;
		display: inline;
		padding-top: 60px;
		position: fixed;
		z-index: 998;
	}
	#content {
		margin-left: 0;
	}
	.nav-item {
		position: absolute;
		display: inline-block;
		padding-top: 20px;
	}
	.topbar .dropdown {
		padding-top: 0px;
	}
	.card-header {
		margin-top: 3.75rem;
	}
	.topbar {
		z-index: 999;
		position: fixed;
		width: 100%;
	}
	body {
		font-size: small;
	}
	.container-fluid {
		padding: 0;
	}
	.card-header:first-child {
		padding: 0;
	}
	body {
		font-size: small;
	}
	.table td, .table th {
		padding: 0.4rem;
	}
	.card-body {
		padding: 0;
	}
	.py-3 {
		margin-bottom: 6px;
	}
	.m-0 {
		margin-left: 14px !important;
	}
}
</style>

<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script>
	function listLoad(){
		var year = $('#project_year').val();
		location.href ="project.jsp?selectYear="+year;
	}

	var AttrList = '<%=myInfo.getSaveAttr()%>';
	var outAttr = new Array();
	for(var a=0; a<AttrList.split(" ").length; a++){
		 outAttr[a] = AttrList.split(" ")[a];
	}
	
	// table load
    function cbLoad(){
    	for(var a=1;a<34;a++){
    		$('td:nth-child('+a+')').hide();
			$('th:nth-child('+a+')').hide();
    	}
       	var inner = "";
       	var labelList = new Array();
       	labelList = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21'
       		,'22','23','24','25','26','27','28','29','30','31','32','33'];
       	
       	for(var c=0; c<outAttr.length; c++){
       		if(outAttr[c] == '1'){
       			$('td:nth-child(1)').show();
       			$('th:nth-child(1)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '2'){
       			$('td:nth-child(2)').show();
       			$('th:nth-child(2)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '3'){
       			$('td:nth-child(3)').show();
       			$('th:nth-child(3)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '4'){
       			$('td:nth-child(4)').show();
       			$('th:nth-child(4)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '5'){
       			$('td:nth-child(5)').show();
       			$('th:nth-child(5)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '6'){
       			$('td:nth-child(6)').show();
       			$('th:nth-child(6)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '7'){
       			$('td:nth-child(7)').show();
       			$('th:nth-child(7)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '8'){
       			$('td:nth-child(8)').show();
       			$('th:nth-child(8)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '9'){
       			$('td:nth-child(9)').show();
       			$('th:nth-child(9)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '10'){
       			$('td:nth-child(10)').show();
       			$('th:nth-child(10)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '11'){
       			$('td:nth-child(11)').show();
       			$('th:nth-child(11)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '12'){
       			$('td:nth-child(12)').show();
       			$('th:nth-child(12)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '13'){
       			$('td:nth-child(13)').show();
       			$('th:nth-child(13)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '14'){
       			$('td:nth-child(14)').show();
       			$('th:nth-child(14)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '15'){
       			$('td:nth-child(15)').show();
       			$('th:nth-child(15)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '16'){
       			$('td:nth-child(16)').show();
       			$('th:nth-child(16)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '17'){       	    	
       			$('td:nth-child(17)').show();
       			$('th:nth-child(17)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '18'){
       			$('td:nth-child(18)').show();
       			$('th:nth-child(18)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '19'){       	    	
       			$('td:nth-child(19)').show();
       			$('th:nth-child(19)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '20'){
       			$('td:nth-child(20)').show();
       			$('th:nth-child(20)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '21'){
       			$('td:nth-child(21)').show();
       			$('th:nth-child(21)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '22'){
       			$('td:nth-child(22)').show();
       			$('th:nth-child(22)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '23'){
       			$('td:nth-child(23)').show();
       			$('th:nth-child(23)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '24'){
       			$('td:nth-child(24)').show();
       			$('th:nth-child(24)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '25'){
       			$('td:nth-child(25)').show();
       			$('th:nth-child(25)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '26'){
       			$('td:nth-child(26)').show();
       			$('th:nth-child(26)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '27'){
       			$('td:nth-child(27)').show();
       			$('th:nth-child(27)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '28'){
       			$('td:nth-child(28)').show();
       			$('th:nth-child(28)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '29'){
       			$('td:nth-child(29)').show();
       			$('th:nth-child(29)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '30'){
       			$('td:nth-child(30)').show();
       			$('th:nth-child(30)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '31'){
       			$('td:nth-child(31)').show();
       			$('th:nth-child(31)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}else if (outAttr[c] == '32'){
       			$('td:nth-child(32)').show();
       			$('th:nth-child(32)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}
       		else if (outAttr[c] == '33'){
       			$('td:nth-child(33)').show();
       			$('th:nth-child(33)').show();
       			labelList.splice(labelList.indexOf(outAttr[c]),1);
       		}
       		
       	}
       	for(var d=0; d<labelList.length; d++){
       		if(labelList[d] == '1'){
       			inner += "<label id=팀(수주) class=labelST onclick=labelEvent('팀(수주)','1')>팀(수주)</label>";
       		}else if (labelList[d] == '2'){
       			inner += "<label id=팀(매출) class=labelST onclick=labelEvent('팀(매출)','2')>팀(매출)</label>";
       		}else if (labelList[d] == '3'){
       			inner += "<label id=프로젝트코드 class=labelST onclick=labelEvent('프로젝트코드','3')>프로젝트코드</label>";
       		}else if (labelList[d] == '4'){
       			inner += "<label id=프로젝트명 class=labelST onclick=labelEvent('프로젝트명','4')>프로젝트명</label>";
       		}else if (labelList[d] == '5'){
       			inner += "<label id=상태 class=labelST onclick=labelEvent('상태','5')>상태</label>";
       		}else if (labelList[d] == '6'){
       			inner += "<label id=실 class=labelST onclick=labelEvent('실','6')>실</label>";
       		}else if (labelList[d] == '7'){
       			inner += "<label id=고객사 class=labelST onclick=labelEvent('고객사','7')>고객사</label>";
       		}else if (labelList[d] == '8'){
       			inner += "<label id=고객부서 class=labelST onclick=labelEvent('고객부서','8')>고객부서</label>";
       		}else if (labelList[d] == '9'){
       			inner += "<label id=M/M class=labelST onclick=labelEvent('M/M','9')>M/M</label>";
       		}else if (labelList[d] == '10'){
       			inner += "<label id=프로젝트계약금액 class=labelST onclick=labelEvent('프로젝트계약금액','10')>프로젝트계약금액</label>";
       		}else if (labelList[d] == '11'){
       			inner += "<label id=상반기예상수주 class=labelST onclick=labelEvent('상반기예상수주','11')>상반기예상수주</label>";
       		}else if (labelList[d] == '12'){
       			inner += "<label id=상반기수주 class=labelST onclick=labelEvent('상반기수주','12')>상반기수주</label>";
       		}else if (labelList[d] == '13'){
       			inner += "<label id=상반기예상매출 class=labelST onclick=labelEvent('상반기예상매출','13')>상반기예상매출</label>";
       		}else if (labelList[d] == '14'){
       			inner += "<label id=상반기매출 class=labelST onclick=labelEvent('상반기매출','14')>상반기매출</label>";
       		}else if (labelList[d] == '15'){
       			inner += "<label id=하반기예상수주 class=labelST onclick=labelEvent('하반기예상수주','15')>하반기예상수주</label>";
       		}else if (labelList[d] == '16'){
       			inner += "<label id=하반기수주 class=labelST onclick=labelEvent('하반기수주','16')>하반기수주</label>";
       		}else if (labelList[d] == '17'){
       			inner += "<label id=하반기예상매출 class=labelST onclick=labelEvent('하반기예상매출','17')>하반기예상매출</label>";
       		}else if (labelList[d] == '18'){
       			inner += "<label id=하반기매출 class=labelST onclick=labelEvent('하반기매출','18')>하반기매출</label>";
       		}
       		else if (labelList[d] == '19'){
       			inner += "<label id=연간수주 class=labelST onclick=labelEvent('연간수주','19')>연간수주</label>";
       		}else if (labelList[d] == '20'){
       			inner += "<label id=연간매출 class=labelST onclick=labelEvent('연간매출','20')>연간매출</label>";
       		}
       		else if (labelList[d] == '21'){
       			inner += "<label id=착수 class=labelST onclick=labelEvent('착수','21')>착수</label>";
       		}else if (labelList[d] == '22'){
       			inner += "<label id=종료 class=labelST onclick=labelEvent('종료','22')>종료</label>";
       		}else if (labelList[d] == '23'){
      			inner += "<label id=고객담당자 class=labelST onclick=labelEvent('고객담당자','23')>고객담당자</label>";
       		}else if (labelList[d] == '24'){
       			inner += "<label id=근무지 class=labelST onclick=labelEvent('근무지','24')>근무지</label>";
       		}else if (labelList[d] == '25'){
       			inner += "<label id=업무 class=labelST onclick=labelEvent('업무','25')>업무</label>";
       		}else if (labelList[d] == '26'){
       			inner += "<label id=PM class=labelST onclick=labelEvent('PM','26')>PM</label>";
       		}else if (labelList[d] == '27'){
       			inner += "<label id=투입명단 class=labelST onclick=labelEvent('투입명단','27')>투입명단</label>";
       		}else if (labelList[d] == '28'){
       			inner += "<label id=평가유형 class=labelST onclick=labelEvent('평가유형','28')>평가유형</label>";
       		}else if (labelList[d] == '29'){
       			inner += "<label id=채용수요 class=labelST onclick=labelEvent('채용수요','29')>채용수요</label>";
       		}else if (labelList[d] == '30'){
       			inner += "<label id=외주수요 class=labelST onclick=labelEvent('외주수요','30')>외주수요</label>";
       		}else if (labelList[d] == '31'){
       			inner += "<label id=주간보고 class=labelST onclick=labelEvent('주간보고','31')>주간보고</label>";
       		}else if (labelList[d] == '32'){
       			inner += "<label id=실적보고 class=labelST onclick=labelEvent('실적보고','32')>실적보고</label>";
       		}else if (labelList[d] == '33'){
       			inner += "<label id=복사 class=labelST onclick=labelEvent('복사','33')>복사</label>";
       		}
       	}
    	$('#list').append(inner);
    	
    	if($('.labelST').length == 0){
    		$("input:checkbox[id='checkall']").prop("checked", true);
    	}
    }
	
	// 탭 숨기기
    function hideAttr(num){
    	$("input:checkbox[id='checkall']").prop("checked", false);
    	$('td:nth-child('+num+')').hide();
    	$('th:nth-child('+num+')').hide();
        
    	var attr = $('th:nth-child('+num+')').text();
    	var attr1 = attr.replace(/ /gi,"");
    	var attName = attr1.split("▲")[0].trim();
    	
    	var inner = "";
    	inner = "<label id="+attName+" class=labelST onclick=labelEvent('"+attName+"',"+num+")>"+attName+"</label>";
    	$('#list').append(inner);
    	AttrList = AttrList.replace(num, "");
    	saveAttrTap();
    }
    
	// 탭 만들기
    function labelEvent(labelName, num){
    	document.getElementById(labelName).remove();
    	$('td:nth-child('+num+')').show();
    	$('th:nth-child('+num+')').show();
    	
    	if($('.labelST').length == 0){
    		$("input:checkbox[id='checkall']").prop("checked", true);
    	}

    	AttrList += " "+num;
    	saveAttrTap();
    }
    
    function cbAll(){
    	$("#checkall").click(function(){
            //클릭되었으면
            if($("#checkall").prop("checked")){
           	 	$( "td" ).show();
           		$( "th" ).show();
                //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
                $(".labelST").remove();
                AttrList = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33";
                saveAttrTap();
            //클릭 해제
            }else{
            	$( ".td" ).hide();
            	$( ".th" ).hide();
                //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
               	var inner = "";
               	inner += "<label id=팀(수주) class=labelST onclick=labelEvent('팀(수주)','1')>팀(수주)</label>";
               	inner += "<label id=팀(매출) class=labelST onclick=labelEvent('팀(매출)','2')>팀(매출)</label>";
       			inner += "<label id=프로젝트코드 class=labelST onclick=labelEvent('프로젝트코드','3')>프로젝트코드</label>";
       			inner += "<label id=상태 class=labelST onclick=labelEvent('상태','5')>상태</label>";
            	inner += "<label id=실 class=labelST onclick=labelEvent('실','6')>실</label>";
       			inner += "<label id=고객사 class=labelST onclick=labelEvent('고객사','7')>고객사</label>";
             	inner += "<label id=고객부서 class=labelST onclick=labelEvent('고객부서','8')>고객부서</label>";
            	inner += "<label id=M/M class=labelST onclick=labelEvent('M/M','9')>M/M</label>";
            	inner += "<label id=프로젝트계약금액 class=labelST onclick=labelEvent('프로젝트계약금액','10')>프로젝트계약금액</label>";
            	inner += "<label id=상반기예상수주 class=labelST onclick=labelEvent('상반기예상수주','11')>상반기예상수주</label>";
            	inner += "<label id=상반기수주 class=labelST onclick=labelEvent('상반기수주','12')>상반기수주</label>";
            	inner += "<label id=상반기예상매출 class=labelST onclick=labelEvent('상반기예상매출','13')>상반기예상매출</label>";
            	inner += "<label id=상반기매출 class=labelST onclick=labelEvent('상반기매출','14')>상반기매출</label>";
            	inner += "<label id=하반기예상수주 class=labelST onclick=labelEvent('하반기예상수주','15')>하반기예상수주</label>";
            	inner += "<label id=하반기수주 class=labelST onclick=labelEvent('하반기수주','16')>하반기수주</label>";
            	inner += "<label id=하반기예상매출 class=labelST onclick=labelEvent('하반기예상매출','17')>하반기예상매출</label>";
            	inner += "<label id=하반기매출 class=labelST onclick=labelEvent('하반기매출','18')>하반기매출</label>";
            	inner += "<label id=착수 class=labelST onclick=labelEvent('착수','21')>착수</label>";
            	inner += "<label id=종료 class=labelST onclick=labelEvent('종료','22')>종료</label>";
            	inner += "<label id=고객담당자 class=labelST onclick=labelEvent('고객담당자','23')>고객담당자</label>";
            	inner += "<label id=근무지 class=labelST onclick=labelEvent('근무지','24')>근무지</label>";
            	inner += "<label id=업무 class=labelST onclick=labelEvent('업무','25')>업무</label>";
            	inner += "<label id=투입명단 class=labelST onclick=labelEvent('투입명단','27')>투입명단</label>";
            	inner += "<label id=평가유형 class=labelST onclick=labelEvent('평가유형','28')>평가유형</label>";
            	inner += "<label id=채용수요 class=labelST onclick=labelEvent('채용수요','29')>채용수요</label>";
            	inner += "<label id=외주수요 class=labelST onclick=labelEvent('외주수요','30')>외주수요</label>";
            	inner += "<label id=주간보고 class=labelST onclick=labelEvent('주간보고','31')>주간보고</label>";
            	inner += "<label id=실적보고 class=labelST onclick=labelEvent('실적보고','32')>실적보고</label>";
            	inner += "<label id=복사 class=labelST onclick=labelEvent('복사','33')>복사</label>";
            	$('#list').append(inner);
            	AttrList = "4 19 20 26";
            	saveAttrTap();
         	}    
        });
    }
    
    // 탭 비동기식 저장
    function saveAttrTap(){
    	$.ajax({
  			url : 'saveAttrList.jsp',
  			type : 'post',
  			dataType: "json",
  			data : {
  				attrList : AttrList
  			}
  		});
    }
    
    function stateColor(){
    	var str;
    	for(var i=0;i<=<%=projectList.size()%>;i++){
    		//var tr = $('#dataTable tr:eq('+i+')');
    		//var td = tr.children();
    		str = $('#dataTable tr:eq('+i+') td:eq(4)').text();
    		if(str.indexOf('1')!=-1){
    			$('#dataTable tr:eq('+i+')').css("background-color", "#A9E2F3");
    		}else if(str.indexOf('2')!=-1){
    			$('#dataTable tr:eq('+i+')').css("background-color", "#A9E2F3");
    		}else if(str.indexOf('3')!=-1){
    			$('#dataTable tr:eq('+i+')').css("background-color", "#A9E2F3");
    		}else if(str.indexOf('4')!=-1){
    			$('#dataTable tr:eq('+i+')').css("background-color", "#F6CEE3");
    		}else if(str.indexOf('5')!=-1){
    			$('#dataTable tr:eq('+i+')').css("background-color", "#F6CEE3");
    		}else if(str.indexOf('6')!=-1){
    			$('#dataTable tr:eq('+i+')').css("background-color", "#FFFFFF");
    		}else if(str.indexOf('7')!=-1){
    			$('#dataTable tr:eq('+i+')').css("background-color", "#E6E6E6");
    		}else if(str.indexOf('8')!=-1){
    			$('#dataTable tr:eq('+i+')').css("background-color", "#A4A4A4");
    		}
    	}
    }
    
    function updateData(projectNo, projectName, attr){
    	var tdID = projectNo+attr;
    	var value = document.getElementById(tdID);
    	var text = prompt(projectName + ' - ' +attr + ' 수정', value.innerHTML);
    	if(text != null){
    		value.innerHTML = text;
	  		$.ajax({
	  			url : 'data_updatePro.jsp',
	  			type : 'post',
	  			dataType: "json",
	  			data : {
	  				no : projectNo,
	  				data2 : text,
	  				attribute : attr,
	  				year : <%=year%>
	  			}
	  		});
    	}
    }
    
    function updateWorkPlace(projectNo, projectName, place){
    	var popupX = (document.body.offsetWidth/2)-(600/2);
    	window.open('update_workPlace.jsp?no=' + projectNo + '&name=' + projectName + '&place=' + place +'&year='+<%=year%>, '', 'toolbar=no, menubar=no, left='+popupX+', top=100, scrollbars=no, width=600, height=250');
    }
    
    function updateCheck(projectNo, projectName, check, attr){
    	var popupX = (document.body.offsetWidth/2)-(600/2);
    	window.open('update_reportcheck.jsp?no=' + projectNo + '&name=' + projectName + '&check=' + check + '&attr=' + attr +'&year='+<%=year%>, '', 'toolbar=no, menubar=no, left='+popupX+', top=100, scrollbars=no, width=600, height=250');
    }
    
    function updateState(projectNo, projectName, state){
    	var popupX = (document.body.offsetWidth/2)-(600/2);
    	window.open('update_state.jsp?no=' + projectNo + '&name=' + projectName + '&state=' + state +'&year='+<%=year%>, '', 'toolbar=no, menubar=no, left='+popupX+', top=100, scrollbars=no, width=600, height=250'); 
    }
    
    function updateTeam(projectNo, projectName, team, what){
    	var popupX = (document.body.offsetWidth/2)-(600/2);
    	window.open('update_team.jsp?no=' + projectNo + '&name=' + projectName + '&team=' + team + '&what=' + what +'&year='+<%=year%>, '', 'toolbar=no, menubar=no, left='+popupX+', top=100, scrollbars=no, width=600, height=250');
    }
    
    function updatePM(projectNo, projectName){
    	var popupX = (document.body.offsetWidth/2)-(600/2);
    	window.open('update_pm.jsp?no=' + projectNo + '&name=' + projectName +'&year='+<%=year%>, '', 'toolbar=no, menubar=no, left='+popupX+', top=100, width=900, height=500');
    }
    
    function updateWorker(projectNo, projectName){
    	var popupX = (document.body.offsetWidth/2)-(600/2);
    	window.open('update_worker.jsp?no=' + projectNo + '&name=' + projectName +'&year='+<%=year%>, '', 'toolbar=no, menubar=no, left='+popupX+', top=100, width=900, height=700');
    }
    
    function updateStart(projectNo, projectName, startDate){
    	var popupX = (document.body.offsetWidth/2)-(600/2);
    	window.open('update_start.jsp?no=' + projectNo + '&name=' + projectName + '&startDate=' + startDate +'&year='+<%=year%>, '', 'toolbar=no, menubar=no, left='+popupX+', top=100, width=600, height=500');
    }
    function updateEnd(projectNo, projectName, endDate){
    	var popupX = (document.body.offsetWidth/2)-(600/2);
    	window.open('update_end.jsp?no=' + projectNo + '&name=' + projectName + '&endDate=' + endDate +'&year='+<%=year%>, '', 'toolbar=no, menubar=no, left='+popupX+', top=100, width=600, height=500');
    }
    
    function openSheetManager(year){
    	var popupX = (document.body.offsetWidth/2)-(600/2);
    	window.open('sheetManage.jsp?year=' + year, '', 'toolbar=no, menubar=no, left='+popupX+', top=100, width=600, height=500');
    }
   
    $(document).ready(function(){
        //최상단 체크박스 클릭
        cbLoad();
        cbAll();
        stateColor();
        $('#project_year').val(<%=year%>).prop("selected",true);
        
        $('.sortBTN').off("click",hideAttr);
        $('.loading').hide();
        $( window ).resize(function() {
        	var windowWidth = $( window ).height();
        });
    });
    
    
    //table sorting
    function sortingNumber( a , b ){  
    	
        if ( typeof a == "number" && typeof b == "number" ) return a - b; 
        // 천단위 쉼표와 공백문자만 삭제하기.  
        var a = ( a + "" ).replace( /[,\s\xA0]+/g , "" ); 
        var b = ( b + "" ).replace( /[,\s\xA0]+/g , "" ); 
        var numA = parseFloat( a ) + ""; 
        var numB = parseFloat( b ) + ""; 
        if ( numA == "NaN" || numB == "NaN" || a != numA || b != numB ) return false; 
        return parseFloat( a ) - parseFloat( b ); 
	} 
    
	/* changeForSorting() : 문자열 바꾸기. */ 
	function changeForSorting( first , second ){  
	        // 문자열의 복사본 만들기. 
	        var a = first.toString().replace( /[\s\xA0]+/g , " " ); 
	        var b = second.toString().replace( /[\s\xA0]+/g , " " ); 
	        var change = { first : a, second : b }; 
	        if ( a.search( /\d/ ) < 0 || b.search( /\d/ ) < 0 || a.length == 0 || b.length == 0 ) return change; 
	        var regExp = /(\d),(\d)/g; // 천단위 쉼표를 찾기 위한 정규식. 
	        a = a.replace( regExp , "$1" + "$2" ); 
	        b = b.replace( regExp , "$1" + "$2" ); 
	        var unit = 0; 
	        var aNb = a + " " + b; 
	        var numbers = aNb.match( /\d+/g ); // 문자열에 들어있는 숫자 찾기 
	        for ( var x = 0; x < numbers.length; x++ ){ 
	                var length = numbers[ x ].length; 
	                if ( unit < length ) unit = length; 
	        } 
	        var addZero = function( string ){ // 숫자들의 단위 맞추기 
	                var match = string.match( /^0+/ ); 
	                if ( string.length == unit ) return ( match == null ) ? string : match + string; 
	                var zero = "0"; 
	                for ( var x = string.length; x < unit; x++ ) string = zero + string; 
	                return ( match == null ) ? string : match + string; 
	        }; 
	        change.first = a.replace( /\d+/g, addZero ); 
	        change.second = b.replace( /\d+/g, addZero ); 
	        return change; 
	} 
	
	/* byLocale() */ 
	function byLocale(){ 
	        var compare = function( a , b ){ 
	                var sorting = sortingNumber( a , b ); 
	                if ( typeof sorting == "number" ) return sorting; 
	                var change = changeForSorting( a , b ); 
	                var a = change.first; 
	                var b = change.second; 
	                return a.localeCompare( b ); 
	        }; 
	        var ascendingOrder = function( a , b ){  return compare( a , b );  }; 
	        var descendingOrder = function( a , b ){  return compare( b , a );  }; 
	        return { ascending : ascendingOrder, descending : descendingOrder }; 
	} 
	
	/* replacement() */ 
	function replacement( parent ){  
	        var tagName = parent.tagName.toLowerCase(); 
	        if ( tagName == "table" ) parent = parent.tBodies[ 0 ]; 
	        tagName = parent.tagName.toLowerCase(); 
	        if ( tagName == "tbody" ) var children = parent.rows; 
	        else var children = parent.getElementsByTagName( "li" ); 
	        var replace = { 
	                order : byLocale(), 
	                index : false, 
	                array : function(){ 
	                        var array = [ ]; 
	                        for ( var x = 0; x < children.length; x++ ) array[ x ] = children[ x ]; 
	                        return array; 
	                }(), 
	                checkIndex : function( index ){ 
	                        if ( index ) this.index = parseInt( index, 10 ); 
	                        var tagName = parent.tagName.toLowerCase(); 
	                        if ( tagName == "tbody" && ! index ) this.index = 0; 
	                }, 
	                getText : function( child ){ 
	                        if ( this.index ) child = child.cells[ this.index ]; 
	                        return getTextByClone( child ); 
	                }, 
	                setChildren : function(){ 
	                        var array = this.array; 
	                        while ( parent.hasChildNodes() ) parent.removeChild( parent.firstChild ); 
	                        for ( var x = 0; x < array.length; x++ ) parent.appendChild( array[ x ] ); 
	                }, 
	                ascending : function( index ){ // 오름차순 
	                        this.checkIndex( index ); 
	                        var _self = this; 
	                        var order = this.order; 
	                        var ascending = function( a, b ){ 
	                                var a = _self.getText( a ); 
	                                var b = _self.getText( b ); 
	                                return order.ascending( a, b ); 
	                        }; 
	                        this.array.sort( ascending ); 
	                        this.setChildren(); 
	                }, 
	                descending : function( index ){ // 내림차순
	                        this.checkIndex( index ); 
	                        var _self = this; 
	                        var order = this.order; 
	                        var descending = function( a, b ){ 
	                                var a = _self.getText( a ); 
	                                var b = _self.getText( b ); 
	                                return order.descending( a, b ); 
	                        }; 
	                        this.array.sort( descending ); 
	                        this.setChildren(); 
	                } 
	        }; 
	        return replace; 
	} 
	
	function getTextByClone( tag ){  
	        var clone = tag.cloneNode( true ); // 태그의 복사본 만들기. 
	        var br = clone.getElementsByTagName( "br" ); 
	        while ( br[0] ){ 
	                var blank = document.createTextNode( " " ); 
	                clone.insertBefore( blank , br[0] ); 
	                clone.removeChild( br[0] ); 
	        } 
	        var isBlock = function( tag ){ 
	                var display = ""; 
	                if ( window.getComputedStyle ) display = window.getComputedStyle ( tag, "" )[ "display" ]; 
	                else display = tag.currentStyle[ "display" ]; 
	                return ( display == "block" ) ? true : false; 
	        }; 
	        var children = clone.getElementsByTagName( "*" ); 
	        for ( var x = 0; x < children.length; x++){ 
	                var child = children[ x ]; 
	                if ( ! ("value" in child) && isBlock(child) ) child.innerHTML = child.innerHTML + " "; 
	        } 
	        var textContent = ( "textContent" in clone ) ? clone.textContent : clone.innerText; 
	        return textContent; 
	}
</script>

<script type="text/javascript">
	<!-- 로딩화면 -->
	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
</script>

<body id="page-top">
	<!--  로딩화면  시작  -->
	<div class="loading">
		<div id="load">
			<i class="fas fa-spinner fa-10x fa-spin"></i>
		</div>
	</div>
	<!--  로딩화면  끝  -->
	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion toggled"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->


			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../mypage/mypage.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>마이페이지</span></a></li>

			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../summary/summary.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>수입 요약</span></a></li>
					
			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../expense_sum/expense_sum.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>지출 요약</span></a></li>
					
			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../profit_analysis/profit_analysis.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>수익 지표</span></a></li>
					
			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../memchart/memchart.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>조직도</span></a></li>

			<!-- Nav Item - project -->
			<li class="nav-item active"><a class="nav-link"
				href="../project/project.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>프로젝트 관리</span></a></li>

			<!-- Nav Item - schedule -->
			<li class="nav-item"><a class="nav-link"
				href="../schedule/schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>스케줄 - 엔지니어</span></a></li>

			<li class="nav-item"><a class="nav-link"
				href="../project_schedule/project_schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>스케줄 - 프로젝트</span></a></li>
					
			<!-- Nav Item - manager schedule -->
			<li class="nav-item"><a class="nav-link"
				href="../manager_schedule/manager_schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>스케줄 - 관리자</span></a></li>

			<!-- Nav Item - report -->
			<li class="nav-item"><a class="nav-link"
				href="../report/report.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>프로젝트 주간보고</span></a></li>

			<!-- Nav Item - meeting -->
			<li class="nav-item"><a class="nav-link"
				href="../meeting/meeting.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>고객미팅 회의록</span></a></li>
					
			<!-- Nav Item - meeting -->
			<li class="nav-item"><a class="nav-link"
				href="../assessment/assessment.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>평가</span></a></li>

			<!-- Nav Item - manager page -->
			<%if(permission == 0){ %>
			<li class="nav-item"><a class="nav-link"
				href="../manager/manager.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>관리자 페이지</span></a></li>
			<% }%>

			

		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>

					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">
						<div class="topbar-divider d-none d-sm-block"></div>

						<!-- Nav Item - User Information -->
						<li class="nav-item dropdown no-arrow"><a
							class="nav-link dropdown-toggle" href="#" id="userDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <span
								class="mr-2 d-none d-lg-inline text-gray-600 small"><%=sessionName%></span>
								<i class="fas fa-info-circle"></i>
						</a> <!-- Dropdown - User Information -->
							<div
								class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="userDropdown">
								<a class="dropdown-item" href="#" data-toggle="modal"
									data-target="#logoutModal"> <i
									class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
									Logout
								</a>
							</div></li>

					</ul>

				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<!--프로젝트 조회 테이블 시작 *********************************************************** -->
				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary"
							style="display: inline-block;">프로젝트 목록</h6>
							
						<select id="project_year" name="project_year" onchange="listLoad()">
							<%
								for(int i=0; i<yearCount; i++){%>
									<option value='<%=maxYear-i%>'><%=maxYear-i%></option>
							<%}%>
							
						</select>
						<%
						
              	if(permission == 0){
              		%><form action="project_synchronization.jsp"
							method="post" class="project_form">
							<input class="project_form2" style="font-size:small; margin-left: 20px;" name="spreadsheet" value="<%=sheetName %>" readonly/>
							<input  style="font-size:small;" type="submit" value="스프레드시트 동기화" class="btn btn-primary project_form2">
							<input  style="font-size:small;" type="button" value="스프레드시트 관리" class="btn btn-primary project_form2" onclick="openSheetManager('<%=year%>')">
					</form>
					<form action="delete_copy.jsp" 
							method="post" class="project_form" stlye="margin-right: 15px">
							<input style="font-size:small;" type="submit" value="<%=maxYear %>년 복사본 삭제" class="btn btn-primary">
							</form>
					<form action="project_copy.jsp" 
							method="post" class="project_form" stlye="margin-right: 15px">
							<input style="font-size:small;" type="submit" value="<%=maxYear + 1%>년 복사" class="btn btn-primary">
					</form>
					<%
              	}
              %>
              </div>
					<div class="card-body" style="margin-bottom: 40px;">
					<details>
						<summary class="btn btn-primary" >체크박스</summary>
						<div id="list">
							<label style="font-size: x-large"><input type="checkbox" id="checkall"class="cb"> All</label>
						</div>
						</details>
						
						<div class="table-responsive" id="tableParent">
							<table class="table TABLE" id="dataTable"
								style="white-space: nowrap; font-size: small;">
								<thead>	
									<tr class="m-0 text-primary">
										<th class="th" onclick="hideAttr(1)">팀(수주)
											<button class="sortBTN" onclick="sortTD (0); event.cancelBubble=true;">▲</button>
											<button class="sortBTN" onclick="reverseTD (0); event.cancelBubble=true;">▼</button>
										</th>
										<th class="th" onclick="hideAttr(2)">팀(매출)
											<button class="sortBTN" onclick="sortTD (1); event.cancelBubble=true;">▲</button>
											<button class="sortBTN" onclick="reverseTD (1); event.cancelBubble=true;">▼</button>
										</th>
										<th class="th" onclick="hideAttr(3)">프로젝트 코드</th>
										<th onclick="hideAttr(4)">프로젝트 명</th>
										<th class="th" onclick="hideAttr(5)">상태
											<button class="sortBTN" onclick="sortTD (4); event.cancelBubble=true;">▲</button>
											<button class="sortBTN" onclick="reverseTD (4); event.cancelBubble=true;">▼</button>
										</th>
										<th class="th" onclick="hideAttr(6)">실</th>
										<th class="th" onclick="hideAttr(7)">고객사
											<button class="sortBTN" onclick="sortTD (6); event.cancelBubble=true;">▲</button>
											<button class="sortBTN" onclick="reverseTD (6); event.cancelBubble=true;">▼</button>
										</th>
										<th class="th" onclick="hideAttr(8)">고객부서</th>
										<th class="th" onclick="hideAttr(9)">M/M</th>
										<th class="th" onclick="hideAttr(10)">프로젝트계약금액</th>
										<th class="th" onclick="hideAttr(11)">상반기예상수주</th>
										<th class="th" onclick="hideAttr(12)">상반기수주</th>
										<th class="th" onclick="hideAttr(13)">상반기예상매출</th>
										<th class="th" onclick="hideAttr(14)">상반기매출</th>
										<th class="th" onclick="hideAttr(15)">하반기예상수주</th>
										<th class="th" onclick="hideAttr(16)">하반기수주</th>
										<th class="th" onclick="hideAttr(17)">하반기예상매출</th>
										<th class="th" onclick="hideAttr(18)">하반기매출</th>
										
										<th onclick="hideAttr(19)">연간수주</th>
										<th onclick="hideAttr(20)">연간매출</th>
										
										<th class="th" onclick="hideAttr(21)">착수
											<button class="sortBTN" onclick="sortTD (20); event.cancelBubble=true;">▲</button>
											<button class="sortBTN" onclick="reverseTD (20); event.cancelBubble=true;">▼</button>
										</th>
										<th class="th" onclick="hideAttr(22)">종료
											<button class="sortBTN" onclick="sortTD (21); event.cancelBubble=true;">▲</button>
											<button class="sortBTN" onclick="reverseTD (21); event.cancelBubble=true;">▼</button>
										</th>
										<th class="th" onclick="hideAttr(23)">고객담당자</th>
										<th class="th" onclick="hideAttr(24)">근무지</th>
										<th class="th" onclick="hideAttr(25)">업무</th>
										<th onclick="hideAttr(26)">PM</th>
										<th class="th" onclick="hideAttr(27)">투입 명단</th>
										<th class="th" onclick="hideAttr(28)">평가유형</th>
										<th class="th" onclick="hideAttr(29)">채용수요</th>
										<th class="th" onclick="hideAttr(30)">외주수요</th>
										<th class="th" onclick="hideAttr(31)">주간보고</th>
										<th class="th" onclick="hideAttr(32)">실적보고</th>
										<th class="th" onclick="hideAttr(33)">복사</th>
									</tr>
								</thead>
								<tbody>
								
                  			<%for(int i=0; i<projectList.size(); i++){
                  				String yearOrder = String.format("%.2f",projectList.get(i).getFH_ORDER()+projectList.get(i).getSH_ORDER());
                  				String yearSales = String.format("%.2f",projectList.get(i).getFH_SALES()+projectList.get(i).getSH_SALES()); 
                  			%>
									<tr>
										<!-- 권한에 따라 수정페이지 접근 가능 -->
										<%if((permission==1 && projectList.get(i).getTEAM_ORDER().equals(myInfo.getTEAM())) || (permission==1 && projectList.get(i).getTEAM_SALES().equals(myInfo.getTEAM())) || permission==0){%>
										<td class="td" onclick="updateTeam('<%=projectList.get(i).getNO()%>','<%=projectList.get(i).getPROJECT_NAME()%>', '<%=projectList.get(i).getTEAM_ORDER()%>', '수주')"><%=projectList.get(i).getTEAM_ORDER()%></td>
										<td class="td" onclick="updateTeam('<%=projectList.get(i).getNO()%>','<%=projectList.get(i).getPROJECT_NAME()%>', '<%=projectList.get(i).getTEAM_SALES()%>', '매출')"><%=projectList.get(i).getTEAM_SALES()%></td>
										<td class="td" id="<%=projectList.get(i).getNO()%>프로젝트코드"onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','프로젝트코드')"><%=projectList.get(i).getPROJECT_CODE()%></td>
										<td>
										<a href="project_update.jsp?no=<%=projectList.get(i).getNO()%>&year=<%=year%>"><div class="textover"><%=projectList.get(i).getPROJECT_NAME()%></div></a></td>
										
										<td class="td" id="state<%=projectList.get(i).getNO()%>" onclick="updateState('<%=projectList.get(i).getNO()%>','<%=projectList.get(i).getPROJECT_NAME()%>', '<%=projectList.get(i).getSTATE()%>')"><%=projectList.get(i).getSTATE()%></td>
										<td id="<%=projectList.get(i).getNO()%>실" class="td" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','실')"><%=projectList.get(i).getPART()%></td>
										<td class="td" id="<%=projectList.get(i).getNO()%>고객사" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','고객사')"><%=projectList.get(i).getCLIENT()%></td>
										<td id="<%=projectList.get(i).getNO()%>고객부서" class="td" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','고객부서')"><%=projectList.get(i).getClIENT_PART()%></td>
										<td id="<%=projectList.get(i).getNO()%>ManMonth" class="td" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','ManMonth')"><%=projectList.get(i).getMAN_MONTH()%></td>
										<td id="<%=projectList.get(i).getNO()%>프로젝트계약금액_백만" class="td" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','프로젝트계약금액_백만')"><%=projectList.get(i).getPROJECT_DESOPIT()%></td>
										<td id="<%=projectList.get(i).getNO()%>상반기예상수주" class="td" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','상반기예상수주')"><%=projectList.get(i).getFH_ORDER_PROJECTIONS()%></td>
										<td id="<%=projectList.get(i).getNO()%>상반기수주" class="td" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','상반기수주')"><%=projectList.get(i).getFH_ORDER()%></td>
										<td id="<%=projectList.get(i).getNO()%>상반기예상매출" class="td" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','상반기예상매출')"><%=projectList.get(i).getFH_SALES_PROJECTIONS()%></td>
										<td id="<%=projectList.get(i).getNO()%>상반기매출" class="td" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','상반기매출','<%=projectList.get(i).getFH_SALES()%>')"><%=projectList.get(i).getFH_SALES()%></td>
										<td id="<%=projectList.get(i).getNO()%>하반기예상수주" class="td" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','하반기예상수주')"><%=projectList.get(i).getSH_ORDER_PROJECTIONS()%></td>
										<td id="<%=projectList.get(i).getNO()%>하반기수주" class="td" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','하반기수주')"><%=projectList.get(i).getSH_ORDER()%></td>
										<td id="<%=projectList.get(i).getNO()%>하반기예상매출" class="td" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','하반기예상매출')"><%=projectList.get(i).getSH_SALES_PROJECTIONS()%></td>
										<td id="<%=projectList.get(i).getNO()%>하반기매출" class="td" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','하반기매출')"><%=projectList.get(i).getSH_SALES()%></td>
										
										<td id="<%=projectList.get(i).getNO()%>연간수주"><%=yearOrder %></td>
										<td id="<%=projectList.get(i).getNO()%>연간매출"><%=yearSales %></td>
										
										
										<td id="<%=projectList.get(i).getNO()%>착수" class="td" onclick="updateStart('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','<%=projectList.get(i).getPROJECT_START()%>')"><%=projectList.get(i).getPROJECT_START()%></td>
										<td id="<%=projectList.get(i).getNO()%>종료" class="td" onclick="updateEnd('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','<%=projectList.get(i).getPROJECT_END()%>')"><%=projectList.get(i).getPROJECT_END()%></td>
										<td id="<%=projectList.get(i).getNO()%>고객담당자" class="td" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','고객담당자')"><%=projectList.get(i).getCLIENT_PTB()%></td>
										<td id="<%=projectList.get(i).getNO()%>근무지" class="td" onclick="updateWorkPlace('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','<%=projectList.get(i).getWORK_PLACE()%>')"><%=projectList.get(i).getWORK_PLACE()%></td>
										<td id="<%=projectList.get(i).getNO()%>업무" class="td" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','업무')"><%=projectList.get(i).getWORK()%></td>	
										<td onclick="updatePM('<%=projectList.get(i).getNO()%>','<%=projectList.get(i).getPROJECT_NAME()%>')">
											<%
						                      	if(i<PMnameList.size()){
						                      		out.print(PMnameList.get(i));
						                      	}
						                      %>
										</td>
										<td class="td" onclick="updateWorker('<%=projectList.get(i).getNO()%>','<%=projectList.get(i).getPROJECT_NAME()%>')">
											<%
						                      	if(i<workerIdList.size()){ 
						                      		for(int a=0;a<workerIdList.get(i).length;a++){%>
																<%=workerIdList.get(i)[a]%> <%}} %>
										</td>
										<td id="<%=projectList.get(i).getNO()%>평가유형" class="td" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','평가유형','<%=projectList.get(i).getASSESSMENT_TYPE()%>')"><%=projectList.get(i).getASSESSMENT_TYPE()%></td>
										<td id="<%=projectList.get(i).getNO()%>채용수요" class="td" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','채용수요','<%=projectList.get(i).getEMPLOY_DEMAND()%>')"><%=projectList.get(i).getEMPLOY_DEMAND()%></td>
										<td id="<%=projectList.get(i).getNO()%>외주수요" class="td" onclick="updateData('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>','외주수요','<%=projectList.get(i).getOUTSOURCE_DEMAND()%>')"><%=projectList.get(i).getOUTSOURCE_DEMAND()%></td>
										<td class="td" onclick="updateCheck('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>', '<%=projectList.get(i).getREPORTCHECK()%>', '주간보고')">
										<%
											if(projectList.get(i).getREPORTCHECK() == 1){
												out.print("ON");
											} else {
												out.print("OFF");
											}
											%></td>
										<td class="td" onclick="updateCheck('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>', '<%=projectList.get(i).getRESULT_REPORT()%>', '실적보고')">
										<%
											if(projectList.get(i).getRESULT_REPORT() == 1){
												out.print("ON");
											} else {
												out.print("OFF");
											}
											%></td>
											
										<td class="td" onclick="updateCheck('<%=projectList.get(i).getNO()%>', '<%=projectList.get(i).getPROJECT_NAME()%>', '<%=projectList.get(i).getCopy()%>', 'copy')">
										<%
											if(projectList.get(i).getCopy().equals("1")){
												out.print("ON");
											} else {
												out.print("OFF");
											}
											%></td>
										<%}
										
										else{%>
										<td class="td"><%=projectList.get(i).getTEAM_ORDER()%></td>
										<td class="td"><%=projectList.get(i).getTEAM_SALES()%></td>
										<td class="td"><%=projectList.get(i).getPROJECT_CODE()%></td>
										<td><div class="textover"><%=projectList.get(i).getPROJECT_NAME()%></div></td>
										<td class="td"><%=projectList.get(i).getSTATE()%></td>
										<td class="td"><%=projectList.get(i).getPART()%></td>
										<td class="td"><%=projectList.get(i).getCLIENT()%></td>
										<td class="td"><%=projectList.get(i).getClIENT_PART()%></td>
										<td class="td"><%=projectList.get(i).getMAN_MONTH()%></td>
										<td class="td"><%=projectList.get(i).getPROJECT_DESOPIT()%></td>
										<td class="td"><%=projectList.get(i).getFH_ORDER_PROJECTIONS()%></td>
										<td class="td"><%=projectList.get(i).getFH_ORDER()%></td>
										<td class="td"><%=projectList.get(i).getFH_SALES_PROJECTIONS()%></td>
										<td class="td"><%=projectList.get(i).getFH_SALES()%></td>
										<td class="td"><%=projectList.get(i).getSH_ORDER_PROJECTIONS()%></td>
										<td class="td"><%=projectList.get(i).getSH_ORDER()%></td>
										<td class="td"><%=projectList.get(i).getSH_SALES_PROJECTIONS()%></td>
										<td class="td"><%=projectList.get(i).getSH_SALES()%></td>
										
										<td><%=yearOrder%></td>
										<td><%=yearSales%></td>
										
										<td class="td"><%=projectList.get(i).getPROJECT_START()%></td>
										<td class="td"><%=projectList.get(i).getPROJECT_END()%></td>
										<td class="td"><%=projectList.get(i).getCLIENT_PTB()%></td>
										<td class="td"><%=projectList.get(i).getWORK_PLACE()%></td>
										<td class="td"><%=projectList.get(i).getWORK()%></td>
										<td>
											<%
						                      	if(i<PMnameList.size()){
						                      		out.print(PMnameList.get(i));
						                      	}
						                      %>
										</td>
										<td class="td">
											<%
						                      	if(i<workerIdList.size()){ 
						                      		for(int a=0;a<workerIdList.get(i).length;a++){%>
																<%=workerIdList.get(i)[a]%> <%}} %>
										</td>
										<td class="td"><%=projectList.get(i).getASSESSMENT_TYPE()%></td>
										<td class="td"><%=projectList.get(i).getEMPLOY_DEMAND()%></td>
										<td class="td"><%=projectList.get(i).getOUTSOURCE_DEMAND()%></td>
										<td class="td">
										<%
											if(projectList.get(i).getREPORTCHECK() == 1){
												out.print("ON");
											} else {
												out.print("OFF");
											}
											%></td>
										<td class="td">
										<%
											if(projectList.get(i).getRESULT_REPORT() == 1){
												out.print("ON");
											} else {
												out.print("OFF");
											}
											%></td>
											
										<td class="td">
										<%
											if(projectList.get(i).getCopy().equals("1")){
												out.print("ON");
											} else {
												out.print("OFF");
											}
											%></td>			
										<%}%>

									</tr>
						<% } %>
								</tbody>
							</table>
							<script type="text/javascript">
			       var myTable = document.getElementById( "dataTable" ); 
			       var replace = replacement( myTable ); 
			       function sortTD( index ){replace.ascending( index ); } 
			       function reverseTD( index ){replace.descending( index );} 
			       </script>
						</div>
						
					</div> 
				</div>
				<%
	          	if (permission <= 1){
	        		%><div id="project_btn">
					<a href="project_make.jsp?year=<%=year%>" class="btn btn-primary">프로젝트 생성</a>
				</div>
				<%
        	} %>

			</div>
			<!-- /.container-fluid -->
			<!--프로젝트 조회 테이블 끝        *********************************************************** -->

			<!-- End of Main Content -->

		</div>
		<!-- End of Content Wrapper -->

		<!-- End of Page Wrapper -->

		<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top"> <i
			class="fas fa-angle-up"></i>
		</a>

		<!-- Logout Modal-->
		<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
						<button class="close" type="button" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body">확인버튼을 누를 시 로그아웃 됩니다.</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button"
							data-dismiss="modal">취소</button>
						<form method="post" action="../LogoutPro.jsp">
							<input type="submit" class="btn btn-primary" value="확인" />
						</form>
					</div>
				</div>
			</div>
		</div>

		<!-- Bootstrap core JavaScript-->
		<script src="../../vendor/jquery/jquery.min.js"></script>
		<script src="../../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

		<!-- Core plugin JavaScript-->
		<script src="../../vendor/jquery-easing/jquery.easing.min.js"></script>

		<!-- Custom scripts for all pages-->
		<script src="../../js/sb-admin-2.min.js"></script>

</body>

</html>
