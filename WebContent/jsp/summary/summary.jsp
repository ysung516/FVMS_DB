<%@page import="jsp.DB.method.SummaryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.io.PrintWriter"
    import = "jsp.sheet.method.*"
    import = "jsp.Bean.model.*"
    import = "java.util.ArrayList"
    import = "java.awt.Color" 
    import="java.util.Date"
    import="java.text.SimpleDateFormat"
    %>
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
	
	SummaryDAO summaryDao = new SummaryDAO();
	ArrayList<StateOfProBean> saleTeamList = summaryDao.StateProjectNum_sales();
	ArrayList<StateOfProBean> orderTeamList = summaryDao.StateProjectNum_order();
	ArrayList<ProjectBean> pjList = summaryDao.getProjectList();
	
	ArrayList<String> teamNameList = new ArrayList<String>(); 
	ArrayList<TeamBean> teamList = summaryDao.getTagetData();
	StateOfProBean ST = new StateOfProBean();
	StateOfProBean ST2 = new StateOfProBean();
	
	// 프로젝트 현황
	int totalY2=0;
	int totalY3=0;
	int totalY4=0;
	int totalY5=0;
	int totalY6=0;
	int totalY7=0;
	int totalY8=0;
	
	// 상반기 예상 수주
	float FH_chassis_ORDER = 0; 
	float FH_body_ORDER = 0;
	float FH_control_ORDER = 0; 
	float FH_safe_ORDER = 0;
	float FH_auto_ORDER = 0;
	float FH_vt_ORDER = 0;
	float FH_total_ORDER = 0;
	
	// 하반기 예상 수주
	float SH_chassis_ORDER = 0; 
	float SH_body_ORDER = 0;
	float SH_control_ORDER = 0; 
	float SH_safe_ORDER = 0;
	float SH_auto_ORDER = 0;
	float SH_vt_ORDER = 0;
	float SH_total_ORDER = 0;
	
	// 상반기 수주 달성
	float FH_chassis_RPJ = 0;
	float FH_body_RPJ = 0;
	float FH_control_RPJ = 0;
	float FH_safe_RPJ = 0;
	float FH_auto_RPJ = 0;
	float FH_vt_RPJ = 0;
	float FH_total_RPJ = 0;
	
	// 하반기 수주 달성
	float SH_chassis_RPJ = 0;
	float SH_body_RPJ = 0;
	float SH_control_RPJ = 0;
	float SH_safe_RPJ = 0;
	float SH_auto_RPJ = 0;
	float SH_vt_RPJ = 0;
	float SH_total_RPJ = 0;
	
	// 상반기 예상 매출
	float FH_chassis_PJSALES = 0;
	float FH_body_PJSALES = 0;
	float FH_control_PJSALES = 0;
	float FH_safe_PJSALES = 0;
	float FH_auto_PJSALES = 0;
	float FH_vt_PJSALES = 0;
	float FH_total_PJSALES = 0;

	// 하반기 예상 매출
	float SH_chassis_PJSALES = 0;
	float SH_body_PJSALES = 0;
	float SH_control_PJSALES = 0;
	float SH_safe_PJSALES = 0;
	float SH_auto_PJSALES = 0;
	float SH_vt_PJSALES = 0;
	float SH_total_PJSALES = 0;
	
	// 상반기 매출 달성
	float FH_chassis_RSALES = 0;
	float FH_body_RSALES = 0;
	float FH_control_RSALES = 0;
	float FH_safe_RSALES = 0;
	float FH_auto_RSALES = 0;
	float FH_vt_RSALES = 0;
	float FH_total_RSALES = 0;
	
	// 하반기 매출 달성
	float SH_chassis_RSALES = 0;
	float SH_body_RSALES = 0;
	float SH_control_RSALES = 0;
	float SH_safe_RSALES = 0;
	float SH_auto_RSALES = 0;
	float SH_vt_RSALES = 0;
	float SH_total_RSALES = 0;
	
	// 수주 & 매출 관련 변수
	for(int i=0; i<teamList.size(); i++){
		teamNameList.add(i, teamList.get(i).getTeamName()); 		
	}
	
	int target = teamNameList.indexOf("샤시힐스검증팀");
	int target1 = teamNameList.indexOf("바디힐스검증팀");
	int target2 = teamNameList.indexOf("제어로직검증팀");
	int target3 = teamNameList.indexOf("기능안전검증팀");
	int target4 = teamNameList.indexOf("자율주행검증팀");
	int target5 = teamNameList.indexOf("미래차검증전략실");

	
	// 상반기 목표 수주,매출
	float FH_chassis_PJ = teamList.get(target).getFH_targetOrder();
	float FH_body_PJ = teamList.get(target1).getFH_targetOrder();
	float FH_control_PJ = teamList.get(target2).getFH_targetOrder();
	float FH_safe_PJ = teamList.get(target3).getFH_targetOrder();
	float FH_auto_PJ = teamList.get(target4).getFH_targetOrder();
	float FH_vt_PJ = teamList.get(target5).getFH_targetOrder();
	float FH_total_PJ = FH_chassis_PJ + FH_body_PJ + FH_control_PJ + FH_safe_PJ + FH_auto_PJ + FH_vt_PJ;
	
	float FH_chassis_SALES = teamList.get(target).getFH_targetSales();
	float FH_body_SALES = teamList.get(target1).getFH_targetSales();
	float FH_control_SALES = teamList.get(target2).getFH_targetSales();
	float FH_safe_SALES = teamList.get(target3).getFH_targetSales();
	float FH_auto_SALES = teamList.get(target4).getFH_targetSales();
	float FH_vt_SALES = teamList.get(target5).getFH_targetSales();
	float FH_total_SALES = FH_chassis_SALES + FH_body_SALES + FH_control_SALES + FH_safe_SALES + FH_auto_SALES + FH_vt_SALES;
	

	// 하반기 목표수주,매출
	float SH_chassis_PJ = teamList.get(target).getSH_targetOrder();
	float SH_body_PJ = teamList.get(target1).getSH_targetOrder();
	float SH_control_PJ = teamList.get(target2).getSH_targetOrder();
	float SH_safe_PJ = teamList.get(target3).getSH_targetOrder();
	float SH_auto_PJ = teamList.get(target4).getSH_targetOrder();
	float SH_vt_PJ = teamList.get(target5).getSH_targetOrder();
	float SH_total_PJ = SH_chassis_PJ + SH_body_PJ + SH_control_PJ + SH_safe_PJ + SH_auto_PJ + SH_vt_PJ;
	
	float SH_chassis_SALES = teamList.get(target).getSH_targetSales();
	float SH_body_SALES = teamList.get(target1).getSH_targetSales();
	float SH_control_SALES = teamList.get(target2).getSH_targetSales();
	float SH_safe_SALES = teamList.get(target3).getSH_targetSales();
	float SH_auto_SALES = teamList.get(target4).getSH_targetSales();
	float SH_vt_SALES = teamList.get(target5).getSH_targetSales();
	float SH_total_SALES = SH_chassis_SALES + SH_body_SALES + SH_control_SALES + SH_safe_SALES + SH_auto_SALES + SH_vt_SALES;
	
	// 연간
	float Y_chassis_PJ = FH_chassis_PJ + SH_chassis_PJ;
	float Y_body_PJ = FH_body_PJ + SH_body_PJ;
	float Y_control_PJ = FH_control_PJ + SH_control_PJ;
	float Y_safe_PJ = FH_safe_PJ + SH_safe_PJ;
	float Y_auto_PJ = FH_auto_PJ + SH_auto_PJ;
	float Y_vt_PJ = FH_vt_PJ + SH_vt_PJ;
	float Y_total_pj = FH_total_PJ + SH_total_PJ;
	
	float Y_chassis_SALES = FH_chassis_SALES + SH_chassis_SALES;
	float Y_body_SALES = FH_body_SALES + SH_body_SALES;
	float Y_control_SALES = FH_control_SALES + SH_control_SALES;
	float Y_safe_SALES = FH_safe_SALES + SH_safe_SALES;
	float Y_auto_SALES = FH_auto_SALES + SH_auto_SALES;
	float Y_vt_SALES = FH_vt_SALES + SH_vt_SALES;
	float Y_total_SALES = FH_total_SALES + SH_total_SALES;

	
	for(int i=0; i<pjList.size(); i++){
		if(pjList.get(i).getTEAM_ORDER().equals("샤시힐스검증팀")){
			FH_chassis_ORDER += pjList.get(i).getFH_ORDER_PROJECTIONS();
			FH_chassis_RPJ += pjList.get(i).getFH_ORDER();
			SH_chassis_ORDER += pjList.get(i).getSH_ORDER_PROJECTIONS();
			SH_chassis_RPJ += pjList.get(i).getSH_ORDER();
		} else if(pjList.get(i).getTEAM_ORDER().equals("바디힐스검증팀")){
			FH_body_ORDER += pjList.get(i).getFH_ORDER_PROJECTIONS();
			FH_body_RPJ += pjList.get(i).getFH_ORDER();
			SH_body_ORDER += pjList.get(i).getSH_ORDER_PROJECTIONS();
			SH_body_RPJ += pjList.get(i).getSH_ORDER();
			
		} else if(pjList.get(i).getTEAM_ORDER().equals("제어로직검증팀")){
			FH_control_ORDER += pjList.get(i).getFH_ORDER_PROJECTIONS();
			FH_control_RPJ += pjList.get(i).getFH_ORDER();
			SH_control_ORDER += pjList.get(i).getSH_ORDER_PROJECTIONS();
			SH_control_RPJ += pjList.get(i).getSH_ORDER();
			
		} else if(pjList.get(i).getTEAM_ORDER().equals("기능안전검증팀")){
			FH_safe_ORDER += pjList.get(i).getFH_ORDER_PROJECTIONS();
			FH_safe_RPJ += pjList.get(i).getFH_ORDER();
			SH_safe_ORDER += pjList.get(i).getSH_ORDER_PROJECTIONS();
			SH_safe_RPJ += pjList.get(i).getSH_ORDER();	
		} else if(pjList.get(i).getTEAM_ORDER().equals("자율주행검증팀")){
			FH_auto_ORDER += pjList.get(i).getFH_ORDER_PROJECTIONS();
			FH_auto_RPJ += pjList.get(i).getFH_ORDER();
			SH_auto_ORDER += pjList.get(i).getSH_ORDER_PROJECTIONS();
			SH_auto_RPJ += pjList.get(i).getSH_ORDER();
			
		} else if(pjList.get(i).getTEAM_SALES().equals("미래차검증전략실")){
			FH_vt_ORDER += pjList.get(i).getFH_ORDER_PROJECTIONS();
			FH_vt_RPJ += pjList.get(i).getFH_ORDER();
			SH_vt_ORDER += pjList.get(i).getSH_ORDER_PROJECTIONS();
			SH_vt_RPJ += pjList.get(i).getSH_ORDER();
		}
	}
	for(int i=0; i<pjList.size(); i++){
		if(pjList.get(i).getTEAM_SALES().equals("샤시힐스검증팀")){
			FH_chassis_PJSALES += pjList.get(i).getFH_SALES_PROJECTIONS();
			FH_chassis_RSALES += pjList.get(i).getFH_SALES();
			SH_chassis_PJSALES += pjList.get(i).getSH_SALES_PROJECTIONS();
			SH_chassis_RSALES += pjList.get(i).getSH_SALES();
			
		} else if(pjList.get(i).getTEAM_SALES().equals("바디힐스검증팀")){
			FH_body_PJSALES += pjList.get(i).getFH_SALES_PROJECTIONS();
			FH_body_RSALES += pjList.get(i).getFH_SALES();
			SH_body_PJSALES += pjList.get(i).getSH_SALES_PROJECTIONS();
			SH_body_RSALES += pjList.get(i).getSH_SALES();
		} else if(pjList.get(i).getTEAM_SALES().equals("제어로직검증팀")){
			FH_control_PJSALES += pjList.get(i).getFH_SALES_PROJECTIONS();
			FH_control_RSALES += pjList.get(i).getFH_SALES();
			SH_control_PJSALES += pjList.get(i).getSH_SALES_PROJECTIONS();
			SH_control_RSALES += pjList.get(i).getSH_SALES();
			
		} else if(pjList.get(i).getTEAM_SALES().equals("기능안전검증팀")){
			FH_safe_PJSALES += pjList.get(i).getFH_SALES_PROJECTIONS();
			FH_safe_RSALES += pjList.get(i).getFH_SALES();
			SH_safe_PJSALES += pjList.get(i).getSH_SALES_PROJECTIONS();
			SH_safe_RSALES += pjList.get(i).getSH_SALES();
		} else if(pjList.get(i).getTEAM_SALES().equals("자율주행검증팀")){
			FH_auto_PJSALES += pjList.get(i).getFH_SALES_PROJECTIONS();
			FH_auto_RSALES += pjList.get(i).getFH_SALES();
			SH_auto_PJSALES += pjList.get(i).getSH_SALES_PROJECTIONS();
			SH_auto_RSALES += pjList.get(i).getSH_SALES();
			
		} else if(pjList.get(i).getTEAM_SALES().equals("미래차검증전략실")){
			FH_vt_PJSALES += pjList.get(i).getFH_SALES_PROJECTIONS();
			FH_vt_RSALES += pjList.get(i).getFH_SALES();
			SH_vt_PJSALES += pjList.get(i).getSH_SALES_PROJECTIONS();
			SH_vt_RSALES += pjList.get(i).getSH_SALES();
		}
	}
	

	FH_total_ORDER = FH_chassis_ORDER + FH_body_ORDER + FH_control_ORDER + FH_safe_ORDER + FH_auto_ORDER + FH_vt_ORDER;
	SH_total_ORDER = SH_chassis_ORDER + SH_body_ORDER + SH_control_ORDER + SH_safe_ORDER + SH_auto_ORDER + SH_vt_ORDER;
	FH_total_RPJ = FH_chassis_RPJ + FH_body_RPJ + FH_control_RPJ + FH_safe_RPJ + FH_auto_RPJ + FH_vt_RPJ;
	SH_total_RPJ = SH_chassis_RPJ + SH_body_RPJ + SH_control_RPJ + SH_safe_RPJ + SH_auto_RPJ + SH_vt_RPJ;
	FH_total_PJSALES = FH_chassis_PJSALES + FH_body_PJSALES + FH_control_PJSALES + FH_safe_PJSALES + FH_auto_PJSALES + FH_vt_PJSALES;
	SH_total_PJSALES = SH_chassis_PJSALES + SH_body_PJSALES + SH_control_PJSALES + SH_safe_PJSALES + SH_auto_PJSALES + SH_vt_PJSALES;
	FH_total_RSALES = FH_chassis_RSALES + FH_body_RSALES + FH_control_RSALES + FH_safe_RSALES + FH_auto_RSALES + FH_vt_RSALES;
	SH_total_RSALES = SH_chassis_RSALES + SH_body_RSALES + SH_control_RSALES + SH_safe_RSALES + SH_auto_RSALES + SH_vt_RSALES;
	
	//연간 예상 수주
	float Y_chassis_ORDER = FH_chassis_ORDER + SH_chassis_ORDER;
	float Y_body_ORDER = FH_body_ORDER + SH_body_ORDER;
	float Y_control_ORDER = FH_control_ORDER + SH_control_ORDER;
	float Y_safe_ORDER = FH_safe_ORDER + SH_safe_ORDER;
	float Y_auto_ORDER = FH_auto_ORDER + SH_auto_ORDER;
	float Y_vt_ORDER = FH_vt_ORDER + SH_vt_ORDER;
	float Y_total_ORDER = FH_total_ORDER + SH_total_ORDER;
	
	//연간 수주 달성
	float Y_chassis_RPJ = FH_chassis_RPJ + SH_chassis_RPJ;
	float Y_body_RPJ = FH_body_RPJ + SH_body_RPJ;
	float Y_control_RPJ = FH_control_RPJ + SH_control_RPJ;
	float Y_safe_RPJ = FH_safe_RPJ + SH_safe_RPJ;
	float Y_auto_RPJ = FH_auto_RPJ + SH_auto_RPJ;
	float Y_vt_RPJ = FH_vt_RPJ + SH_vt_RPJ;
	float Y_total_RPJ = FH_total_RPJ + SH_total_RPJ;
	
	//연간 예상 매출
	float Y_chassis_PJSALES = FH_chassis_PJSALES + SH_chassis_PJSALES;
	float Y_body_PJSALES = FH_body_PJSALES + SH_body_PJSALES;
	float Y_control_PJSALES = FH_control_PJSALES + SH_control_PJSALES;
	float Y_safe_PJSALES = FH_safe_PJSALES + SH_safe_PJSALES;
	float Y_auto_PJSALES = FH_auto_PJSALES + SH_auto_PJSALES;
	float Y_vt_PJSALES = FH_vt_PJSALES + SH_vt_PJSALES;
	float Y_total_PJSALES = FH_total_PJSALES + SH_total_PJSALES;
	
	//연간 매출 달성
	float Y_chassis_RSALES = FH_chassis_RSALES + SH_chassis_RSALES;
	float Y_body_RSALES = FH_body_RSALES + SH_body_RSALES;
	float Y_control_RSALES = FH_control_RSALES + SH_control_RSALES;
	float Y_safe_RSALES = FH_safe_RSALES + SH_safe_RSALES;
	float Y_auto_RSALES = FH_auto_RSALES + SH_auto_RSALES;
	float Y_vt_RSALES = FH_vt_RSALES + SH_vt_RSALES;
	float Y_total_RSALES = FH_total_RSALES + SH_total_RSALES;
%>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1" />
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - Summary</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css" rel="stylesheet"type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<style>
.google-visualization-tooltip{
		
		
	} 

.chart{
	width:50% !important;
}
#content{
	margin-left:90px;
}
	.sidebar{
		position:fixed;
		z-index:9999;
	}
	
	.pie{
		height:350px;
		width:500px;
	}
	.table td{
		padding:0.2rem;
		font-weight:bold !important;
	}
	.fh_tr{
		background-color:#f2f3bbb0;
	}
	.sh_tr{
	text-align:center;
	background-color:#e4c4266b;
	}
	.y_tr{
	text-align:center;
	background-color:#eaa55085;
	}
	ul.tabs{
	margin: 0px;
	padding: 0px;
	list-style: none;
}
ul.tabs li{
	background: none;
	color: #222;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
}
ul.tabs li:hover {
	  font-weight:bold;
	}

ul.tabs li.current{
	border-bottom:3px solid #5bb8e4ad;
	background-color:#00a1ff36;
	border:1px soid #ededed;
	color: #222;
}

.tab-content{
	display: none;
	padding: 15px;
}

.tab-content.current{
	display: inherit;
}

	.table-responsive{
	table-layout:fixed;
	 display:table;
	}
	
	table{ 
	white-space: nowrap;
	display:table-cell;
	overflow:auto;
	 white-space: nowrap;
	}
	
	@media(max-width:765px){
	.container-fluid{
	margin-top`
	}
	.chart{
	width:100% !important;
}
	#content{
	margin-left:0;
	}
	
	.topbar{
		z-index:999;
		position:fixed;
		width:100%;
		}
		.card-body{
			padding:0px;
		}
		.pie{
		height:100%;
		width:100%;
	}
		.container-fluid{
			padding: 0;
		}
		.card-header:first-child{
			padding: 0;
		}
		
		body{
		font-size:small;}
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
	td{
		text-align : center;
	}
	.sale{
		width : 65px;
	}

	.chart{		
  	width: 100%; 
	}
	
	button {
	  background:none;
	  border:0;
	  outline:0;
	  cursor:pointer;
	}
	.tootipTable td {
		padding: 7px;
		text-align: left;
	} 
	
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.0.min.js" ></script>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  
    
    /* 막대 차트 */
      google.charts.load('current', {'packages':['corechart', 'bar']});
      google.charts.setOnLoadCallback(fh_order);
      google.charts.setOnLoadCallback(fh_sales);
      google.charts.setOnLoadCallback(sh_order);
      google.charts.setOnLoadCallback(sh_sales);
      google.charts.setOnLoadCallback(y_order);
      google.charts.setOnLoadCallback(y_sales);
      
    
      function fh_order() {
    	  <%
	    	  StringBuffer FH_chassis_project_pj = new StringBuffer();
			  StringBuffer FH_body_project_pj = new StringBuffer();
			  StringBuffer FH_control_project_pj = new StringBuffer();
			  StringBuffer FH_safe_project_pj = new StringBuffer();
			  StringBuffer FH_auto_project_pj = new StringBuffer();
			  
			  FH_chassis_project_pj.append("<table class=tootipTable>");
			  FH_chassis_project_pj.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
			  
			  FH_body_project_pj.append("<table class=tootipTable>");
			  FH_body_project_pj.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
			  
			  FH_control_project_pj.append("<table class=tootipTable>");
			  FH_control_project_pj.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
			  
			  FH_safe_project_pj.append("<table class=tootipTable>");
			  FH_safe_project_pj.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
			  
			  FH_auto_project_pj.append("<table class=tootipTable>");
			  FH_auto_project_pj.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
			  
			  for(int i=0; i<pjList.size(); i++){
			  		if(pjList.get(i).getTEAM_ORDER().equals("샤시힐스검증팀")){
			  			FH_chassis_project_pj.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
			  				+pjList.get(i).getFH_ORDER_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_ORDER()+"</td></tr>");
			  		}
			  		else if(pjList.get(i).getTEAM_ORDER().equals("바디힐스검증팀")){
			  			FH_body_project_pj.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
				  				+pjList.get(i).getFH_ORDER_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_ORDER()+"</td></tr>");
			  		}
			  		else if(pjList.get(i).getTEAM_ORDER().equals("제어로직검증팀")){
			  			FH_control_project_pj.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
				  				+pjList.get(i).getFH_ORDER_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_ORDER()+"</td></tr>");
			  		}
			  		else if(pjList.get(i).getTEAM_ORDER().equals("기능안전검증팀")){
			  			FH_safe_project_pj.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
				  				+pjList.get(i).getFH_ORDER_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_ORDER()+"</td></tr>");
			  		}
			  		else if(pjList.get(i).getTEAM_ORDER().equals("자율주행검증팀")){
			  			FH_auto_project_pj.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
				  				+pjList.get(i).getFH_ORDER_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_ORDER()+"</td></tr>");
			  		}
			  	}
			  
			  FH_chassis_project_pj.append("<tr><td>total</td><td>"+FH_chassis_ORDER+"</td><td>"+FH_chassis_RPJ+"</td></tr>");
			  FH_chassis_project_pj.append("<tr><td colspan=3>목표수주 : "+FH_chassis_PJ+" (백만)</td></tr>");
			  FH_chassis_project_pj.append("</table>");
			  
			  FH_body_project_pj.append("<tr><td>total</td><td>"+FH_body_ORDER+"</td><td>"+FH_body_RPJ+"</td></tr>");
			  FH_body_project_pj.append("<tr><td colspan=3>목표수주 : "+FH_body_PJ+" (백만)</td></tr>");
			  FH_body_project_pj.append("</table>");
			  
			  FH_control_project_pj.append("<tr><td>total</td><td>"+FH_control_ORDER+"</td><td>"+FH_control_RPJ+"</td></tr>");
			  FH_control_project_pj.append("<tr><td colspan=3>목표수주 : "+FH_control_PJ+" (백만)</td></tr>");
			  FH_control_project_pj.append("</table>");
			  
			  FH_safe_project_pj.append("<tr><td>total</td><td>"+FH_safe_ORDER+"</td><td>"+FH_safe_RPJ+"</td></tr>");
			  FH_safe_project_pj.append("<tr><td colspan=3>목표수주 : "+FH_safe_PJ+" (백만)</td></tr>");
			  FH_safe_project_pj.append("</table>");
			  
			  FH_auto_project_pj.append("<tr><td>total</td><td>"+FH_auto_ORDER+"</td><td>"+FH_auto_RPJ+"</td></tr>");
			  FH_auto_project_pj.append("<tr><td colspan=3>목표수주 : "+FH_auto_PJ+" (백만)</td></tr>");
			  FH_auto_project_pj.append("</table>");
	 	 %>
  
		  // 목표
		  var total_str = '<table class=tootipTable><tr><td>팀</td><td>목표수주</td><td>예상수주</td><td>수주달성</td></tr>';
		  		total_str += '<tr><td>샤시힐스</td><td>'+<%=FH_chassis_PJ%>+'</td><td>'+<%=FH_chassis_ORDER%>+'</td><td>'+<%=FH_chassis_RPJ%>+'</td></tr>';
		  		total_str += '<tr><td>바디힐스</td><td>'+<%=FH_body_PJ%>+'</td><td>'+<%=FH_body_ORDER%>+'</td><td>'+<%=FH_body_RPJ%>+'</td></tr>';
		  		total_str += '<tr><td>제어로직</td><td>'+<%=FH_control_PJ%>+'</td><td>'+<%=FH_control_ORDER%>+'</td><td>'+<%=FH_control_RPJ%>+'</td></tr>';
		  		total_str += '<tr><td>기능안전</td><td>'+<%=FH_safe_PJ%>+'</td><td>'+<%=FH_safe_ORDER%>+'</td><td>'+<%=FH_safe_RPJ%>+'</td></tr>';
		  		total_str += '<tr><td>자율주행</td><td>'+<%=FH_auto_PJ%>+'</td><td>'+<%=FH_auto_ORDER%>+'</td><td>'+<%=FH_auto_RPJ%>+'</td></tr>';
		  		total_str += '<tr><td>total</td><td>'+<%=FH_total_PJ%>+'</td><td>'+<%=FH_total_ORDER%>+'</td><td>'+<%=FH_total_RPJ%>+'</td></tr></table>';
		  		
          var dataTable = new google.visualization.DataTable();
          dataTable.addColumn('string', 'Team');
          dataTable.addColumn('number', '목표수주');
          dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
          dataTable.addColumn('number', '예상수주');
          dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
          dataTable.addColumn('number', '수주달성');
          dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
          dataTable.addRows([
        	  ['Total', <%=FH_total_PJ%>, total_str, <%=FH_total_ORDER%>, total_str, <%=FH_total_RPJ%>, total_str],
              ['샤시힐스', <%=FH_chassis_PJ%>,'<%=FH_chassis_project_pj%>',<%=FH_chassis_ORDER%>,'<%=FH_chassis_project_pj%>', <%=FH_chassis_RPJ%>, '<%=FH_chassis_project_pj%>'],
              ['바디힐스', <%=FH_body_PJ%>,'<%=FH_body_project_pj%>',<%=FH_body_ORDER%>,'<%=FH_body_project_pj%>', <%=FH_body_RPJ%>, '<%=FH_body_project_pj%>'],
              ['제어로직', <%=FH_control_PJ%>,'<%=FH_control_project_pj%>',<%=FH_control_ORDER%>,'<%=FH_control_project_pj%>', <%=FH_control_RPJ%>, '<%=FH_control_project_pj%>'],
              ['기능안전', <%=FH_safe_PJ%>,'<%=FH_safe_project_pj%>',<%=FH_safe_ORDER%>,'<%=FH_safe_project_pj%>', <%=FH_safe_RPJ%>, '<%=FH_safe_project_pj%>'],
              ['자율주행', <%=FH_auto_PJ%>,'<%=FH_auto_project_pj%>',<%=FH_auto_ORDER%>,'<%=FH_auto_project_pj%>', <%=FH_auto_RPJ%>, '<%=FH_auto_project_pj%>']
          ]);
          
          var fh_order_option = { 
          		title: '상반기 수주', 
          		width: '80%',
                height: 500,
                legend: {
                	position: 'left',
                	alignment: 'start' 
                	},
                tooltip:{
                	isHtml: true},

                series: {
                    0: { color: '#d4fc79' },
                    1: { color: '#84fab0' },
                    2: { color: '#96e6a1' }
                  }
          };

          var fh_order_chart = new google.visualization.ColumnChart(document.getElementById('fh_order_chart'));

          fh_order_chart.draw(dataTable, fh_order_option);
      }
 	
 function fh_sales() {

	      <%
		  	StringBuffer FH_chassis_project_Sales = new StringBuffer();
		  	StringBuffer FH_body_project_Sales = new StringBuffer();
		  	StringBuffer FH_control_project_Sales = new StringBuffer();
		  	StringBuffer FH_safe_project_Sales = new StringBuffer();
		  	StringBuffer FH_auto_project_Sales = new StringBuffer();
		  	
		  	FH_chassis_project_Sales.append("<table class=tootipTable>");
		  	FH_chassis_project_Sales.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
			  
		  	FH_body_project_Sales.append("<table class=tootipTable>");
		  	FH_body_project_Sales.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
			  
		  	FH_control_project_Sales.append("<table class=tootipTable>");
		  	FH_control_project_Sales.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
			  
		  	FH_safe_project_Sales.append("<table class=tootipTable>");
		  	FH_safe_project_Sales.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
			  
		  	FH_auto_project_Sales.append("<table class=tootipTable>");
		  	FH_auto_project_Sales.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
			  
			  	
			  	for(int i=0; i<pjList.size(); i++){
			  		if(pjList.get(i).getTEAM_SALES().equals("샤시힐스검증팀")){
			  			FH_chassis_project_Sales.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
				  				+pjList.get(i).getFH_SALES_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_SALES()+"</td></tr>");
			  		}
			  		else if(pjList.get(i).getTEAM_ORDER().equals("바디힐스검증팀")){
			  			FH_body_project_Sales.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
				  				+pjList.get(i).getFH_SALES_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_SALES()+"</td></tr>");
			  		}
			  		else if(pjList.get(i).getTEAM_ORDER().equals("제어로직검증팀")){
			  			FH_control_project_Sales.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
				  				+pjList.get(i).getFH_SALES_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_SALES()+"</td></tr>");
			  		}
			  		else if(pjList.get(i).getTEAM_ORDER().equals("기능안전검증팀")){
			  			FH_safe_project_Sales.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
				  				+pjList.get(i).getFH_SALES_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_SALES()+"</td></tr>");
			  		}
			  		else if(pjList.get(i).getTEAM_ORDER().equals("자율주행검증팀")){
			  			FH_auto_project_Sales.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
				  				+pjList.get(i).getFH_SALES_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_SALES()+"</td></tr>");
			  		}
			  	}
			  	
			  	FH_chassis_project_Sales.append("<tr><td>total</td><td>"+FH_chassis_PJSALES+"</td><td>"+FH_chassis_RSALES+"</td></tr>");
			  	FH_chassis_project_Sales.append("<tr><td colspan=3>목표매출 : "+FH_chassis_SALES+" (백만)</td></tr>");
			  	FH_chassis_project_Sales.append("</table>");
				  
			  	FH_body_project_Sales.append("<tr><td>total</td><td>"+FH_body_PJSALES+"</td><td>"+FH_body_RSALES+"</td></tr>");
			  	FH_body_project_Sales.append("<tr><td colspan=3>목표매출 : "+FH_body_SALES+" (백만)</td></tr>");
			  	FH_body_project_Sales.append("</table>");
				  
			  	FH_control_project_Sales.append("<tr><td>total</td><td>"+FH_control_PJSALES+"</td><td>"+FH_control_RSALES+"</td></tr>");
			  	FH_control_project_Sales.append("<tr><td colspan=3>목표매출 : "+FH_control_SALES+" (백만)</td></tr>");
			  	FH_control_project_Sales.append("</table>");
				  
			  	FH_safe_project_Sales.append("<tr><td>total</td><td>"+FH_safe_PJSALES+"</td><td>"+FH_safe_RSALES+"</td></tr>");
			  	FH_safe_project_Sales.append("<tr><td colspan=3>목표매출 : "+FH_safe_SALES+" (백만)</td></tr>");
			  	FH_safe_project_Sales.append("</table>");
				  
			  	FH_auto_project_Sales.append("<tr><td>total</td><td>"+FH_auto_PJSALES+"</td><td>"+FH_auto_RSALES+"</td></tr>");
			  	FH_auto_project_Sales.append("<tr><td colspan=3>목표매출 : "+FH_auto_SALES+" (백만)</td></tr>");
			  	FH_auto_project_Sales.append("</table>");
		  %>
		  
		  // 목표
		  var total_str = '<table class=tootipTable><tr><td>팀</td><td>목표매출</td><td>예상매출</td><td>매출달성</td></tr>';
	  		total_str += '<tr><td>샤시힐스</td><td>'+<%=FH_chassis_SALES%>+'</td><td>'+<%=FH_chassis_PJSALES%>+'</td><td>'+<%=FH_chassis_RSALES%>+'</td></tr>';
	  		total_str += '<tr><td>바디힐스</td><td>'+<%=FH_body_SALES%>+'</td><td>'+<%=FH_body_PJSALES%>+'</td><td>'+<%=FH_body_RSALES%>+'</td></tr>';
	  		total_str += '<tr><td>제어로직</td><td>'+<%=FH_control_SALES%>+'</td><td>'+<%=FH_control_PJSALES%>+'</td><td>'+<%=FH_control_RSALES%>+'</td></tr>';
	  		total_str += '<tr><td>기능안전</td><td>'+<%=FH_safe_SALES%>+'</td><td>'+<%=FH_safe_PJSALES%>+'</td><td>'+<%=FH_safe_RSALES%>+'</td></tr>';
	  		total_str += '<tr><td>자율주행</td><td>'+<%=FH_auto_SALES%>+'</td><td>'+<%=FH_auto_PJSALES%>+'</td><td>'+<%=FH_auto_RSALES%>+'</td></tr>';
	  		total_str += '<tr><td>total</td><td>'+<%=FH_total_SALES%>+'</td><td>'+<%=FH_total_PJSALES%>+'</td><td>'+<%=FH_total_RSALES%>+'</td></tr></table>';
    
          var dataTable = new google.visualization.DataTable();
          dataTable.addColumn('string', 'Team');
          dataTable.addColumn('number', '목표매출');
          // A column for custom tooltip content
          dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
          dataTable.addColumn('number', '예상매출');
          // A column for custom tooltip content
          dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
          dataTable.addColumn('number', '매출달성');
          // A column for custom tooltip content
          dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
          dataTable.addRows([
        	  ['Total', <%=FH_total_SALES%>, total_str, <%=FH_total_PJSALES%>, total_str, <%=FH_total_RSALES%>, total_str],
              ['샤시힐스', <%=FH_chassis_SALES%>, '<%=FH_chassis_project_Sales%>', <%=FH_chassis_PJSALES%>, '<%=FH_chassis_project_Sales%>', <%=FH_chassis_RSALES%>, '<%=FH_chassis_project_Sales%>'],
              ['바디힐스', <%=FH_body_SALES%>, '<%=FH_body_project_Sales%>', <%=FH_body_PJSALES%>, '<%=FH_body_project_Sales%>', <%=FH_body_RSALES%>, '<%=FH_body_project_Sales%>'],
              ['제어로직', <%=FH_control_SALES%>, '<%=FH_control_project_Sales%>', <%=FH_control_PJSALES%>, '<%=FH_control_project_Sales%>', <%=FH_control_RSALES%>, '<%=FH_control_project_Sales%>'],
              ['기능안전', <%=FH_safe_SALES%>, '<%=FH_safe_project_Sales%>', <%=FH_safe_PJSALES%>, '<%=FH_safe_project_Sales%>', <%=FH_safe_RSALES%>, '<%=FH_safe_project_Sales%>'],
              ['자율주행', <%=FH_auto_SALES%>, '<%=FH_auto_project_Sales%>', <%=FH_auto_PJSALES%>, '<%=FH_auto_project_Sales%>', <%=FH_auto_RSALES%>, '<%=FH_auto_project_Sales%>']
          ]);

          var fh_sales_option = {
           
              title: '상반기 매출',
              width: '100%',
              'height': 500,
              'legend': {'position': 'bottom'},
              tooltip:{isHtml: true},
              series: {
                  0: { color: '#ffd1ff' },
                  1: { color: '#fbc2eb' },
                  2: { color: '#a18cd1' }
                }
          };

          var fh_sales_chart = new google.visualization.ColumnChart(document.getElementById('fh_sales_chart'));

          fh_sales_chart.draw(dataTable, fh_sales_option);
        }
 
 function sh_order() {	
	  // 목표
	  var total_str = '<table class=tootipTable><tr><td>팀</td><td>목표수주</td><td>예상수주</td><td>수주달성</td></tr>';
	  		total_str += '<tr><td>샤시힐스</td><td>'+<%=SH_chassis_PJ%>+'</td><td>'+<%=SH_chassis_ORDER%>+'</td><td>'+<%=SH_chassis_RPJ%>+'</td></tr>';
	  		total_str += '<tr><td>바디힐스</td><td>'+<%=SH_body_PJ%>+'</td><td>'+<%=SH_body_ORDER%>+'</td><td>'+<%=SH_body_RPJ%>+'</td></tr>';
	  		total_str += '<tr><td>제어로직</td><td>'+<%=SH_control_PJ%>+'</td><td>'+<%=SH_control_ORDER%>+'</td><td>'+<%=SH_control_RPJ%>+'</td></tr>';
	  		total_str += '<tr><td>기능안전</td><td>'+<%=SH_safe_PJ%>+'</td><td>'+<%=SH_safe_ORDER%>+'</td><td>'+<%=SH_safe_RPJ%>+'</td></tr>';
	  		total_str += '<tr><td>자율주행</td><td>'+<%=SH_auto_PJ%>+'</td><td>'+<%=SH_auto_ORDER%>+'</td><td>'+<%=SH_auto_RPJ%>+'</td></tr>';
	  		total_str += '<tr><td>total</td><td>'+<%=SH_total_PJ%>+'</td><td>'+<%=SH_total_ORDER%>+'</td><td>'+<%=SH_total_RPJ%>+'</td></tr></table>';
	  		

	<%
	  StringBuffer SH_chassis_project_pj = new StringBuffer();
	  StringBuffer SH_body_project_pj = new StringBuffer();
	  StringBuffer SH_control_project_pj = new StringBuffer();
	  StringBuffer SH_safe_project_pj = new StringBuffer();
	  StringBuffer SH_auto_project_pj = new StringBuffer();
	  
	  SH_chassis_project_pj.append("<table class=tootipTable>");
	  SH_chassis_project_pj.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
	  
	  SH_body_project_pj.append("<table class=tootipTable>");
	  SH_body_project_pj.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
	  
	  SH_control_project_pj.append("<table class=tootipTable>");
	  SH_control_project_pj.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
	  
	  SH_safe_project_pj.append("<table class=tootipTable>");
	  SH_safe_project_pj.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
	  
	  SH_auto_project_pj.append("<table class=tootipTable>");
	  SH_auto_project_pj.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
	  
	  for(int i=0; i<pjList.size(); i++){
	  		if(pjList.get(i).getTEAM_ORDER().equals("샤시힐스검증팀")){
	  			SH_chassis_project_pj.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
	  				+pjList.get(i).getSH_ORDER_PROJECTIONS()+"</td><td>"+pjList.get(i).getSH_ORDER()+"</td></tr>");
	  		}
	  		else if(pjList.get(i).getTEAM_ORDER().equals("바디힐스검증팀")){
	  			SH_body_project_pj.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
		  				+pjList.get(i).getSH_ORDER_PROJECTIONS()+"</td><td>"+pjList.get(i).getSH_ORDER()+"</td></tr>");
	  		}
	  		else if(pjList.get(i).getTEAM_ORDER().equals("제어로직검증팀")){
	  			SH_control_project_pj.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
		  				+pjList.get(i).getSH_ORDER_PROJECTIONS()+"</td><td>"+pjList.get(i).getSH_ORDER()+"</td></tr>");
	  		}
	  		else if(pjList.get(i).getTEAM_ORDER().equals("기능안전검증팀")){
	  			SH_safe_project_pj.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
		  				+pjList.get(i).getSH_ORDER_PROJECTIONS()+"</td><td>"+pjList.get(i).getSH_ORDER()+"</td></tr>");
	  		}
	  		else if(pjList.get(i).getTEAM_ORDER().equals("자율주행검증팀")){
	  			SH_auto_project_pj.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
		  				+pjList.get(i).getSH_ORDER_PROJECTIONS()+"</td><td>"+pjList.get(i).getSH_ORDER()+"</td></tr>");
	  		}
	  	}
	  
	  SH_chassis_project_pj.append("<tr><td>total</td><td>"+SH_chassis_ORDER+"</td><td>"+SH_chassis_RPJ+"</td></tr>");
	  SH_chassis_project_pj.append("<tr><td colspan=3>목표수주 : "+SH_chassis_PJ+" (백만)</td></tr>");
	  SH_chassis_project_pj.append("</table>");
	  
	  SH_body_project_pj.append("<tr><td>total</td><td>"+SH_body_ORDER+"</td><td>"+SH_body_RPJ+"</td></tr>");
	  SH_body_project_pj.append("<tr><td colspan=3>목표수주 : "+SH_body_PJ+" (백만)</td></tr>");
	  SH_body_project_pj.append("</table>");
	  
	  SH_control_project_pj.append("<tr><td>total</td><td>"+SH_control_ORDER+"</td><td>"+SH_control_RPJ+"</td></tr>");
	  SH_control_project_pj.append("<tr><td colspan=3>목표수주 : "+SH_control_PJ+" (백만)</td></tr>");
	  SH_control_project_pj.append("</table>");
	  
	  SH_safe_project_pj.append("<tr><td>total</td><td>"+SH_safe_ORDER+"</td><td>"+SH_safe_RPJ+"</td></tr>");
	  SH_safe_project_pj.append("<tr><td colspan=3>목표수주 : "+SH_safe_PJ+" (백만)</td></tr>");
	  SH_safe_project_pj.append("</table>");
	  
	  SH_auto_project_pj.append("<tr><td>total</td><td>"+SH_auto_ORDER+"</td><td>"+SH_auto_RPJ+"</td></tr>");
	  SH_auto_project_pj.append("<tr><td colspan=3>목표수주 : "+SH_auto_PJ+" (백만)</td></tr>");
	  SH_auto_project_pj.append("</table>");
	  
	%>
	    
     var dataTable = new google.visualization.DataTable();
     dataTable.addColumn('string', 'Team');
     dataTable.addColumn('number', '목표수주');
     // A column for custom tooltip content
	dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
     dataTable.addColumn('number', '예상수주');
     // A column for custom tooltip content
	dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
     dataTable.addColumn('number', '수주달성');
     // A column for custom tooltip content
	dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});	
     dataTable.addRows([
    	 ['Total', <%=SH_total_PJ%>, total_str, <%=SH_total_ORDER%>, total_str, <%=SH_total_RPJ%>, total_str],
         ['샤시힐스', <%=SH_chassis_PJ%>,'<%=SH_chassis_project_pj%>',<%=SH_chassis_ORDER%>,'<%=SH_chassis_project_pj%>', <%=SH_chassis_RPJ%>, '<%=SH_chassis_project_pj%>'],
         ['바디힐스', <%=SH_body_PJ%>,'<%=SH_body_project_pj%>',<%=SH_body_ORDER%>,'<%=SH_body_project_pj%>', <%=SH_body_RPJ%>, '<%=SH_body_project_pj%>'],
         ['제어로직', <%=SH_control_PJ%>,'<%=SH_control_project_pj%>',<%=SH_control_ORDER%>,'<%=SH_control_project_pj%>', <%=SH_control_RPJ%>, '<%=SH_control_project_pj%>'],
         ['기능안전', <%=SH_safe_PJ%>,'<%=SH_safe_project_pj%>',<%=SH_safe_ORDER%>,'<%=SH_safe_project_pj%>', <%=SH_safe_RPJ%>, '<%=SH_safe_project_pj%>'],
         ['자율주행', <%=SH_auto_PJ%>,'<%=SH_auto_project_pj%>',<%=SH_auto_ORDER%>,'<%=SH_auto_project_pj%>', <%=SH_auto_RPJ%>, '<%=SH_auto_project_pj%>']
     ]);

     var sh_order_option = { 
     		title: '하반기 수주',
     		width: '100%',
            'height': 500,
            'legend': {'position': 'bottom'},
            tooltip:{isHtml: true},
            series: {
            	 0: { color: '#d4fc79' },
                 1: { color: '#84fab0' },
                 2: { color: '#96e6a1' }
              }
     };

     var sh_order_chart = new google.visualization.ColumnChart(document.getElementById('sh_order_chart'));

     sh_order_chart.draw(dataTable, sh_order_option);
   }
   
function sh_sales() {

      <%
	  	StringBuffer SH_chassis_project_Sales = new StringBuffer();
	  	StringBuffer SH_body_project_Sales = new StringBuffer();
	  	StringBuffer SH_control_project_Sales = new StringBuffer();
	  	StringBuffer SH_safe_project_Sales = new StringBuffer();
	  	StringBuffer SH_auto_project_Sales = new StringBuffer();
	  	
	  	SH_chassis_project_Sales.append("<table class=tootipTable>");
	  	SH_chassis_project_Sales.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
		  
	  	SH_body_project_Sales.append("<table class=tootipTable>");
	  	SH_body_project_Sales.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
		  
	  	SH_control_project_Sales.append("<table class=tootipTable>");
	  	SH_control_project_Sales.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
		  
	  	SH_safe_project_Sales.append("<table class=tootipTable>");
	  	SH_safe_project_Sales.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
		  
	  	SH_auto_project_Sales.append("<table class=tootipTable>");
	  	SH_auto_project_Sales.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
		  
		  	
		  	for(int i=0; i<pjList.size(); i++){
		  		if(pjList.get(i).getTEAM_SALES().equals("샤시힐스검증팀")){
		  			SH_chassis_project_Sales.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
			  				+pjList.get(i).getSH_SALES_PROJECTIONS()+"</td><td>"+pjList.get(i).getSH_SALES()+"</td></tr>");
		  		}
		  		else if(pjList.get(i).getTEAM_ORDER().equals("바디힐스검증팀")){
		  			SH_body_project_Sales.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
			  				+pjList.get(i).getSH_SALES_PROJECTIONS()+"</td><td>"+pjList.get(i).getSH_SALES()+"</td></tr>");
		  		}
		  		else if(pjList.get(i).getTEAM_ORDER().equals("제어로직검증팀")){
		  			SH_control_project_Sales.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
			  				+pjList.get(i).getSH_SALES_PROJECTIONS()+"</td><td>"+pjList.get(i).getSH_SALES()+"</td></tr>");
		  		}
		  		else if(pjList.get(i).getTEAM_ORDER().equals("기능안전검증팀")){
		  			SH_safe_project_Sales.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
			  				+pjList.get(i).getSH_SALES_PROJECTIONS()+"</td><td>"+pjList.get(i).getSH_SALES()+"</td></tr>");
		  		}
		  		else if(pjList.get(i).getTEAM_ORDER().equals("자율주행검증팀")){
		  			SH_auto_project_Sales.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
			  				+pjList.get(i).getSH_SALES_PROJECTIONS()+"</td><td>"+pjList.get(i).getSH_SALES()+"</td></tr>");
		  		}
		  	}
		  	
		  	SH_chassis_project_Sales.append("<tr><td>total</td><td>"+SH_chassis_PJSALES+"</td><td>"+SH_chassis_RSALES+"</td></tr>");
		  	SH_chassis_project_Sales.append("<tr><td colspan=3>목표매출 : "+SH_chassis_SALES+" (백만)</td></tr>");
		  	SH_chassis_project_Sales.append("</table>");
			  
		  	SH_body_project_Sales.append("<tr><td>total</td><td>"+SH_body_PJSALES+"</td><td>"+SH_body_RSALES+"</td></tr>");
		  	SH_body_project_Sales.append("<tr><td colspan=3>목표매출 : "+SH_body_SALES+" (백만)</td></tr>");
		  	SH_body_project_Sales.append("</table>");
			  
		  	SH_control_project_Sales.append("<tr><td>total</td><td>"+SH_control_PJSALES+"</td><td>"+SH_control_RSALES+"</td></tr>");
		  	SH_control_project_Sales.append("<tr><td colspan=3>목표매출 : "+SH_control_SALES+" (백만)</td></tr>");
		  	SH_control_project_Sales.append("</table>");
			  
		  	SH_safe_project_Sales.append("<tr><td>total</td><td>"+SH_safe_PJSALES+"</td><td>"+SH_safe_RSALES+"</td></tr>");
		  	SH_safe_project_Sales.append("<tr><td colspan=3>목표매출 : "+SH_safe_SALES+" (백만)</td></tr>");
		  	SH_safe_project_Sales.append("</table>");
			  
		  	SH_auto_project_Sales.append("<tr><td>total</td><td>"+SH_auto_PJSALES+"</td><td>"+SH_auto_RSALES+"</td></tr>");
		  	SH_auto_project_Sales.append("<tr><td colspan=3>목표매출 : "+SH_auto_SALES+" (백만)</td></tr>");
		  	SH_auto_project_Sales.append("</table>");

	  %>
	  // 목표
	  var total_str = '<table class=tootipTable><tr><td>팀</td><td>목표매출</td><td>예상매출</td><td>매출달성</td></tr>';
  		total_str += '<tr><td>샤시힐스</td><td>'+<%=SH_chassis_SALES%>+'</td><td>'+<%=SH_chassis_PJSALES%>+'</td><td>'+<%=SH_chassis_RSALES%>+'</td></tr>';
  		total_str += '<tr><td>바디힐스</td><td>'+<%=SH_body_SALES%>+'</td><td>'+<%=SH_body_PJSALES%>+'</td><td>'+<%=SH_body_RSALES%>+'</td></tr>';
  		total_str += '<tr><td>제어로직</td><td>'+<%=SH_control_SALES%>+'</td><td>'+<%=SH_control_PJSALES%>+'</td><td>'+<%=SH_control_RSALES%>+'</td></tr>';
  		total_str += '<tr><td>기능안전</td><td>'+<%=SH_safe_SALES%>+'</td><td>'+<%=SH_safe_PJSALES%>+'</td><td>'+<%=SH_safe_RSALES%>+'</td></tr>';
  		total_str += '<tr><td>자율주행</td><td>'+<%=SH_auto_SALES%>+'</td><td>'+<%=SH_auto_PJSALES%>+'</td><td>'+<%=SH_auto_RSALES%>+'</td></tr>';
  		total_str += '<tr><td>total</td><td>'+<%=SH_total_SALES%>+'</td><td>'+<%=SH_total_PJSALES%>+'</td><td>'+<%=SH_total_RSALES%>+'</td></tr></table>';

  
       var dataTable = new google.visualization.DataTable();
       dataTable.addColumn('string', 'Team');
       dataTable.addColumn('number', '목표매출');
       // A column for custom tooltip content
		dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
       dataTable.addColumn('number', '예상매출');
       // A column for custom tooltip content
		dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
       dataTable.addColumn('number', '매출달성');
       // A column for custom tooltip content
		dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
       dataTable.addRows([
     	  ['Total', <%=SH_total_SALES%>, total_str, <%=SH_total_PJSALES%>, total_str, <%=SH_total_RSALES%>, total_str],
          ['샤시힐스', <%=SH_chassis_SALES%>, '<%=SH_chassis_project_Sales%>', <%=SH_chassis_PJSALES%>, '<%=SH_chassis_project_Sales%>', <%=SH_chassis_RSALES%>, '<%=SH_chassis_project_Sales%>'],
          ['바디힐스', <%=SH_body_SALES%>, '<%=SH_body_project_Sales%>', <%=SH_body_PJSALES%>, '<%=SH_body_project_Sales%>', <%=SH_body_RSALES%>, '<%=SH_body_project_Sales%>'],
          ['제어로직', <%=SH_control_SALES%>, '<%=SH_control_project_Sales%>', <%=SH_control_PJSALES%>, '<%=SH_control_project_Sales%>', <%=SH_control_RSALES%>, '<%=SH_control_project_Sales%>'],
          ['기능안전', <%=SH_safe_SALES%>, '<%=SH_safe_project_Sales%>', <%=SH_safe_PJSALES%>, '<%=SH_safe_project_Sales%>', <%=SH_safe_RSALES%>, '<%=SH_safe_project_Sales%>'],
          ['자율주행', <%=SH_auto_SALES%>, '<%=SH_auto_project_Sales%>', <%=SH_auto_PJSALES%>, '<%=SH_auto_project_Sales%>', <%=SH_auto_RSALES%>, '<%=SH_auto_project_Sales%>']
       ]);

       var sh_sales_option = {
      
           title: '하반기 매출',
           width: '100%',
           'height': 500,
           'legend': {'position': 'bottom'},
           tooltip:{isHtml: true},
           series: {
               0: { color: '#ffd1ff' },
               1: { color: '#fbc2eb' },
               2: { color: '#a18cd1' }
             }
      
       };

       var sh_sales_chart = new google.visualization.ColumnChart(document.getElementById('sh_sales_chart'));

       sh_sales_chart.draw(dataTable, sh_sales_option);
     }
     
function y_order() {

	 <%
	  	StringBuffer Y_chassis_project_pj = new StringBuffer();
	  	StringBuffer Y_body_project_pj = new StringBuffer();
	  	StringBuffer Y_control_project_pj = new StringBuffer();
	  	StringBuffer Y_safe_project_pj = new StringBuffer();
	  	StringBuffer Y_auto_project_pj = new StringBuffer();
	  	
	  	Y_chassis_project_pj.append("<table class=tootipTable>");
	  	Y_chassis_project_pj.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
		  
	  	Y_body_project_pj.append("<table class=tootipTable>");
	  	Y_body_project_pj.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
		  
	  	Y_control_project_pj.append("<table class=tootipTable>");
	  	Y_control_project_pj.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
		  
	  	Y_safe_project_pj.append("<table class=tootipTable>");
	  	Y_safe_project_pj.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
		  
	  	Y_auto_project_pj.append("<table class=tootipTable>");
	  	Y_auto_project_pj.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
		  
		  	
		  	for(int i=0; i<pjList.size(); i++){
		  		if(pjList.get(i).getTEAM_ORDER().equals("샤시힐스검증팀")){
		  			Y_chassis_project_pj.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
			  				+pjList.get(i).getFH_ORDER_PROJECTIONS()+pjList.get(i).getSH_ORDER_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_ORDER()+pjList.get(i).getSH_ORDER()+"</td></tr>");
		  		}
		  		else if(pjList.get(i).getTEAM_ORDER().equals("바디힐스검증팀")){
		  			Y_body_project_pj.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
			  				+pjList.get(i).getFH_ORDER_PROJECTIONS()+pjList.get(i).getSH_ORDER_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_ORDER()+pjList.get(i).getSH_ORDER()+"</td></tr>");
		  		}
		  		else if(pjList.get(i).getTEAM_ORDER().equals("제어로직검증팀")){
		  			Y_control_project_pj.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
			  				+pjList.get(i).getFH_ORDER_PROJECTIONS()+pjList.get(i).getSH_ORDER_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_ORDER()+pjList.get(i).getSH_ORDER()+"</td></tr>");
		  		}
		  		else if(pjList.get(i).getTEAM_ORDER().equals("기능안전검증팀")){
		  			Y_safe_project_pj.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
			  				+pjList.get(i).getFH_ORDER_PROJECTIONS()+pjList.get(i).getSH_ORDER_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_ORDER()+pjList.get(i).getSH_ORDER()+"</td></tr>");
		  		}
		  		else if(pjList.get(i).getTEAM_ORDER().equals("자율주행검증팀")){
		  			Y_auto_project_pj.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
			  				+pjList.get(i).getFH_ORDER_PROJECTIONS()+pjList.get(i).getSH_ORDER_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_ORDER()+pjList.get(i).getSH_ORDER()+"</td></tr>");
		  		}
		  	}
		  	
		  	Y_chassis_project_pj.append("<tr><td>total</td><td>"+Y_chassis_ORDER+"</td><td>"+Y_chassis_RPJ+"</td></tr>");
		  	Y_chassis_project_pj.append("<tr><td colspan=3>목표수주 : "+Y_chassis_ORDER+" (백만)</td></tr>");
		  	Y_chassis_project_pj.append("</table>");
			  
		  	Y_body_project_pj.append("<tr><td>total</td><td>"+Y_body_ORDER+"</td><td>"+Y_body_RPJ+"</td></tr>");
		  	Y_body_project_pj.append("<tr><td colspan=3>목표수주 : "+Y_body_ORDER+" (백만)</td></tr>");
		  	Y_body_project_pj.append("</table>");
			  
		  	Y_control_project_pj.append("<tr><td>total</td><td>"+Y_control_ORDER+"</td><td>"+Y_control_RPJ+"</td></tr>");
		  	Y_control_project_pj.append("<tr><td colspan=3>목표수주 : "+Y_control_ORDER+" (백만)</td></tr>");
		  	Y_control_project_pj.append("</table>");
			  
		  	Y_safe_project_pj.append("<tr><td>total</td><td>"+Y_safe_ORDER+"</td><td>"+Y_safe_RPJ+"</td></tr>");
		  	Y_safe_project_pj.append("<tr><td colspan=3>목표수주 : "+Y_safe_ORDER+" (백만)</td></tr>");
		  	Y_safe_project_pj.append("</table>");
			  
		  	Y_auto_project_pj.append("<tr><td>total</td><td>"+Y_auto_ORDER+"</td><td>"+Y_auto_RPJ+"</td></tr>");
		  	Y_auto_project_pj.append("<tr><td colspan=3>목표수주 : "+Y_auto_ORDER+" (백만)</td></tr>");
		  	Y_auto_project_pj.append("</table>");
	%>
	
	  // 목표
	  var total_str = '<table class=tootipTable><tr><td>팀</td><td>목표수주</td><td>예상수주</td><td>수주달성</td></tr>';
		total_str += '<tr><td>샤시힐스</td><td>'+<%=Y_chassis_PJ%>+'</td><td>'+<%=Y_chassis_ORDER%>+'</td><td>'+<%=Y_chassis_RPJ%>+'</td></tr>';
		total_str += '<tr><td>바디힐스</td><td>'+<%=Y_body_PJ%>+'</td><td>'+<%=Y_body_ORDER%>+'</td><td>'+<%=Y_body_RPJ%>+'</td></tr>';
		total_str += '<tr><td>제어로직</td><td>'+<%=Y_control_PJ%>+'</td><td>'+<%=Y_control_ORDER%>+'</td><td>'+<%=Y_control_RPJ%>+'</td></tr>';
		total_str += '<tr><td>기능안전</td><td>'+<%=Y_safe_PJ%>+'</td><td>'+<%=Y_safe_ORDER%>+'</td><td>'+<%=Y_safe_RPJ%>+'</td></tr>';
		total_str += '<tr><td>자율주행</td><td>'+<%=Y_auto_PJ%>+'</td><td>'+<%=Y_auto_ORDER%>+'</td><td>'+<%=Y_auto_RPJ%>+'</td></tr>';
		total_str += '<tr><td>total</td><td>'+<%=Y_total_pj%>+'</td><td>'+<%=Y_total_ORDER%>+'</td><td>'+<%=Y_total_RPJ%>+'</td></tr></table>';

    var dataTable = new google.visualization.DataTable();
    dataTable.addColumn('string', 'Team');
    dataTable.addColumn('number', '목표수주');
    // A column for custom tooltip content
    dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
    dataTable.addColumn('number', '예상수주');
    // A column for custom tooltip content
    dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
    dataTable.addColumn('number', '수주달성');
    // A column for custom tooltip content
    dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
    dataTable.addRows([
    	['Total', <%=Y_total_pj%>, total_str, <%=Y_total_ORDER%>, total_str, <%=Y_total_RPJ%>, total_str],
        ['샤시힐스', <%=Y_chassis_PJ%>, '<%=Y_chassis_project_pj%>', <%=Y_chassis_ORDER%>, '<%=Y_chassis_project_pj%>', <%=Y_chassis_RPJ%>, '<%=Y_chassis_project_pj%>'],
        ['바디힐스', <%=Y_body_PJ%>, '<%=Y_body_project_pj%>', <%=Y_body_ORDER%>, '<%=Y_body_project_pj%>', <%=Y_body_RPJ%>, '<%=Y_body_project_pj%>'],
        ['제어로직', <%=Y_control_PJ%>, '<%=Y_control_project_pj%>', <%=Y_control_ORDER%>, '<%=Y_control_project_pj%>', <%=Y_control_RPJ%>, '<%=Y_control_project_pj%>'],
        ['기능안전', <%=Y_safe_PJ%>, '<%=Y_auto_project_pj%>', <%=Y_safe_ORDER%>, '<%=Y_auto_project_pj%>', <%=Y_auto_RPJ%>, '<%=Y_auto_project_pj%>'],
        ['자율주행', <%=Y_auto_PJ%>, '<%=Y_auto_project_pj%>', <%=Y_auto_ORDER%>, '<%=Y_auto_project_pj%>', <%=Y_auto_RPJ%>, '<%=Y_auto_project_pj%>']
    ]);

    var y_order_option = {
  
        title: '연간 수주',
        width: '100%',
        'height': 500,
        'legend': {'position': 'bottom'},
        tooltip:{isHtml: true},
        series: {
        	 0: { color: '#d4fc79' },
             1: { color: '#84fab0' },
             2: { color: '#96e6a1' }
          }
    
    };

    var y_order_chart = new google.visualization.ColumnChart(document.getElementById('y_order_chart'));

    y_order_chart.draw(dataTable, y_order_option);
  }
  
function y_sales() {
    <%
	  	StringBuffer Y_chassis_project_Sales = new StringBuffer();
	  	StringBuffer Y_body_project_Sales = new StringBuffer();
	  	StringBuffer Y_control_project_Sales = new StringBuffer();
	  	StringBuffer Y_safe_project_Sales = new StringBuffer();
	  	StringBuffer Y_auto_project_Sales = new StringBuffer();
	  	
	  	Y_chassis_project_Sales.append("<table class=tootipTable>");
	  	Y_chassis_project_Sales.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
		  
	  	Y_body_project_Sales.append("<table class=tootipTable>");
	  	Y_body_project_Sales.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
		  
	  	Y_control_project_Sales.append("<table class=tootipTable>");
	  	Y_control_project_Sales.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
		  
	  	Y_safe_project_Sales.append("<table class=tootipTable>");
	  	Y_safe_project_Sales.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
		  
	  	Y_auto_project_Sales.append("<table class=tootipTable>");
	  	Y_auto_project_Sales.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
		  
		  	
		  	for(int i=0; i<pjList.size(); i++){
		  		if(pjList.get(i).getTEAM_SALES().equals("샤시힐스검증팀")){
		  			Y_chassis_project_Sales.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
			  				+pjList.get(i).getFH_SALES_PROJECTIONS()+pjList.get(i).getSH_SALES_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_SALES()+pjList.get(i).getSH_SALES()+"</td></tr>");
		  		}
		  		else if(pjList.get(i).getTEAM_ORDER().equals("바디힐스검증팀")){
		  			Y_body_project_Sales.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
			  				+pjList.get(i).getFH_SALES_PROJECTIONS()+pjList.get(i).getSH_SALES_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_SALES()+pjList.get(i).getSH_SALES()+"</td></tr>");
		  		}
		  		else if(pjList.get(i).getTEAM_ORDER().equals("제어로직검증팀")){
		  			Y_control_project_Sales.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
			  				+pjList.get(i).getFH_SALES_PROJECTIONS()+pjList.get(i).getSH_SALES_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_SALES()+pjList.get(i).getSH_SALES()+"</td></tr>");
		  		}
		  		else if(pjList.get(i).getTEAM_ORDER().equals("기능안전검증팀")){
		  			Y_safe_project_Sales.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
			  				+pjList.get(i).getFH_SALES_PROJECTIONS()+pjList.get(i).getSH_SALES_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_SALES()+pjList.get(i).getSH_SALES()+"</td></tr>");
		  		}
		  		else if(pjList.get(i).getTEAM_ORDER().equals("자율주행검증팀")){
		  			Y_auto_project_Sales.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
			  				+pjList.get(i).getFH_SALES_PROJECTIONS()+pjList.get(i).getSH_SALES_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_SALES()+pjList.get(i).getSH_SALES()+"</td></tr>");
		  		}
		  	}
		  	
		  	Y_chassis_project_Sales.append("<tr><td>total</td><td>"+Y_chassis_PJSALES+"</td><td>"+Y_chassis_RSALES+"</td></tr>");
		  	Y_chassis_project_Sales.append("<tr><td colspan=3>목표매출 : "+Y_chassis_SALES+" (백만)</td></tr>");
		  	Y_chassis_project_Sales.append("</table>");
			  
		  	Y_body_project_Sales.append("<tr><td>total</td><td>"+Y_body_PJSALES+"</td><td>"+Y_body_RSALES+"</td></tr>");
		  	Y_body_project_Sales.append("<tr><td colspan=3>목표매출 : "+Y_body_SALES+" (백만)</td></tr>");
		  	Y_body_project_Sales.append("</table>");
			  
		  	Y_control_project_Sales.append("<tr><td>total</td><td>"+Y_control_PJSALES+"</td><td>"+Y_control_RSALES+"</td></tr>");
		  	Y_control_project_Sales.append("<tr><td colspan=3>목표매출 : "+Y_control_SALES+" (백만)</td></tr>");
		  	Y_control_project_Sales.append("</table>");
			  
		  	Y_safe_project_Sales.append("<tr><td>total</td><td>"+Y_safe_PJSALES+"</td><td>"+Y_safe_RSALES+"</td></tr>");
		  	Y_safe_project_Sales.append("<tr><td colspan=3>목표매출 : "+Y_safe_SALES+" (백만)</td></tr>");
		  	Y_safe_project_Sales.append("</table>");
			  
		  	Y_auto_project_Sales.append("<tr><td>total</td><td>"+Y_auto_PJSALES+"</td><td>"+Y_auto_RSALES+"</td></tr>");
		  	Y_auto_project_Sales.append("<tr><td colspan=3>목표매출 : "+Y_auto_SALES+" (백만)</td></tr>");
		  	Y_auto_project_Sales.append("</table>");
  %>
	  // 목표
	  var total_str = '<table class=tootipTable><tr><td>팀</td><td>목표매출</td><td>예상매출</td><td>매출달성</td></tr>';
		total_str += '<tr><td>샤시힐스</td><td>'+<%=Y_chassis_SALES%>+'</td><td>'+<%=Y_chassis_PJSALES%>+'</td><td>'+<%=Y_chassis_RSALES%>+'</td></tr>';
		total_str += '<tr><td>바디힐스</td><td>'+<%=Y_body_SALES%>+'</td><td>'+<%=Y_body_PJSALES%>+'</td><td>'+<%=Y_body_RSALES%>+'</td></tr>';
		total_str += '<tr><td>제어로직</td><td>'+<%=Y_control_SALES%>+'</td><td>'+<%=Y_control_PJSALES%>+'</td><td>'+<%=Y_control_RSALES%>+'</td></tr>';
		total_str += '<tr><td>기능안전</td><td>'+<%=Y_safe_SALES%>+'</td><td>'+<%=Y_safe_PJSALES%>+'</td><td>'+<%=Y_safe_RSALES%>+'</td></tr>';
		total_str += '<tr><td>자율주행</td><td>'+<%=Y_auto_SALES%>+'</td><td>'+<%=Y_auto_PJSALES%>+'</td><td>'+<%=Y_auto_RSALES%>+'</td></tr>';
		total_str += '<tr><td>total</td><td>'+<%=Y_total_SALES%>+'</td><td>'+<%=Y_total_PJSALES%>+'</td><td>'+<%=Y_total_RSALES%>+'</td></tr></table>';

      var dataTable = new google.visualization.DataTable();
      dataTable.addColumn('string', 'Team');
      dataTable.addColumn('number', '목표매출');
      // A column for custom tooltip content
      dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
      dataTable.addColumn('number', '예상매출');
      // A column for custom tooltip content
      dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
      dataTable.addColumn('number', '매출달성');
      // A column for custom tooltip content
      dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
      dataTable.addRows([
    	  ['Total', <%=Y_total_SALES%>, total_str, <%=Y_total_PJSALES%>, total_str, <%=Y_total_RSALES%>, total_str],
          ['샤시힐스', <%=Y_chassis_SALES%>, '<%=Y_chassis_project_Sales%>', <%=Y_chassis_PJSALES%>, '<%=Y_chassis_project_Sales%>', <%=Y_chassis_RSALES%>, '<%=Y_chassis_project_Sales%>'],
          ['바디힐스', <%=Y_body_SALES%>, '<%=Y_body_project_Sales%>', <%=Y_body_PJSALES%>, '<%=Y_body_project_Sales%>', <%=Y_body_RSALES%>, '<%=Y_body_project_Sales%>'],
          ['제어로직', <%=Y_control_SALES%>, '<%=Y_control_project_Sales%>', <%=Y_control_PJSALES%>, '<%=Y_control_project_Sales%>', <%=Y_control_RSALES%>, '<%=Y_control_project_Sales%>'],
          ['기능안전', <%=Y_safe_SALES%>, '<%=Y_safe_project_Sales%>', <%=Y_safe_PJSALES%>, '<%=Y_safe_project_Sales%>', <%=Y_safe_RSALES%>, '<%=Y_safe_project_Sales%>'],
          ['자율주행', <%=Y_auto_SALES%>, '<%=Y_auto_project_Sales%>', <%=Y_auto_PJSALES%>, '<%=Y_auto_project_Sales%>', <%=Y_auto_RSALES%>, '<%=Y_auto_project_Sales%>']
      ]);
      
      var y_sales_option = {
       
          title: '연간 매출', 
          width: '100%',
          'height': 500,
          'legend': {'position': 'bottom'},
          tooltip:{isHtml: true},
          series: {
              0: { color: '#ffd1ff' },
              1: { color: '#fbc2eb' },
              2: { color: '#a18cd1' }
            }
      
      };

      var y_sales_chart = new google.visualization.ColumnChart(document.getElementById('y_sales_chart'));

      y_sales_chart.draw(dataTable, y_sales_option);
    } 
    
/*도넛 차트*/
google.charts.load("current", {packages:["corechart"]});
google.charts.setOnLoadCallback(fh_rpj);
google.charts.setOnLoadCallback(sh_rpj);
google.charts.setOnLoadCallback(y_rpj);
google.charts.setOnLoadCallback(fh_rsales);
google.charts.setOnLoadCallback(sh_rsales);
google.charts.setOnLoadCallback(y_rsales);

function fh_rpj() {
	  var fh_rpj_data = google.visualization.arrayToDataTable([
	    ['Count', 'How Many'],
	    ['샤시힐스',   <%=FH_chassis_RPJ%>],
	    ['바디힐스',   <%=FH_body_RPJ%>],
	    ['제어로직',  <%=FH_control_RPJ%>],
	    ['기능안전',  <%=FH_safe_RPJ%>],
	    ['자율주행',  <%=FH_auto_RPJ%>],
	    ['실',  <%=FH_vt_RPJ%>],
	  ]);

	  var fh_rpj_options = {
	    title: '상반기 수주 달성',
	    tooltip:{isHtml: true},
	    pieHole: 0.4, width: '100%', height:'100%',
	    colors: ['#E4E8C6', '#C2D68B', '#80C2B3', '#9DDCCE', '#B7E6D6','#30B08F']
	  };

	  var fh_rpj_chart = new google.visualization.PieChart(document.getElementById('fh_rpj_chart'));
	  fh_rpj_chart.draw( fh_rpj_data, fh_rpj_options);
	}
	
function sh_rpj() {
	  var sh_rpj_data = google.visualization.arrayToDataTable([
	    ['Count', 'How Many'],
	    ['샤시힐스',   <%=SH_chassis_RPJ%>],
	    ['바디힐스',   <%=SH_body_RPJ%>],
	    ['제어로직',  <%=SH_control_RPJ%>],
	    ['기능안전',  <%=SH_safe_RPJ%>],
	    ['자율주행',  <%=SH_auto_RPJ%>],
	    ['실',  <%=SH_vt_RPJ%>],
	  ]);

	  var sh_rpj_options = {
	    title: '하반기 수주 달성',
	    tooltip:{isHtml: true},
	    pieHole: 0.4, width: '100%', height:'100%',
	    colors: ['#E4E8C6', '#C2D68B', '#80C2B3', '#9DDCCE', '#B7E6D6','#30B08F']
	  };

	  var sh_rpj_chart = new google.visualization.PieChart(document.getElementById('sh_rpj_chart'));
	  sh_rpj_chart.draw( sh_rpj_data, sh_rpj_options);
	}
	
function y_rpj() {
	  var y_rpj_data = google.visualization.arrayToDataTable([
	    ['Count', 'How Many'],
	    ['샤시힐스',   <%=Y_chassis_RPJ%>],
	    ['바디힐스',   <%=Y_body_RPJ%>],
	    ['제어로직',  <%=Y_control_RPJ%>],
	    ['기능안전',  <%=Y_safe_RPJ%>],
	    ['자율주행',  <%=Y_auto_RPJ%>],
	    ['실',  <%=Y_vt_RPJ%>],
	  ]);

	  var y_rpj_options = {
	    title: '연간 수주 달성',
	    tooltip:{isHtml: true},
	    pieHole: 0.4, width: '100%', height:'100%',
	    colors: ['#E4E8C6', '#C2D68B', '#80C2B3', '#9DDCCE', '#B7E6D6','#30B08F']
	  };

	  var y_rpj_chart = new google.visualization.PieChart(document.getElementById('y_rpj_chart'));
	  y_rpj_chart.draw( y_rpj_data, y_rpj_options);
	}

function fh_rsales() {
	  var fh_rsales_data = google.visualization.arrayToDataTable([
	    ['Count', 'How Many'],
	    ['샤시힐스',   <%=FH_chassis_RSALES%>],
	    ['바디힐스',   <%=FH_body_RSALES%>],
	    ['제어로직',  <%=FH_control_RSALES%>],
	    ['기능안전',  <%=FH_safe_RSALES%>],
	    ['자율주행',  <%=FH_auto_RSALES%>],
	    ['실',  <%=FH_vt_RSALES%>],
	  ]);

	  var fh_rsales_options = {
	    title: '상반기 매출 달성',
	    tooltip:{isHtml: true},
	    pieHole: 0.4, width: '100%', height:'100%',
	    colors: ['#D2ACD1', '#FACDBD', '#F4B8C6', '#C587AE', '#8C749F','#7D6394']
	  };

	  var fh_rsales_chart = new google.visualization.PieChart(document.getElementById('fh_rsales_chart'));
	  fh_rsales_chart.draw( fh_rsales_data, fh_rsales_options);
	}
	
function sh_rsales() {
	  var sh_rsales_data = google.visualization.arrayToDataTable([
	    ['Count', 'How Many'],
	    ['샤시힐스',   <%=SH_chassis_RSALES%>],
	    ['바디힐스',   <%=SH_body_RSALES%>],
	    ['제어로직',  <%=SH_control_RSALES%>],
	    ['기능안전',  <%=SH_safe_RSALES%>],
	    ['자율주행',  <%=SH_auto_RSALES%>],
	    ['실',  <%=SH_vt_RSALES%>],
	  ]);

	  var sh_rsales_options = {
	    title: '하반기 매출 달성',
	    tooltip:{isHtml: true},
	    pieHole: 0.4, width: '100%', height:'100%',
	    colors: ['#D2ACD1', '#FACDBD', '#F4B8C6', '#C587AE', '#8C749F','#7D6394']
	  };

	  var sh_rsales_chart = new google.visualization.PieChart(document.getElementById('sh_rsales_chart'));
	  sh_rsales_chart.draw( sh_rsales_data, sh_rsales_options);
	}
	
function y_rsales() {
	  var y_rsales_data = google.visualization.arrayToDataTable([
	    ['Count', 'How Many'],
	    ['샤시힐스',   <%=Y_chassis_RSALES%>],
	    ['바디힐스',   <%=Y_body_RSALES%>],
	    ['제어로직',  <%=Y_control_RSALES%>],
	    ['기능안전',  <%=Y_safe_RSALES%>],
	    ['자율주행',  <%=Y_auto_RSALES%>],
	    ['실',  <%=Y_vt_RSALES%>],
	  ]);

	  var y_rsales_options = {
	    title: '연간 매출 달성',
	    tooltip:{isHtml: true},
	    pieHole: 0.4, width: '100%', height:'100%',
	    colors: ['#D2ACD1', '#FACDBD', '#F4B8C6', '#C587AE', '#8C749F','#7D6394']
	  };

	  var y_rsales_chart = new google.visualization.PieChart(document.getElementById('y_rsales_chart'));
	  y_rsales_chart.draw( y_rsales_data, y_rsales_options);
	}
</script>

<script type="text/javascript">
	
	//달성률에 따른 색 변화
	 function stateColor(){
		 var data;
		 var z;
		 var arr = new Array();
		 var arr = [4, 6, 9, 11, 14, 16, 19, 21, 24, 26, 29, 31];
		 for(var i=0; i<12; i++){
			 for(var a=1; a<8; a++){
				 data =  $('#dataTable tr:eq('+arr[i]+') td:eq('+a+')').text().split(".")[0];
				 z = (data/100)+0.1;
				 $('#dataTable tr:eq('+arr[i]+') td:eq('+a+')').css('background', 'rgb(130,130,250, '+z+')')
				 $('#dataTable tr:eq('+arr[i]+') td:eq('+a+')').css('color','white');
			 }
		 }
	}
	
	function orderByDate(){
		<%
			Date nowTime = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("MM");
		%>
		var month = <%=Integer.parseInt(sf.format(nowTime))%>;
		if(month > 6){
			$('#tab-4').after($('#tab-3'));
			$('#tab-3').after($('#tab-2'));
		}
	}
	

	$(document).ready(function(){
		$('.loading').hide();
		stateColor();
		orderByDate();
		
	$('ul.tabs li').click(function() {
			var tab_id = $(this).attr('data-tab');

			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');

			$(this).addClass('current');
			$("#" + tab_id).addClass('current');
		});

	});
	
	window.onbeforeunload = function() {
		$('.loading').show();
	} //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
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
			<li class="nav-item active"><a class="nav-link"
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

			<li class="nav-item"><a class="nav-link"
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
    
      <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
         <h6 class="m-0 font-weight-bold text-primary" style="padding-left: 17px;">수주 & 매출</h6>
        </div>
            <div class="card-body">
	<div class="container2">
	<ul class="tabs">
		<li class="tab-link current" data-tab="tab-1">전체보기</li>
		<li class="tab-link" data-tab="tab-2">상반기</li>
		<li class="tab-link" data-tab="tab-3">하반기</li>
		<li class="tab-link" data-tab="tab-4">연간</li>
	</ul>
			

 				<div id="tab-1" class="tab-content current">
 				<form method="post" action="Save_targetData.jsp">
 				 <div class="table-responsive">
                <table class="table table-bordered" id="dataTable">
                  <thead>
                   <tr>
                    	<td colspan="3" style="border:0px;"></td>
                    	<td colspan="5"style="text-align:center;background-color:#15a3da52;">상세내역(단위: 백만)</td>
                    	<td>
                    	<%
                    		if(permission == 0){
                    			%><input type="submit" value="저장"><%	
                    		}	
                    	%>
                    	</td>
                    </tr>  
                    <tr style="text-align:center;background-color:#15a3da52;">
	                    <th>구분</th>
	                    <th>항목</th>
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
                    <tr class="fh_tr">
                    	<td rowspan="10" style="text-align:center; vertical-align: middle;">상반기</td>
                    	<td style="text-align:center;">목표 수주</td>
                    	<td><%=FH_total_PJ%></td>
                    	<td><input class="sale" name="FH_chassis_PJ" value='<%=FH_chassis_PJ%>'></td>
                    	<td><input class="sale" name="FH_body_PJ" value='<%=FH_body_PJ%>'></td>
                    	<td><input class="sale" name="FH_control_PJ" value='<%=FH_control_PJ%>'></td>
                    	<td><input class="sale" name="FH_safe_PJ" value='<%=FH_safe_PJ%>'></td>
                    	<td><input class="sale" name="FH_auto_PJ" value='<%=FH_auto_PJ%>'></td>
                    	<td><input class="sale" name="FH_vt_PJ" value='<%=FH_vt_PJ%>'></td>
                    </tr>
                    <tr class="fh_tr">
                    	<td>예상 수주</td>
                    	<td><%=FH_total_ORDER%></td>
                    	<td><%=FH_chassis_ORDER%></td>
                    	<td><%=FH_body_ORDER%></td>
                    	<td><%=FH_control_ORDER%></td>
                    	<td><%=FH_safe_ORDER%></td>
                    	<td><%=FH_auto_ORDER%></td>
                    	<td><%=FH_vt_ORDER%></td>
                    </tr>
                     <tr class="fh_tr">
                    	<td>예상 수주(%)</td>
                    	<td><%=String.format("%.1f", FH_total_ORDER/FH_total_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_chassis_ORDER/FH_chassis_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_body_ORDER/FH_body_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_control_ORDER/FH_control_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_safe_ORDER/FH_safe_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_auto_ORDER/FH_auto_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_vt_ORDER/FH_vt_PJ *100)%>(%)</td>
                    </tr>
                     <tr class="fh_tr">
                    	<td>달성</td> 	
                    	<td><%=FH_total_RPJ%></td>
                    	<td><%=FH_chassis_RPJ%></td>
                    	<td><%=FH_body_RPJ%></td>
                    	<td><%=FH_control_RPJ%></td>
                    	<td><%=FH_safe_RPJ%></td>
                    	<td><%=FH_auto_RPJ%></td>
                    	<td><%=FH_vt_RPJ%></td>
                    	
                    </tr>
                     <tr class="fh_tr">
                    	<td>수주 달성률</td>
                    	<td><%=String.format("%.1f", FH_total_RPJ/FH_total_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_chassis_RPJ/FH_chassis_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_body_RPJ/FH_body_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_control_RPJ/FH_control_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_safe_RPJ/FH_safe_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_auto_RPJ/FH_auto_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_vt_RPJ/FH_vt_PJ *100)%>(%)</td>
                    </tr>
                     <tr class="fh_tr">
                    	<td>목표 매출</td>
                        <td><%=FH_total_SALES%></td>
                    	<td><input class="sale" name="FH_chassis_SALES" value='<%=FH_chassis_SALES %>'></td>
                    	<td><input class="sale" name="FH_body_SALES" value='<%=FH_body_SALES %>'></td>
                    	<td><input class="sale" name="FH_control_SALES" value='<%=FH_control_SALES %>'></td>
                    	<td><input class="sale" name="FH_safe_SALES" value='<%=FH_safe_SALES %>'></td>
                    	<td><input class="sale" name="FH_auto_SALES" value='<%=FH_auto_SALES %>'></td>
                    	<td><input class="sale" name="FH_vt_SALES" value='<%=FH_vt_SALES %>'></td>
                    </tr>
                     <tr class="fh_tr">
                    	<td>예상 매츨</td>
                    	<td><%=FH_total_PJSALES %></td>
                    	<td><%=FH_chassis_PJSALES %></td>
                    	<td><%=FH_body_PJSALES %></td>
                    	<td><%=FH_control_PJSALES %></td>
                    	<td><%=FH_safe_PJSALES %></td>
                    	<td><%=FH_auto_PJSALES %></td>
                    	<td><%=FH_vt_PJSALES %></td>
                    </tr>
                     <tr class="fh_tr">
                    	<td>예상 매출(%)</td>
                    	
                    	<td><%=String.format("%.1f", FH_total_PJSALES/FH_total_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_chassis_PJSALES/FH_chassis_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_body_PJSALES/FH_body_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_control_PJSALES/FH_control_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_safe_PJSALES/FH_safe_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_auto_PJSALES/FH_auto_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_vt_PJSALES/FH_vt_SALES *100)%>(%)</td>
                    </tr>
                     <tr class="fh_tr">
                    	<td>달성</td>
                    	<td><%=FH_total_RSALES %></td>
                   		<td><%=FH_chassis_RSALES %></td>
                    	<td><%=FH_body_RSALES %></td>
                    	<td><%=FH_control_RSALES %></td>
                    	<td><%=FH_safe_RSALES %></td>
                    	<td><%=FH_auto_RSALES %></td>
                    	<td><%=FH_vt_RSALES %></td>
                    	
                    </tr>
                     <tr class="fh_tr">
                    	<td>매출 달성률</td>
                    	
                    	<td><%=String.format("%.1f", FH_total_RSALES/FH_total_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_chassis_RSALES/FH_chassis_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_body_RSALES/FH_body_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_control_RSALES/FH_control_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_safe_RSALES/FH_safe_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_auto_RSALES/FH_auto_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", FH_vt_RSALES/FH_vt_SALES *100)%>(%)</td>
                    </tr>
                    
                     <tr class="sh_tr">
                    	<td rowspan="10" style=" vertical-align: middle;">하반기</td>
                    	<td style="text-align:center;">목표 수주</td>
                    	<td><%=SH_total_PJ%></td>
                    	<td><input class="sale" name="SH_chassis_PJ" value='<%=SH_chassis_PJ %>'></td>
                    	<td><input class="sale" name="SH_body_PJ" value='<%=SH_body_PJ %>'></td>
                    	<td><input class="sale" name="SH_control_PJ" value='<%=SH_control_PJ %>'></td>
                    	<td><input class="sale" name="SH_safe_PJ" value='<%=SH_safe_PJ %>'></td>
                    	<td><input class="sale" name="SH_auto_PJ" value='<%=SH_auto_PJ %>'></td>
                    	<td><input class="sale" name="SH_vt_PJ" value='<%=SH_vt_PJ %>'></td>
                    </tr>
                     <tr class="sh_tr">
                    	<td>예상 수주</td>
                    	<td><%=SH_total_ORDER%></td>
                    	<td><%=SH_chassis_ORDER%></td>
                    	<td><%=SH_body_ORDER%></td>
                    	<td><%=SH_control_ORDER%></td>
                    	<td><%=SH_safe_ORDER%></td>
                    	<td><%=SH_auto_ORDER%></td>
                    	<td><%=SH_vt_ORDER%></td>
                    </tr>
                     <tr class="sh_tr">
                    	<td>예상 수주(%)</td>
						<td><%=String.format("%.1f", SH_total_ORDER/SH_total_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_chassis_ORDER/SH_chassis_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_body_ORDER/SH_body_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_control_ORDER/SH_control_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_safe_ORDER/SH_safe_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_auto_ORDER/SH_auto_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_vt_ORDER/SH_vt_PJ *100)%>(%)</td>
                    </tr>
                     <tr class="sh_tr">
                    	<td>달성</td>
                    	<td><%=SH_total_RPJ%></td>
                    	<td><%=SH_chassis_RPJ%></td>
                    	<td><%=SH_body_RPJ%></td>
                    	<td><%=SH_control_RPJ%></td>
                    	<td><%=SH_safe_RPJ%></td>
                    	<td><%=SH_auto_RPJ%></td>
                    	<td><%=SH_vt_RPJ%></td>
                    	
                    </tr>
                     <tr class="sh_tr">
                    	<td>수주 달성률</td>
						<td><%=String.format("%.1f", SH_total_RPJ/SH_total_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_chassis_RPJ/SH_chassis_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_body_RPJ/SH_body_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_control_RPJ/SH_control_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_safe_RPJ/SH_safe_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_auto_RPJ/SH_auto_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_vt_RPJ/SH_vt_PJ *100)%>(%)</td>
                    </tr>
                     <tr class="sh_tr">
                    	<td>목표 매출</td>
                        <td><%=SH_total_SALES%></td>
                    	<td><input class="sale" name="SH_chassis_SALES" value='<%=SH_chassis_SALES %>'></td>
                    	<td><input class="sale" name="SH_body_SALES" value='<%=SH_body_SALES %>'></td>
                    	<td><input class="sale" name="SH_control_SALES" value='<%=SH_control_SALES %>'></td>
                    	<td><input class="sale" name="SH_safe_SALES" value='<%=SH_safe_SALES %>'></td>
                    	<td><input class="sale" name="SH_auto_SALES" value='<%=SH_auto_SALES %>'></td>
                    	<td><input class="sale" name="SH_vt_SALES" value='<%=SH_vt_SALES %>'></td>
                    </tr>
                     <tr class="sh_tr">
                    	<td>예상 매츨</td>
                    	<td><%=SH_total_PJSALES %></td>
                    	<td><%=SH_chassis_PJSALES %></td>
                    	<td><%=SH_body_PJSALES %></td>
                    	<td><%=SH_control_PJSALES %></td>
                    	<td><%=SH_safe_PJSALES %></td>
                    	<td><%=SH_auto_PJSALES %></td>
                    	<td><%=SH_vt_PJSALES %></td>
                    </tr>
                     <tr class="sh_tr">
                    	<td>예상 매출(%)</td>
                    	<td><%=String.format("%.1f", SH_total_PJSALES/SH_total_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_chassis_PJSALES/SH_chassis_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_body_PJSALES/SH_body_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_control_PJSALES/SH_control_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_safe_PJSALES/SH_safe_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_auto_PJSALES/SH_auto_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_vt_PJSALES/SH_vt_SALES *100)%>(%)</td>
                    </tr>
                     <tr class="sh_tr">
                    	<td>달성</td>
                    	<td><%=SH_total_RSALES %></td>
                   		<td><%=SH_chassis_RSALES %></td>
                    	<td><%=SH_body_RSALES %></td>
                    	<td><%=SH_control_RSALES %></td>
                    	<td><%=SH_safe_RSALES %></td>
                    	<td><%=SH_auto_RSALES %></td>
                    	<td><%=SH_vt_RSALES %></td>
                    	
                    </tr>
                     <tr class="sh_tr">
                    	<td>매출 달성률</td>
                    	<td><%=String.format("%.1f", SH_total_RSALES/SH_total_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_chassis_RSALES/SH_chassis_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_body_RSALES/SH_body_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_control_RSALES/SH_control_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_safe_RSALES/SH_safe_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_auto_RSALES/SH_auto_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", SH_vt_RSALES/SH_vt_SALES *100)%>(%)</td>
                    </tr>
                    
                    <tr class="y_tr">
                    	<td rowspan="10" style=" vertical-align:middle;">연간</td>
                    <td style="text-align:center;">목표 수주</td>
                    	<td><%=Y_total_pj %></td>
                    	<td><%=Y_chassis_PJ %></td>
                    	<td><%=Y_body_PJ %></td>
                    	<td><%=Y_control_PJ %></td>
                    	<td><%=Y_safe_PJ %></td>
                    	<td><%=Y_auto_PJ %></td>
                    	<td><%=Y_vt_PJ %></td>
                    </tr>
                    <tr class="y_tr">
                    	<td>예상 수주</td>
                    	<td><%=Y_total_ORDER %></td>
                    	<td><%=Y_chassis_ORDER %></td>
                    	<td><%=Y_body_ORDER %></td>
                    	<td><%=Y_control_ORDER %></td>
                    	<td><%=Y_safe_ORDER %></td>
                    	<td><%=Y_auto_ORDER %></td>
                    	<td><%=Y_vt_ORDER %></td>
                    </tr>
                     <tr class="y_tr">
                    	<td>예상 수주(%)</td>
                    	<td><%=String.format("%.1f", Y_total_ORDER/Y_total_pj *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_chassis_ORDER/Y_chassis_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_body_ORDER/Y_body_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_control_ORDER/Y_control_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_safe_ORDER/Y_safe_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_auto_ORDER/Y_auto_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_vt_ORDER/Y_vt_PJ *100)%>(%)</td>
                    </tr>
                     <tr class="y_tr">
                    	<td>달성</td>
                    	<td><%=Y_total_RPJ %></td>
                    	<td><%=Y_chassis_RPJ %></td>
                    	<td><%=Y_body_RPJ %></td>
                    	<td><%=Y_control_RPJ %></td>
                    	<td><%=Y_safe_RPJ %></td>
                    	<td><%=Y_auto_RPJ %></td>
                    	<td><%=Y_vt_RPJ %></td>
                    </tr>
                     <tr class="y_tr">
                    	<td>수주 달성률</td>
                    	<td><%=String.format("%.1f", Y_total_RPJ/Y_total_pj *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_chassis_RPJ/Y_chassis_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_body_RPJ/Y_body_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_control_RPJ/Y_control_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_safe_RPJ/Y_safe_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_auto_RPJ/Y_auto_PJ *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_vt_RPJ/Y_vt_PJ *100)%>(%)</td>
                    </tr>
                     <tr class="y_tr">
                    	<td>목표 매출</td>
                        <td><%=Y_total_SALES %></td>
                    	<td><%=Y_chassis_SALES %></td>
                    	<td><%=Y_body_SALES %></td>
                    	<td><%=Y_control_SALES %></td>
                    	<td><%=Y_safe_SALES %></td>
                    	<td><%=Y_auto_SALES %></td>
                    	<td><%=Y_vt_SALES %></td>
                    </tr>
                     <tr class="y_tr">
                    	<td>예상 매츨</td>
                    	<td><%=Y_total_PJSALES %></td>
                    	<td><%=Y_chassis_PJSALES %></td>
                    	<td><%=Y_body_PJSALES %></td>
                    	<td><%=Y_control_PJSALES %></td>
                    	<td><%=Y_safe_PJSALES %></td>
                    	<td><%=Y_auto_PJSALES %></td>
                    	<td><%=Y_vt_PJSALES %></td>
                    </tr>
                     <tr class="y_tr">
                    	<td>예상 매출(%)</td>
                    	<td><%=String.format("%.1f", Y_total_PJSALES/Y_total_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_chassis_PJSALES/Y_chassis_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_body_PJSALES/Y_body_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_control_PJSALES/Y_control_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_safe_PJSALES/Y_safe_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_auto_PJSALES/Y_auto_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_vt_PJSALES/Y_vt_SALES *100)%>(%)</td>
                    </tr>
                     <tr class="y_tr">
                    	<td>달성</td>
                    	<td><%=Y_total_RSALES %></td>
                    	<td><%=Y_chassis_RSALES %></td>
                    	<td><%=Y_body_RSALES %></td>
                    	<td><%=Y_control_RSALES %></td>
                    	<td><%=Y_safe_RSALES %></td>
                    	<td><%=Y_auto_RSALES %></td>
                    	<td><%=Y_vt_RSALES %></td>
                    </tr>
                     <tr class="y_tr">
                    	<td>매출 달성률</td>
                    	<td><%=String.format("%.1f", Y_total_RSALES/Y_total_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_chassis_RSALES/Y_chassis_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_body_RSALES/Y_body_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_control_RSALES/Y_control_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_safe_RSALES/Y_safe_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_auto_RSALES/Y_auto_SALES *100)%>(%)</td>
                    	<td><%=String.format("%.1f", Y_vt_RSALES/Y_vt_SALES *100)%>(%)</td>
                    </tr>
                  	  </tbody>                            
               		 </table>
               		 </div>
               		 </form> 
               		 </div>
               		 
              
               <div id="tab-2" class="tab-content current">
               		<table class="table-responsive">
	            	 <tr><td style="width:50%;"><div id="fh_order_chart" class="chart bar"></div></td></tr>
	             	 <tr><td><div id="fh_sales_chart" class="chart bar"></div></td></tr>
	             	 <tr><td><div id="fh_rpj_chart" class="chart pie"></div></td></tr>
	             	 <tr><td><div id="fh_rsales_chart" class="chart pie"></div></td></tr>
             	 	</table>
             </div>
             	 
           	  <div id="tab-3" class="tab-content current">
             		<table class="table-responsive">
					 <tr><td><div id="sh_order_chart" class="chart bar" ></div></td></tr>
					 <tr><td><div id="sh_sales_chart" class="chart bar"></div></td></tr>
					 <tr><td><div id="sh_rpj_chart" class="chart pie"></div></td></tr>
					 <tr><td><div id="sh_rsales_chart" class="chart pie"></div></td></tr>
           	 		</table>
           	 </div>
             	 
           	  <div id="tab-4" class="tab-content current">
             		<table class="table-responsive">
					 <tr><td><div id="y_order_chart" class="chart bar"></div></td></tr>
					 <tr><td><div id="y_sales_chart" class="chart "></div></td></tr>
				 	 <tr><td><div id="y_rpj_chart" class="chart pie"></div></td></tr>
				 	 <tr><td><div id="y_rsales_chart" class="chart pie"></div></td></tr>
           	 		</table>
           	 </div>
             
    </div>
    </div>
              </div>
              
        <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
         <h6 class="m-0 font-weight-bold text-primary" style="padding-left: 17px;">수익률</h6>
        </div>
            <div class="card-body"> 
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable">
                  <thead>
                   <tr>
                    	<td colspan="3" style="border:0px;"></td>
                    	<td colspan="6" style="text-align:center;background-color:#15a3da52;">상세내역</td>
                    </tr>  
                    <tr style="text-align:center;background-color:#15a3da52;">
	                    <th>구분</th>
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
                   
                    </tbody>                           
                </table>
              </div>   
              </div>     
         </div>
     
   
    <!-- /.container-fluid -->
</div>

   <!-- End of Main Content -->

  <!-- End of Content Wrapper -->

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
     <h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
     <button class="close" type="button" data-dismiss="modal" aria-label="Close">
      <span aria-hidden="true">×</span>
     </button>
    </div>
    <div class="modal-body">확인버튼을 누를 시 로그아웃 됩니다.</div>
    <div class="modal-footer">
     <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
    <form method = "post" action = "../LogoutPro.jsp">
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