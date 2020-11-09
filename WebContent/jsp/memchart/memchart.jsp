<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="java.util.ArrayList"
	import="java.util.List" import="jsp.DB.method.*"
	import="jsp.Bean.model.*"
	import="java.text.SimpleDateFormat" import="java.util.Date"
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
		
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		session.setMaxInactiveInterval(60*60);
		
		MemberDAO memberDao = new MemberDAO();
	    ArrayList<MemberBean> memberList = memberDao.getMemberData();
	    ArrayList<MemberBean> cooperationList = memberDao.getMember_cooperation(); //협력업체
	    HashMap<String, Integer> coopNum = memberDao.getNum_cooperation();
	%>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - 조직도</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
	
<script>
	function memchartInsert(){
		var now = new Date();
		var year = now.getFullYear();
		var month = now.getMonth()+1;
		if(month > 6){
			var half = '하반기';
		}else{
			var half = '상반기';
		}
		$('.tag').html('인턴('+year+'년 '+half+')');
		var chasisNum = 0;
		var bodyNum = 0;
		var controlNum = 0;
		var safeNum = 0;
		var autoNum = 0;
		var internNum = 0;
		<%for(MemberBean mem : memberList){
			if(mem.getPosition().equals("실장")){%>
				$('#vtM').html('<%=mem.getNAME()%>' + ' 실장');
			<%	continue; }
			if(mem.getRANK().equals("인턴")){%>
				internNum = internNum + 1;
				if(!($('.cen').is(':empty'))){
					$('.cen').append(', ' + '<%=mem.getNAME()%>'); 
				}else{
					$('.cen').append('<%=mem.getNAME()%>');
				}
			<%	continue; }
			if(mem.getTEAM().equals("샤시힐스검증팀")){%>
				chasisNum = chasisNum + 1;
				<%if(mem.getPosition().equals("팀장")){%>
					$('.chasis > .teamM').html('<%=mem.getNAME()%>' + ' 팀장');
				<%continue; }
				if(mem.getRANK().equals("수석") || mem.getRANK().equals("책임")){%>
					$('.chasis > .lv2').append('<%=mem.getNAME()%>' + ' ' + '<%=mem.getRANK()%>' + '<br>');
				<%continue; }
				if(mem.getRANK().equals("선임")){%>
					$('.chasis > .lv3').append('<%=mem.getNAME()%>' + ' 선임<br>');
				<%continue; }
				if(mem.getRANK().equals("전임")){%>
					$('.chasis > .lv4').append('<%=mem.getNAME()%>' + ' 전임<br>');
				<%continue; }
			}
			if(mem.getTEAM().equals("바디힐스검증팀")){%>
				bodyNum = bodyNum + 1;
				<%if(mem.getPosition().equals("팀장")){%>
					$('.body > .teamM').html('<%=mem.getNAME()%>' + ' 팀장');
				<%continue; }
				if(mem.getRANK().equals("수석") || mem.getRANK().equals("책임")){%>
					$('.body > .lv2').append('<%=mem.getNAME()%>' + ' ' + '<%=mem.getRANK()%>' + '<br>');
				<%continue; }
				if(mem.getRANK().equals("선임")){%>
					$('.body > .lv3').append('<%=mem.getNAME()%>' + ' 선임<br>');
				<%continue; }
				if(mem.getRANK().equals("전임")){%>
					$('.body > .lv4').append('<%=mem.getNAME()%>' + ' 전임<br>');
				<%continue; }
			}
			if(mem.getTEAM().equals("제어로직검증팀")){%>
				controlNum = controlNum + 1;
				<%if(mem.getPosition().equals("팀장")){%>
					$('.control > .teamM').html('<%=mem.getNAME()%>' + ' 팀장');
				<%continue; }
				if(mem.getRANK().equals("수석") || mem.getRANK().equals("책임")){%>
					$('.control > .lv2').append('<%=mem.getNAME()%>' + ' ' + '<%=mem.getRANK()%>' + '<br>');
				<%continue; }
				if(mem.getRANK().equals("선임")){%>
					$('.control > .lv3').append('<%=mem.getNAME()%>' + ' 선임<br>');
				<%continue; }
				if(mem.getRANK().equals("전임")){%>
					$('.control > .lv4').append('<%=mem.getNAME()%>' + ' 전임<br>');
				<%continue; }
			}
			if(mem.getTEAM().equals("기능안전검증팀")){%>
				safeNum = safeNum + 1;
				<%if(mem.getPosition().equals("팀장")){%>
					$('.safe > .teamM').html('<%=mem.getNAME()%>' + ' 팀장');
				<%continue; }
				if(mem.getRANK().equals("수석") || mem.getRANK().equals("책임")){%>
					$('.safe > .lv2').append('<%=mem.getNAME()%>' + ' ' + '<%=mem.getRANK()%>' + '<br>');
				<%continue; }
				if(mem.getRANK().equals("선임")){%>
					$('.safe > .lv3').append('<%=mem.getNAME()%>' + ' 선임<br>');
				<%continue; }
				if(mem.getRANK().equals("전임")){%>
					$('.safe > .lv4').append('<%=mem.getNAME()%>' + ' 전임<br>');
				<%continue; }
			}if(mem.getTEAM().equals("자율주행검증팀")){%>
				autoNum = autoNum + 1;
				<%if(mem.getPosition().equals("팀장")){%>
					$('.auto > .teamM').html('<%=mem.getNAME()%>' + ' 팀장');
				<%continue; }
				if(mem.getRANK().equals("수석") || mem.getRANK().equals("책임")){%>
					$('.auto > .lv2').append('<%=mem.getNAME()%>' + ' ' + '<%=mem.getRANK()%>' + '<br>');
				<%continue; }
				if(mem.getRANK().equals("선임")){%>
					$('.auto > .lv3').append('<%=mem.getNAME()%>' + ' 선임<br>');
				<%continue; }
				if(mem.getRANK().equals("전임")){%>
					$('.auto > .lv4').append('<%=mem.getNAME()%>' + ' 전임<br>');
				<%continue; }
			}}%>
			
			$('#chasisnum').html(chasisNum + '명');
			$('#bodynum').html(bodyNum + '명');
			$('#controlnum').html(controlNum + '명');
			$('#safenum').html(safeNum + '명');
			$('#autonum').html(autoNum + '명');
			$('#internnum').html(internNum + '명');
			
	}
	
	function cooperView(){	
		$('#cooper').change(function(){
			if($('#cooper').is(":checked")){
				$('#vt6 > td').css('border-bottom','0px');
				$('#coopTR > .chasis > .coop').empty();
				$('#coopTR > .body > .coop').empty();
				$('#coopTR > .control > .coop').empty();
				$('#coopTR > .safe > .coop').empty();
				$('#coopTR > .auto > .coop').empty();
				
				var str = "";
				<%for(String coop : coopNum.keySet()){%>
					str = str + '<%=coop%>' + ' : ' + '<%=coopNum.get(coop)%>' + '명<br>';
				<%}%>
				
				var vtnum = 0;
				var chasisnum = 0;
				var bodynum = 0;
				var controlnum = 0;
				var safenum = 0;
				var autonum = 0;
				
				var coopTR = '<td class = "vt vtadd" style="border:0.1px #393A60 solid;border-top:0px;"><div class="coop vtadd"></div></td>';
				$('#coopTR').append(coopTR);
				
				<%for(MemberBean mem : cooperationList){
					if(mem.getTEAM().equals("미래차검증전략실")){%>
						$('#coopTR > .vt > .coop').append('<%=mem.getNAME()%>' + ' ' + '<%=mem.getRANK()%>' + '<br>(' + '<%=mem.getPART()%>' + ')<br>');
						vtnum = vtnum + 1;
					<%continue; }if(mem.getTEAM().equals("샤시힐스검증팀")){%>
						$('#coopTR > .chasis > .coop').append('<%=mem.getNAME()%>' + ' ' + '<%=mem.getRANK()%>' + '<br>(' + '<%=mem.getPART()%>' + ')<br>');
						chasisnum = chasisnum + 1;
					<%continue; }if(mem.getTEAM().equals("바디힐스검증팀")){%>
						$('#coopTR > .body > .coop').append('<%=mem.getNAME()%>' + ' ' + '<%=mem.getRANK()%>' + '<br>(' + '<%=mem.getPART()%>' + ')<br>');
						bodynum = bodynum + 1;
					<%continue; }if(mem.getTEAM().equals("제어로직검증팀")){%>
						$('#coopTR > .control > .coop').append('<%=mem.getNAME()%>' + ' ' + '<%=mem.getRANK()%>' + '<br>(' + '<%=mem.getPART()%>' + ')<br>');
						controlnum = controlnum + 1;
					<%continue; }if(mem.getTEAM().equals("기능안전검증팀")){%>
						$('#coopTR > .safe > .coop').append('<%=mem.getNAME()%>' + ' ' + '<%=mem.getRANK()%>' + '<br>(' + '<%=mem.getPART()%>' + ')<br>');
						safenum = safenum + 1;
					<%continue; }if(mem.getTEAM().equals("자율주행검증팀")){%>
						$('#coopTR > .auto > .coop').append('<%=mem.getNAME()%>' + ' ' + '<%=mem.getRANK()%>' + '<br>(' + '<%=mem.getPART()%>' + ')<br>');
						autonum = autonum + 1;
					<%continue; }%>
				<%}%>
				
				var chasisnum = chasisnum + parseInt($('#chasisnum').text().split()[0]);
				var bodynum = bodynum + parseInt($('#bodynum').text().split()[0]);
				var controlnum = controlnum + parseInt($('#controlnum').text().split()[0]);
				var safenum = safenum + parseInt($('#safenum').text().split()[0]);
				var autonum = autonum + parseInt($('#autonum').text().split()[0]);
				
				var total_vt = parseInt($('#chasisnum').text().split()[0]) + parseInt($('#bodynum').text().split()[0])
							+ parseInt($('#controlnum').text().split()[0]) + parseInt($('#safenum').text().split()[0])
							+ parseInt($('#autonum').text().split()[0]);
				var total = chasisnum+bodynum+controlnum+safenum+autonum+vtnum
				
				var vt18 = '<td class="chartHeader vtadd">미래차검증전략실</td>';
				$('#vt1').append(vt18);
				$('#vt8').append(vt18);
				var vt2 = '<th class="chartHeader vtadd">미래차검증전략실</th>';
				$('#vt2').append(vt2);
				var vt3 = '<td class = "vt vtadd" style="border:0.1px #393A60 solid; border-bottom: 0px;"><div class="teamM vtadd"></div></td>';
				$('#vt3').append(vt3);
				var vt4 = '<td rowspan = "3" class = "vt vtadd" style="border:1px #393A60 solid; border-bottom: 0px; border-top:0px;"><div class="lv2 vtadd" style="color:black;">'
						+'<p style="color:red;"><b>Total : '+total+'명</b></p>'
						+'<p style="color:red;"><b>Total<a style="font-size:10px; color:red;">(협력제외)</a> : '+total_vt+'명</b></p><br>'
						+'<b>협력업체 총 인원</b><br>' + str + '</div></td>';
				$('#vt4').append(vt4);
				/*var vt5 = '<td class = "vt vtadd"><div class="lv3 vtadd"></div></td>';
				$('#vt5').append(vt5);
				var vt6 = '<td class = "vt vtadd"><div class="lv4 vtadd"></div></td>';
				$('#vt6').append(vt6);*/
				var vt7 = '<th class="chartHeader vtadd">명</th>';
				$('#vt7').append(vt7);
				var totalP = '<td class = "chartHeader vtadd" id="vtnum"></td>';
				$('#totalP').append(totalP);
				
				$('#chasisnum').html(chasisnum + '명');
				$('#bodynum').html(bodynum + '명');
				$('#controlnum').html(controlnum + '명');
				$('#safenum').html(safenum + '명');
				$('#autonum').html(autonum + '명');
				$('#vtnum').html(vtnum + '명');
				$('#coopTR').css('visibility', 'visible');
				
	
			}else{
				$('#vt6 > td').css('border-bottom','0.1px solid #393A60');
				var chasisnum = 0;
				var bodynum = 0;
				var controlnum = 0;
				var safenum = 0;
				var autonum = 0;
				
				<%for(MemberBean mem : cooperationList){
					if(mem.getTEAM().equals("샤시힐스검증팀")){%>
						chasisnum = chasisnum + 1;
					<%continue; }if(mem.getTEAM().equals("바디힐스검증팀")){%>
						bodynum = bodynum + 1;
					<%continue; }if(mem.getTEAM().equals("제어로직검증팀")){%>
						controlnum = controlnum + 1;
					<%continue; }if(mem.getTEAM().equals("기능안전검증팀")){%>
						safenum = safenum + 1;
					<%continue; }if(mem.getTEAM().equals("자율주행검증팀")){%>
						autonum = autonum + 1;
					<%continue; }%>
				<%}%>
				
				$('.vtadd').remove();
				
				var chasisnum =parseInt($('#chasisnum').text().split()[0]) - chasisnum;
				var bodynum =parseInt($('#bodynum').text().split()[0]) -  bodynum;
				var controlnum =parseInt($('#controlnum').text().split()[0]) -  controlnum;
				var safenum =parseInt($('#safenum').text().split()[0]) -  safenum;
				var autonum =parseInt($('#autonum').text().split()[0]) -  autonum;
				$('#chasisnum').html(chasisnum + '명');
				$('#bodynum').html(bodynum + '명');
				$('#controlnum').html(controlnum + '명');
				$('#safenum').html(safenum + '명');
				$('#autonum').html(autonum + '명');
				
				$('#coopTR > .chasis > .coop').empty();
				$('#coopTR > .body > .coop').empty();
				$('#coopTR > .control > .coop').empty();
				$('#coopTR > .safe > .coop').empty();
				$('#coopTR > .auto > .coop').empty();
				$('#coopTR').css('visibility', 'collapse');
			}
		});
	}
	
	$(document).ready(function(){
		$('.loading').hide();
		memchartInsert();
		cooperView();
		
		$('#cooper').change(function(){
			if($('#cooper').is(":checked")){
				$('.sidebar').css("height", '100%');
			}else{
				$('.sidebar').css("height", 'auto');
			}
		});
	});
	
	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').hide();
	});
</script>

<style>
.sidebar .nav-item{
	 	word-break: keep-all;
}
#sidebarToggle{
		display:none;
	}
#content{
	margin-left:90px;
}
.sidebar{
		position:absolute;
		height:100eh;
		z-index:9999;
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

@media ( max-width :765px) {
#sidebarToggle{
		display:block;
	}
#content{
	margin-left:0;
}
	.card-header{
		margin-top:4.75rem;
	}
	.topbar{
		z-index:999;
		position:fixed;
		width:100%;
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
}

	
	td{
		text-align : center;
	}
	
	.table-responsive{
	table-layout:fixed;
	 display:table;
	}
	
	table:not(.memchart):not(#intern){ 
	white-space: nowrap;
	/*display:table-cell;*/
	overflow:auto;
	white-space: nowrap;
	}

<!-- 조직도 css -->
	.memchart #intern{
		text-align : center;
	}

	.chartHeader, #totalP, .memInfo, .intd{
		padding-top : 6px !important;
		padding-bottom : 6px !important;
		padding-right : 20px !important;
		padding-left : 20px !important;
	}
	
	.chartHeader, #totalP{
		background-color : #393A60;
		color : white;
		text-align : center;
	}
	
	.memchart td{
		vertical-align:top;
		padding-top:10px;
		padding-bottom:10px;
	}
	
	.teamM{
		background-color : #F2F2F2;
		color : #393A60;
		text-decoration : underline;
	}
	
	.lv2{
		background-color : #F2F2F2;
		color : #045FB4;
	}
	
	.lv3{
		background-color : #F2F2F2;
		color : #B45F04;
	}
	
	.lv4{
		background-color : #F2F2F2;
		color : #298A08;
	}
	
	.coop{
		background-color : #F2F2F2;
		color : #8904B1;
	}
	
	.tag{
		background-color : #97A3C2;
		color : white;
	}
	
	.cen{
		background-color : #F2F2F2;
		color : #298A08;
	}
	
	.memchart div{
	line-height:130% !important;}
	
</style>

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
		<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion toggled" id="accordionSidebar">
			<!-- Sidebar - Brand -->

			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../mypage/mypage.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>마이페이지</span></a></li>

			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../summary/summary.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>요약정보</span></a></li>
					
			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../income_sum/income_sum.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>수입 요약</span></a></li>
					
			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../expense_sum/expense_sum.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>지출 요약</span></a></li>
					
			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../profit_analysis/profit_analysis.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>수익성 분석</span></a></li>
					
			<!-- Nav Item - summary -->
			<li class="nav-item active"><a class="nav-link"
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
							<h6 class="m-0 font-weight-bold text-primary"
								style="padding-left: 17px;">조직도</h6>
							<label style="float:right; font-size:13px;display:inline-block;"><input type="checkbox" id="cooper" name="cooper" value="cooper">
							<span style="vertical-align: text-bottom;margin-left: 2px;">협력업체 및 세부정보</span></label>
						</div>

						<div class="card-body">
							<div class="table-respensive" id="organizationChart">
								<div id="vtM" style="text-align:center; margin:15px; color:black; text-decoration:underline; font-size:18px;">
								</div>
								<div>
									<table class = "memchart" style="margin-left: auto; margin-right: auto; border-spacing : 20px 0; border-collapse:unset; margin-bottom:15px;">
											<tr id = "vt1">
												<td class = "chartHeader">샤시힐스검증팀</td>
												<td class = "chartHeader">바디힐스검증팀</td>
												<td class = "chartHeader">제어로직검증팀</td>
												<td class = "chartHeader">기능안전검증팀</td>
												<td class = "chartHeader">자율주행검증팀</td>
											</tr>
									</table>
							      	<table class = "memchart" style="margin-left: auto; margin-right: auto; border-spacing : 20px 0px; border-collapse:unset;">
										<thead style="visibility : collapse;">
											<tr id = "vt2">
												<th class = "chartHeader">샤시힐스검증팀</th>
												<th class = "chartHeader">바디힐스검증팀</th>
												<th class = "chartHeader">제어로직검증팀</th>
												<th class = "chartHeader">기능안전검증팀</th>
												<th class = "chartHeader">자율주행검증팀</th>
											</tr>
										</thead>
										<tbody style="background-color:#F2F2F2;">
											<tr id = "vt3">
												<td class = "chasis" style="border:0.1px #393A60 solid; border-bottom: 0px;">
													<div class="teamM"></div>
												</td>
												<td class = "body" style="border:0.1px #393A60 solid; border-bottom: 0px;">
													<div class="teamM"></div>
												</td>
												<td class = "control" style="border:0.1px #393A60 solid; border-bottom: 0px;">
													<div class="teamM"></div>
												</td>
												<td class = "safe" style="border:0.1px #393A60 solid; border-bottom: 0px;">
													<div class="teamM"></div>
												</td>
												<td class = "auto" style="border:0.1px #393A60 solid; border-bottom: 0px;">
													<div class="teamM"></div>
												</td>
											</tr>
											<tr id = "vt4">
												<td class = "chasis" style="border:0.1px #393A60 solid; border-bottom: 0px; border-top:0px;">
													<div class = "lv2"></div>
												</td>
												<td class = "body" style="border:0.1px #393A60 solid; border-bottom: 0px; border-top:0px;">
													<div class = "lv2"></div>
												</td>
												<td class = "control" style="border:0.1px #393A60 solid; border-bottom: 0px; border-top:0px;">
													<div class = "lv2"></div>
												</td>
												<td class = "safe" style="border:0.1px #393A60 solid; border-bottom: 0px; border-top:0px;">
													<div class = "lv2"></div>
												</td>
												<td class = "auto" style="border:0.1px #393A60 solid; border-bottom: 0px; border-top:0px;">
													<div class = "lv2"></div>
												</td>
											</tr>
											<tr id = "vt5">
												<td class = "chasis" style="border:0.1px #393A60 solid; border-bottom: 0px; border-top:0px;">
													<div class = "lv3"></div>
												</td>
												<td class = "body" style="border:0.1px #393A60 solid; border-bottom: 0px; border-top:0px;">
													<div class = "lv3"></div>
												</td>
												<td class = "control" style="border:0.1px #393A60 solid; border-bottom: 0px; border-top:0px;">
													<div class = "lv3"></div>
												</td>
												<td class = "safe" style="border:0.1px #393A60 solid; border-bottom: 0px; border-top:0px;">
													<div class = "lv3"></div>
												</td>
												<td class = "auto" style="border:0.1px #393A60 solid; border-bottom: 0px; border-top:0px;">
													<div class = "lv3"></div>
												</td>
											</tr>
											<tr id = "vt6">
												<td class = "chasis" style="border:0.1px #393A60 solid;border-top:0px;">
													<div class = "lv4"></div>
												</td>
												<td class = "body" style="border:0.1px #393A60 solid;border-top:0px;">
													<div class = "lv4"></div>
												</td>
												<td class = "control" style="border:0.1px #393A60 solid; border-top:0px;">
													<div class = "lv4"></div>
												</td>
												<td class = "safe" style="border:0.1px #393A60 solid;  border-top:0px;">
													<div class = "lv4"></div>
												</td>
												<td class = "auto" style="border:0.1px #393A60 solid; border-top:0px;">
													<div class = "lv4"></div>
												</td>
											</tr>
											<tr id="coopTR" style="visibility : collapse;">
												<td class = "chasis" style="border:0.1px #393A60 solid; border-top:0px;">
													<div class = "coop"></div>
												</td>
												<td class = "body" style="border:0.1px #393A60 solid;border-top:0px;">
													<div class = "coop" ></div>
												</td>
												<td class = "control" style="border:0.1px #393A60 solid; border-top:0px;">
													<div class = "coop"></div>
												</td>
												<td class = "safe" style="border:0.1px #393A60 solid;border-top:0px;">
													<div class = "coop"></div>
												</td>
												<td class = "auto" style="border:0.1px #393A60 solid; border-top:0px;">
													<div class = "coop"></div>
												</td>
											</tr>
										</tbody>
										<tfoot style="visibility : collapse;">
											<tr id = "vt7">
												<th class = "chartHeader">명</th>
												<th class = "chartHeader">명</th>
												<th class = "chartHeader">명</th>
												<th class = "chartHeader">명</th>
												<th class = "chartHeader">명</th>
											</tr>
										</tfoot>
									</table>
									
									<table class="memchart" style="margin-left: auto; margin-right: auto; margin-top:15px; border-spacing : 20px 0; border-collapse:unset;">
										<thead style="visibility : collapse;">
											<tr id = "vt8">
												<th class = "chartHeader">샤시힐스검증팀</th>
												<th class = "chartHeader">바디힐스검증팀</th>
												<th class = "chartHeader">제어로직검증팀</th>
												<th class = "chartHeader">기능안전검증팀</th>
												<th class = "chartHeader">자율주행검증팀</th>
											</tr>
										</thead>
										<tr id = "totalP">
											<td class = "chartHeader" id="chasisnum"></td>
											<td class = "chartHeader" id="bodynum"></td>
											<td class = "chartHeader" id="controlnum"></td>
											<td class = "chartHeader" id="safenum"></td>
											<td class = "chartHeader" id="autonum"></td>
										</tr>
									</table>
								</div>
								<div>
									<table id = "intern" style="margin-left: auto; margin-right: auto; margin-top:15px;">
										<tr>
											<td class = "tag intd">인턴</td>
											<td class = "cen intd"></td>
											<td class = "tag intd" id="internnum"></td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
					
				</div>
				<!-- container-fluid -->
					
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
				<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
								<button class="close" type="button" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
							</div>
							<div class="modal-body">확인버튼을 누를 시 로그아웃 됩니다.</div>
							<div class="modal-footer">
								<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
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