<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.io.PrintWriter" import="java.util.ArrayList" 
    import="jsp.Bean.model.*" import="jsp.DB.method.*"
    import="java.util.Date"
	import="java.text.SimpleDateFormat"
	import="java.util.HashMap"
    %>
<!DOCTYPE html>
<html>
<head>
<style>
#timelineChart{
	height : 1050px;
}

.endline{
	page-break-before:always
	}
#select_info{
	margin-top:50px;
}
th{
	text-align: left;
	padding: 5px;
}
td{
	padding: 5px;
}

</style>
<meta charset="UTF-8">
<title>Project TimelineChart</title>


<%
	PrintWriter script =  response.getWriter();
	if (session.getAttribute("sessionID") == null){
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	}
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	if(permission > 2){
		script.print("<script> alert('접근 권한이 없습니다.'); history.back(); </script>");
	}
	ProjectDAO projectDao = new ProjectDAO();
	Date nowTime = new Date();
	MemberDAO memberDao = new MemberDAO();
	ArrayList<MemberBean> memberList = memberDao.getMemberData(); 
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sf.format(nowTime);
	
	HashMap<String, ArrayList<Project_sch_Bean>> projectList = projectDao.getProjectList_team();
	ArrayList<Project_sch_Bean> vh_project = projectList.get("미래차검증전략실");
	ArrayList<Project_sch_Bean> chasis_project = projectList.get("샤시힐스검증팀");
	ArrayList<Project_sch_Bean> body_project = projectList.get("바디힐스검증팀");
	ArrayList<Project_sch_Bean> control_project = projectList.get("제어로직검증팀");
	ArrayList<Project_sch_Bean> save_project = projectList.get("기능안전검증팀");
	ArrayList<Project_sch_Bean> auto_project = projectList.get("자율주행검증팀");
	
	System.out.println(vh_project.size());
	
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
    		<%for(String key : projectList.keySet()){
   		for(int b=0; b<projectList.get(key).size(); b++){%>
   			,[	'<%=projectList.get(key).get(b).getTEAM_ORDER()%>'
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
   
   
   
function defaultTotal(){
	for(var j=0;j<9;j++){
    	var total_step = 0;
		for(var i=1;i<7;i++){
    		total_step += Number($("#infoTable tbody tr:eq(" + j + ") td:eq(" + i + ")").text());
    	}
		$("#infoTable tbody tr:eq(" + j + ") td:eq(0)").html(total_step);
    }
}

function clickfun(state, team){
	var inner = "";
	<%for(String key : projectList.keySet()){%>
		if(team == '<%=key%>'){
			<%for(Project_sch_Bean i : projectList.get(key)){%>
				if(state == '<%=i.getSTATE()%>'){
					inner += "<tr>";
					inner += "<td><div class='teamover'>"+'<%=i.getTEAM_ORDER()%>'+"</div></td>";
 					inner += "<td><div class='teamover'>"+'<%=i.getTEAM_SALES()%>'+"</div></td>";
 					inner += "<td><div class='textover'>"+"<%=i.getPROJECT_NAME()%>"+"</div></td>";
					inner += "<td><div class='teamover'>"+'<%=i.getCLIENT()%>'+"</div></td>";
					inner += "<td>"+'<%=i.getPROJECT_START()%>'+"</td>";
					inner += "<td>"+'<%=i.getPROJECT_END()%>'+"</td>";
					inner += "<td>"+'<%=i.getPROJECT_MANAGER()%>'+"</td>";
					inner += "</tr>";
				}else if(state == 'total'){
					inner += "<tr>";
					inner += "<td><div class='teamover'>"+'<%=i.getTEAM_ORDER()%>'+"</div></td>";
 					inner += "<td><div class='teamover'>"+'<%=i.getTEAM_SALES()%>'+"</div></td>";
 					inner += "<td><div class='textover'>"+"<%=i.getPROJECT_NAME()%>"+"</div></td>";
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
				inner += "<td><div class='textover'>"+"<%=i.getPROJECT_NAME()%>"+"</div></td>";
				inner += "<td><div class='teamover'>"+'<%=i.getCLIENT()%>'+"</div></td>";
				inner += "<td>"+'<%=i.getPROJECT_START()%>'+"</td>";
				inner += "<td>"+'<%=i.getPROJECT_END()%>'+"</td>";
				inner += "<td>"+'<%=i.getPROJECT_MANAGER()%>'+"</td>";
				inner += "</tr>";
			}else if(state == 'total'){
				inner += "<tr>";
				inner += "<td><div class='teamover'>"+'<%=i.getTEAM_ORDER()%>'+"</div></td>";
				inner += "<td><div class='teamover'>"+'<%=i.getTEAM_SALES()%>'+"</div></td>";
				inner += "<td><div class='textover'>"+"<%=i.getPROJECT_NAME()%>"+"</div></td>";
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
   
	//페이지 시작시 호출 함수
	$(document).ready(function (){
		document.body.style.zoom=0.8;
		defaultTotal();
		drawChart('timelineChart');
	});
</script>

</head>
<body>
	<div id="timelineChart"></div>
	<div class="endline"></div><br style="height:0; line-height:0">
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
</body>
</html>