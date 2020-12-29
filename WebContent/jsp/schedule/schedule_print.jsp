<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="jsp.DB.method.*"
	import="java.util.ArrayList" import="java.util.Date"
	import="java.text.SimpleDateFormat"
	import="java.util.LinkedHashMap"
	import="java.util.HashMap"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sure FVMS - Schedule Print</title>
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
	ProjectDAO projectDao = new ProjectDAO();
	SchDAO schDao = new SchDAO();
	
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sf.format(nowTime);
	String nowYear = sf.format(nowTime).split("-")[0];
	int year = Integer.parseInt(date.split("-")[0]);
   	int preYear = Integer.parseInt(nowYear) - 1;
   	int nextYear = Integer.parseInt(nowYear) + 1;    
   	
	LinkedHashMap<Integer, String> teamList = memberDao.getTeam();
	ArrayList<MemberBean> memberList = memberDao.getMemberDataWithoutOut(year);
	ArrayList<schBean> schList = schDao.getProject_except8();
	
                       
   	
   	//HashMap<팀명, HashMap<total or 직급, ArrayList<MemberBean>>>
   	HashMap<String, HashMap<String, ArrayList<MemberBean>>> allList = new HashMap<String, HashMap<String, ArrayList<MemberBean>>>();

	ArrayList<MemberBean> ListT = new ArrayList<MemberBean>();
	ArrayList<MemberBean> ListT1 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> ListT2 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> ListT3 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> ListT4 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> ListT5 = new ArrayList<MemberBean>();

	for(int key : teamList.keySet()){
		HashMap<String, ArrayList<MemberBean>> teamMember = new HashMap<String, ArrayList<MemberBean>>();
		ArrayList<MemberBean> total = new ArrayList<MemberBean>();
		ArrayList<MemberBean> list1 = new ArrayList<MemberBean>();
		ArrayList<MemberBean> list2 = new ArrayList<MemberBean>();
		ArrayList<MemberBean> list3 = new ArrayList<MemberBean>();
		ArrayList<MemberBean> list4 = new ArrayList<MemberBean>();
		ArrayList<MemberBean> list5 = new ArrayList<MemberBean>();
		for(int i=0; i<memberList.size(); i++){
			if(memberList.get(i).getTEAM().equals(teamList.get(key))){
				total.add(memberList.get(i));
				ListT.add(memberList.get(i));
				if(memberList.get(i).getRANK().equals("수석")){
					list1.add(memberList.get(i));
					ListT1.add(memberList.get(i));
					continue;
				} else if(memberList.get(i).getRANK().equals("책임")){
					list2.add(memberList.get(i));
					ListT2.add(memberList.get(i));
					continue;
				} else if(memberList.get(i).getRANK().equals("선임")){
					list3.add(memberList.get(i));
					ListT3.add(memberList.get(i));
					continue;
				} else if(memberList.get(i).getRANK().equals("전임")){
					list4.add(memberList.get(i));
					ListT4.add(memberList.get(i));
					continue;
				} else if(memberList.get(i).getRANK().equals("인턴")){
					list5.add(memberList.get(i));
					ListT5.add(memberList.get(i));
					continue;
				}
			}
		}
		teamMember.put("total", total);
		teamMember.put("수석", list1);
		teamMember.put("책임", list2);
		teamMember.put("선임", list3);
		teamMember.put("전임", list4);
		teamMember.put("인턴", list5);
		allList.put(teamList.get(key), teamMember);
	}
	

	HashMap<Integer, Integer> teamNum = new HashMap<Integer, Integer>();
	for(int key : teamList.keySet()){
		teamNum.put(key, new Integer(0));
		for(int i=0; i<schList.size(); i++){
			if(teamList.get(key).equals(schList.get(i).getTeam())){
				teamNum.put(key, teamNum.get(key)+1);
			}
		}
		System.out.println(teamNum.get(key));
	}
%>

<style>
	#0{
		padding-right : 40px;
	}
	#1{
		padding-right : 40px;
	}
	#2{
		padding-right : 40px;
	}
	#3{
		padding-right : 40px;
	}
	#4{
		padding-right : 40px;
	}
	#5{
		padding-right : 40px;
	}
	
	.endline{
		page-break-before:always
	}

</style>

<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
google.charts.load("current", {packages:["timeline"]});
<%for(int key : teamList.keySet()){%>
google.charts.setOnLoadCallback(drawChartOp<%=key%>);
<%}%>


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


<%for(int key : teamList.keySet()){
	   	StringBuffer strColor = new StringBuffer();%>
function drawChartOp<%=key%>(){
	var team = '<%=teamList.get(key)%>';
	var rank = 'total';
	  var container = document.getElementById('<%=key%>');
	    var chart = new google.visualization.Timeline(container);
	    var dataTable = new google.visualization.DataTable();

	    dataTable.addColumn({ type: 'string', id: 'Position' });
	    dataTable.addColumn({ type: 'string', id: 'dummy bar label' });
	    dataTable.addColumn({ type: 'string', role: 'tooltip' });
	    dataTable.addColumn({ type: 'string', id: 'style', role: 'style' });
	    dataTable.addColumn({ type: 'date', id: 'Start' });
	    dataTable.addColumn({ type: 'date', id: 'End' });
	    dataTable.addRows([
	    		[ '\0', 'Now','','',new Date(), new Date()],
	    		['\0','','', 'opacity:0', new Date('<%=preYear%>-01-01'), new Date('<%=nextYear%>-12-31')]
			]);
	    <%
	  	  for(int i=0; i<schList.size(); i++){%>
	  	  	if(team == '<%=schList.get(i).getTeam()%>'){
	  			 dataTable.addRows([
	  				[	'<%=schList.get(i).getName()%>'
      				,'<%=schList.get(i).getProjectName()%>'
      				
      				,'<div class = "tooltip-padding"> <h6><strong><%=schList.get(i).getProjectName()%></strong></h6>' + '<hr style ="border:solid 1px;color:black">' + '<p><b>PM : </b><%=schList.get(i).getPm()%><br><b>투입명단 : </b> <%=schList.get(i).getWorkList().trim()%></p>' 
      				+ '<b>착수일 : </b><%=schList.get(i).getStart()%><br><b>종료일 : </b><%=schList.get(i).getEnd()%></div>'
      				,'<%=schList.get(i).getColor()%>'
      				, new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
	            ]);
	  		}  	
	<%	}%>
		if(<%=teamNum.get(key)%> > 0){
			$('#'+'<%=key%>').height(<%=teamNum.get(key)%>*55);
		}
		
	  	chart.draw(dataTable);
		nowLine('<%=key%>');
	 	google.visualization.events.addListener(chart, 'onmouseover', function(obj){
	 		if(obj.row == 0){
	 			$('.google-visualization-tooltip').css('display', 'none');
	 		}
	 	    nowLine('<%=key%>');
	 	  })
	 	  
	 	  google.visualization.events.addListener(chart, 'onmouseout', function(obj){
	 	  	nowLine('<%=key%>');
	 	  })
  	//memberInfoTable(team, rank);
}	//end
<%}%>
//페이지 시작시 호출 함수
$(document).ready(function (){
	document.body.style.zoom=0.8;
	window.print(); //윈도우 인쇄 창 띄우고
});
</script>

</head>
<body>
	<%for(int key : teamList.keySet()){ %>
	<p><b><%=teamList.get(key) %></b></p>
	<div id="<%=key%>"></div>
	<div class="endline"></div><br style="height:0; line-height:0">
	<%} %>
</body>
</html>