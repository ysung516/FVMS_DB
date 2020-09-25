<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="jsp.DB.method.*"
	import="java.util.ArrayList" import="java.util.Date"
	import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%

	PrintWriter script =  response.getWriter();
	if (session.getAttribute("sessionID") == null){
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../../html/login.html' </script>");
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
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sf.format(nowTime);
	
	ArrayList<Project_sch_Bean> all_project = projectDao.getProjectList_team();
	
	String str = "";
	
	ArrayList<String[]> workerIdList = new ArrayList<String[]>();
	ArrayList<String> PMnameList = new ArrayList<String>();
	String[] workerIdArray = {};
	String pmInfo="";
	// 투입명단 id >> 이름으로 변경
	for(int i=0; i<all_project.size();i++){
		if(all_project.get(i).getWORKER_LIST() != null){
			workerIdArray =  all_project.get(i).getWORKER_LIST().split(" ");
			for(int a=0; a<workerIdArray.length; a++){
				for(int b=0; b<memberList.size(); b++){
					if(workerIdArray[a].equals(memberList.get(b).getID())){
						workerIdArray[a] = memberList.get(b).getNAME();
					}
				}
			}
			workerIdList.add(workerIdArray);
		}
	}
	
	// PM ID >> 이름 변경
	for(int i=0; i<projectList.size();i++){
		if(projectList.get(i).getWORKER_LIST() != null){
			pmInfo =  projectList.get(i).getPROJECT_MANAGER();
			for(int b=0; b<memberList.size(); b++){
				if(pmInfo.equals(memberList.get(b).getID())){
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
}

.memberTable{
	width : 100%;
	white-space:nowrap;
	text-align:center;
}
#dataTable td:hover{
	background-color: black;
}
.memberTable2{
	width : 100%;
	height: 60%;
	text-align:center;
}
.tableST{
	width : 40%;
	height: 90%;
	float:right;
}
#timelineChart{
	height: 90%;
	width:  60%;
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


</style>



<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
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
        	   	<%
        	   	String nowYear = sf.format(nowTime).split("-")[0];
        	   	int preYear = Integer.parseInt(nowYear) - 1;
        	   	int nextYear = Integer.parseInt(nowYear) + 1;
        	%>

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
              		<%
	            		for(int b=0; b<all_project.size(); b++){%>
	            			,[	'<%=all_project.get(b).getTEAM_ORDER()%>'
	            				,'<%=all_project.get(b).getPROJECT_NAME()%>'
	            				,'<div class = "tooltip-padding"> <h7><strong><%=all_project.get(b).getPROJECT_NAME()%></strong></h7>' + '<hr style ="border:solid 1px;color:black">' + '<p><b>PM : </b><%=all_project.get(b).getPROJECT_MANAGER()%><br><b>투입명단 : </b><%=all_project.get(b).getWORKER_LIST()%></p>' 
	            				+ '<b>착수일 : </b><%=all_project.get(b).getPROJECT_START()%><br><b>종료일 : </b><%=all_project.get(b).getPROJECT_END()%></div>'
	            				,'text-align:left'
	            				, new Date('<%=all_project.get(b).getPROJECT_START()%>'), new Date('<%=all_project.get(b).getPROJECT_END()%>')]
	            		<%}%>
            ]);
        
            var options = {
            	timeline: { colorByRowLabel: false, groupByRowLabel: true }
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
          	
		<!-- 로딩화면 -->
		window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
		$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
		    $('.loading').hide();
		});
		
		// 페이지 시작시 호출 함수
		$(function(){
			drawChart();
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
			<a class="sidebar-brand d-flex align-items-center justify-content-center"
				href="../summary/summary.jsp">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-laugh-wink"></i>
				</div>
				<div class="sidebar-brand-text mx-3">Sure FVMS</div>
			</a>

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
					class="fas fa-fw fa-calendar"></i> <span>스케줄</span></a></li>
					
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


			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

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

				</nav>
				<h6 class="m-0 font-weight-bold text-primary">Schedule</h6>
				<div class="tableST">
				<div class="table-responsive">
				<table class="memberTable" id="dataTable" style="font-size:14px;">
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
	                    <tr>
		                    <th style="text-align:left">1.예산확보</th>
		                    <td onclick="clickfun()"></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
	                    </tr>
	                   <tr>
		                    <th style="text-align:left">2.고객의사</th>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
	                   </tr> 
	                   <tr>
		                    <th style="text-align:left">3.제안단계</th>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
	                   </tr> 
	                   <tr>
		                    <th style="text-align:left">4.업체선정</th>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
	                   </tr> 
	                   <tr>
		                    <th style="text-align:left">5.진행예정</th>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
	                   </tr> 
	                   <tr>
		                    <th style="text-align:left">6.진행중</th>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
	                   </tr>
						<tr>
		                    <th style="text-align:left">8.Dropped</th>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
	                   </tr>
					   <tr>
		                    <th style="text-align:left">Total</th>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
		                    <td onclick=""></td>
	                   </tr>
                   </tbody>
                </table>
                </div>
				
				<div class="table-responsive"style="height: 664px;">
				<table class="table table-bordered" style="font-size:14px;">
	                <thead>
	                    <tr style="text-align:center;background-color:#15a3da52;">
		                    <th>팀(수주)</th>
		                    <th>팀(매출)</th>
		                    <th>프로젝트명</th>
		                    <th>고객사</th>
		                    <th>착수</th>
		                    <th>종료</th>
		                    <th>PM</th>
		                    <th>투입명단</th>	                   	         
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
