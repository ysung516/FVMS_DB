<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="java.util.ArrayList"
	import="java.util.Date" import="java.text.SimpleDateFormat"
	import="jsp.DB.method.*"%>
<!DOCTYPE html>

<html lang="en">

<head>

<%
	request.setCharacterEncoding("UTF-8");
	PrintWriter script =  response.getWriter();
	if (session.getAttribute("sessionID") == null){
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	}
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	if (permission > 1){
		script.print("<script> alert('관리자가 아닙니다.'); history.back(); </script>");
	}
	String sessionID = session.getAttribute("sessionID").toString();
	String sessionName = session.getAttribute("sessionName").toString();
	
%>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript">
	<!-- 로딩화면 -->
	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').css("display","none");
	});
	
</script>

<link href='./lib/main.css' rel='stylesheet' />
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.0/jquery-ui.min.js"></script>
<script src='./lib/main.js'></script>
<script>
	
function formatDate(date) { 
		var d = new Date(date), 
		month = '' + (d.getMonth() + 1), 
		day = '' + d.getDate(), year = d.getFullYear(); 
		if (month.length < 2) month = '0' + month;
		if (day.length < 2) day = '0' + day; 
		return [year, month, day].join('-'); 
	}
	
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
    	headerToolbar: {
            center: 'title',
            left: '',
            right: 'prev,today,next'
          },
                  
        initialView: 'dayGridWeek',
    	navLinks: false,
      	editable: false,
      	hiddenDays: [0,6],
      	dayMaxEvents: true, // allow "more" link when too many events
      	
     
      <%
        MSC_DAO mscDao = new MSC_DAO();
		ArrayList<MSC_Bean> MSCList = new ArrayList<MSC_Bean>();
		MSCList = mscDao.allMSC();
		
		SimpleDateFormat format = new SimpleDateFormat("HH");
		Date time = new Date();
		int nowTime = Integer.parseInt(format.format(time));
      %>
      
      eventOrder: 'level',
      events: [ 	  
      <%
      	for(MSC_Bean li : MSCList){
      		String id = li.getNo()+ " " + li.getID();
      		String title_str = li.getName() +"<br> 오전 : <span style=background-color:" +li.getAMcolor() + ">" + li.getAMplace() +"</span> <br>오후 : <span style=background-color:" + li.getPMcolor() + ">" + li.getPMplace() + "</span>";  
         	 %> 
         	    	  {
         	    		  groupId: '<%=li.getName()%>',
         	    		  level: '<%=li.getLevel()%>',
         	    		  <%if(li.getLevel() == 1){
         	    			  %>className: "layout-1",
         	    			  
       	    			 <%} else if(li.getLevel() == 2){
           	    			 %>className: "layout-2",
           	    			 
         	    		  <%} else if(li.getLevel() == 3){
         	    			 %>className: "layout-3",
         	    		  <%
         	    		  	} else if(li.getLevel() == 4){
         	    		  	%>className: "layout-4",
         	    		  	
         	    		  <%} else if(li.getLevel() == 5){
         	    			 %>className: "layout-5",
         	    			 
         	    		  <%} else if(li.getLevel() == 6){
         	    			 %>className: "layout-6",
         	    		  <%}%>
         	    		  
         	    		  id : '<%=id%>',
         	    		  title: '<%=title_str%>',
         	    		  start: '<%=li.getDate()%>',
         	    		  backgroundColor: 'white',
         	    		  textColor: 'black',
         	    		  
         	    	  },
         	    	
         	<%}%>
         ]
      
      , eventClick: function(arg) {
    		var str = arg.event.id.split(' ');
    		var no = str[0];
    		var id = str[1];
    		var date = formatDate(arg.event.start);
    		var str2 = arg.event.title.split(' ');
    		var amPlace = str2[1];
    		var pmPlace = str2[3];
    		
    		amPlace2 = amPlace;
    		pmPlace2 = pmPlace;
    		
        	if(id == '<%=sessionID%>'){
        		if(confirm("일정을 수정하시겠습니까?") == true){
        			var setNo = document.getElementById("number");
        			var setDate = document.getElementById("setDate");
        			var setAm = document.getElementById("setAm");
        			var setPm = document.getElementById("setPm");
        			setNo.value = no;
        			setDate.value = date;
        			setAm.value = amPlace;
        			setPm.value = pmPlace;
        			document.updateform.submit();
        		} else{
        			window.location.reload()
        		}
        	}	// end if
      }	//end eventClick
      	

       });
    calendar.render();
   
  });

  
  	// ui 바뀐것들
	window.onload = function (){
		fnMove();
	}
	function fnMove(){
	    var offset = $(".fc .fc-col-header-cell.fc-day-today").offset();
	    $('#calendar').animate({scrollLeft : offset.left}, 200);
	}	
	
     //다음주 버튼 누르면 월요일로 가게 할 함수
	function nextMove(){
	    var offset = $(".fc .fc-col-header-cell.fc-day.fc-day-mon").offset();
	    $('#calendar').animate({scrollLeft : offset.left}, 200);
	}
     
	 //지난주 버튼 누르면 금요일로 가게 할 함수
	function preMove(){
	    var offset = $(".fc .fc-col-header-cell.fc-day.fc-day-fri").offset();
	    $('#calendar').animate({scrollLeft : offset.left}, 200);
	}
     
	$(function(){
		$('.fc-next-button.fc-button.fc-button-primary').click(function(){
			nextMove();
		}); 
	});
	
	$(function(){
		$('.fc-prev-button.fc-button.fc-button-primary').click(function(){
			preMove();
		}); 
	});
	function weekAdd(){
		var date = $(".fc-day-mon").attr("data-date");
		document.getElementById("weekDate").value = date;
		document.form_weekAdd.submit();
	}
		
	 function dayEvent(){
		$('.fc-day-mon').click(function(){
		     var date = $(".fc-day-mon").attr("data-date");
		     var day_data = document.getElementById("Date");
		     day_data.value = date;
		     document.Dayform.submit();
		     
		});
		$('.fc-day-tue').click(function(){
		     var date = $(".fc-day-tue").attr("data-date");
		     var day_data = document.getElementById("Date");
		     day_data.value = date;
		     document.Dayform.submit();
		});
		$('.fc-day-wed').click(function(){
		     var date = $(".fc-day-wed").attr("data-date");
		     var day_data = document.getElementById("Date");
		     day_data.value = date;
		     document.Dayform.submit();
		});
		$('.fc-day-thu').click(function(){
		     var date = $(".fc-day-thu").attr("data-date");
		     var day_data = document.getElementById("Date");
		     day_data.value = date;
		     document.Dayform.submit();	
		});
		$('.fc-day-fri').click(function(){
		     var date = $(".fc-day-fri").attr("data-date");
		     var day_data = document.getElementById("Date");
		     day_data.value = date;
		     document.Dayform.submit();
		});
	} 

	function placeColor() {
	    $(".fc-event-title").text(function () {
	        $(this).html( $(this).text().replace(" ", " "));
	    });
	}
	
		
	$(function(){
		dayEvent();
		placeColor();
		$('.fc-next-button').click(function(){
			dayEvent();
			placeColor();
		});
		$('.fc-prev-button').click(function(){
			dayEvent();
			placeColor();
		});
		$('.fc-today-button').click(function(){
			dayEvent();
			placeColor();
		});
	});
	
</script>


<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - Manager_Schedule_add</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">

<!-- Custom styles for this page -->
<link href="../vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">

<style>
.sidebar .nav-item{
	 	word-break: keep-all;
}
	#sidebarToggle{
		display:none;
	}
.sidebar{
	position:relative;
	z-index:997;
}
#reload_btn a {
	box-shadow: 1px 2px 0px 0px #3ba9e0;
	background-color: white;
	display: grid;
	border: 1px solid #3ba9e0;
	border-radius: 8px;
	background-color: white;
}

#reload_btn {
	float: right;
}

#reload_btn a:hover {
	background-color: #3ba9e057;
}

#reload_btn a:active {
	background-color: #3ba9e057;
	border: 2px solid #1a78a7;
	box-shadow: 1px 2px 0px 0px #1a78a7;
}

button:focus {
	outline: none;
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

.fc .fc-daygrid-event-harness {
	margin-bottom: 15px;
}

.fc-popover.fc-more-popover {
	top: 10% !important;
	left: 30% !important;
}

.layout-1 {
	border-color: red;
}

.layout-2 {
	border-color: orange;
}

.layout-3 {
	border-color: brown;
}

.layout-4 {
	border-color: green;
}

.layout-5 {
	border-color: black;
}

.layout-6 {
	margin-top: 20px;
	border-color: purple;
}

.fc-daygrid-event {
	white-space: pre;
}

.fc .fc-col-header-cell.fc-day-today {
	background-color: #b2c8f080;
	background-color: var(- -fc-today-bg-color, rgba(120, 223, 202, 0.46));
}

.fc .fc-daygrid-day.fc-day-today {
	background-color: #b2c8f080;
	background-color: var(- -fc-today-bg-color, rgba(120, 223, 202, 0.46));
}

.fc .fc-toolbar {
	display: inline;
	justify-content: space-between;
	align-items: center;
	margin-right: 10px;
	top: 0;
	left: 0;
	position: sticky;
}

.fc-direction-ltr {
	direction: lrt;
	text-align: center;
}

#calendar {
	padding: 5px;
	max-width: 1100px;
	margin: 0 auto;
	display: flex;
}

@media ( max-width :320px) {
	#sidebarToggle{
		display:block;
	}
	.card-header{
		margin-top:4.75rem;
	}
	.sidebar .nav-item{
	 	white-space:nowrap !important;
	 	font-size: x-large !important;	 	
	}
	.topbar{
		z-index:999;
		position:fixed;
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

	body {
		font-size: small;
	}
	.container-fluid {
		padding: 0;
	}
	.card-header:first-child {
		padding: 0;
	}
	#calendar {
		overflow: auto;
		height: 788px;
		display: flex;
		clear: both;
	}
	.fc-scrollgrid-sync-table {
		width: 788px !important;
	}
	.fc-col-header {
		width: 788px !important;
	}
	.fc .fc-scrollgrid-liquid {
		width: 788px;
	}
	.fc-dayGridWeek-view {
		width: 788px !important;
		overflow: scoll;
	}
	.fc .fc-button-group>.fc-button {
		position: relative;
		flex: 1 1 auto;
		background-color: #858796;
	}
}

@media ( max-width :360px) and (min-width:321px) {
.btn-primary{
	font-size:small;
}
#sidebarToggle{
		display:block;
	}
		.card-header {
		margin-top:4.75rem;
	}
	.sidebar .nav-item{
	 	white-space:nowrap !important;
	 	font-size: x-large !important;	 	
	}
	.topbar{
		z-index:999;
		position:fixed;
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
	.container-fluid {
		padding: 0;
	}
	.card-header:first-child {
		padding: 0;
	}
	#calendar {
		overflow: auto;
		height: 800px;
		display: flex;
		clear: both;
	}
	.fc-scrollgrid-sync-table {
		width: 880px !important;
	}
	.fc-col-header {
		width: 880px !important;
	}
	.fc .fc-scrollgrid-liquid {
		width: 880px;
	}
	.fc-dayGridWeek-view {
		width: 880px !important;
		overflow: scoll;
	}
	.fc .fc-button-group>.fc-button {
		position: relative;
		flex: 1 1 auto;
		background-color: #858796;
	}
}

@media ( max-width :380px) and (min-width:361px) {
.btn-primary{
	font-size:small;
}
#sidebarToggle{
		display:block;
	}
	.card-header py-3{
		margin-top:4.75rem;
	}
	.sidebar .nav-item{
	 	white-space:nowrap !important;
	 	font-size: x-large !important;	 	
	}
	.topbar{
		z-index:999;
		position:fixed;
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
	.container-fluid {
		padding: 0;
	}
	.card-header:first-child {
		padding: 0;
	}
	#calendar {
		overflow: auto;
		height: 800px;
		display: flex;
		clear: both;
	}
	.fc-scrollgrid-sync-table {
		width: 910px !important;
	}
	.fc-col-header {
		width: 910px !important;
	}
	.fc .fc-scrollgrid-liquid {
		width: 910px;
	}
	.fc-dayGridWeek-view {
		width: 910px !important;
		overflow: scoll;
	}
	.fc .fc-button-group>.fc-button {
		position: relative;
		flex: 1 1 auto;
		background-color: #858796;
	}
}

@media ( max-width :765px) {
.btn-primary{
	font-size:small;
}
	body{
		font-size:small;}
#sidebarToggle{
		display:inline;
	}
	.card-header {
		margin-top:4.75rem;
	}
	.sidebar .nav-item{
	 	white-space:nowrap !important;
	 	font-size: x-large !important;	 	
	}
	.topbar{
		z-index:999;
		position:fixed;
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
	.container-fluid {
		padding: 0;
	}
	.card-header:first-child {
		padding: 0;
	}
	#calendar {
		overflow: auto;
		height: 800px;
		display: flex;
		clear: both;
	}
	.fc-dayGridWeek-view {
		width: 1000px;
		overflow: scoll;
	}
	.fc .fc-button-group>.fc-button {
		position: relative;
		flex: 1 1 auto;
		background-color: #858796;
	}
}

#fc-day-mon #fc-event-main-frame #fc-event-title #fc-sticky {
	top: 400px;
}

@media ( max-width :765px) {
.btn-primary{
	font-size:small;
}
#sidebarToggle{
		display:block;
	}
	.card-header{
		margin-top:4.75rem;
	}
	.sidebar .nav-item{
	 	white-space:nowrap !important;
	 	font-size: x-large !important;	 	
	}
	.topbar{
		z-index:999;
		position:fixed;
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

	.container-fluid {
		padding: 0;
	}
	.card-header:first-child {
		padding: 0;
	}
}
</style>

</head>

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
			<li class="nav-item"><a class="nav-link"
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
			<li class="nav-item active"><a class="nav-link"
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
				<div class="container-fluid">

					<div class="card shadow mb-4">

						<div class="card-header py-3">


							<!-- /.container-fluid -->
							<div class="card-body" id="reload_btn">
								<a href="JavaScript:window.location.reload()"
									class="btn btn-primary"><img src="../../img/reload.png"
									width="20px"></a>
							</div>


							<form name="form_weekAdd" method="post"
								action="manager_schedule_week_add.jsp">
								<input id="weekDate" type="hidden" name="weekDate" value="">
								<input id="Add" type="button" class="btn btn-primary"
									onClick="weekAdd()" value="일주일추가" style="margin-left: 5px;">
							</form>

							<div id='calendar'></div>

							<form name="updateform" method="post"
								action="manager_schedule_update.jsp">
								<input id="number" type="hidden" name="num" value="" /> <input
									id="setDate" type="hidden" name="date" value="" /> <input
									id="setAm" type="hidden" name="amPlace" value="" /> <input
									id="setPm" type="hidden" name="pmPlace" value="" />
							</form>


							<form name="Dayform" method="post" action="doubleCheck.jsp">
								<input id="Date" type="hidden" name="date" value="" />
							</form>

						</div>
					</div>
					<!-- End of Main Content -->
				</div>
			</div>
		</div>
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
