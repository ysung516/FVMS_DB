<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="jsp.DB.method.*"
	import="java.util.ArrayList" import="java.util.Date"
	import="java.text.SimpleDateFormat"
	import="java.util.HashMap"
	import="java.util.LinkedHashMap"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%

	PrintWriter script =  response.getWriter();
	if (session.getAttribute("sessionID") == null){
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	}
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	if(permission > 2){
		script.print("<script> alert('접근 권한이 없습니다.'); history.back(); </script>");
	}
	
	String sessionID = session.getAttribute("sessionID").toString();
	String sessionName = session.getAttribute("sessionName").toString();
	
	ProjectDAO projectDao = new ProjectDAO();
	// 실, 팀별 프로젝트 정보 HashMap<팀명, ArrayList<프로젝트스케줄빈>>
	HashMap<String, ArrayList<Project_sch_Bean>> projectList = projectDao.getProjectList_team();
	
	MemberDAO memberDao = new MemberDAO();
	LinkedHashMap<Integer, String> teamList = memberDao.getTeam();

	// 현재 년도 구하기
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sf.format(nowTime);
	int year = Integer.parseInt(date.split("-")[0]); // 이번 년도

	// 실, 팀 프로젝트 상태별 개수 HashMap<팀명, HashMap<상태, 개수>>
	HashMap<String, HashMap<String, Integer>> projectNum = new HashMap<String, HashMap<String, Integer>>();
	for(int key : teamList.keySet()){
		HashMap<String, Integer> projectState = new HashMap<String, Integer>();
		for(Project_sch_Bean i : projectList.get(teamList.get(key))){
			if(projectState.containsKey(i.getSTATE())){
				projectState.put(i.getSTATE(), projectState.get(i.getSTATE())+1);
			}else{
				projectState.put(i.getSTATE(), 1);
			}
		}
		projectNum.put(teamList.get(key), projectState);
	}
%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - Schedule</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">


</head>
<style>	
.sidebar .nav-item{
	 	word-break: keep-all;
}
#sidebarToggle{
		display:none;
	}
.topbar {
    height: 3.375rem;
}
.sidebar{
	position:relative;
	z-index:997;
}
@media(max-width:755px){
	body{
		font-size:small;
		}
	#sidebarToggle{
		display:block;
	}
	.tableST{
		width : 100% !important;
		height: 40%;
		
	}

	.table-responsive2 {
		visibility: collapse;
		height: 5vh;
		overflow: auto !important;
	}
	#timelineChart{
		width:  100% !important;
	
	}
	.table-responsive{
		overflow: auto !important;
	}
		.sidebar .nav-item{
	 	white-space:nowrap !important;
	 	font-size: x-large !important;	 	
	}
	.topbar{
		z-index:999;
		width:100%;
	}
	#accordionSidebar{
		width: 100%;
		height: 100%;
		text-align: center;
		display: inline;
		padding-top: 60px;
		position: fixed;
		z-index: 998;
	}
	#content{
		margin-left:0;
	}
	.nav-item{
		position: absolute;
		display: inline-block;
		padding-top: 20px;
	}
	.topbar .dropdown {
		padding-top: 0px;
	}
	
}

@media (min-width:756px) and (max-width:799px){
	

	#sidebarToggle{
		display:block;
	}
	
	.tableST{
		width : 100% !important;
		height: 40%;
		
	}

	.table-responsive2 {
		visibility: collapse;
		height: 5vh;
		overflow: auto !important;
	}
	#timelineChart{
		width:  100% !important;
	
	}
	.table-responsive{
		overflow: auto !important;
	}
	

}

@media(min-width:800px){
	.table-responsive2{
		height: 65vh;
	}
}

#select_info {
 table-layout:fixed; 
 width:100%;
 }

.table-responsive2 {
	display: block;
	width: 100%;
	overflow: auto;
	-webkit-overflow-scrolling: touch;
	margin-bottom:20px;
}

.memberTable{
	float:right;
	width : 100%;
	text-align:center;
}
#infoTable td:hover{
	background-color: black;
}
.memberTable2{
	width : 100%;
	height: 60%;
	text-align:center;
}
.tableST{
	width : 50%;
	float:right;
	height:auto;
}

#timelineChart{
	height: 90%;
	width:  50%;
	float : right;
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

.tooltip-padding{
	text-align: left;
	padding: 5%;
}

.table { border:1px solid; border-collapse: collapse;}
.table td, .test-table th { border: 1px solid;}
.table thead th { position:sticky; top: 0; background-color:#15a3da52; border:1px solid;}

/*
.textover {
	width:10vw;
	overflow:hidden;
	text-overflow:ellipsis;
	white-space:nowrap;
}
*/
.teamover {
	width:4vw;
	overflow:hidden;
	text-overflow:ellipsis;
	white-space:nowrap;
}
</style>

<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">

  	<%
	  	String nowYear = sf.format(nowTime).split("-")[0];
	  	int preYear = Integer.parseInt(nowYear) - 1;
	  	int nextYear = Integer.parseInt(nowYear) + 1;
	   	StringBuffer strColor = new StringBuffer();
	%>

     google.charts.load("current", {packages:["timeline"]});
     google.charts.setOnLoadCallback(drawChart);
     
    function nowLine(div){
  	//get the height of the timeline div
  		var height;
  	  $('#' + div + ' rect').each(function(index){
  	  	var x = parseFloat($(this).attr('x'));
  	    var y = parseFloat($(this).attr('y'));
  	    if(x == 0 && y == 0) {height = parseFloat($(this).attr('height'))}
  	  })
  		var nowWord = $('#' + div + ' text:contains("Now")');
  	  nowWord.prev().first().attr('height', height + 'px').attr('width', '1px').attr('y', '0');
  	}
    
    function drawChart() {
    	 
       var container = document.getElementById('timelineChart');
       var chart = new google.visualization.Timeline(container);
       var dataTable = new google.visualization.DataTable();
 
       dataTable.addColumn({ type: 'string', id: 'Position' });
       dataTable.addColumn({ type: 'string', id: 'dummy bar label' });
       dataTable.addColumn({ type: 'string', role: 'tooltip' });
       dataTable.addColumn({ type: 'string', id: 'style', role: 'style' });
       dataTable.addColumn({ type: 'date', id: 'Start' });
       dataTable.addColumn({ type: 'date', id: 'End' });
       dataTable.addRows([
       		['\0', 'Now','','',new Date(), new Date()],
       		['\0','','', 'opacity:0', new Date('<%=preYear%>-01-01'), new Date('<%=nextYear%>-12-31')]
         		<%for(String key : projectList.keySet()){
        		for(int b=0; b<projectList.get(key).size(); b++){%>
        			,[	'<%=projectList.get(key).get(b).getTEAM()%>'
        				,'<%=projectList.get(key).get(b).getPROJECT_NAME()%>'
        				,'<div class = "tooltip-padding"> <h7><strong><%=projectList.get(key).get(b).getPROJECT_NAME()%></strong></h7>' + '<hr style ="border:solid 1px;color:black">'
        				+'<p><b>PM : </b><%=projectList.get(key).get(b).getPROJECT_MANAGER()%><br>'
        				+'<b>투입명단 : </b><%=projectList.get(key).get(b).getWORKER_LIST()%></p>' 
        				+'<b>착수일 : </b><%=projectList.get(key).get(b).getPROJECT_START()%><br><b>종료일 : </b><%=projectList.get(key).get(b).getPROJECT_END()%></div>'
        				,'<%=projectList.get(key).get(b).getColor()%>'
        				, new Date('<%=projectList.get(key).get(b).getPROJECT_START()%>'), new Date('<%=projectList.get(key).get(b).getPROJECT_END()%>')]
	        	<%}}%>
          ]);
         
          var options = {
          	timeline: { colorByRowLabel: false, groupByRowLabel: true, avoidOverlappingGridLines : false}
          };
          
	          chart.draw(dataTable, options);
	         	nowLine('timelineChart');
         	  
         	google.visualization.events.addListener(chart, 'onmouseover', function(obj){
         		if(obj.row == 0){
         			$('.google-visualization-tooltip').css('display', 'none');
         		}
         	    nowLine('timelineChart');
         	  })
         	  
         	  google.visualization.events.addListener(chart, 'onmouseout', function(obj){
         	  	nowLine('timelineChart');
         	  })

          	var st = container.getElementsByTagName("div")[0];
			st.style.position = 'inherit';
	
        }     
 
    function defaultTotal(){
    	for(var j=0;j<9;j++){
        	var total_step = 0;
    		for(var i=1;i<7;i++){
	    		total_step += Number($("#infoTable tbody tr:eq(" + j + ") td:eq(" + i + ")").text());
	    	}
    		$("#infoTable tbody tr:eq(" + j + ") td:eq(0)").html(total_step);
	    }
    }
    
	<!-- 로딩화면 -->
	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').hide();
	});
	
	function clickfun(state, team){
		var inner = "";
		<%for(String key : projectList.keySet()){%>
			if(team == '<%=key%>'){
				<%for(Project_sch_Bean i : projectList.get(key)){%>
					if(state == '<%=i.getSTATE()%>'){
						inner += '<tr style="<%=i.getColor()%>">';
						inner += "<td><div class='teamover'>"+'<%=i.getTEAM_ORDER()%>'+"</div></td>";
	 					inner += "<td><div class='teamover'>"+'<%=i.getTEAM_SALES()%>'+"</div></td>";
	 					if(<%=permission%> == 0){
		  					inner += "<td><div class='textover'><a href='../project/project_update.jsp?no=<%=i.getNO()%>&year=<%=year%>'>"+"<%=i.getPROJECT_NAME()%>"+"</a></div></td>";
		  				}else{
		  					inner += "<td><div class='textover'>"+"<%=i.getPROJECT_NAME()%>"+"</div></td>";
		  				}
						inner += "<td><div class='teamover'>"+'<%=i.getCLIENT()%>'+"</div></td>";
						inner += "<td>"+'<%=i.getPROJECT_START()%>'+"</td>";
						inner += "<td>"+'<%=i.getPROJECT_END()%>'+"</td>";
						inner += "<td>"+'<%=i.getPROJECT_MANAGER()%>'+"</td>";
						inner += "</tr>";
					}else if(state == 'total'){
						inner += "<tr>";
						inner += "<td><div class='teamover'>"+'<%=i.getTEAM_ORDER()%>'+"</div></td>";
	 					inner += "<td><div class='teamover'>"+'<%=i.getTEAM_SALES()%>'+"</div></td>";
	 					if(<%=permission%> == 0){
		  					inner += "<td><div class='textover'><a href='../project/project_update.jsp?no=<%=i.getNO()%>&year=<%=year%>'>"+"<%=i.getPROJECT_NAME()%>"+"</a></div></td>";
		  				}else{
		  					inner += "<td><div class='textover'>"+"<%=i.getPROJECT_NAME()%>"+"</div></td>";
		  				}
						inner += "<td><div class='teamover'>"+'<%=i.getCLIENT()%>'+"</div></td>";
						inner += "<td>"+'<%=i.getPROJECT_START()%>'+"</td>";
						inner += "<td>"+'<%=i.getPROJECT_END()%>'+"</td>";
						inner += "<td>"+'<%=i.getPROJECT_MANAGER()%>'+"</td>";
						inner += "</tr>";
					}
				<%}%>
			}else if(team == 'total'){
				<%for(Project_sch_Bean i : projectList.get(key)){%>
				if(state == '<%=i.getSTATE()%>'){
					inner += "<tr>";
					inner += "<td><div class='teamover'>"+'<%=i.getTEAM_ORDER()%>'+"</div></td>";
 					inner += "<td><div class='teamover'>"+'<%=i.getTEAM_SALES()%>'+"</div></td>";
 					if(<%=permission%> == 0){
	  					inner += "<td><div class='textover'><a href='../project/project_update.jsp?no=<%=i.getNO()%>&year=<%=year%>'>"+"<%=i.getPROJECT_NAME()%>"+"</a></div></td>";
	  				}else{
	  					inner += "<td><div class='textover'>"+"<%=i.getPROJECT_NAME()%>"+"</div></td>";
	  				}
					inner += "<td><div class='teamover'>"+'<%=i.getCLIENT()%>'+"</div></td>";
					inner += "<td>"+'<%=i.getPROJECT_START()%>'+"</td>";
					inner += "<td>"+'<%=i.getPROJECT_END()%>'+"</td>";
					inner += "<td>"+'<%=i.getPROJECT_MANAGER()%>'+"</td>";
					inner += "</tr>";
				}else if(state == 'total'){
					inner += "<tr>";
					inner += "<td><div class='teamover'>"+'<%=i.getTEAM_ORDER()%>'+"</div></td>";
 					inner += "<td><div class='teamover'>"+'<%=i.getTEAM_SALES()%>'+"</div></td>";
 					if(<%=permission%> == 0){
	  					inner += "<td><div class='textover'><a href='../project/project_update.jsp?no=<%=i.getNO()%>&year=<%=year%>'>"+"<%=i.getPROJECT_NAME()%>"+"</a></div></td>";
	  				}else{
	  					inner += "<td><div class='textover'>"+"<%=i.getPROJECT_NAME()%>"+"</div></td>";
	  				}
					inner += "<td><div class='teamover'>"+'<%=i.getCLIENT()%>'+"</div></td>";
					inner += "<td>"+'<%=i.getPROJECT_START()%>'+"</td>";
					inner += "<td>"+'<%=i.getPROJECT_END()%>'+"</td>";
					inner += "<td>"+'<%=i.getPROJECT_MANAGER()%>'+"</td>";
					inner += "</tr>";
				}
			<%}%>
			}
		<%}%>

		$('#projectINFO').empty();
		$('#projectINFO').append(inner);
		
		// if mobile
       	var windowWidth = $(window).width();
       	console.log(windowWidth);
       	if(windowWidth <= 800){
       		$('.table-responsive2').css('height', '40vh');
       		$('.table-responsive2').css('visibility', 'unset');
       	}
	}
	
	function goPrint(){
		var popupX = (document.body.offsetWidth/2)-(600/2);
		window.open('project_schedule_print.jsp', '', 'toolbar=no, menubar=no, left='+popupX+', top=100, width=1250, height=850');
	}
	
	function match(a, b){
		if (a==b){
			return 'stroke-width: 3; stroke-color: black;';
		}else{
			return '';
		}
	}

	function clickData(){
		$(document.body).delegate('#select_info tr', 'click', function(){
				var projectName = '';
	 			var tr = $(this);
	 			var td = tr.children();
	 			projectName = td.eq(2).text();
	 			console.log(projectName);
	 	    	
	 	        var container = document.getElementById('timelineChart');
	 	        var chart = new google.visualization.Timeline(container);
	 	        var dataTable = new google.visualization.DataTable();
	 	  
	 	        dataTable.addColumn({ type: 'string', id: 'Position' });
	 	        dataTable.addColumn({ type: 'string', id: 'dummy bar label' });
	 	        dataTable.addColumn({ type: 'string', role: 'tooltip' });
	 	        dataTable.addColumn({ type: 'string', id: 'style', role: 'style' });
	 	        dataTable.addColumn({ type: 'date', id: 'Start' });
	 	        dataTable.addColumn({ type: 'date', id: 'End' });
	 	        dataTable.addRows([
	        		['\0', 'Now','','',new Date(), new Date()],
	        		['\0','','', 'opacity:0', new Date('<%=preYear%>-01-01'), new Date('<%=nextYear%>-12-31')]
	          		<%for(String key : projectList.keySet()){
	         		for(int b=0; b<projectList.get(key).size(); b++){%>
	         			,[	'<%=projectList.get(key).get(b).getTEAM()%>'
	         				,'<%=projectList.get(key).get(b).getPROJECT_NAME()%>'
	         				,'<div class = "tooltip-padding"> <h7><strong><%=projectList.get(key).get(b).getPROJECT_NAME()%></strong></h7>' + '<hr style ="border:solid 1px;color:black">'
	         				+'<p><b>PM : </b><%=projectList.get(key).get(b).getPROJECT_MANAGER()%><br>'
	         				+'<b>투입명단 : </b><%=projectList.get(key).get(b).getWORKER_LIST()%></p>' 
	         				+'<b>착수일 : </b><%=projectList.get(key).get(b).getPROJECT_START()%><br><b>종료일 : </b><%=projectList.get(key).get(b).getPROJECT_END()%></div>'
	         				,'color: <%=projectList.get(key).get(b).getColor()%>;' + match(projectName, '<%=projectList.get(key).get(b).getPROJECT_NAME()%>')
	         				,new Date('<%=projectList.get(key).get(b).getPROJECT_START()%>'), new Date('<%=projectList.get(key).get(b).getPROJECT_END()%>')]
	         		<%}}%>
	            ]);
	 	         
	 	           var options = {
	 	           	timeline: { colorByRowLabel: false, groupByRowLabel: true, avoidOverlappingGridLines : false}
	 	           	
	 	           };
	 	           
	 	 	          chart.draw(dataTable, options);
	 	 	         	nowLine('timelineChart');
	 	          	  
	 	          	google.visualization.events.addListener(chart, 'onmouseover', function(obj){
	 	          		if(obj.row == 0){
	 	          			$('.google-visualization-tooltip').css('display', 'none');
	 	          		}
	 	          	    nowLine('timelineChart');
	 	          	  })
	 	          	  
	 	          	  google.visualization.events.addListener(chart, 'onmouseout', function(obj){
	 	          	  	nowLine('timelineChart');
	 	          	  })

	 	           	var st = container.getElementsByTagName("div")[0];
	 	 			st.style.position = 'inherit';
	     });
	}
	
	// 페이지 시작시 호출 함수
	$(document).ready(function (){
		defaultTotal();
		//drawChart('timelineChart');
		clickData();
	});
	
	
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
					<span>수익 요약</span></a></li>
					
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
			<li class="nav-item"><a class="nav-link"
				href="../project/project.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>프로젝트 관리</span></a></li>

			<!-- Nav Item - schedule -->
			<li class="nav-item"><a class="nav-link"
				href="../schedule/schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>스케줄 - 엔지니어</span></a></li>

			<li class="nav-item active"><a class="nav-link"
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
		<div id="content-wrapper" class="flex-column" style="display: inline">

			<!-- Main Content -->
			

				<!-- Topbar -->
				<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>

					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">


						

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
					<button onclick="goPrint()">인쇄</button>
				</nav>
				<!-- Topbar end -->
				
				<h6 class="m-0 font-weight-bold text-primary">Schedule</h6>
				<div class="tableST" id="infoDiv">
					<div class="table-responsive">
					<table class="memberTable" id="infoTable" style="font-size:14px;">
						<thead>
		                  <tr style="background-color:#15a3da52;">
			                    <th>상태</th>
			                    <th>Total</th>
			                    <%for(int key : teamList.keySet()){ 
			                    	if(key != 0){%>
			                    	<th><%=teamList.get(key).substring(0, 4) %></th>
			                    	<%} 
			                    }%>
			                    <th style="padding:15px;">실</th>
		                    </tr>
	                    </thead>
	                    <tbody>
		                    <tr id="step1">
			                    <th style="text-align:left">1.예산확보</th>
			                    <td onclick="clickfun('1.예산확보', 'total')"></td>
			                    <%for(int key : teamList.keySet()){ 
			                    	if(key != 0){%>
			                    	<td onclick="clickfun('1.예산확보', '<%=teamList.get(key)%>')"><%if(projectNum.get(teamList.get(key)).get("1.예산확보")!=null){%><%=projectNum.get(teamList.get(key)).get("1.예산확보") %><%}else{ %>0<%} %></td>
			                    	<%} 
			                    }%>
			                    <td onclick="clickfun('1.예산확보', '<%=teamList.get(0)%>')"><%if(projectNum.get(teamList.get(0)).get("1.예산확보")!=null){%><%=projectNum.get(teamList.get(0)).get("1.예산확보") %><%}else{ %>0<%} %></td>
		                    </tr>
		                   <tr id="step2">
			                    <th style="text-align:left">2.고객의사</th>
			                    <td onclick="clickfun('2.고객의사', 'total')"></td>
			                    <%for(int key : teamList.keySet()){ 
			                    	if(key != 0){%>
			                    	<td onclick="clickfun('2.고객의사', '<%=teamList.get(key)%>')"><%if(projectNum.get(teamList.get(key)).get("2.고객의사")!=null){%><%=projectNum.get(teamList.get(key)).get("2.고객의사") %><%}else{ %>0<%} %></td>
			                    	<%} 
			                    }%>
			                    <td onclick="clickfun('2.고객의사', '<%=teamList.get(0)%>')"><%if(projectNum.get(teamList.get(0)).get("2.고객의사")!=null){%><%=projectNum.get(teamList.get(0)).get("2.고객의사") %><%}else{ %>0<%} %></td>
		                    </tr> 
		                   <tr id="step3">
			                    <th style="text-align:left">3.제안단계</th>
			                    <td onclick="clickfun('3.제안단계', 'total')"></td>
			                    <%for(int key : teamList.keySet()){ 
			                    	if(key != 0){%>
			                    	<td onclick="clickfun('3.제안단계', '<%=teamList.get(key)%>')"><%if(projectNum.get(teamList.get(key)).get("3.제안단계")!=null){%><%=projectNum.get(teamList.get(key)).get("3.제안단계") %><%}else{ %>0<%} %></td>
			                    	<%} 
			                    }%>
			                    <td onclick="clickfun('3.제안단계', '<%=teamList.get(0)%>')"><%if(projectNum.get(teamList.get(0)).get("3.제안단계")!=null){%><%=projectNum.get(teamList.get(0)).get("3.제안단계") %><%}else{ %>0<%} %></td>
		                    </tr> 
		                   <tr id="step4">
			                    <th style="text-align:left">4.업체선정</th>
			                    <td onclick="clickfun('4.업체선정', 'total')"></td>
			                    <%for(int key : teamList.keySet()){ 
			                    	if(key != 0){%>
			                    	<td onclick="clickfun('4.업체선정', '<%=teamList.get(key)%>')"><%if(projectNum.get(teamList.get(key)).get("4.업체선정")!=null){%><%=projectNum.get(teamList.get(key)).get("4.업체선정") %><%}else{ %>0<%} %></td>
			                    	<%} 
			                    }%>
			                    <td onclick="clickfun('4.업체선정', '<%=teamList.get(0)%>')"><%if(projectNum.get(teamList.get(0)).get("4.업체선정")!=null){%><%=projectNum.get(teamList.get(0)).get("4.업체선정") %><%}else{ %>0<%} %></td>
		                    </tr> 
		                   <tr id="step5">
			                    <th style="text-align:left">5.진행예정</th>
			                    <td onclick="clickfun('5.진행예정', 'total')"></td>
			                    <%for(int key : teamList.keySet()){ 
			                    	if(key != 0){%>
			                    	<td onclick="clickfun('5.진행예정', '<%=teamList.get(key)%>')"><%if(projectNum.get(teamList.get(key)).get("5.진행예정")!=null){%><%=projectNum.get(teamList.get(key)).get("5.진행예정") %><%}else{ %>0<%} %></td>
			                    	<%} 
			                    }%>
			                    <td onclick="clickfun('5.진행예정', '<%=teamList.get(0)%>')"><%if(projectNum.get(teamList.get(0)).get("5.진행예정")!=null){%><%=projectNum.get(teamList.get(0)).get("5.진행예정") %><%}else{ %>0<%} %></td>
		                    </tr> 
		                   <tr id="step6">
			                    <th style="text-align:left">6.진행중</th>
			                    <td onclick="clickfun('6.진행중', 'total')"></td>
			                    <%for(int key : teamList.keySet()){ 
			                    	if(key != 0){%>
			                    	<td onclick="clickfun('6.진행중', '<%=teamList.get(key)%>')"><%if(projectNum.get(teamList.get(key)).get("6.진행중")!=null){%><%=projectNum.get(teamList.get(key)).get("6.진행중") %><%}else{ %>0<%} %></td>
			                    	<%} 
			                    }%>
			                    <td onclick="clickfun('6.진행중', '<%=teamList.get(0)%>')"><%if(projectNum.get(teamList.get(0)).get("6.진행중")!=null){%><%=projectNum.get(teamList.get(0)).get("6.진행중") %><%}else{ %>0<%} %></td>
		                    </tr>
							<tr id="step7">
			                    <th style="text-align:left">7.종료</th>
			                    <td onclick="clickfun('7.종료', 'total')"></td>
			                    <%for(int key : teamList.keySet()){ 
			                    	if(key != 0){%>
			                    	<td onclick="clickfun('7.종료', '<%=teamList.get(key)%>')"><%if(projectNum.get(teamList.get(key)).get("7.종료")!=null){%><%=projectNum.get(teamList.get(key)).get("7.종료") %><%}else{ %>0<%} %></td>
			                    	<%} 
			                    }%>
			                    <td onclick="clickfun('7.종료', '<%=teamList.get(0)%>')"><%if(projectNum.get(teamList.get(0)).get("7.종료")!=null){%><%=projectNum.get(teamList.get(0)).get("7.종료") %><%}else{ %>0<%} %></td>
		                    </tr>
							<tr id="step8">
			                    <th style="text-align:left">8.Dropped</th>
			                    <td onclick="clickfun('8.Dropped', 'total')"></td>
			                    <%for(int key : teamList.keySet()){ 
			                    	if(key != 0){%>
			                    	<td onclick="clickfun('8.Dropped', '<%=teamList.get(key)%>')"><%if(projectNum.get(teamList.get(key)).get("8.Dropped")!=null){%><%=projectNum.get(teamList.get(key)).get("8.Dropped") %><%}else{ %>0<%} %></td>
			                    	<%} 
			                    }%>
			                    <td onclick="clickfun('8.Dropped', '<%=teamList.get(0)%>')"><%if(projectNum.get(teamList.get(0)).get("8.Dropped")!=null){%><%=projectNum.get(teamList.get(0)).get("8.Dropped") %><%}else{ %>0<%} %></td>
		                   </tr>
						   <tr id="step9">
			                    <th style="text-align:left">Total</th>
			                    <td onclick="clickfun('total', 'total')"></td>
			                    <%for(int key : teamList.keySet()){ 
			                    	if(key != 0){%>
			                    	<td onclick="clickfun('total', '<%=teamList.get(key)%>')"><%=projectList.get(teamList.get(key)).size()%></td>
			                    	<%} 
			                    }%>
			                    <td onclick="clickfun('total', '<%=teamList.get(0)%>')"><%=projectList.get(teamList.get(0)).size()%></td>
		                   </tr>
	                   </tbody>
	                </table>
	                </div>
					
					<div class="table-responsive2">
					<table class="table table-bordered" id="select_info" style="font-size:12px;">
		                <thead> 
		                    <tr style="text-align:center;background-color:#15a3da52;">
			                    <th style="width:12%;">팀(수주)</th>
			                    <th style="width:12%;">팀(매출)</th>
			                    <th style="width:29%;">프로젝트명</th>
			                    <th style="width:13%;">고객사</th>
			                    <th style="width:13%;">착수</th>
			                    <th style="width:13%;">종료</th>
			                    <th style="width:8%;">PM</th>                 	         
		                    </tr>
	                    </thead>
	                    <tbody id="projectINFO"></tbody>
	                </table>
	                </div>
        
                </div>
                
	            <div id="timelineChart"></div>
		</div>			
					<!-- /.container-fluid -->
			
				<!-- End of Main Content -->
		
			<!-- End of Content Wrapper -->
	</div>
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

			<!-- Page level plugins -->
			<script src="../../vendor/chart.js/Chart.min.js"></script>

			<!-- Page level custom scripts -->
			<script src="../../js/demo/chart-area-demo.js"></script>
			<script src="../../js/demo/chart-pie-demo.js"></script>
			<script src="../../js/demo/chart-bar-demo.js"></script>
</body>

</html>
