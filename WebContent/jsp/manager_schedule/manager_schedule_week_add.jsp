<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.io.PrintWriter"
    import = "jsp.sheet.method.*"
    import ="java.util.*"
    import = "java.text.SimpleDateFormat"
    %>
<!DOCTYPE html>
<html lang="en">

<head>
<%
		request.setCharacterEncoding("UTF-8");
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../../html/login.html' </script>");
		}
		int permission = Integer.parseInt(session.getAttribute("permission").toString());
		if (permission > 1){
			script.print("<script> alert('관리자가 아닙니다.'); history.back(); </script>");
		}
		
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		session.setMaxInactiveInterval(15*60);
		String date = request.getParameter("weekDate");
		
		// 문자형 date형으로 변환
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date to = transFormat.parse(date);
		
		Calendar cal = Calendar.getInstance(); 
		cal.setTime(to);
		
		String date1 = date;
		cal.add(Calendar.DATE, 1);
		String date2 = transFormat.format(cal.getTime());
		cal.add(Calendar.DATE, 1);
		String date3 = transFormat.format(cal.getTime());
		cal.add(Calendar.DATE, 1);
		String date4 = transFormat.format(cal.getTime());
		cal.add(Calendar.DATE, 1);
		String date5 = transFormat.format(cal.getTime());
		
%>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Sure FVMS - Manager_Schedule_add</title>

  <!-- Custom fonts for this template-->
  <link href="../../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="../../https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="../../css/sb-admin-2.min.css" rel="stylesheet">
	
</head>
<style>
	#allTable {
		margin : auto;
		text-align : center;
	}
	caption {
		text-align : center;
		caption-side : top;
	}
	.table_week {
		float : left;
		margin : 10px;
	}
	#table_td{
		padding-left: 10px;
		padding-top: 10px;
		display:grid !important;
		padding-bottom: 10px;
	}
	summary:hover{
	 	background-color:#e0dfdfbf;
	 	font-weight:700;
	 	border:2px solid black;
	}
	
	summary:active{
	 	background-color: #c0c0c4;
	 	 border:2px solid black;
	 	 color:black;
	 	
	}
	details p{
    padding-left:12px !important;
    margin:3px 0px !important;
    width:80%;
	}
	summary{
    border: 1px solid black;
    border-radius: 5px;
    padding: 6px;
	}
	#holiday:focus {
		outline:#fff;
	}
	#holiday{
		color:white;
		border:0px solid;
		border-radius: 6px; 
		height:52px;
		font-weight: 700;
	}
	.loading{
		position:fixed;
		text-align: center;
		width:100%;
		height:100%;
		top:0;
		left:0;
		font-size:8px;
		background-color: #4e73df6b;
  	  	background-image: linear-gradient(181deg,#3d5482 16%,#6023b654 106%);
  	  	background-size: cover;
        z-index:1000;
        color:#ffffffc4;
	}
	.loading #load{
		position:fixed;
		top:50%;
		left: 50%;
		transform:translate(-50%, -50%);
	}
	@media(max-width:800px){
		.container-fluid{
			padding: 0;
		}
		.card-header:first-child{
			padding: 0;
		}
		.table_week {
			float:none;
		}
	}
</style>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript">
	
	function AMfocus(){
		document.getElementById('AMradio').checked=true;
	}
	function PMfocus(){
		document.getElementById('PMradio').checked=true;
	}
	
	
//로딩화면
	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').hide();
	    ff();
	});
	
	//mon_ 기타
	$(function(){
		$("#amselboxDirect_mon").hide();
		$("#amPlaceSel_mon").change(function() {
				if($("#amPlaceSel_mon").val() == "기타") {
					$("#amselboxDirect_mon").show();
				}  else {
					$("#amselboxDirect_mon").hide();
				}
		})
	});
	
	$(function(){
		$("#pmselboxDirect_mon").hide();
		$("#pmPlaceSel_mon").change(function() {
				if($("#pmPlaceSel_mon").val() == "기타") {
					$("#pmselboxDirect_mon").show();
				}  else {
					$("#pmselboxDirect_mon").hide();
				}
		})
	});

	//tue_ 기타
	$(function(){
		$("#amselboxDirect_tue").hide();
		$("#amPlaceSel_tue").change(function() {
				if($("#amPlaceSel_tue").val() == "기타") {
					$("#amselboxDirect_tue").show();
				}  else {
					$("#amselboxDirect_tue").hide();
				}
		})
	});
	
	$(function(){
		$("#pmselboxDirect_tue").hide();
		$("#pmPlaceSel_tue").change(function() {
				if($("#pmPlaceSel_tue").val() == "기타") {
					$("#pmselboxDirect_tue").show();
				}  else {
					$("#pmselboxDirect_tue").hide();
				}
		})
	});
	
	//wed_ 기타
	$(function(){
		$("#amselboxDirect_wed").hide();
		$("#amPlaceSel_wed").change(function() {
				if($("#amPlaceSel_wed").val() == "기타") {
					$("#amselboxDirect_wed").show();
				}  else {
					$("#amselboxDirect_wed").hide();
				}
		})
	});
	
	$(function(){
		$("#pmselboxDirect_wed").hide();
		$("#pmPlaceSel_wed").change(function() {
				if($("#pmPlaceSel_wed").val() == "기타") {
					$("#pmselboxDirect_wed").show();
				}  else {
					$("#pmselboxDirect_wed").hide();
				}
		})
	});
	
	//thu_ 기타
	$(function(){
		$("#amselboxDirect_thu").hide();
		$("#amPlaceSel_thu").change(function() {
				if($("#amPlaceSel_thu").val() == "기타") {
					$("#amselboxDirect_thu").show();
				}  else {
					$("#amselboxDirect_thu").hide();
				}
		})
	});
	
	$(function(){
		$("#pmselboxDirect_thu").hide();
		$("#pmPlaceSel_thu").change(function() {
				if($("#pmPlaceSel_thu").val() == "기타") {
					$("#pmselboxDirect_thu").show();
				}  else {
					$("#pmselboxDirect_thu").hide();
				}
		})
	});
	
	//fri_ 기타
	$(function(){
		$("#amselboxDirect_fri").hide();
		$("#amPlaceSel_fri").change(function() {
				if($("#amPlaceSel_fri").val() == "기타") {
					$("#amselboxDirect_fri").show();
				}  else {
					$("#amselboxDirect_fri").hide();
				}
		})
	});
	
	$(function(){
		$("#pmselboxDirect_fri").hide();
		$("#pmPlaceSel_fri").change(function() {
				if($("#pmPlaceSel_fri").val() == "기타") {
					$("#pmselboxDirect_fri").show();
				}  else {
					$("#pmselboxDirect_fri").hide();
				}
		})
	});
</script>

<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">
  	 <!--  로딩화면  시작  -->
				  <div class="loading">
				  <div id="load">
				<i class="fas fa-spinner fa-10x fa-spin"></i>
				  </div>
				  </div>
			<!--  로딩화면  끝  -->

    <!-- Sidebar -->
    
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion toggled" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="../summary/summary.jsp">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Sure FVMS</div>
      </a>

   <!-- Divider -->
			<hr class="sidebar-divider my-0">
			
			<!-- Nav Item - summary -->
		    <li class="nav-item">
	          <a class="nav-link" href="../mypage/mypage.jsp">
	          <i class="fas fa-fw fa-table"></i>
	          <span>마이페이지</span></a>
	     	</li>
	     	
			<!-- Nav Item - summary -->
		    <li class="nav-item">
	          <a class="nav-link" href="../summary/summary.jsp">
	          <i class="fas fa-fw fa-table"></i>
	          <span>요약정보</span></a>
	     	</li>
      
       		<!-- Nav Item - project -->
      		<li class="nav-item">
     	     <a class="nav-link" href="../project/project.jsp">
             <i class="fas fa-fw fa-clipboard-list"></i>
             <span>프로젝트</span></a>
     	    </li>
      
		    <!-- Nav Item - rowdata -->
		    <li class="nav-item">
		      <a class="nav-link" href="../rowdata/rowdata.jsp">
		      <i class="fas fa-fw fa-chart-area"></i>
		      <span>멤버</span></a>
     		</li>
     		
	      <!-- Nav Item - schedule -->
	      <li class="nav-item ">
	        <a class="nav-link" href="../schedule/schedule.jsp">
	        <i class="fas fa-fw fa-calendar"></i>
	        <span>스케줄</span></a>
	      </li>
	      
	      <!-- Nav Item - manager schedule -->
	      <li class="nav-item active">
	        <a class="nav-link" href="../manager_schedule/manager_schedule.jsp">
	        <i class="fas fa-fw fa-calendar"></i>
	        <span>관리자 스케줄</span></a>
	      </li>
	      

		  <!-- Nav Item - report -->
			<li class="nav-item">
			  <a class="nav-link" href="../report/report.jsp">
			  <i class="fas fa-fw fa-clipboard-list"></i> 
			  <span>주간보고서</span></a>
			</li>
      	
      	<!-- Nav Item - meeting -->
			<li class="nav-item">
			  <a class="nav-link" href="../meeting/meeting.jsp">
			  <i class="fas fa-fw fa-clipboard-list"></i> 
			  <span>회의록</span></a>
			</li>
		
		<!-- Nav Item - manager page -->
     	<%if(sessionID.equals("ymyou")){ %>
			<li class="nav-item">
			  <a class="nav-link" href="../manager/manager.jsp">
			  <i class="fas fa-fw fa-clipboard-list"></i> 
			  <span>관리자 페이지</span></a>
			</li>
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
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">

        

            <div class="topbar-divider d-none d-sm-block"></div>

            <!-- Nav Item - User Information -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%=sessionName%></span>
                <i class="fas fa-info-circle"></i>
              </a>
              <!-- Dropdown - User Information -->
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  Logout
                </a>
              </div>
            </li>

          </ul>

        </nav>
        <!-- End of Topbar -->

        <!-- Begin Page Content -->
        <div class="container-fluid">
       
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary" style="padding-left: 17px;">일주일 일정추가</h6>
                </div>
                <div class="card-body">
  		
  
  	
	<form method = "post" action = "manager_schedule_week_addPro.jsp">
		<input type="hidden" name="date1" value="<%=date1%>">
		<input type="hidden" name="date2" value="<%=date2%>">
		<input type="hidden" name="date3" value="<%=date3%>">
		<input type="hidden" name="date4" value="<%=date4%>">
		<input type="hidden" name="date5" value="<%=date5%>">
		<table id ="allTable">
			<tr>
				<td>
					<div id="table_mon" class="table_week">
						 <table style="white-space: nowrap; overflow:hidden;width:100%;" id="table_in_mon">
						 <caption>월</caption>
					     <tr>
					    	<td class="m-0 text-primary" align="center">날짜 </td>
					      	<td colspan="2" style="padding: 15px 0;"><input type="text" readonly id="nowDate_mon" name="DATE_mon" value = <%=date1%> style="width:100%; border:#fff; text-align:center;" maxlength="50"></td>
					     </tr>
					     <tr height="1" bgcolor="#fff"><td colspan="3"></td></tr>
					     <tr height="1" bgcolor="#82B5DF"><td colspan="3"></td></tr>
					     <tr>
					     	<td class="m-0 text-primary" align="center" style="white-space: nowrap;">오전</td>
					     	<td id="table_td">
					      		<select id="amPlaceSel_mon" name="amPlaceSel_mon">
					  				<option value="슈어(본사,삼성)" selected="selected">슈어(본사,삼성)</option>
					  				<option value="슈어(남양사무실)">슈어(남양사무실)</option>
					 				<option value="슈어(대전사무실)">슈어(대전사무실)</option>
					 				<option value="HMC(남양연구소)">HMC(남양연구소)</option>
					 				<option value="오트론(삼성)">오트론(삼성)</option>
					 				<option value="모비스(의왕)">모비스(의왕)</option>
					 				<option value="모비스(마북)">모비스(마북)</option>
					 				<option value="엠엔소프트(용산)">엠엔소프트(용산)</option>
					 				<option value="트랜시스(남양)">트랜시스(남양)</option>
					 				<option value="휴가">휴가</option>
					 				<option value="기타">기타</option>
								</select>
								<input type="text" id="amselboxDirect_mon" name="amselboxDirect_mon"/>
					      	</td>
					     </tr>
					     <tr height="1" bgcolor="#fff"><td colspan="3"></td></tr>
					     <tr height="1" bgcolor="#82B5DF"><td colspan="3"></td></tr>
					     <tr>
					      	<td class="m-0 text-primary" align="center" style="white-space: nowrap;">오후</td>
					      	<td id="table_td"	>
						    	<select id="pmPlaceSel_mon" name="pmPlaceSel_mon">
					  				<option value="슈어(본사,삼성)" selected="selected">슈어(본사,삼성)</option>
					  				<option value="슈어(남양사무실)">슈어(남양사무실)</option>
					 				<option value="슈어(대전사무실)">슈어(대전사무실)</option>
					 				<option value="HMC(남양연구소)">HMC(남양연구소)</option>
					 				<option value="오트론(삼성)">오트론(삼성)</option>
					 				<option value="모비스(의왕)">모비스(의왕)</option>
					 				<option value="모비스(마북)">모비스(마북)</option>
					 				<option value="엠엔소프트(용산)">엠엔소프트(용산)</option>
					 				<option value="트랜시스(남양)">트랜시스(남양)</option>
					 				<option value="휴가">휴가</option>
					 				<option value="기타">기타</option>
								</select>
								<input type="text" id="pmselboxDirect_mon" name="pmselboxDirect_mon"/>
					      	</td>
					     </tr>
					     <tr height="1" bgcolor="#fff"><td colspan="3"></td></tr>
					     </table>
					</div>
					
					<div id="table_tue" class="table_week">
						 <table style="white-space: nowrap; overflow:hidden;width:100%;" id="table_in_tue">
						 <caption>화</caption>
					     <tr>
					    	<td class="m-0 text-primary" align="center">날짜 </td>
					      	<td colspan="2" style="padding: 15px 0;"><input type="text" readonly id="nowDate_tue" name="DATE_tue" value = <%=date2%> style="width:100%; border:#fff; text-align:center;" maxlength="50"></td>
					     </tr>
					     <tr height="1" bgcolor="#fff"><td colspan="3"></td></tr>
					     <tr height="1" bgcolor="#82B5DF"><td colspan="3"></td></tr>
					     <tr>
					     	<td class="m-0 text-primary" align="center" style="white-space: nowrap;">오전</td>
					     	<td id="table_td">
					      		<select id="amPlaceSel_tue" name="amPlaceSel_tue">
					  				<option value="슈어(본사,삼성)" selected="selected">슈어(본사,삼성)</option>
					  				<option value="슈어(남양사무실)">슈어(남양사무실)</option>
					 				<option value="슈어(대전사무실)">슈어(대전사무실)</option>
					 				<option value="HMC(남양연구소)">HMC(남양연구소)</option>
					 				<option value="오트론(삼성)">오트론(삼성)</option>
					 				<option value="모비스(의왕)">모비스(의왕)</option>
					 				<option value="모비스(마북)">모비스(마북)</option>
					 				<option value="엠엔소프트(용산)">엠엔소프트(용산)</option>
					 				<option value="트랜시스(남양)">트랜시스(남양)</option>
					 				<option value="휴가">휴가</option>
					 				<option value="기타">기타</option>
								</select>
								<input type="text" id="amselboxDirect_tue" name="amselboxDirect_tue"/>
					      	</td>
					     </tr>
					     <tr height="1" bgcolor="#fff"><td colspan="3"></td></tr>
					     <tr height="1" bgcolor="#82B5DF"><td colspan="3"></td></tr>
					     <tr>
					      	<td class="m-0 text-primary" align="center" style="white-space: nowrap;">오후</td>
					      	<td id="table_td"	>
						    	<select id="pmPlaceSel_tue" name="pmPlaceSel_tue">
					  				<option value="슈어(본사,삼성)" selected="selected">슈어(본사,삼성)</option>
					  				<option value="슈어(남양사무실)">슈어(남양사무실)</option>
					 				<option value="슈어(대전사무실)">슈어(대전사무실)</option>
					 				<option value="HMC(남양연구소)">HMC(남양연구소)</option>
					 				<option value="오트론(삼성)">오트론(삼성)</option>
					 				<option value="모비스(의왕)">모비스(의왕)</option>
					 				<option value="모비스(마북)">모비스(마북)</option>
					 				<option value="엠엔소프트(용산)">엠엔소프트(용산)</option>
					 				<option value="트랜시스(남양)">트랜시스(남양)</option>
					 				<option value="휴가">휴가</option>
					 				<option value="기타">기타</option>
								</select>
								<input type="text" id="pmselboxDirect_tue" name="pmselboxDirect_tue"/>
					      	</td>
					     </tr>
					     <tr height="1" bgcolor="#fff"><td colspan="3"></td></tr>
					     </table>
					</div>
					
					<div id="table_wed" class="table_week">
						<table style="white-space: nowrap; overflow:hidden;width:100%;" id="table_in_wed">
						<caption>수</caption>
					     <tr>
					    	<td class="m-0 text-primary" align="center">날짜 </td>
					      	<td colspan="2" style="padding: 15px 0;"><input type="text" readonly id="nowDate_wed" name="DATE_wed" value = <%=date3%> style="width:100%; border:#fff; text-align:center;" maxlength="50"></td>
					     </tr>
					     <tr height="1" bgcolor="#fff"><td colspan="3"></td></tr>
					     <tr height="1" bgcolor="#82B5DF"><td colspan="3"></td></tr>
					     <tr>
					     	<td class="m-0 text-primary" align="center" style="white-space: nowrap;">오전</td>
					     	<td id="table_td">
					      		<select id="amPlaceSel_wed" name="amPlaceSel_wed">
					  				<option value="슈어(본사,삼성)" selected="selected">슈어(본사,삼성)</option>
					  				<option value="슈어(남양사무실)">슈어(남양사무실)</option>
					 				<option value="슈어(대전사무실)">슈어(대전사무실)</option>
					 				<option value="HMC(남양연구소)">HMC(남양연구소)</option>
					 				<option value="오트론(삼성)">오트론(삼성)</option>
					 				<option value="모비스(의왕)">모비스(의왕)</option>
					 				<option value="모비스(마북)">모비스(마북)</option>
					 				<option value="엠엔소프트(용산)">엠엔소프트(용산)</option>
					 				<option value="트랜시스(남양)">트랜시스(남양)</option>
					 				<option value="휴가">휴가</option>
					 				<option value="기타">기타</option>
								</select>
								<input type="text" id="amselboxDirect_wed" name="amselboxDirect_wed"/>
					      	</td>
					     </tr>
					     <tr height="1" bgcolor="#fff"><td colspan="3"></td></tr>
					     <tr height="1" bgcolor="#82B5DF"><td colspan="3"></td></tr>
					     <tr>
					      	<td class="m-0 text-primary" align="center" style="white-space: nowrap;">오후</td>
					      	<td id="table_td"	>
						    	<select id="pmPlaceSel_wed" name="pmPlaceSel_wed">
					  				<option value="슈어(본사,삼성)" selected="selected">슈어(본사,삼성)</option>
					  				<option value="슈어(남양사무실)">슈어(남양사무실)</option>
					 				<option value="슈어(대전사무실)">슈어(대전사무실)</option>
					 				<option value="HMC(남양연구소)">HMC(남양연구소)</option>
					 				<option value="오트론(삼성)">오트론(삼성)</option>
					 				<option value="모비스(의왕)">모비스(의왕)</option>
					 				<option value="모비스(마북)">모비스(마북)</option>
					 				<option value="엠엔소프트(용산)">엠엔소프트(용산)</option>
					 				<option value="트랜시스(남양)">트랜시스(남양)</option>
					 				<option value="휴가">휴가</option>
					 				<option value="기타">기타</option>
								</select>
								<input type="text" id="pmselboxDirect_wed" name="pmselboxDirect_wed"/>
					      	</td>
					     </tr>
					     <tr height="1" bgcolor="#fff"><td colspan="3"></td></tr>
					     </table>
					</div>
					
					<div id="table_thu" class="table_week">
						<table style="white-space: nowrap; overflow:hidden;width:100%;" id="table_in_thu">
						<caption>목</caption>
					     <tr>
					    	<td class="m-0 text-primary" align="center">날짜 </td>
					      	<td colspan="2" style="padding: 15px 0;"><input type="text" readonly id="nowDate_thu" name="DATE_thu" value = <%=date4%> style="width:100%; border:#fff; text-align:center;" maxlength="50"></td>
					     </tr>
					     <tr height="1" bgcolor="#fff"><td colspan="3"></td></tr>
					     <tr height="1" bgcolor="#82B5DF"><td colspan="3"></td></tr>
					     <tr>
					     	<td class="m-0 text-primary" align="center" style="white-space: nowrap;">오전</td>
					     	<td id="table_td">
					      		<select id="amPlaceSel_thu" name="amPlaceSel_thu">
					  				<option value="슈어(본사,삼성)" selected="selected">슈어(본사,삼성)</option>
					  				<option value="슈어(남양사무실)">슈어(남양사무실)</option>
					 				<option value="슈어(대전사무실)">슈어(대전사무실)</option>
					 				<option value="HMC(남양연구소)">HMC(남양연구소)</option>
					 				<option value="오트론(삼성)">오트론(삼성)</option>
					 				<option value="모비스(의왕)">모비스(의왕)</option>
					 				<option value="모비스(마북)">모비스(마북)</option>
					 				<option value="엠엔소프트(용산)">엠엔소프트(용산)</option>
					 				<option value="트랜시스(남양)">트랜시스(남양)</option>
					 				<option value="휴가">휴가</option>
					 				<option value="기타">기타</option>
								</select>
								<input type="text" id="amselboxDirect_thu" name="amselboxDirect_thu"/>
					      	</td>
					     </tr>
					     <tr height="1" bgcolor="#fff"><td colspan="3"></td></tr>
					     <tr height="1" bgcolor="#82B5DF"><td colspan="3"></td></tr>
					     <tr>
					      	<td class="m-0 text-primary" align="center" style="white-space: nowrap;">오후</td>
					      	<td id="table_td"	>
						    	<select id="pmPlaceSel_thu" name="pmPlaceSel_thu">
					  				<option value="슈어(본사,삼성)" selected="selected">슈어(본사,삼성)</option>
					  				<option value="슈어(남양사무실)">슈어(남양사무실)</option>
					 				<option value="슈어(대전사무실)">슈어(대전사무실)</option>
					 				<option value="HMC(남양연구소)">HMC(남양연구소)</option>
					 				<option value="오트론(삼성)">오트론(삼성)</option>
					 				<option value="모비스(의왕)">모비스(의왕)</option>
					 				<option value="모비스(마북)">모비스(마북)</option>
					 				<option value="엠엔소프트(용산)">엠엔소프트(용산)</option>
					 				<option value="트랜시스(남양)">트랜시스(남양)</option>
					 				<option value="휴가">휴가</option>
					 				<option value="기타">기타</option>
								</select>
								<input type="text" id="pmselboxDirect_thu" name="pmselboxDirect_thu"/>
					      	</td>
					     </tr>
					     <tr height="1" bgcolor="#fff"><td colspan="3"></td></tr>
					     </table>
					</div>
					
					<div id="table_fri" class="table_week">
						<table style="white-space: nowrap; overflow:hidden;width:100%;" id="table_in_fri">
						<caption>금</caption>
					     <tr>
					    	<td class="m-0 text-primary" align="center">날짜 </td>
					      	<td colspan="2" style="padding: 15px 0;"><input type="text" readonly id="nowDate_fri" name="DATE_fri" value = <%=date5%> style="width:100%; border:#fff; text-align:center;" maxlength="50"></td>
					     </tr>
					     <tr height="1" bgcolor="#fff"><td colspan="3"></td></tr>
					     <tr height="1" bgcolor="#82B5DF"><td colspan="3"></td></tr>
					     <tr>
					     	<td class="m-0 text-primary" align="center" style="white-space: nowrap;">오전</td>
					     	<td id="table_td">
					      		<select id="amPlaceSel_fri" name="amPlaceSel_fri">
					  				<option value="슈어(본사,삼성)" selected="selected">슈어(본사,삼성)</option>
					  				<option value="슈어(남양사무실)">슈어(남양사무실)</option>
					 				<option value="슈어(대전사무실)">슈어(대전사무실)</option>
					 				<option value="HMC(남양연구소)">HMC(남양연구소)</option>
					 				<option value="오트론(삼성)">오트론(삼성)</option>
					 				<option value="모비스(의왕)">모비스(의왕)</option>
					 				<option value="모비스(마북)">모비스(마북)</option>
					 				<option value="엠엔소프트(용산)">엠엔소프트(용산)</option>
					 				<option value="트랜시스(남양)">트랜시스(남양)</option>
					 				<option value="휴가">휴가</option>
					 				<option value="기타">기타</option>
								</select>
								<input type="text" id="amselboxDirect_fri" name="amselboxDirect_fri"/>
					      	</td>
					     </tr>
					     <tr height="1" bgcolor="#fff"><td colspan="3"></td></tr>
					     <tr height="1" bgcolor="#82B5DF"><td colspan="3"></td></tr>
					     <tr>
					      	<td class="m-0 text-primary" align="center" style="white-space: nowrap;">오후</td>
					      	<td id="table_td"	>
						    	<select id="pmPlaceSel_fri" name="pmPlaceSel_fri">
					  				<option value="슈어(본사,삼성)" selected="selected">슈어(본사,삼성)</option>
					  				<option value="슈어(남양사무실)">슈어(남양사무실)</option>
					 				<option value="슈어(대전사무실)">슈어(대전사무실)</option>
					 				<option value="HMC(남양연구소)">HMC(남양연구소)</option>
					 				<option value="오트론(삼성)">오트론(삼성)</option>
					 				<option value="모비스(의왕)">모비스(의왕)</option>
					 				<option value="모비스(마북)">모비스(마북)</option>
					 				<option value="엠엔소프트(용산)">엠엔소프트(용산)</option>
					 				<option value="트랜시스(남양)">트랜시스(남양)</option>
					 				<option value="휴가">휴가</option>
					 				<option value="기타">기타</option>
								</select>
								<input type="text" id="pmselboxDirect_fri" name="pmselboxDirect_fri"/>
					      	</td>
					     </tr>
					     <tr height="1" bgcolor="#fff"><td colspan="3"></td></tr>
					     </table>
					</div>
				</td>
		 </tr>
		
		 <tr>
			 <td>
		     	<div class="card-body" style="margin: 0 auto; display:table;" >
		   			<input id="COMPLETE" type="submit" name="COMPLETE" value="등록"  class="btn btn-primary" style="margin-right: 5px;">
		       		<a href="manager_schedule.jsp" class="btn btn-primary">취소</a>
		     	</div>
		     </td>
	     </tr>
     </table>
</form>
 	    
 	    </div>

    <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->


    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

<!-- Logout Modal-->
 <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
   <div class="modal-content">
    <div class="modal-header">
     <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
     <button class="close" type="button" data-dismiss="modal" aria-label="Close">
      <span aria-hidden="true">×</span>
     </button>
    </div>
    <div class="modal-body">Select "Logout" below if you are ready  to end your current session.</div>
    <div class="modal-footer">
     <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
    <form method = "post" action = "../LogoutPro.jsp">
     	  <input type="submit" class="btn btn-primary" value="Logout" />
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
