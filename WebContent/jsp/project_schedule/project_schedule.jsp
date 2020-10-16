<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="jsp.DB.method.*"
	import="java.util.ArrayList" import="java.util.Date"
	import="java.text.SimpleDateFormat"
	import="java.util.HashMap"%>
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
	session.setMaxInactiveInterval(60*60);
	
	ProjectDAO projectDao = new ProjectDAO();
	Date nowTime = new Date();
	MemberDAO memberDao = new MemberDAO();
	ArrayList<MemberBean> memberList = memberDao.getMemberData(); 
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sf.format(nowTime);
	
	HashMap<String, ArrayList<Project_sch_Bean>> projectList = projectDao.getProjectList_team();
	System.out.print(projectList.size());
	ArrayList<Project_sch_Bean> vh_project = projectList.get("미래차검증전략실");
	ArrayList<Project_sch_Bean> chasis_project = projectList.get("샤시힐스검증팀");
	ArrayList<Project_sch_Bean> body_project = projectList.get("바디힐스검증팀");
	ArrayList<Project_sch_Bean> control_project = projectList.get("제어로직검증팀");
	ArrayList<Project_sch_Bean> save_project = projectList.get("기능안전검증팀");
	ArrayList<Project_sch_Bean> auto_project = projectList.get("자율주행검증팀");
	
	HashMap<String, Integer> vh_count = new HashMap<String, Integer>();
	HashMap<String, Integer> chasis_count = new HashMap<String, Integer>();
	HashMap<String, Integer> body_count = new HashMap<String, Integer>();
	HashMap<String, Integer> control_count = new HashMap<String, Integer>();
	HashMap<String, Integer> save_count = new HashMap<String, Integer>();
	HashMap<String, Integer> auto_count = new HashMap<String, Integer>();
	
	for(Project_sch_Bean i : vh_project){
		if(vh_count.containsKey(i.getSTATE())){
			vh_count.put(i.getSTATE(), vh_count.get(i.getSTATE())+1);
		}else{
			vh_count.put(i.getSTATE(), 1);
		}
	}
	
	for(Project_sch_Bean i : chasis_project){
		if(chasis_count.containsKey(i.getSTATE())){
			chasis_count.put(i.getSTATE(), chasis_count.get(i.getSTATE())+1);
		}else{
			chasis_count.put(i.getSTATE(), 1);
		}
	}
	
	for(Project_sch_Bean i : body_project){
		if(body_count.containsKey(i.getSTATE())){
			body_count.put(i.getSTATE(), body_count.get(i.getSTATE())+1);
		}else{
			body_count.put(i.getSTATE(), 1);
		}
	}
	
	for(Project_sch_Bean i : control_project){
		if(control_count.containsKey(i.getSTATE())){
			control_count.put(i.getSTATE(), control_count.get(i.getSTATE())+1);
		}else{
			control_count.put(i.getSTATE(), 1);
		}
	}
	
	for(Project_sch_Bean i : save_project){
		if(save_count.containsKey(i.getSTATE())){
			save_count.put(i.getSTATE(), save_count.get(i.getSTATE())+1);
		}else{
			save_count.put(i.getSTATE(), 1);
		}
	}
	
	for(Project_sch_Bean i : auto_project){
		if(auto_count.containsKey(i.getSTATE())){
			auto_count.put(i.getSTATE(), auto_count.get(i.getSTATE())+1);
		}else{
			auto_count.put(i.getSTATE(), 1);
		}
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
.topbar {
    height: 3.375rem;
}

@media(max-width:800px){
	.tableST{
	width : 100% !important;
	height: 40%;
	
}
#timelineChart{
	width:  100% !important;

}
.table-responsive{
	overflow: auto !important;
}
}

.memberTable{
	width : 100%;
	white-space:nowrap;
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
.table thead th { position:sticky; top: 0; background-color:#15a3da52; border:1px solid; }

.textover {
	width:10vw;
	overflow:hidden;
	text-overflow:ellipsis;
	white-space:nowrap;
}
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
        				,'text-align:left'
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
     
     
     
     function highlight(){
		console.log(1);
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
						var str = '<%=i.getPROJECT_NAME()%>';
 						console.log(str);
						inner += '<tr>';
						//inner += "<tr onclick='drawChartOp()'>";
						inner += "<td><div class='teamover'>"+'<%=i.getTEAM_ORDER()%>'+"</div></td>";
	 					inner += "<td><div class='teamover'>"+'<%=i.getTEAM_SALES()%>'+"</div></td>";
	 					if(<%=permission%> == 0){
		  					inner += "<td><div class='textover'><a href='../project/project_update.jsp?no=<%=i.getNO()%>'>"+"<%=i.getPROJECT_NAME()%>"+"</a></div></td>";
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
		  					inner += "<td><div class='textover'><a href='../project/project_update.jsp?no=<%=i.getNO()%>'>"+"<%=i.getPROJECT_NAME()%>"+"</a></div></td>";
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
	  					inner += "<td><div class='textover'><a href='../project/project_update.jsp?no=<%=i.getNO()%>'>"+"<%=i.getPROJECT_NAME()%>"+"</a></div></td>";
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
	  					inner += "<td><div class='textover'><a href='../project/project_update.jsp?no=<%=i.getNO()%>'>"+"<%=i.getPROJECT_NAME()%>"+"</a></div></td>";
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
	}
	
	function goPrint(){
		var popupX = (document.body.offsetWidth/2)-(600/2);
		window.open('project_schedule_print.jsp', '', 'toolbar=no, menubar=no, left='+popupX+', top=100, width=1250, height=850');
	}
	
	function match(a, b){
		if (a==b){
			return 'stroke-width: 3;stroke-color: red;';
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
	         				,match(projectName, '<%=projectList.get(key).get(b).getPROJECT_NAME()%>')
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
			
			<button id="sidebarToggle" class="rounded-circle border-0" style="margin-left:30px; margin-top:10px">
						
					</button>
			<!-- Divider -->
			<hr class="sidebar-divider my-0">


			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../mypage/mypage.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>마이페이지</span></a></li>

			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../summary/summary.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>요약정보</span></a></li>

			<!-- Nav Item - project -->
			<li class="nav-item"><a class="nav-link"
				href="../project/project.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>프로젝트</span></a></li>

			<!-- Nav Item - schedule -->
			<li class="nav-item"><a class="nav-link"
				href="../schedule/schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>엔지니어 스케줄</span></a></li>

			<li class="nav-item active"><a class="nav-link"
				href="../project_schedule/project_schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>프로젝트 스케줄</span></a></li>
					
			<!-- Nav Item - manager schedule -->
			<li class="nav-item"><a class="nav-link"
				href="../manager_schedule/manager_schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>관리자 스케줄</span></a></li>

			<!-- Nav Item - report -->
			<li class="nav-item"><a class="nav-link"
				href="../report/report.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>주간보고서</span></a></li>

			<!-- Nav Item - meeting -->
			<li class="nav-item"><a class="nav-link"
				href="../meeting/meeting.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>회의록</span></a></li>

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
					<button onclick="highlight('123')">test</button>
				</nav>
				<h6 class="m-0 font-weight-bold text-primary">Schedule</h6>
				<div class="tableST" id="infoDiv">
				<div class="table-responsive">
				<table class="memberTable" id="infoTable" style="font-size:14px;">
					<thead>
	                  <tr style="background-color:#15a3da52;">
		                    <th>상태</th>
		                    <th>Total</th>
		                    <th>샤시힐스</th>
		                    <th>바디힐스</th>
		                    <th>제어로직</th>
		                    <th>기능안전</th>
		                    <th>자율주행</th>
		                    <th>실</th>
	                    </tr>
                    </thead>
                    <tbody>
	                    <tr id="step1">
		                    <th style="text-align:left">1.예산확보</th>
		                    <td onclick="clickfun('1.예산확보', 'total')"></td>
		                    <td onclick="clickfun('1.예산확보', '샤시힐스검증팀')"><%if(chasis_count.get("1.예산확보")!=null){%><%=chasis_count.get("1.예산확보") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('1.예산확보', '바디힐스검증팀')"><%if(body_count.get("1.예산확보")!=null){%><%=body_count.get("1.예산확보") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('1.예산확보', '제어로직검증팀')"><%if(control_count.get("1.예산확보")!=null){%><%=control_count.get("1.예산확보") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('1.예산확보', '기능안전검증팀')"><%if(save_count.get("1.예산확보")!=null){%><%=save_count.get("1.예산확보") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('1.예산확보', '자율주행검증팀')"><%if(auto_count.get("1.예산확보")!=null){%><%=auto_count.get("1.예산확보") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('1.예산확보', '미래차검증전략실')"><%if(vh_count.get("1.예산확보")!=null){%><%=vh_count.get("1.예산확보") %><%}else{ %>0<%} %></td>
	                    </tr>
	                   <tr id="step2">
		                    <th style="text-align:left">2.고객의사</th>
		                    <td onclick="clickfun('2.고객의사', 'total')"></td>
		                    <td onclick="clickfun('2.고객의사', '샤시힐스검증팀')"><%if(chasis_count.get("2.고객의사")!=null){%><%=chasis_count.get("2.고객의사") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('2.고객의사', '바디힐스검증팀')"><%if(body_count.get("2.고객의사")!=null){%><%=body_count.get("2.고객의사") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('2.고객의사', '제어로직검증팀')"><%if(control_count.get("2.고객의사")!=null){%><%=control_count.get("2.고객의사") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('2.고객의사', '기능안전검증팀')"><%if(save_count.get("2.고객의사")!=null){%><%=save_count.get("2.고객의사") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('2.고객의사', '자율주행검증팀')"><%if(auto_count.get("2.고객의사")!=null){%><%=auto_count.get("2.고객의사") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('2.고객의사', '미래차검증전략실')"><%if(vh_count.get("2.고객의사")!=null){%><%=vh_count.get("2.고객의사") %><%}else{ %>0<%} %></td>
	                   </tr> 
	                   <tr id="step3">
		                    <th style="text-align:left">3.제안단계</th>
		                    <td onclick="clickfun('3.제안단계', 'total')"></td>
		                    <td onclick="clickfun('3.제안단계', '샤시힐스검증팀')"><%if(chasis_count.get("3.제안단계")!=null){%><%=chasis_count.get("3.제안단계") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('3.제안단계', '바디힐스검증팀')"><%if(body_count.get("3.제안단계")!=null){%><%=body_count.get("3.제안단계") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('3.제안단계', '제어로직검증팀')"><%if(control_count.get("3.제안단계")!=null){%><%=control_count.get("3.제안단계") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('3.제안단계', '기능안전검증팀')"><%if(save_count.get("3.제안단계")!=null){%><%=save_count.get("3.제안단계") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('3.제안단계', '자율주행검증팀')"><%if(auto_count.get("3.제안단계")!=null){%><%=auto_count.get("3.제안단계") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('3.제안단계', '미래차검증전략실')"><%if(vh_count.get("3.제안단계")!=null){%><%=vh_count.get("3.제안단계") %><%}else{ %>0<%} %></td>
	                   </tr> 
	                   <tr id="step4">
		                    <th style="text-align:left">4.업체선정</th>
		                    <td onclick="clickfun('4.업체선정', 'total')"></td>
		                    <td onclick="clickfun('4.업체선정', '샤시힐스검증팀')"><%if(chasis_count.get("4.업체선정")!=null){%><%=chasis_count.get("4.업체선정") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('4.업체선정', '바디힐스검증팀')"><%if(body_count.get("4.업체선정")!=null){%><%=body_count.get("4.업체선정") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('4.업체선정', '제어로직검증팀')"><%if(control_count.get("4.업체선정")!=null){%><%=control_count.get("4.업체선정") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('4.업체선정', '기능안전검증팀')"><%if(save_count.get("4.업체선정")!=null){%><%=save_count.get("4.업체선정") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('4.업체선정', '자율주행검증팀')"><%if(auto_count.get("4.업체선정")!=null){%><%=auto_count.get("4.업체선정") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('4.업체선정', '미래차검증전략실')"><%if(vh_count.get("4.업체선정")!=null){%><%=vh_count.get("4.업체선정") %><%}else{ %>0<%} %></td>
	                   </tr> 
	                   <tr id="step5">
		                    <th style="text-align:left">5.진행예정</th>
		                    <td onclick="clickfun('5.진행예정', 'total')"></td>
		                    <td onclick="clickfun('5.진행예정', '샤시힐스검증팀')"><%if(chasis_count.get("5.진행예정")!=null){%><%=chasis_count.get("5.진행예정") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('5.진행예정', '바디힐스검증팀')"><%if(body_count.get("5.진행예정")!=null){%><%=body_count.get("5.진행예정") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('5.진행예정', '제어로직검증팀')"><%if(control_count.get("5.진행예정")!=null){%><%=control_count.get("5.진행예정") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('5.진행예정', '기능안전검증팀')"><%if(save_count.get("5.진행예정")!=null){%><%=save_count.get("5.진행예정") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('5.진행예정', '자율주행검증팀')"><%if(auto_count.get("5.진행예정")!=null){%><%=auto_count.get("5.진행예정") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('5.진행예정', '미래차검증전략실')"><%if(vh_count.get("5.진행예정")!=null){%><%=vh_count.get("5.진행예정") %><%}else{ %>0<%} %></td>
	                   </tr> 
	                   <tr id="step6">
		                    <th style="text-align:left">6.진행중</th>
		                    <td onclick="clickfun('6.진행중', 'total')"></td>
		                    <td onclick="clickfun('6.진행중', '샤시힐스검증팀')"><%if(chasis_count.get("6.진행중")!=null){%><%=chasis_count.get("6.진행중") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('6.진행중', '바디힐스검증팀')"><%if(body_count.get("6.진행중")!=null){%><%=body_count.get("6.진행중") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('6.진행중', '제어로직검증팀')"><%if(control_count.get("6.진행중")!=null){%><%=control_count.get("6.진행중") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('6.진행중', '기능안전검증팀')"><%if(save_count.get("6.진행중")!=null){%><%=save_count.get("6.진행중") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('6.진행중', '자율주행검증팀')"><%if(auto_count.get("6.진행중")!=null){%><%=auto_count.get("6.진행중") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('6.진행중', '미래차검증전략실')"><%if(vh_count.get("6.진행중")!=null){%><%=vh_count.get("6.진행중") %><%}else{ %>0<%} %></td>
	                   </tr>
						<tr id="step7">
		                    <th style="text-align:left">7.종료</th>
		                    <td onclick="clickfun('7.종료', 'total')"></td>
		                    <td onclick="clickfun('7.종료', '샤시힐스검증팀')"><%if(chasis_count.get("7.종료")!=null){%><%=chasis_count.get("7.종료") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('7.종료', '바디힐스검증팀')"><%if(body_count.get("7.종료")!=null){%><%=body_count.get("7.종료") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('7.종료', '제어로직검증팀')"><%if(control_count.get("7.종료")!=null){%><%=control_count.get("7.종료") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('7.종료', '기능안전검증팀')"><%if(save_count.get("7.종료")!=null){%><%=save_count.get("7.종료") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('7.종료', '자율주행검증팀')"><%if(auto_count.get("7.종료")!=null){%><%=auto_count.get("7.종료") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('7.종료', '미래차검증전략실')"><%if(vh_count.get("7.종료")!=null){%><%=vh_count.get("7.종료") %><%}else{ %>0<%} %></td>
	                   </tr>
						<tr id="step8">
		                    <th style="text-align:left">8.Dropped</th>
		                    <td onclick="clickfun('8.Dropped', 'total')"></td>
		                    <td onclick="clickfun('8.Dropped', '샤시힐스검증팀')"><%if(chasis_count.get("8.Dropped")!=null){%><%=chasis_count.get("8.Dropped") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('8.Dropped', '바디힐스검증팀')"><%if(body_count.get("8.Dropped")!=null){%><%=body_count.get("8.Dropped") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('8.Dropped', '제어로직검증팀')"><%if(control_count.get("8.Dropped")!=null){%><%=control_count.get("8.Dropped") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('8.Dropped', '기능안전검증팀')"><%if(save_count.get("8.Dropped")!=null){%><%=save_count.get("8.Dropped") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('8.Dropped', '자율주행검증팀')"><%if(auto_count.get("8.Dropped")!=null){%><%=auto_count.get("8.Dropped") %><%}else{ %>0<%} %></td>
		                    <td onclick="clickfun('8.Dropped', '미래차검증전략실')"><%if(vh_count.get("8.Dropped")!=null){%><%=vh_count.get("8.Dropped") %><%}else{ %>0<%} %></td>
	                   </tr>
					   <tr id="step9">
		                    <th style="text-align:left">Total</th>
		                    <td onclick="clickfun('total', 'total')"></td>
		                    <td onclick="clickfun('total', '샤시힐스검증팀')"><%=chasis_project.size()%></td>
		                    <td onclick="clickfun('total', '바디힐스검증팀')"><%=body_project.size()%></td>
		                    <td onclick="clickfun('total', '제어로직검증팀')"><%=control_project.size()%></td>
		                    <td onclick="clickfun('total', '기능안전검증팀')"><%=save_project.size()%></td>
		                    <td onclick="clickfun('total', '자율주행검증팀')"><%=auto_project.size()%></td>
		                    <td onclick="clickfun('total', '미래차검증전략실')"><%=vh_project.size()%></td>
	                   </tr>
                   </tbody>
                </table>
                </div>
				
				<div class="table-responsive" style="height:65vh; overflow:visible;">
				<table class="table table-bordered" id="select_info" style="font-size:12px;">
	                <thead>
	                    <tr style="text-align:center;background-color:#15a3da52;">
		                    <th style="width:12vw;">팀(수주)</th>
		                    <th style="width:12vw;">팀(매출)</th>
		                    <th style="width:38vw;">프로젝트명</th>
		                    <th style="width:10vw;">고객사</th>
		                    <th style="width:13vw;">착수</th>
		                    <th style="width:13vw;">종료</th>
		                    <th style="width:8vw;">PM</th>                 	         
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
