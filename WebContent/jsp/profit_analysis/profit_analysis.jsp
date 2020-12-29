<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="java.util.ArrayList"
	import="java.util.List" import="jsp.DB.method.*"
	import="jsp.Bean.model.*" import="java.text.SimpleDateFormat"
	import="java.util.Date" import="java.util.ArrayList"
	import="java.awt.Color" import="java.util.Date"
	import="java.text.SimpleDateFormat" import="java.util.HashMap"
	import="java.util.LinkedHashMap" import="java.util.LinkedList"%>
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
		
		MemberDAO memberDao = new MemberDAO();
		ExpendDAO expendDao = new ExpendDAO();
		SummaryDAO summaryDao = new SummaryDAO();
		
		MemberBean member = memberDao.returnMember(sessionID);
		
		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy");
		String year = sf.format(date);
		
		int fyear = Integer.parseInt(sf.format(date));
		int startYear = 2020;
		int yearCount = fyear - startYear + 1;
		
		int year_int = Integer.parseInt(year);
		
		if(request.getParameter("year") != null){
			year_int = Integer.parseInt(request.getParameter("year"));
		}
		ArrayList<String> teamList  = expendDao.getTeamData(year);
		ArrayList<Expend_TeamBean> exList = new ArrayList<Expend_TeamBean>();
		ArrayList<Expend_CoopBean> exList_coop = new ArrayList<Expend_CoopBean>();
		ArrayList<DPcostBean> FH_dpList = new ArrayList<DPcostBean>();
		ArrayList<DPcostBean> SH_dpList = new ArrayList<DPcostBean>();
		ArrayList<Eq_PurchaseBean> FH_eqList = new ArrayList<Eq_PurchaseBean>();
		ArrayList<Eq_PurchaseBean> SH_eqList = new ArrayList<Eq_PurchaseBean>();
		ArrayList<Outside_ExpendBean> FH_outexList = new ArrayList<Outside_ExpendBean>();
		ArrayList<Outside_ExpendBean> SH_outexList = new ArrayList<Outside_ExpendBean>();
		
		ArrayList<Rank_CostBean> rankCost = expendDao.getRankCost();

		int maxYear = summaryDao.maxYear();
		int yearCnt = maxYear - summaryDao.minYear() + 1;
		
	    LinkedHashMap<Integer, String> teamList2 = memberDao.getTeam_year(year);	// 현재 년도 팀 정보 가져오기
		
		ArrayList<ProjectBean> pjList = summaryDao.getProjectList(year);	// 이번년도 실적보고 프로젝트 리스트
		HashMap<String, Integer> RankCompe = summaryDao.getRank();	// 직급별 기준
		
		ArrayList<String> teamNameList = new ArrayList<String>(); 
		LinkedHashMap<String, TeamBean> teamGoalList = summaryDao.getTargetData(year);	// 현재 년도 팀별 목표값 가져오기
		StateOfProBean ST = new StateOfProBean();
		StateOfProBean ST2 = new StateOfProBean();
		
		StringBuffer total_goal_str = null;
		
		// 프로젝트 현황
		int totalY2=0;
		int totalY3=0;
		int totalY4=0;
		int totalY5=0;
		int totalY6=0;
		int totalY7=0;
		int totalY8=0;

		// 매출달성
		LinkedHashMap<String, Float> FH_achSale = new LinkedHashMap<String, Float>();
		LinkedHashMap<String, Float> SH_achSale = new LinkedHashMap<String, Float>();
		LinkedHashMap<String, Float> Y_achSale = new LinkedHashMap<String, Float>();
		float FH_totalachSale = 0;
		float SH_totalachSale = 0;
		float Y_totalachSale = 0;
		
		for(int key : teamList2.keySet()){
			FH_achSale.put(teamList2.get(key), new Float(0));
			SH_achSale.put(teamList2.get(key), new Float(0));
			Y_achSale.put(teamList2.get(key), new Float(0));
			
			for(int i = 0; i < pjList.size(); i++){
				if(pjList.get(i).getTEAM_SALES().equals(teamList2.get(key))){
					
					/* ========매출달성======== */
					//상반기
					FH_achSale.put(teamList2.get(key), FH_achSale.get(teamList2.get(key)) + pjList.get(i).getFH_SALES());
					FH_totalachSale += pjList.get(i).getFH_SALES();
					//하반기
					SH_achSale.put(teamList2.get(key), SH_achSale.get(teamList2.get(key)) + pjList.get(i).getSH_SALES());
					SH_totalachSale += pjList.get(i).getSH_SALES();
					//연간
					Y_achSale.put(teamList2.get(key), Y_achSale.get(teamList2.get(key)) + pjList.get(i).getFH_SALES() + pjList.get(i).getSH_SALES());
					Y_totalachSale += pjList.get(i).getFH_SALES() + pjList.get(i).getSH_SALES();
				}
			}
		}

		/*매출 보정 start*/
		// 팀별 보정
		LinkedHashMap<String, LinkedHashMap<String, ArrayList<CMSBean>>> corrVal = new LinkedHashMap<String, LinkedHashMap<String, ArrayList<CMSBean>>>();
		for(int key : teamList2.keySet()){
			LinkedHashMap<String, ArrayList<CMSBean>> val = new LinkedHashMap<String, ArrayList<CMSBean>>();
			val.put("plus", summaryDao.getCMS_plusList(teamList2.get(key), year));
			val.put("minus", summaryDao.getCMS_minusList(teamList2.get(key), year));
			corrVal.put(teamList2.get(key), val);
		}
		
		// 팀별 보정값 변수 및 for문
		LinkedHashMap<String, LinkedList<LinkedList<Float>>> corrRate = new LinkedHashMap<String, LinkedList<LinkedList<Float>>>();
		for(String key : corrVal.keySet()){
			LinkedList<LinkedList<Float>> list_all = new LinkedList<LinkedList<Float>>();
			LinkedList<Float> list_fh = new LinkedList<Float>();
			LinkedList<Float> list_sh = new LinkedList<Float>();
			LinkedList<Float> list_y = new LinkedList<Float>();
			
			float fh_plus = 0;
			float sh_plus = 0;
			float y_plus = 0;
			float fh_minus = 0;
			float sh_minus = 0;
			float y_minus = 0;
			
			for(CMSBean cms : corrVal.get(key).get("plus")){
				fh_plus += cms.getFH_MM_CMS();
				sh_plus += cms.getSH_MM_CMS();
				y_plus += cms.getFH_MM_CMS() + cms.getSH_MM_CMS();
			}
			for(CMSBean cms : corrVal.get(key).get("minus")){
				fh_minus += cms.getFH_MM_CMS();
				sh_minus += cms.getSH_MM_CMS();
				y_minus += cms.getFH_MM_CMS() + cms.getSH_MM_CMS();
			}
			
			list_fh.add(fh_plus);
			list_fh.add(fh_minus);
			list_sh.add(sh_plus);
			list_sh.add(sh_minus);
			list_y.add(y_plus);
			list_y.add(y_minus);
			
			list_all.add(list_fh);
			list_all.add(list_sh);
			list_all.add(list_y);
			
			corrRate.put(key, list_all);
		}
		
		// 매출 보정 결과값
		LinkedList<LinkedHashMap<String, Float>> cmsRate = new LinkedList<LinkedHashMap<String, Float>>();
		LinkedHashMap<String, Float> RateMap_fh = new LinkedHashMap<String, Float>();
		LinkedHashMap<String, Float> RateMap_sh = new LinkedHashMap<String, Float>();
		LinkedHashMap<String, Float> RateMap_y = new LinkedHashMap<String, Float>();
		float totalCmsFh = 0;
		float totalCmsSh = 0;
		float totalCmsY = 0;
		for(String key : corrRate.keySet()){
			float fh_cms_chassis = FH_achSale.get(key) - corrRate.get(key).get(0).get(1) + corrRate.get(key).get(0).get(0);
		    float sh_cms_chassis = SH_achSale.get(key) - corrRate.get(key).get(1).get(1) + corrRate.get(key).get(1).get(0);
		    float y_cms_chassis = Y_achSale.get(key) - corrRate.get(key).get(2).get(1) + corrRate.get(key).get(2).get(0);
		    RateMap_fh.put(key, fh_cms_chassis);
			RateMap_sh.put(key, sh_cms_chassis);
			RateMap_y.put(key, y_cms_chassis);
			totalCmsFh += fh_cms_chassis;
			totalCmsSh += sh_cms_chassis;
			totalCmsY += y_cms_chassis;
		}
		RateMap_fh.put("Total", totalCmsFh);
		RateMap_sh.put("Total", totalCmsSh);
		RateMap_y.put("Total", totalCmsY);
		cmsRate.add(RateMap_fh);
		cmsRate.add(RateMap_sh);
		cmsRate.add(RateMap_y);
	%>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - 수익 지표</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>

<script>
	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(document).ready(function(){
		$('.loading').hide();
		$('#ex_year').val(<%=year_int%>).attr("selected","selected");
		Expend();
	});
	
	function listLoad(){
		var year = $('#ex_year').val();
		location.href ="expense_sum.jsp?year="+year;
	}
	
	function Expend(){
		var FHsure= new Array();
		var SHsure = new Array();
		var FHcoop = new Array();
		var SHcoop = new Array();
		var FHdp = new Array();
		var SHdp = new Array();
		var totalSum = new Array();
		
		<%
			float totalSum2 = 0;
			float [] total_sum = new float[teamList.size()];
			for(int i=0; i<teamList.size(); i++){
				exList = expendDao.getExpend_sure(teamList.get(i), Integer.toString(year_int));
				exList_coop = expendDao.getExpend_coop(teamList.get(i), year_int);
				FH_dpList = expendDao.getExpend_dp_FH(teamList.get(i), year_int);
				SH_dpList = expendDao.getExpend_dp_SH(teamList.get(i), year_int);
				FH_eqList = expendDao.getPurchaseList(teamList.get(i), year_int, 0);
				SH_eqList = expendDao.getPurchaseList(teamList.get(i), year_int, 1);
				FH_outexList = expendDao.getOutside_Expend(teamList.get(i), year_int, 0);
				SH_outexList = expendDao.getOutside_Expend(teamList.get(i), year_int, 1);
				
				int [] sure_sum = {0,0};
				int [] coop_sum = {0,0};
				int [] dp_sum = {0,0};
				int [] eq_sum = {0,0};
				int [] out_sum = {0,0};
				int [] outex_sum = {0,0};
				
				
				for(int j=0; j<exList.size(); j++){
					sure_sum[0] += exList.get(j).getFh_expend();
					sure_sum[1] += exList.get(j).getSh_expend();
				}
				for(int z=0; z<exList_coop.size(); z++){
					coop_sum[0] += exList_coop.get(z).getFh_ex();
					coop_sum[1] += exList_coop.get(z).getSh_ex();
				}
				
				for(int x=0; x<FH_dpList.size(); x++){
					dp_sum[0] += FH_dpList.get(x).getFh_ex();
				}
				for(int r=0; r<SH_dpList.size(); r++){
					dp_sum[1] += SH_dpList.get(r).getSh_ex();
				}
				
				for(int q=0; q<FH_eqList.size(); q++){
					eq_sum[0] += FH_eqList.get(q).getSum();
				}
				for(int w=0; w<SH_eqList.size(); w++){
					eq_sum[1] += SH_eqList.get(w).getSum();
				}
				
				for(int e=0; e<FH_outexList.size(); e++){
					outex_sum[0] += FH_outexList.get(e).getCost();
				}
				for(int e=0; e<SH_outexList.size(); e++){
					outex_sum[1] += SH_outexList.get(e).getCost();
				}
				String team = teamList.get(i);
				total_sum[i] = sure_sum[0] + sure_sum[1] + coop_sum[0] + coop_sum[1] + dp_sum[0] + dp_sum[1] + eq_sum[0] + eq_sum[1] + outex_sum[0] + outex_sum[1];
				totalSum2 += total_sum[i];
				%>
				
				totalSum[<%=i%>] = "<td>"+'<%=String.format("%.2f", total_sum[i])%>'+"</td>";		
			<%}%>
		
		var cnt = <%=teamList.size()%>;
		for(var a=0; a<cnt; a++){
			$('#total').append(totalSum[a]);
		}
		
	}

</script>

<style>
td:first-child {
	background: #e0efef;
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

textarea {
	width: 100%;
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
	#sidebarToggle {
		display: block;
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
		margin-top: 4.75rem;
	}
	.topbar {
		z-index: 999;
		position: fixed;
		width: 100%;
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

fieldset {
	border-top: 3px inset;
	border-color: #5d7ace;
}

legend {
	color: #1b3787 !important;
	font-size: 18px;
	font-weight: 600;
	width: auto;
	padding: 5px;
}

.report_div {
	padding-left: 15px;
	padding-bottom: 15px;
}
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
				href="../expense_sum/expense_sum.jsp"> <i
					class="fas fa-fw fa-table"></i> <span>지출 요약</span></a></li>

			<!-- Nav Item - summary -->
			<li class="nav-item active"><a class="nav-link"
				href="../profit_analysis/profit_analysis.jsp"> <i
					class="fas fa-fw fa-table"></i> <span>수익 지표</span></a></li>

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
			<%
				if (permission == 0) {
			%>
			<li class="nav-item"><a class="nav-link"
				href="../manager/manager.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>관리자 페이지</span></a></li>
			<%
				}
			%>
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
							<h6 class="m-0 font-weight-bold text-primary"
								style="padding-left: 17px;">수익 지표 (단위:만)</h6>
						</div>

						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered">
									<thead>
										<tr style="background: #e0efef;">
											<th><select id="ex_year" name="wp_year"
												onchange="listLoad()">
													<%
														for (int i = 0; i < yearCount; i++) {
													%>
													<option value="<%=fyear - i%>"><%=fyear - i%></option>
													<%
														}
													%>
											</select></th>
											<th>Total</th>
											<%
												for (int i = 0; i < teamList.size(); i++) {
											%>
											<th><%=teamList.get(i)%></th>
											<%
												}
											%>
										
										<tr>
									</thead>

									<tbody>
										<tr id="totalSale">
											<td>총 수입</td>
											<td><%=String.format("%.2f", Y_totalachSale * 100)%></td>
											<%
												for (int key : teamList2.keySet()) {
											%>
											<!-- 지출에 맞춰 만 단위로 변경 -->
											<td><%=String.format("%.2f", Y_achSale.get(teamList2.get(key)) * 100)%></td>
											<%
												}
											%>
										</tr>
										<tr id="totalSaleCMS">
											<td style="word-break: keep-all;">총 수입(매출보정)</td>
											<td><%=String.format("%.2f", totalCmsY * 100)%></td>
											<%
												for (int key : teamList2.keySet()) {
											%>
											
											<!-- 지출에 맞춰 만 단위로 변경 -->
											<td><%=String.format("%.2f", cmsRate.get(2).get(teamList2.get(key)) * 100)%></td>
											<%
												}
											%>
										</tr>
										<tr id="total">
											<td>총 지출</td>
											<td><%=String.format("%.2f", totalSum2)%></td>
										</tr>
										<tr>
											<td>총 수익</td>
											<!-- 총 지출 빼야함 -->
											<td><%=String.format("%.2f",totalCmsY * 100-totalSum2)%></td>
											
											<%
												for (int i = 0; i < teamList.size(); i++) {
											%>
											<td><%=String.format("%.2f",cmsRate.get(2).get(teamList2.get(i)) * 100 - total_sum[i])%></td>
												<%}%>
											</tr>
									</tbody>
								</table>
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