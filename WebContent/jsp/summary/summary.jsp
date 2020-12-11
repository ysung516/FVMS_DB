<%@page import="jsp.DB.method.MemberDAO"%>
<%@page import="jsp.DB.method.SummaryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.io.PrintWriter"
    import = "jsp.sheet.method.*"
    import = "jsp.Bean.model.*"
    import = "java.util.ArrayList"
    import = "java.awt.Color" 
    import = "java.util.Date"
    import = "java.text.SimpleDateFormat"
    import = "java.util.HashMap"  
    import = "java.util.LinkedHashMap"  
    import = "java.util.LinkedList"
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
	session.setMaxInactiveInterval(60*240);
	
	MemberDAO memberDao = new MemberDAO();
	SummaryDAO summaryDao = new SummaryDAO();
	
	Date nowTime = new Date();
	SimpleDateFormat sf_yyyy = new SimpleDateFormat("yyyy");
	String nowYear = sf_yyyy.format(nowTime);
	
	int maxYear = summaryDao.maxYear();
	int yearCount = maxYear - summaryDao.minYear() + 1;
	
	if(request.getParameter("selectYear") != null){
		nowYear = request.getParameter("selectYear");
	}
	
    LinkedHashMap<Integer, String> teamList = memberDao.getTeam_year(nowYear);	// 현재 년도 팀 정보 가져오기
	
	ArrayList<ProjectBean> pjList = summaryDao.getProjectList(nowYear);	// 이번년도 실적보고 프로젝트 리스트
	HashMap<String, Integer> RankCompe = summaryDao.getRank();	// 직급별 기준
	
	ArrayList<String> teamNameList = new ArrayList<String>(); 
	LinkedHashMap<String, TeamBean> teamGoalList = summaryDao.getTargetData(nowYear);	// 현재 년도 팀별 목표값 가져오기
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
	
	/* ========목표======== */
	// 목표수주
	LinkedHashMap<String, Float> FH_goalOrder = new LinkedHashMap<String, Float>();
	LinkedHashMap<String, Float> SH_goalOrder = new LinkedHashMap<String, Float>();
	LinkedHashMap<String, Float> Y_goalOrder = new LinkedHashMap<String, Float>();
	float FH_totalGoalOrder = 0;
	float SH_totalGoalOrder = 0;
	float Y_totalGoalOrder = 0;
	for(int key : teamList.keySet()){
		//상반기
		FH_goalOrder.put(teamList.get(key), teamGoalList.get(teamList.get(key)).getFH_targetOrder());
		FH_totalGoalOrder += teamGoalList.get(teamList.get(key)).getFH_targetOrder();
		//하반기
		SH_goalOrder.put(teamList.get(key), teamGoalList.get(teamList.get(key)).getSH_targetOrder());
		SH_totalGoalOrder += teamGoalList.get(teamList.get(key)).getSH_targetOrder();
		//연간
		Y_goalOrder.put(teamList.get(key), teamGoalList.get(teamList.get(key)).getFH_targetOrder() + teamGoalList.get(teamList.get(key)).getSH_targetOrder());
		Y_totalGoalOrder += teamGoalList.get(teamList.get(key)).getFH_targetOrder() + teamGoalList.get(teamList.get(key)).getSH_targetOrder();
	}
	// 목표매출
	LinkedHashMap<String, Float> FH_goalSale = new LinkedHashMap<String, Float>();
	LinkedHashMap<String, Float> SH_goalSale = new LinkedHashMap<String, Float>();
	LinkedHashMap<String, Float> Y_goalSale = new LinkedHashMap<String, Float>();
	float FH_totalGoalSale = 0;
	float SH_totalGoalSale = 0;
	float Y_totalGoalSale = 0;
	for(int key : teamList.keySet()){
		//상반기
		FH_goalSale.put(teamList.get(key), teamGoalList.get(teamList.get(key)).getFH_targetSales());
		FH_totalGoalSale += teamGoalList.get(teamList.get(key)).getFH_targetSales();
		//하반기
		SH_goalSale.put(teamList.get(key), teamGoalList.get(teamList.get(key)).getSH_targetSales());
		SH_totalGoalSale += teamGoalList.get(teamList.get(key)).getSH_targetSales();
		//연간
		Y_goalSale.put(teamList.get(key), teamGoalList.get(teamList.get(key)).getFH_targetSales() + teamGoalList.get(teamList.get(key)).getSH_targetSales());
		Y_totalGoalSale += teamGoalList.get(teamList.get(key)).getFH_targetSales() + teamGoalList.get(teamList.get(key)).getSH_targetSales();
	}

	
	// 예상수주
	LinkedHashMap<String, Float> FH_preOrder = new LinkedHashMap<String, Float>();
	LinkedHashMap<String, Float> SH_preOrder = new LinkedHashMap<String, Float>();
	LinkedHashMap<String, Float> Y_preOrder = new LinkedHashMap<String, Float>();
	float FH_totalpreOrder = 0;
	float SH_totalpreOrder = 0;
	float Y_totalpreOrder = 0;
	
	// 수주달성
	LinkedHashMap<String, Float> FH_achOrder = new LinkedHashMap<String, Float>();
	LinkedHashMap<String, Float> SH_achOrder = new LinkedHashMap<String, Float>();
	LinkedHashMap<String, Float> Y_achOrder = new LinkedHashMap<String, Float>();
	float FH_totalachOrder = 0;
	float SH_totalachOrder = 0;
	float Y_totalachOrder = 0;
	
	// 예상매출
	LinkedHashMap<String, Float> FH_preSale = new LinkedHashMap<String, Float>();
	LinkedHashMap<String, Float> SH_preSale = new LinkedHashMap<String, Float>();
	LinkedHashMap<String, Float> Y_preSale = new LinkedHashMap<String, Float>();
	float FH_totalpreSale = 0;
	float SH_totalpreSale = 0;
	float Y_totalpreSale = 0;
	
	// 매출달성
	LinkedHashMap<String, Float> FH_achSale = new LinkedHashMap<String, Float>();
	LinkedHashMap<String, Float> SH_achSale = new LinkedHashMap<String, Float>();
	LinkedHashMap<String, Float> Y_achSale = new LinkedHashMap<String, Float>();
	float FH_totalachSale = 0;
	float SH_totalachSale = 0;
	float Y_totalachSale = 0;
	
	for(int key : teamList.keySet()){
		FH_preOrder.put(teamList.get(key), new Float(0));
		SH_preOrder.put(teamList.get(key), new Float(0));
		Y_preOrder.put(teamList.get(key), new Float(0));
		FH_achOrder.put(teamList.get(key), new Float(0));
		SH_achOrder.put(teamList.get(key), new Float(0));
		Y_achOrder.put(teamList.get(key), new Float(0));
		FH_preSale.put(teamList.get(key), new Float(0));
		SH_preSale.put(teamList.get(key), new Float(0));
		Y_preSale.put(teamList.get(key), new Float(0));
		FH_achSale.put(teamList.get(key), new Float(0));
		SH_achSale.put(teamList.get(key), new Float(0));
		Y_achSale.put(teamList.get(key), new Float(0));
		
		for(int i = 0; i < pjList.size(); i++){
			if(pjList.get(i).getTEAM_ORDER().equals(teamList.get(key))){
				/* ========예상수주======== */
				//상반기
				FH_preOrder.put(teamList.get(key), FH_preOrder.get(teamList.get(key)) + pjList.get(i).getFH_ORDER_PROJECTIONS());
				FH_totalpreOrder += pjList.get(i).getFH_ORDER_PROJECTIONS();
				//하반기
				SH_preOrder.put(teamList.get(key), SH_preOrder.get(teamList.get(key)) + pjList.get(i).getSH_ORDER_PROJECTIONS());
				SH_totalpreOrder += pjList.get(i).getSH_ORDER_PROJECTIONS();
				//연간
				Y_preOrder.put(teamList.get(key), Y_preOrder.get(teamList.get(key)) + pjList.get(i).getFH_ORDER_PROJECTIONS() + pjList.get(i).getSH_ORDER_PROJECTIONS());
				Y_totalpreOrder += pjList.get(i).getFH_ORDER_PROJECTIONS() + pjList.get(i).getSH_ORDER_PROJECTIONS();

				/* ========수주달성======== */
				//상반기
				FH_achOrder.put(teamList.get(key), FH_achOrder.get(teamList.get(key)) + pjList.get(i).getFH_ORDER());
				FH_totalachOrder += pjList.get(i).getFH_ORDER();
				//하반기
				SH_achOrder.put(teamList.get(key), SH_achOrder.get(teamList.get(key)) + pjList.get(i).getSH_ORDER());
				SH_totalachOrder += pjList.get(i).getSH_ORDER();
				//연간
				Y_achOrder.put(teamList.get(key), Y_achOrder.get(teamList.get(key)) + pjList.get(i).getFH_ORDER() + pjList.get(i).getSH_ORDER());
				Y_totalachOrder += pjList.get(i).getFH_ORDER() + pjList.get(i).getSH_ORDER();
			}
			if(pjList.get(i).getTEAM_SALES().equals(teamList.get(key))){
				/* ========예상매출======== */
				//상반기
				FH_preSale.put(teamList.get(key), FH_preSale.get(teamList.get(key)) + pjList.get(i).getFH_SALES_PROJECTIONS());
				FH_totalpreSale += pjList.get(i).getFH_SALES_PROJECTIONS();
				//하반기
				SH_preSale.put(teamList.get(key), SH_preSale.get(teamList.get(key)) + pjList.get(i).getSH_SALES_PROJECTIONS());
				SH_totalpreSale += pjList.get(i).getSH_SALES_PROJECTIONS();
				//연간
				Y_preSale.put(teamList.get(key), Y_preSale.get(teamList.get(key)) + pjList.get(i).getFH_SALES_PROJECTIONS() + pjList.get(i).getSH_SALES_PROJECTIONS());
				Y_totalpreSale += pjList.get(i).getFH_SALES_PROJECTIONS() + pjList.get(i).getSH_SALES_PROJECTIONS();

				/* ========매출달성======== */
				//상반기
				FH_achSale.put(teamList.get(key), FH_achSale.get(teamList.get(key)) + pjList.get(i).getFH_SALES());
				FH_totalachSale += pjList.get(i).getFH_SALES();
				//하반기
				SH_achSale.put(teamList.get(key), SH_achSale.get(teamList.get(key)) + pjList.get(i).getSH_SALES());
				SH_totalachSale += pjList.get(i).getSH_SALES();
				//연간
				Y_achSale.put(teamList.get(key), Y_achSale.get(teamList.get(key)) + pjList.get(i).getFH_SALES() + pjList.get(i).getSH_SALES());
				Y_totalachSale += pjList.get(i).getFH_SALES() + pjList.get(i).getSH_SALES();
			}
		}
	}
	
	
	/*
	
	매출 보정 start
	
	*/
	
	// 팀별 보정
	LinkedHashMap<String, LinkedHashMap<String, ArrayList<CMSBean>>> corrVal = new LinkedHashMap<String, LinkedHashMap<String, ArrayList<CMSBean>>>();
	for(int key : teamList.keySet()){
		LinkedHashMap<String, ArrayList<CMSBean>> val = new LinkedHashMap<String, ArrayList<CMSBean>>();
		val.put("plus", summaryDao.getCMS_plusList(teamList.get(key), nowYear));
		val.put("minus", summaryDao.getCMS_minusList(teamList.get(key), nowYear));
		corrVal.put(teamList.get(key), val);
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
.sidebar{
		position:relative;
		z-index:997;
}
#dataTable{
	font-size:small;
	float:left;
	max-width:750px;
}
.firstTD.orderTD{
	background: #a3c7e494;
}

.firstTD.saleTD{
	background:#6cabe094;
}
.firstTD{
	background:#64b5f98f;
}
.lastTD{
	background:#efa465ab;
}
.lastTD.orderTD{
	background:#deb38f7a;
}
.lastTD.saleTD{
	background:#e48b4069;
}
.yearTD{
	background:#b0d2a2;
}
.yearTD.orderTD{
	background:#b8d8aa78;
}
.yearTD.saleTD{
	background:#9dc78aa6;
}
#os_chart{
	display:block;
}
.sidebar .nav-item{
	 	word-break: keep-all;
}
#sidebarToggle{
		display:none;
	}
.chart{
     float:right;
}
.google-visualization-tooltip{
		
		
	} 
.chart{
	width:50% !important;
}

	.pie{
		height:350px;
		width:500px;
	}
	.table td{
		padding:0.2rem;
		font-weight:bold !important;
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
	
	table:not(.memchart):not(#intern){ 
	white-space: nowrap;
	display:table-cell;
	overflow:auto;
	white-space: nowrap;
	}
	
	@media(max-width:765px){
		#sidebarToggle{
			display:inline;
		}
		.container-fluid{
			margin-top: 80px;
		}
		.chart{
			width:100% !important;
		}
		.sidebar .nav-item{
		 	white-space:nowrap !important;
		 	font-size: x-large !important;	 	
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
			font-size:small;
		}
			
		#dataTable{
			width:100%;
			table-layout:fixed;
		}
		#dataTable thead th, #dataTable tbody td{
			overflow: hidden;
			white-space: nowrap;
		}
		
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
		width : 75px;
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
	
	.changeCompeData{
		 width:42px;
		 margin-right:0px;
	}
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.0.min.js" ></script>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.js"></script>
<script type="text/javascript">
  
/* 막대 차트 */
google.charts.load('current', {'packages':['corechart', 'bar']});
google.charts.setOnLoadCallback(fh_order);
google.charts.setOnLoadCallback(fh_sales);
google.charts.setOnLoadCallback(sh_order);
google.charts.setOnLoadCallback(sh_sales);
google.charts.setOnLoadCallback(y_order);
google.charts.setOnLoadCallback(y_sales);

// 상반기 수주 차트 그리기
function fh_order() {
	 <%
	 	HashMap<Integer, StringBuffer> table_fh_order = new HashMap<Integer, StringBuffer>();
	 	total_goal_str = new StringBuffer();
	 	total_goal_str.append("<table class=tootipTable><tr><td>팀</td><td>목표수주</td><td>예상수주</td><td>수주달성</td></tr>");
	 	for(int key : teamList.keySet()){
	 		StringBuffer element = new StringBuffer();
	 		element.append("<table class=tootipTable>");
		element.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
		
		for(int i=0; i<pjList.size(); i++){
	  		if(pjList.get(i).getTEAM_ORDER().equals(teamList.get(key))){
	  			element.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
	  				+pjList.get(i).getFH_ORDER_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_ORDER()+"</td></tr>");
	  		}
		}
		
		element.append("<tr><td>total</td><td>"+FH_preOrder.get(teamList.get(key))+"</td><td>"+FH_achOrder.get(teamList.get(key))+"</td></tr>");
		element.append("<tr><td colspan=3>목표수주 : "+FH_goalOrder.get(teamList.get(key))+" (백만)</td></tr>");
		element.append("</table>");
		
		table_fh_order.put(key, element);
		if(key != 0){
			total_goal_str.append("<tr><td>" + teamList.get(key).substring(0, 4) + "</td><td>" + FH_goalOrder.get(teamList.get(key))
						+ "</td><td>" + FH_preOrder.get(teamList.get(key)) + "</td><td>" + FH_achOrder.get(teamList.get(key)) + "</td></tr>");
		}
	 	}
	 	total_goal_str.append("</table>");
	 %>
	  		
    var dataTable = new google.visualization.DataTable();
    dataTable.addColumn('string', 'Team');
    dataTable.addColumn('number', '목표수주');
    dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
    dataTable.addColumn('number', '예상수주');
    dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
    dataTable.addColumn('number', '수주달성');
    dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
    dataTable.addRows([
  	  	['Total', <%=FH_totalGoalOrder%>, '<%=total_goal_str%>', <%=FH_totalpreOrder%>, '<%=total_goal_str%>', <%=FH_totalachOrder%>, '<%=total_goal_str%>']
  	  	<%for(int key : teamList.keySet()){
  	  		if(key != 0){%>
        ,['<%=teamList.get(key).substring(0, 4)%>', <%=FH_goalOrder.get(teamList.get(key))%>,'<%=table_fh_order.get(key)%>',<%=FH_preOrder.get(teamList.get(key))%>,'<%=table_fh_order.get(key)%>', <%=FH_achOrder.get(teamList.get(key))%>, '<%=table_fh_order.get(key)%>']
  	  	<%}}%>
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

//상반기 매출 차트 그리기
function fh_sales() {
    <%
    HashMap<Integer, StringBuffer> table_fh_sales = new HashMap<Integer, StringBuffer>();
    total_goal_str = new StringBuffer();
    total_goal_str.append("<table class=tootipTable><tr><td>팀</td><td>목표매출</td><td>예상매출</td><td>매출달성</td></tr>");
    for(int key : teamList.keySet()){
         StringBuffer element = new StringBuffer();
         element.append("<table class=tootipTable>");
         element.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
         
         for(int i=0; i<pjList.size(); i++){
              if(pjList.get(i).getTEAM_SALES().equals(teamList.get(key))){
                   element.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
                        +pjList.get(i).getFH_SALES_PROJECTIONS()+"</td><td>"+pjList.get(i).getFH_SALES()+"</td></tr>");
              }
         }
         
         element.append("<tr><td>total</td><td>"+FH_preSale.get(teamList.get(key))+"</td><td>"+FH_achSale.get(teamList.get(key))+"</td></tr>");
         element.append("<tr><td colspan=3>목표매출 : "+FH_goalSale.get(teamList.get(key))+" (백만)</td></tr>");
         element.append("</table>");
         
         table_fh_sales.put(key, element);
         if(key != 0){
              total_goal_str.append("<tr><td>" + teamList.get(key).substring(0, 4) + "</td><td>" + FH_goalSale.get(teamList.get(key))
                             + "</td><td>" + FH_preSale.get(teamList.get(key)) + "</td><td>" + FH_achSale.get(teamList.get(key)) + "</td></tr>");
         }
    }
    total_goal_str.append("</table>");
    %>
               
    var dataTable = new google.visualization.DataTable();
    dataTable.addColumn('string', 'Team');
    dataTable.addColumn('number', '목표매출');
    dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
    dataTable.addColumn('number', '예상매출');
    dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
    dataTable.addColumn('number', '매출달성');
    dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
    dataTable.addRows([
          ['Total', <%=FH_totalGoalSale%>, '<%=total_goal_str%>', <%=FH_totalpreSale%>, '<%=total_goal_str%>', <%=FH_totalachSale%>, '<%=total_goal_str%>']
          <%for(int key : teamList.keySet()){
               if(key != 0){%>
        ,['<%=teamList.get(key).substring(0, 4)%>', <%=FH_goalSale.get(teamList.get(key))%>,'<%=table_fh_sales.get(key)%>',<%=FH_preSale.get(teamList.get(key))%>,'<%=table_fh_sales.get(key)%>', <%=FH_achSale.get(teamList.get(key))%>, '<%=table_fh_sales.get(key)%>']
          <%}}%>
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

//하반기 수주 바차트 그리기
function sh_order() {	
	<%
  	HashMap<Integer, StringBuffer> table_sh_order = new HashMap<Integer, StringBuffer>();
  	total_goal_str = new StringBuffer();
  	total_goal_str.append("<table class=tootipTable><tr><td>팀</td><td>목표수주</td><td>예상수주</td><td>수주달성</td></tr>");
  	for(int key : teamList.keySet()){
  		StringBuffer element = new StringBuffer();
  		element.append("<table class=tootipTable>");
		element.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
		
		for(int i=0; i<pjList.size(); i++){
	  		if(pjList.get(i).getTEAM_ORDER().equals(teamList.get(key))){
	  			element.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
	  				+pjList.get(i).getSH_ORDER_PROJECTIONS()+"</td><td>"+pjList.get(i).getSH_ORDER()+"</td></tr>");
	  		}
		}
		
		element.append("<tr><td>total</td><td>"+SH_preOrder.get(teamList.get(key))+"</td><td>"+SH_achOrder.get(teamList.get(key))+"</td></tr>");
		element.append("<tr><td colspan=3>목표수주 : "+SH_goalOrder.get(teamList.get(key))+" (백만)</td></tr>");
		element.append("</table>");
		
		table_sh_order.put(key, element);
		if(key != 0){
			total_goal_str.append("<tr><td>" + teamList.get(key).substring(0, 4) + "</td><td>" + SH_goalOrder.get(teamList.get(key))
						+ "</td><td>" + SH_preOrder.get(teamList.get(key)) + "</td><td>" + SH_achOrder.get(teamList.get(key)) + "</td></tr>");
		}
  	}
  	total_goal_str.append("</table>");
	 %>
	  		
	var dataTable = new google.visualization.DataTable();
	dataTable.addColumn('string', 'Team');
	dataTable.addColumn('number', '목표수주');
	dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
	dataTable.addColumn('number', '예상수주');
	dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
	dataTable.addColumn('number', '수주달성');
	dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
	dataTable.addRows([
		  	['Total', <%=SH_totalGoalOrder%>, '<%=total_goal_str%>', <%=SH_totalpreOrder%>, '<%=total_goal_str%>', <%=SH_totalachOrder%>, '<%=total_goal_str%>']
		  	<%for(int key : teamList.keySet()){
		  		if(key != 0){%>
	    ,['<%=teamList.get(key).substring(0, 4)%>', <%=SH_goalOrder.get(teamList.get(key))%>,'<%=table_sh_order.get(key)%>',<%=SH_preOrder.get(teamList.get(key))%>,'<%=table_sh_order.get(key)%>', <%=SH_achOrder.get(teamList.get(key))%>, '<%=table_sh_order.get(key)%>']
		  	<%}}%>
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

//하반기 매출 바차트 그리기
function sh_sales() {
	<%
    HashMap<Integer, StringBuffer> table_sh_sales = new HashMap<Integer, StringBuffer>();
    total_goal_str = new StringBuffer();
    total_goal_str.append("<table class=tootipTable><tr><td>팀</td><td>목표매출</td><td>예상매출</td><td>매출달성</td></tr>");
    for(int key : teamList.keySet()){
         StringBuffer element = new StringBuffer();
         element.append("<table class=tootipTable>");
         element.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
         
         for(int i=0; i<pjList.size(); i++){
              if(pjList.get(i).getTEAM_SALES().equals(teamList.get(key))){
                   element.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
                        +pjList.get(i).getSH_SALES_PROJECTIONS()+"</td><td>"+pjList.get(i).getSH_SALES()+"</td></tr>");
              }
         }
         
         element.append("<tr><td>total</td><td>"+SH_preSale.get(teamList.get(key))+"</td><td>"+SH_achSale.get(teamList.get(key))+"</td></tr>");
         element.append("<tr><td colspan=3>목표매출 : "+SH_goalSale.get(teamList.get(key))+" (백만)</td></tr>");
         element.append("</table>");
         
         table_sh_sales.put(key, element);
         if(key != 0){
              total_goal_str.append("<tr><td>" + teamList.get(key).substring(0, 4) + "</td><td>" + SH_goalSale.get(teamList.get(key))
                             + "</td><td>" + SH_preSale.get(teamList.get(key)) + "</td><td>" + SH_achSale.get(teamList.get(key)) + "</td></tr>");
         }
    }
    total_goal_str.append("</table>");
	%>
	         
	var dataTable = new google.visualization.DataTable();
	dataTable.addColumn('string', 'Team');
	dataTable.addColumn('number', '목표매출');
	dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
	dataTable.addColumn('number', '예상매출');
	dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
	dataTable.addColumn('number', '매출달성');
	dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
	dataTable.addRows([
	    ['Total', <%=SH_totalGoalSale%>, '<%=total_goal_str%>', <%=SH_totalpreSale%>, '<%=total_goal_str%>', <%=SH_totalachSale%>, '<%=total_goal_str%>']
	    <%for(int key : teamList.keySet()){
	         if(key != 0){%>
	  ,['<%=teamList.get(key).substring(0, 4)%>', <%=SH_goalSale.get(teamList.get(key))%>,'<%=table_sh_sales.get(key)%>',<%=SH_preSale.get(teamList.get(key))%>,'<%=table_sh_sales.get(key)%>', <%=SH_achSale.get(teamList.get(key))%>, '<%=table_sh_sales.get(key)%>']
	    <%}}%>
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

//연간 수주 바차트 그리기
function y_order() {
	<%
  	HashMap<Integer, StringBuffer> table_y_order = new HashMap<Integer, StringBuffer>();
  	total_goal_str = new StringBuffer();
  	total_goal_str.append("<table class=tootipTable><tr><td>팀</td><td>목표수주</td><td>예상수주</td><td>수주달성</td></tr>");
  	for(int key : teamList.keySet()){
  		StringBuffer element = new StringBuffer();
  		element.append("<table class=tootipTable>");
		element.append("<tr><td>프로젝트</td><td>예상수주</td><td>수주달성</td></tr>");
		
		for(int i=0; i<pjList.size(); i++){
	  		if(pjList.get(i).getTEAM_ORDER().equals(teamList.get(key))){
	  			float y_val_preOrder = pjList.get(i).getFH_ORDER_PROJECTIONS() + pjList.get(i).getSH_ORDER_PROJECTIONS();
	  			float y_val_order = pjList.get(i).getFH_ORDER() + pjList.get(i).getSH_ORDER();
	  			element.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
	  				+y_val_preOrder+"</td><td>"+y_val_order+"</td></tr>");
	  		}
		}
		
		element.append("<tr><td>total</td><td>"+Y_preOrder.get(teamList.get(key))+"</td><td>"+Y_achOrder.get(teamList.get(key))+"</td></tr>");
		element.append("<tr><td colspan=3>목표수주 : "+Y_goalOrder.get(teamList.get(key))+" (백만)</td></tr>");
		element.append("</table>");
		
		table_y_order.put(key, element);
		if(key != 0){
			total_goal_str.append("<tr><td>" + teamList.get(key).substring(0, 4) + "</td><td>" + Y_goalOrder.get(teamList.get(key))
						+ "</td><td>" + Y_preOrder.get(teamList.get(key)) + "</td><td>" + Y_achOrder.get(teamList.get(key)) + "</td></tr>");
		}
  	}
  	total_goal_str.append("</table>");
	 %>
	  		
	var dataTable = new google.visualization.DataTable();
	dataTable.addColumn('string', 'Team');
	dataTable.addColumn('number', '목표수주');
	dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
	dataTable.addColumn('number', '예상수주');
	dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
	dataTable.addColumn('number', '수주달성');
	dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
	dataTable.addRows([
		  	['Total', <%=Y_totalGoalOrder%>, '<%=total_goal_str%>', <%=Y_totalpreOrder%>, '<%=total_goal_str%>', <%=Y_totalachOrder%>, '<%=total_goal_str%>']
		  	<%for(int key : teamList.keySet()){
		  		if(key != 0){%>
	    ,['<%=teamList.get(key).substring(0, 4)%>', <%=Y_goalOrder.get(teamList.get(key))%>,'<%=table_y_order.get(key)%>',<%=Y_preOrder.get(teamList.get(key))%>,'<%=table_y_order.get(key)%>', <%=Y_achOrder.get(teamList.get(key))%>, '<%=table_y_order.get(key)%>']
		  	<%}}%>
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

//연간 매출 바차트 그리기
function y_sales() {
	<%
    HashMap<Integer, StringBuffer> table_y_sales = new HashMap<Integer, StringBuffer>();
    total_goal_str = new StringBuffer();
    total_goal_str.append("<table class=tootipTable><tr><td>팀</td><td>목표매출</td><td>예상매출</td><td>매출달성</td></tr>");
    for(int key : teamList.keySet()){
         StringBuffer element = new StringBuffer();
         element.append("<table class=tootipTable>");
         element.append("<tr><td>프로젝트</td><td>예상매출</td><td>매출달성</td></tr>");
         
         for(int i=0; i<pjList.size(); i++){
              if(pjList.get(i).getTEAM_SALES().equals(teamList.get(key))){
            	  	float y_val_preSales = pjList.get(i).getFH_SALES_PROJECTIONS() + pjList.get(i).getSH_SALES_PROJECTIONS();
  	  				float y_val_sales = pjList.get(i).getFH_SALES() + pjList.get(i).getSH_SALES();
                   	element.append("<tr><td>"+pjList.get(i).getPROJECT_NAME()+"</td><td>"
                        +y_val_preSales+"</td><td>"+y_val_sales+"</td></tr>");
              }
         }
         
         element.append("<tr><td>total</td><td>"+Y_preSale.get(teamList.get(key))+"</td><td>"+Y_achSale.get(teamList.get(key))+"</td></tr>");
         element.append("<tr><td colspan=3>목표매출 : "+Y_goalSale.get(teamList.get(key))+" (백만)</td></tr>");
         element.append("</table>");
         
         table_y_sales.put(key, element);
         if(key != 0){
              total_goal_str.append("<tr><td>" + teamList.get(key).substring(0, 4) + "</td><td>" + Y_goalSale.get(teamList.get(key))
                             + "</td><td>" + Y_preSale.get(teamList.get(key)) + "</td><td>" + Y_achSale.get(teamList.get(key)) + "</td></tr>");
         }
    }
    total_goal_str.append("</table>");
	%>
	         
	var dataTable = new google.visualization.DataTable();
	dataTable.addColumn('string', 'Team');
	dataTable.addColumn('number', '목표매출');
	dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
	dataTable.addColumn('number', '예상매출');
	dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
	dataTable.addColumn('number', '매출달성');
	dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
	dataTable.addRows([
	    ['Total', <%=Y_totalGoalSale%>, '<%=total_goal_str%>', <%=Y_totalpreSale%>, '<%=total_goal_str%>', <%=Y_totalachSale%>, '<%=total_goal_str%>']
	    <%for(int key : teamList.keySet()){
	         if(key != 0){%>
	  ,['<%=teamList.get(key).substring(0, 4)%>', <%=Y_goalSale.get(teamList.get(key))%>,'<%=table_y_sales.get(key)%>',<%=Y_preSale.get(teamList.get(key))%>,'<%=table_y_sales.get(key)%>', <%=Y_achSale.get(teamList.get(key))%>, '<%=table_y_sales.get(key)%>']
	    <%}}%>
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
	    ['Count', 'How Many']
	    <%for(int key : teamList.keySet()){
	    	if(key != 0){%>
	    ,['<%=teamList.get(key).substring(0, 4)%>', <%=FH_achOrder.get(teamList.get(key))%>]
	    <%}}%>
	    ,['실', <%=FH_achOrder.get(teamList.get(0))%>]
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
	    ['Count', 'How Many']
	    <%for(int key : teamList.keySet()){
	    	if(key != 0){%>
	    ,['<%=teamList.get(key).substring(0, 4)%>', <%=SH_achOrder.get(teamList.get(key))%>]
	    <%}}%>
	    ,['실', <%=SH_achOrder.get(teamList.get(0))%>]
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
	    ['Count', 'How Many']
	    <%for(int key : teamList.keySet()){
	    	if(key != 0){%>
	    ,['<%=teamList.get(key).substring(0, 4)%>', <%=Y_achOrder.get(teamList.get(key))%>]
	    <%}}%>
	    ,['실', <%=Y_achOrder.get(teamList.get(0))%>]
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
	    ['Count', 'How Many']
	    <%for(int key : teamList.keySet()){
	    	if(key != 0){%>
	    ,['<%=teamList.get(key).substring(0, 4)%>', <%=FH_achSale.get(teamList.get(key))%>]
	    <%}}%>
	    ,['실', <%=FH_achSale.get(teamList.get(0))%>]
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
	    ['Count', 'How Many']
	    <%for(int key : teamList.keySet()){
	    	if(key != 0){%>
	    ,['<%=teamList.get(key).substring(0, 4)%>', <%=SH_achSale.get(teamList.get(key))%>]
	    <%}}%>
	    ,['실', <%=SH_achSale.get(teamList.get(0))%>]
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
	    ['Count', 'How Many']
	    <%for(int key : teamList.keySet()){
	    	if(key != 0){%>
	    ,['<%=teamList.get(key).substring(0, 4)%>', <%=Y_achSale.get(teamList.get(key))%>]
	    <%}}%>
	    ,['실', <%=Y_achSale.get(teamList.get(0))%>]
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
		 var arr = [4, 6, 9, 12, 13, 16, 18, 21, 24, 25, 28, 30, 33, 36, 37];
		 for(var i=0; i<16; i++){
			 for(var a=1; a<8; a++){
				 data =  $('#dataTable tr:eq('+arr[i]+') td:eq('+a+')').text().split(".")[0];
				 z = (data/100)+0.1;
				 $('#dataTable tr:eq('+arr[i]+') td:eq('+a+')').css('background', 'rgb(130,130,250, '+z+')')
				 if(i == 4 || i == 9 || i == 14){
					 $('#dataTable tr:eq('+arr[i]+') td:eq('+a+')').css('color','red');
					 $('#dataTable tr:eq('+arr[i]+') td:eq('+a+')').css('text-shadow','white 0px 0px 3px');
				 }else{
				 	$('#dataTable tr:eq('+arr[i]+') td:eq('+a+')').css('color','white');
				 }
			 }
		 }
	}
	
	function orderByDate(){
		<%
			SimpleDateFormat sf_mm = new SimpleDateFormat("MM");
		%>
		var month = <%=Integer.parseInt(sf_mm.format(nowTime))%>;
		if(month > 6){
			$('#tab-4').after($('#tab-3'));
			$('#tab-3').after($('#tab-2'));
		}
	}
	
	function summaryOSchartAll(){
		//checkALL
		$('#checkALL').change(function(){
			if(!($('#checkALL').is(":checked"))){
				$('.firstTD').css('visibility', 'collapse');
				$('.lastTD').css('visibility', 'collapse');
				$('.yearTD').css('visibility', 'collapse');
				$('#checkFIRST').prop('checked', false);
				$('#checkLAST').prop('checked', false);
				$('#checkYEAR').prop('checked', false);
				$('#checkORDER').prop('checked', false);
				$('#checkSALE').prop('checked', false);
				$('#checkDATA').prop('checked', false);
				$('#checkRATE').prop('checked', false);
			}else{
				$('.firstTD').css('visibility', 'visible');
				$('.lastTD').css('visibility', 'visible');
				$('.yearTD').css('visibility', 'visible');
				$('#checkFIRST').prop('checked', true);
				$('#checkLAST').prop('checked', true);
				$('#checkYEAR').prop('checked', true);
				$('#checkORDER').prop('checked', true);
				$('#checkSALE').prop('checked', true);
				$('#checkDATA').prop('checked', true);
				$('#checkRATE').prop('checked', true);
			}
		});
		
		//checkFIRST
		$('#checkFIRST').change(function(){
			if(!($('#checkFIRST').is(":checked"))){
				$('.firstTD').css('visibility', 'collapse');
			}else{
				$('.firstTD').css('visibility', 'visible');
				if(!($('#checkORDER').is(":checked"))){
					$('.orderTD').css('visibility', 'collapse');
				}
				if(!($('#checkSALE').is(":checked"))){
					$('.saleTD').css('visibility', 'collapse');
				}
				if(!($('#checkRATE').is(":checked"))){
					$('.rateTD').css('visibility', 'collapse');
				}
				if(!($('#checkDATA').is(":checked"))){
					$('.dataTD').css('visibility', 'collapse');
				}
			}
		});
		
		//checkLAST
		$('#checkLAST').change(function(){
			if(!($('#checkLAST').is(":checked"))){
				$('.lastTD').css('visibility', 'collapse');
			}else{
				$('.lastTD').css('visibility', 'visible');
				if(!($('#checkORDER').is(":checked"))){
					$('.orderTD').css('visibility', 'collapse');
				}
				if(!($('#checkSALE').is(":checked"))){
					$('.saleTD').css('visibility', 'collapse');
				}
				if(!($('#checkRATE').is(":checked"))){
					$('.rateTD').css('visibility', 'collapse');
				}
				if(!($('#checkDATA').is(":checked"))){
					$('.dataTD').css('visibility', 'collapse');
				}
			}
		});
		
		//checkYEAR
		$('#checkYEAR').change(function(){
			if(!($('#checkYEAR').is(":checked"))){
				$('.yearTD').css('visibility', 'collapse');
			}else{
				$('.yearTD').css('visibility', 'visible');
				if(!($('#checkORDER').is(":checked"))){
					$('.orderTD').css('visibility', 'collapse');
				}
				if(!($('#checkSALE').is(":checked"))){
					$('.saleTD').css('visibility', 'collapse');
				}
				if(!($('#checkRATE').is(":checked"))){
					$('.rateTD').css('visibility', 'collapse');
				}
				if(!($('#checkDATA').is(":checked"))){
					$('.dataTD').css('visibility', 'collapse');
				}
			}
		});
		
		//checkORDER
		$('#checkORDER').change(function(){
			if(!($('#checkORDER').is(":checked"))){
				$('.orderTD').css('visibility', 'collapse');
				if(!($('#checkFIRST').is(":checked"))){
					$('.firstTD').css('visibility', 'collapse');
				}else{
					$('.firstTag').css('visibility', 'visible');
				}
				if(!($('#checkLAST').is(":checked"))){
					$('.lastTD').css('visibility', 'collapse');
				}else{
					$('.lastTag').css('visibility', 'visible');
				}
				if(!($('#checkYEAR').is(":checked"))){
					$('.yearTD').css('visibility', 'collapse');
				}else{
					$('.yearTag').css('visibility', 'visible');
				}
			}else{
				$('.orderTD').css('visibility', 'visible');
				if(!($('#checkFIRST').is(":checked"))){
					$('.firstTD').css('visibility', 'collapse');
				}else{
					$('.firstTag').css('visibility', 'visible');
				}
				if(!($('#checkLAST').is(":checked"))){
					$('.lastTD').css('visibility', 'collapse');
				}else{
					$('.lastTag').css('visibility', 'visible');
				}
				if(!($('#checkYEAR').is(":checked"))){
					$('.yearTD').css('visibility', 'collapse');
				}else{
					$('.yearTag').css('visibility', 'visible');
				}
				if(!($('#checkRATE').is(":checked"))){
					$('.rateTD').css('visibility', 'collapse');
				}
				if(!($('#checkDATA').is(":checked"))){
					$('.dataTD').css('visibility', 'collapse');
				}
			}
		});
		
		//checkSALE
		$('#checkSALE').change(function(){
			if(!($('#checkSALE').is(":checked"))){
				$('.saleTD').css('visibility', 'collapse');
				if(!($('#checkFIRST').is(":checked"))){
					$('.firstTD').css('visibility', 'collapse');
				}else{
					$('.firstTag').css('visibility', 'visible');
				}
				if(!($('#checkLAST').is(":checked"))){
					$('.lastTD').css('visibility', 'collapse');
				}else{
					$('.lastTag').css('visibility', 'visible');
				}
				if(!($('#checkYEAR').is(":checked"))){
					$('.yearTD').css('visibility', 'collapse');
				}else{
					$('.yearTag').css('visibility', 'visible');
				}
			}else{
				$('.saleTD').css('visibility', 'visible');
				if(!($('#checkFIRST').is(":checked"))){
					$('.firstTD').css('visibility', 'collapse');
				}else{
					$('.firstTag').css('visibility', 'visible');
				}
				if(!($('#checkLAST').is(":checked"))){
					$('.lastTD').css('visibility', 'collapse');
				}else{
					$('.lastTag').css('visibility', 'visible');
				}
				if(!($('#checkYEAR').is(":checked"))){
					$('.yearTD').css('visibility', 'collapse');
				}else{
					$('.yearTag').css('visibility', 'visible');
				}
				if(!($('#checkRATE').is(":checked"))){
					$('.rateTD').css('visibility', 'collapse');
				}
				if(!($('#checkDATA').is(":checked"))){
					$('.dataTD').css('visibility', 'collapse');
				}
			}
		});
		
		//checkRATE
		$('#checkRATE').change(function(){
			if(!($('#checkRATE').is(":checked"))){
				$('.rateTD').css('visibility', 'collapse');
				if(!($('#checkFIRST').is(":checked"))){
					$('.firstTD').css('visibility', 'collapse');
				}else{
					$('.firstTag').css('visibility', 'visible');
				}
				if(!($('#checkLAST').is(":checked"))){
					$('.lastTD').css('visibility', 'collapse');
				}else{
					$('.lastTag').css('visibility', 'visible');
				}
				if(!($('#checkYEAR').is(":checked"))){
					$('.yearTD').css('visibility', 'collapse');
				}else{
					$('.yearTag').css('visibility', 'visible');
				}
			}else{
				$('.rateTD').css('visibility', 'visible');
				if(!($('#checkFIRST').is(":checked"))){
					$('.firstTD').css('visibility', 'collapse');
				}else{
					$('.firstTag').css('visibility', 'visible');
				}
				if(!($('#checkLAST').is(":checked"))){
					$('.lastTD').css('visibility', 'collapse');
				}else{
					$('.lastTag').css('visibility', 'visible');
				}
				if(!($('#checkYEAR').is(":checked"))){
					$('.yearTD').css('visibility', 'collapse');
				}else{
					$('.yearTag').css('visibility', 'visible');
				}
				if(!($('#checkORDER').is(":checked"))){
					$('.orderTD').css('visibility', 'collapse');
				}
				if(!($('#checkSALE').is(":checked"))){
					$('.saleTD').css('visibility', 'collapse');
				}
			}
		});
		
		//checkDATA
		$('#checkDATA').change(function(){
			if(!($('#checkDATA').is(":checked"))){
				$('.dataTD').css('visibility', 'collapse');
				if(!($('#checkFIRST').is(":checked"))){
					$('.firstTD').css('visibility', 'collapse');
				}else{
					$('.firstTag').css('visibility', 'visible');
				}
				if(!($('#checkLAST').is(":checked"))){
					$('.lastTD').css('visibility', 'collapse');
				}else{
					$('.lastTag').css('visibility', 'visible');
				}
				if(!($('#checkYEAR').is(":checked"))){
					$('.yearTD').css('visibility', 'collapse');
				}else{
					$('.yearTag').css('visibility', 'visible');
				}
			}else{
				$('.dataTD').css('visibility', 'visible');
				if(!($('#checkFIRST').is(":checked"))){
					$('.firstTD').css('visibility', 'collapse');
				}else{
					$('.firstTag').css('visibility', 'visible');
				}
				if(!($('#checkLAST').is(":checked"))){
					$('.lastTD').css('visibility', 'collapse');
				}else{
					$('.lastTag').css('visibility', 'visible');
				}
				if(!($('#checkYEAR').is(":checked"))){
					$('.yearTD').css('visibility', 'collapse');
				}else{
					$('.yearTag').css('visibility', 'visible');
				}
				if(!($('#checkORDER').is(":checked"))){
					$('.orderTD').css('visibility', 'collapse');
				}
				if(!($('#checkSALE').is(":checked"))){
					$('.saleTD').css('visibility', 'collapse');
				}
			}
		});
	}
	
    function viewDetail(team, time){
    	var popupX = (document.body.offsetWidth/2)-(600/2);
    	var sale = 0;
    	var saleSet = 0;
    	if(time == '상반기'){
    		if(team == 'Total'){
        		sale = <%=FH_totalachSale%>;
        		saleSet = <%=cmsRate.get(0).get("Total") %>
        	} else{
    	    	<%for(int key : teamList.keySet()){%>
    	    		if(team == '<%=teamList.get(key)%>'){
    	    			sale = <%=FH_achSale.get(teamList.get(key))%>;
    	    			saleSet = <%=cmsRate.get(0).get(teamList.get(key)) %>;
    	    		}
    	    	<%}%>
        	}
    	}else if(time == '하반기'){
    		if(team == 'Total'){
        		sale = <%=SH_totalachSale%>;
        		saleSet = <%=cmsRate.get(1).get("Total") %>
        	} else{
    	    	<%for(int key : teamList.keySet()){%>
    	    		if(team == '<%=teamList.get(key)%>'){
    	    			sale = <%=SH_achSale.get(teamList.get(key))%>;
    	    			saleSet = <%=cmsRate.get(1).get(teamList.get(key)) %>;
    	    		}
    	    	<%}%>
        	}
    	}else if(time == '연간'){
    		if(team == 'Total'){
        		sale = <%=Y_totalachSale%>;
        		saleSet = <%=cmsRate.get(2).get("Total") %>
        	} else{
    	    	<%for(int key : teamList.keySet()){%>
    	    		if(team == '<%=teamList.get(key)%>'){
    	    			sale = <%=Y_achSale.get(teamList.get(key))%>;
    	    			saleSet = <%=cmsRate.get(2).get(teamList.get(key)) %>;
    	    		}
    	    	<%}%>
        	}
    	}
    	
    	window.open('summary_PopUp.jsp?team='+team + '&time=' + time + '&sale=' + sale + '&saleSet=' + saleSet + '&year=' + '<%=nowYear%>', 'popUpWindow', 'toolbar=yes,status=yes, menubar=yes, left='+popupX+', top=10, width=1000, height=700');
    }
    
    function loadYear(){
		var year = $('#selYear').val();
		location.href ="summary.jsp?selectYear="+year;
	}
	
	$(document).ready(function(){
		$('.loading').hide();
		stateColor();
		orderByDate();
		$('#selYear').val(<%=nowYear%>).prop("selected",true);
		
		$('ul.tabs li').click(function() {
			var tab_id = $(this).attr('data-tab');

			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');

			$(this).addClass('current');
			$("#" + tab_id).addClass('current');
		});
		
		summaryOSchartAll();

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

			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../mypage/mypage.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>마이페이지</span></a></li>

			<!-- Nav Item - summary -->
			<li class="nav-item active"><a class="nav-link"
				href="../summary/summary.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>수입 요약</span></a></li>

			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../expense_sum/expense_sum.jsp"> <i
					class="fas fa-fw fa-table"></i> <span>지출 요약</span></a></li>

			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../profit_analysis/profit_analysis.jsp"> <i
					class="fas fa-fw fa-table"></i> <span>수익성 분석</span></a></li>

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


					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary"
								style="padding-left: 17px;">
								수주 & 매출 <select id="selYear" name="selYear"
									onchange="loadYear()">
									<%for(int i=0; i<yearCount; i++){%>
									<option value='<%=maxYear-i%>'><%=maxYear-i%></option>
									<%}%>
								</select>
							</h6>
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
									<label style="margin-right: 7px;"><input id="checkALL"
										class="OSchartClass" type="checkbox" checked>ALL</label> <label
										style="margin-right: 7px;"><input id="checkFIRST"
										class="OSchartClass" type="checkbox" checked>상반기</label> <label
										style="margin-right: 7px;"><input id="checkLAST"
										class="OSchartClass" type="checkbox" checked>하반기</label> <label
										style="margin-right: 7px;"><input id="checkYEAR"
										class="OSchartClass" type="checkbox" checked>연간</label> <label
										style="margin-right: 7px;"><input id="checkORDER"
										class="OSchartClass" type="checkbox" checked>수주</label> <label
										style="margin-right: 7px;"><input id="checkSALE"
										class="OSchartClass" type="checkbox" checked>매출</label> <label
										style="margin-right: 7px;"><input id="checkRATE"
										class="OSchartClass" type="checkbox" checked>비율</label> <label
										style="margin-right: 7px;"><input id="checkDATA"
										class="OSchartClass" type="checkbox" checked>값</label>
									<%if(permission == 0){ %>
									<div id="setRankCompe"
										style="margin-bottom: 10px; font-size: small; width:">
										<form name="changeCompe" method="post"
											action="./summary_changeComp.jsp">
											<p
												style="color: black; margin-bottom: 0px; display: list-item; margin-left: 16px;">
												<b>매출 보정 기준값 변경(단위:만)</b>
											</p>
											<p style="margin-left: 15px;">
												수석 : <input name="1step" class="changeCompeData"
													value="<%=RankCompe.get("수석")%>" /> 책임 : <input
													name="2step" class="changeCompeData"
													value="<%=RankCompe.get("책임")%>" /> 선임 : <input
													name="3step" class="changeCompeData"
													value="<%=RankCompe.get("선임")%>" /> 전임 : <input
													name="4step" class="changeCompeData"
													value="<%=RankCompe.get("전임")%>" /> <input type="submit"
													class="btn btn-primary" name="setCompe" value="변경"
													style="font-size: xx-small; vertical-align: bottom; margin-left: 10px;" />
											</p>
										</form>
									</div>
									<%} %>

									<form method="post" action="Save_targetData.jsp">
										<input type="hidden" name="nowYear" value="<%=nowYear %>">
										<div class="table-responsive">
											<table class="table table-bordered" id="dataTable">
												<thead>
													<tr>
														<td colspan="3" style="border: 0px;"></td>
														<td colspan="<%=teamList.size()-1%>"
															style="text-align: center; background-color: #5a6f7730;">상세내역(단위:
															백만)</td>
														<td>
															<%if(permission == 0){%>
															<input type="submit" value="저장">
															<%	}%>
														</td>
													</tr>
													<tr
														style="text-align: center; background-color: #5a6f7730;">
														<th>구분</th>
														<th>항목</th>
														<th>Total</th>
														<%for(int key : teamList.keySet()){
	                    									if(key != 0){%>
														<th><%=teamList.get(key).substring(0,4) %></th>
														<%}}%>
														<th>실</th>
													</tr>
												</thead>

												<tbody>
													<!-- 상반기목표수주 -->
													<tr class="firstTD orderTD dataTD">
														<td rowspan="12"
															style="text-align: center; font-size: medium; padding-top: 10px"
															class="firstTD firstTag">상반기</td>
														<td style="text-align: center; vertical-align: middle;">목표
															수주</td>
														<td><%=FH_totalGoalOrder%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><input class="sale" name="FH_<%=key%>_PJ"
															value="<%=FH_goalOrder.get(teamList.get(key))%>"></td>
														<%}}%>
                    	
														<td><input class="sale" name="FH_0_PJ"
															value="<%=FH_goalOrder.get(teamList.get(0))%>"></td>
													</tr>
													<!-- 상반기예상수주 -->
													<tr class="firstTD orderTD dataTD">
														<td>예상 수주</td>
														<td><%=FH_totalpreOrder%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=FH_preOrder.get(teamList.get(key))%></td>
														<%}} %>
														<td><%=FH_preOrder.get(teamList.get(0))%></td>
													</tr>
													<!-- 상반기예상수주(%) -->
													<tr class="firstTD orderTD rateTD">
														<td>예상 수주(%)</td>
														<td><%=String.format("%.1f", FH_totalpreOrder/FH_totalGoalOrder *100)%>(%)</td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=String.format("%.1f", FH_preOrder.get(teamList.get(key))/FH_goalOrder.get(teamList.get(key)) *100)%>(%)</td>
														<%}} %>
														<td><%=String.format("%.1f", FH_preOrder.get(teamList.get(0))/FH_goalOrder.get(teamList.get(0)) *100)%>(%)</td>
													</tr>
													<!-- 상반기수주달성 -->
													<tr class="firstTD orderTD dataTD">
														<td>수주 달성</td>
														<td><%=FH_totalachOrder%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=FH_achOrder.get(teamList.get(key))%></td>
														<%}} %>
														<td><%=FH_achOrder.get(teamList.get(0))%></td>
													</tr>
													<!-- 상반기수주달성률 -->
													<tr class="firstTD orderTD rateTD">
														<td>수주 달성률</td>
														<td><%=String.format("%.1f", FH_totalachOrder/FH_totalGoalOrder *100)%>(%)</td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=String.format("%.1f", FH_achOrder.get(teamList.get(key))/FH_goalOrder.get(teamList.get(key)) *100)%>(%)</td>
														<%}} %>
														<td><%=String.format("%.1f", FH_achOrder.get(teamList.get(0))/FH_goalOrder.get(teamList.get(0)) *100)%>(%)</td>
													</tr>
													<!-- 상반기목표매출 -->
													<tr class="firstTD saleTD dataTD">
														<td style="vertical-align: middle;">목표 매출</td>
														<td><%=FH_totalGoalSale%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><input class="sale" name="FH_<%=key%>_SALES"
															value='<%=FH_goalSale.get(teamList.get(key))%>'></td>
														<%}} %>
														<td><input class="sale" name="FH_0_SALES"
															value='<%=FH_goalSale.get(teamList.get(0))%>'></td>
													</tr>
													<!-- 상반기예상매출 -->
													<tr class="firstTD saleTD dataTD">
														<td>예상 매출</td>
														<td><%=FH_totalpreSale%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=FH_preSale.get(teamList.get(key))%></td>
														<%}} %>
														<td><%=FH_preSale.get(teamList.get(0))%></td>
													</tr>
													<!-- 상반기예상매출(%) -->
													<tr class="firstTD saleTD rateTD">
														<td>예상 매출(%)</td>
														<td><%=String.format("%.1f", FH_totalpreSale/FH_totalGoalSale *100)%>(%)</td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=String.format("%.1f", FH_preSale.get(teamList.get(key))/FH_goalSale.get(teamList.get(key)) *100)%>(%)</td>
														<%}} %>
														<td><%=String.format("%.1f", FH_preSale.get(teamList.get(0))/FH_goalSale.get(teamList.get(0)) *100)%>(%)</td>
													</tr>
													<!-- 상반기매출달성 -->
													<tr class="firstTD saleTD dataTD">
														<td>매출 달성</td>
														<td><%=FH_totalachSale%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=FH_achSale.get(teamList.get(key))%></td>
														<%}} %>
														<td><%=FH_achSale.get(teamList.get(0))%></td>
													</tr>
													<!-- 상반기매출보정 -->
													<tr class="firstTD saleTD dataTD corrTD_fh"
														style="color: red;">
														<td>매출 보정</td>
														<td onclick="viewDetail('Total', '상반기')"><%=cmsRate.get(0).get("Total") %></td>
														<%for(String key : cmsRate.get(0).keySet()) {
                    										if(!key.equals(teamList.get(0)) && !key.equals("Total")){%>
														<td onclick="viewDetail('<%=key%>', '상반기')"><%=cmsRate.get(0).get(key) %></td>
														<%}} %>
														<td onclick="viewDetail('<%=teamList.get(0) %>', '상반기')"><%=cmsRate.get(0).get(teamList.get(0)) %></td>
													</tr>
													<!-- 상반기매출달성률 -->
													<tr class="firstTD saleTD rateTD">
														<td>매출 달성률</td>
														<td><%=String.format("%.1f", FH_totalachSale/FH_totalGoalSale *100)%>(%)</td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=String.format("%.1f", FH_achSale.get(teamList.get(key))/FH_goalSale.get(teamList.get(key)) *100)%>(%)</td>
														<%}} %>
														<td><%=String.format("%.1f", FH_achSale.get(teamList.get(0))/FH_goalSale.get(teamList.get(0)) *100)%>(%)</td>
													</tr>
													<!-- 상반기매출보정달성률 -->
													<tr class="firstTD saleTD rateTD corrRate_fh"
														style="color: red;">
														<td>매출 보정 달성률</td>
														<td><%=String.format("%.1f", cmsRate.get(0).get("Total")/FH_totalGoalSale *100)%>(%)</td>
														<%for(String key : cmsRate.get(0).keySet()) {
                    										if(!key.equals(teamList.get(0)) && !key.equals("Total")){%>
														<td><%=String.format("%.1f", cmsRate.get(0).get(key)/FH_goalSale.get(key) *100)%>(%)</td>
														<%}} %>
														<td><%=String.format("%.1f", cmsRate.get(0).get(teamList.get(0))/FH_goalSale.get(teamList.get(0)) *100)%>(%)</td>
													</tr>

													<!-- 하반기목표수주 -->
													<tr class="lastTD orderTD dataTD">
														<td rowspan="12"
															style="text-align: center; font-size: medium; padding-top: 10px"
															class="lastTD lastTag">하반기</td>
														<td style="text-align: center; vertical-align: middle;">목표
															수주</td>
														<td><%=SH_totalGoalOrder%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><input class="sale" name="SH_<%=key%>_PJ"
															value="<%=SH_goalOrder.get(teamList.get(key))%>"></td>
														<%}} %>
														<td><input class="sale" name="SH_0_PJ"
															value="<%=SH_goalOrder.get(teamList.get(0))%>"></td>
													</tr>
													<!-- 하반기예상수주 -->
													<tr class="lastTD orderTD dataTD">
														<td>예상 수주</td>
														<td><%=SH_totalpreOrder%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=SH_preOrder.get(teamList.get(key))%></td>
														<%}} %>
														<td><%=SH_preOrder.get(teamList.get(0))%></td>
													</tr>
													<!-- 하반기예상수주(%) -->
													<tr class="lastTD orderTD rateTD">
														<td>예상 수주(%)</td>
														<td><%=String.format("%.1f", SH_totalpreOrder/SH_totalGoalOrder *100)%>(%)</td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=String.format("%.1f", SH_preOrder.get(teamList.get(key))/SH_goalOrder.get(teamList.get(key)) *100)%>(%)</td>
														<%}} %>
														<td><%=String.format("%.1f", SH_preOrder.get(teamList.get(0))/SH_goalOrder.get(teamList.get(0)) *100)%>(%)</td>
													</tr>
													<!-- 하반기수주달성 -->
													<tr class="lastTD orderTD dataTD">
														<td>수주 달성</td>
														<td><%=SH_totalachOrder%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=SH_achOrder.get(teamList.get(key))%></td>
														<%}} %>
														<td><%=SH_achOrder.get(teamList.get(0))%></td>
													</tr>
													<!-- 하반기수주달성률 -->
													<tr class="lastTD orderTD rateTD">
														<td>수주 달성률</td>
														<td><%=String.format("%.1f", SH_totalachOrder/SH_totalGoalOrder *100)%>(%)</td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=String.format("%.1f", SH_achOrder.get(teamList.get(key))/SH_goalOrder.get(teamList.get(key)) *100)%>(%)</td>
														<%}} %>
														<td><%=String.format("%.1f", SH_achOrder.get(teamList.get(0))/SH_goalOrder.get(teamList.get(0)) *100)%>(%)</td>
													</tr>
													<!-- 하반기목표매출 -->
													<tr class="lastTD saleTD dataTD">
														<td style="vertical-align: middle;">목표 매출</td>
														<td><%=SH_totalGoalSale%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><input class="sale" name="SH_<%=key%>_SALES"
															value='<%=SH_goalSale.get(teamList.get(key))%>'></td>
														<%}} %>
														<td><input class="sale" name="SH_0_SALES"
															value='<%=SH_goalSale.get(teamList.get(0))%>'></td>
													</tr>
													<!-- 하반기예상매출 -->
													<tr class="lastTD saleTD dataTD">
														<td>예상 매출</td>
														<td><%=SH_totalpreSale%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=SH_preSale.get(teamList.get(key))%></td>
														<%}} %>
														<td><%=SH_preSale.get(teamList.get(0))%></td>
													</tr>
													<!-- 하반기예상매출(%) -->
													<tr class="lastTD saleTD rateTD">
														<td>예상 매출(%)</td>
														<td><%=String.format("%.1f", SH_totalpreSale/SH_totalGoalSale *100)%>(%)</td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=String.format("%.1f", SH_preSale.get(teamList.get(key))/SH_goalSale.get(teamList.get(key)) *100)%>(%)</td>
														<%}} %>
														<td><%=String.format("%.1f", SH_preSale.get(teamList.get(0))/SH_goalSale.get(teamList.get(0)) *100)%>(%)</td>
													</tr>
													<!-- 하반기매출달성 -->
													<tr class="lastTD saleTD dataTD">
														<td>매출 달성</td>
														<td><%=SH_totalachSale%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=SH_achSale.get(teamList.get(key))%></td>
														<%}} %>
														<td><%=SH_achSale.get(teamList.get(0))%></td>
													</tr>
													<!-- 하반기매출보정 -->
													<tr class="lastTD saleTD dataTD corrTD_sh"
														style="color: red;">
														<td>매출 보정</td>
														<td onclick="viewDetail('Total', '하반기')"><%=cmsRate.get(1).get("Total") %></td>
														<%for(String key : cmsRate.get(1).keySet()) {
                              								if(!key.equals(teamList.get(0)) && !key.equals("Total")){%>
														<td onclick="viewDetail('<%=key%>', '하반기')"><%=cmsRate.get(1).get(key) %></td>
														<%}} %>
														<td onclick="viewDetail('<%=teamList.get(0) %>', '하반기')"><%=cmsRate.get(1).get(teamList.get(0)) %></td>
													</tr>
													<!-- 하반기매출달성률 -->
													<tr class="lastTD saleTD rateTD">
														<td>매출 달성률</td>
														<td><%=String.format("%.1f", SH_totalachSale/SH_totalGoalSale *100)%>(%)</td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=String.format("%.1f", SH_achSale.get(teamList.get(key))/SH_goalSale.get(teamList.get(key)) *100)%>(%)</td>
														<%}} %>
														<td><%=String.format("%.1f", SH_achSale.get(teamList.get(0))/SH_goalSale.get(teamList.get(0)) *100)%>(%)</td>
													</tr>
													<!-- 하반기매출보정달성률 -->
													<tr class="lastTD saleTD rateTD corrRate_sh"
														style="color: red;">
														<td>매출 보정 달성률</td>
														<td><%=String.format("%.1f", cmsRate.get(1).get("Total")/SH_totalGoalSale *100)%>(%)</td>
														<%for(String key : cmsRate.get(1).keySet()) {
                              								if(!key.equals(teamList.get(0)) && !key.equals("Total")){%>
														<td><%=String.format("%.1f", cmsRate.get(1).get(key)/SH_goalSale.get(key) *100)%>(%)</td>
														<%}} %>
														<td><%=String.format("%.1f", cmsRate.get(1).get(teamList.get(0))/SH_goalSale.get(teamList.get(0)) *100)%>(%)</td>
													</tr>

													<!-- 연간목표수주 -->
													<tr class="yearTD orderTD dataTD">
														<td rowspan="12"
															style="text-align: center; font-size: medium; padding-top: 10px"
															class="yearTD yearTag">연간</td>
														<td style="text-align: center;">목표 수주</td>
														<td><%=Y_totalGoalOrder%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=Y_goalOrder.get(teamList.get(key))%></td>
														<%}} %>
														<td><%=Y_goalOrder.get(teamList.get(0))%></td>
													</tr>
													<!-- 연간예상수주 -->
													<tr class="yearTD orderTD dataTD">
														<td>예상 수주</td>
														<td><%=Y_totalpreOrder%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=Y_preOrder.get(teamList.get(key))%></td>
														<%}} %>
														<td><%=Y_preOrder.get(teamList.get(0))%></td>
													</tr>
													<!-- 연간예상수주(%) -->
													<tr class="yearTD orderTD rateTD">
														<td>예상 수주(%)</td>
														<td><%=String.format("%.1f", Y_totalpreOrder/Y_totalGoalOrder *100)%>(%)</td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=String.format("%.1f", Y_preOrder.get(teamList.get(key))/Y_goalOrder.get(teamList.get(key)) *100)%>(%)</td>
														<%}} %>
														<td><%=String.format("%.1f", Y_preOrder.get(teamList.get(0))/Y_goalOrder.get(teamList.get(0)) *100)%>(%)</td>
													</tr>
													<!-- 연간수주달성 -->
													<tr class="yearTD orderTD dataTD">
														<td>수주 달성</td>
														<td><%=Y_totalachOrder%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=Y_achOrder.get(teamList.get(key))%></td>
														<%}} %>
														<td><%=Y_achOrder.get(teamList.get(0))%></td>
													</tr>
													<!-- 연간수주달성률 -->
													<tr class="yearTD orderTD rateTD">
														<td>수주 달성률</td>
														<td><%=String.format("%.1f", Y_totalachOrder/Y_totalGoalOrder *100)%>(%)</td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=String.format("%.1f", Y_achOrder.get(teamList.get(key))/Y_goalOrder.get(teamList.get(key)) *100)%>(%)</td>
														<%}} %>
														<td><%=String.format("%.1f", Y_achOrder.get(teamList.get(0))/Y_goalOrder.get(teamList.get(0)) *100)%>(%)</td>
													</tr>
													<!-- 연간목표매출 -->
													<tr class="yearTD saleTD dataTD">
														<td>목표 매출</td>
														<td><%=Y_totalGoalSale%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=Y_goalSale.get(teamList.get(key))%></td>
														<%}}%>
														<td><%=Y_goalSale.get(teamList.get(0))%></td>
													</tr>
													<!-- 연간예상매출 -->
													<tr class="yearTD saleTD dataTD">
														<td>예상 매출</td>
														<td><%=Y_totalpreSale%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=Y_preSale.get(teamList.get(key))%></td>
														<%}} %>
														<td><%=Y_preSale.get(teamList.get(0))%></td>
													</tr>
													<!-- 연간예상매출(%) -->
													<tr class="yearTD saleTD rateTD">
														<td>예상 매출(%)</td>
														<td><%=String.format("%.1f", Y_totalpreSale/Y_totalGoalSale *100)%>(%)</td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=String.format("%.1f", Y_preSale.get(teamList.get(key))/Y_goalSale.get(teamList.get(key)) *100)%>(%)</td>
														<%}} %>
														<td><%=String.format("%.1f", Y_preSale.get(teamList.get(0))/Y_goalSale.get(teamList.get(0)) *100)%>(%)</td>
													</tr>
													<!-- 연간매출달성 -->
													<tr class="yearTD saleTD dataTD">
														<td>매출 달성</td>
														<td><%=Y_totalachSale%></td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=Y_achSale.get(teamList.get(key))%></td>
														<%}} %>
														<td><%=Y_achSale.get(teamList.get(0))%></td>
													</tr>
													<!-- 연간매출보정 -->
													<tr class="yearTD saleTD dataTD corrTD_y"
														style="color: red;">
														<td>매출 보정</td>
														<td onclick="viewDetail('Total', '연간')"><%=cmsRate.get(2).get("Total") %></td>
														<%for(String key : cmsRate.get(2).keySet()) {
                              								if(!key.equals(teamList.get(0)) && !key.equals("Total")){%>
														<td onclick="viewDetail('<%=key%>', '연간')"><%=cmsRate.get(2).get(key) %></td>
														<%}} %>
														<td onclick="viewDetail('<%=teamList.get(0) %>', '연간')"><%=cmsRate.get(2).get(teamList.get(0)) %></td>
													</tr>
													<!-- 연간매출달성률 -->
													<tr class="yearTD saleTD rateTD">
														<td>매출 달성률</td>
														<td><%=String.format("%.1f", Y_totalachSale/Y_totalGoalSale *100)%>(%)</td>
														<%for(int key : teamList.keySet()){
                    										if(key != 0){%>
														<td><%=String.format("%.1f", Y_achSale.get(teamList.get(key))/Y_goalSale.get(teamList.get(key)) *100)%>(%)</td>
														<%}} %>
														<td><%=String.format("%.1f", Y_achSale.get(teamList.get(0))/Y_goalSale.get(teamList.get(0)) *100)%>(%)</td>
													</tr>
													<!-- 연간매출보정달성률 -->
													<tr class="yearTD saleTD rateTD corrRate_y"
														style="color: red;">
														<td>매출 보정 달성률</td>
														<td><%=String.format("%.1f", cmsRate.get(2).get("Total")/Y_totalGoalSale *100)%>(%)</td>
														<%for(String key : cmsRate.get(2).keySet()) {
                              								if(!key.equals(teamList.get(0)) && !key.equals("Total")){%>
														<td><%=String.format("%.1f", cmsRate.get(2).get(key)/Y_goalSale.get(key) *100)%>(%)</td>
														<%}} %>
														<td><%=String.format("%.1f", cmsRate.get(2).get(teamList.get(0))/Y_goalSale.get(teamList.get(0)) *100)%>(%)</td>
													</tr>
												</tbody>
											</table>
										</div>
									</form>
								</div>


								<div id="tab-2" class="tab-content current">

									<div id="fh_order_chart" class="chart bar"></div>
									<div id="fh_sales_chart" class="chart bar"></div>
									<div id="fh_rpj_chart" class="chart pie"></div>
									<div id="fh_rsales_chart" class="chart pie"></div>

								</div>

								<div id="tab-3" class="tab-content current">

									<div id="sh_order_chart" class="chart bar"></div>
									<div id="sh_sales_chart" class="chart bar"></div>
									<div id="sh_rpj_chart" class="chart pie"></div>
									<div id="sh_rsales_chart" class="chart pie"></div>

								</div>

								<div id="tab-4" class="tab-content current">

									<div id="y_order_chart" class="chart bar"></div>
									<div id="y_sales_chart" class="chart "></div>
									<div id="y_rpj_chart" class="chart pie"></div>
									<div id="y_rsales_chart" class="chart pie"></div>

								</div>

							</div>
						</div>
					</div>


				</div>
				<!-- /.container-fluid -->
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