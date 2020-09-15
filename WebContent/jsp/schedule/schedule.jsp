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
	
	MemberDAO memberDao = new MemberDAO();
	ProjectDAO projectDao = new ProjectDAO();
	SchDAO schDao = new SchDAO();
	ArrayList<MemberBean> memberList = memberDao.getMemberData();
	ArrayList<ProjectBean> projectList = schDao.getProjectList_sch();
	ArrayList<schBean> schList = new ArrayList<schBean>();
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sf.format(nowTime);
	
	String str = "";

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
body{
overflow-y:hidden;
}
@media(max-width:800px){
	.tableST{
	width : 100% !important;
	height: 40%;
	
}
#timelineChart{
	height: 90%;
	width:  100% !important;

}
}

.memberTable{
	width : 100%;
	height: 40%;
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
	height: 100%;
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
</style>



<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
<%
	ArrayList<MemberBean> List1 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List11 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List12 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List13 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List14 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List15 = new ArrayList<MemberBean>();
	
	ArrayList<MemberBean> List2 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List21 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List22 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List23 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List24 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List25 = new ArrayList<MemberBean>();
	
	
	ArrayList<MemberBean> List3 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List31 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List32 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List33 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List34 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List35 = new ArrayList<MemberBean>();
	
	ArrayList<MemberBean> List4 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List41 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List42 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List43 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List44 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List45 = new ArrayList<MemberBean>();
	
	ArrayList<MemberBean> List5 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List51 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List52 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List53 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List54 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List55 = new ArrayList<MemberBean>();
	
	ArrayList<MemberBean> List6 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List61 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List62 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List63 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List64 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List65 = new ArrayList<MemberBean>();
	
	ArrayList<MemberBean> ListT = new ArrayList<MemberBean>();
	ArrayList<MemberBean> ListT1 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> ListT2 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> ListT3 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> ListT4 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> ListT5 = new ArrayList<MemberBean>();
	
	for(int i=0; i<memberList.size(); i++){
		if(memberList.get(i).getTEAM().equals("미래차검증전략실")){
			List1.add(memberList.get(i));
			ListT.add(memberList.get(i));
			if(memberList.get(i).getRANK().equals("수석")){
				List11.add(memberList.get(i));
				ListT1.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("책임")){
				List12.add(memberList.get(i));
				ListT2.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("선임")){
				List13.add(memberList.get(i));
				ListT3.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("전임")){
				List14.add(memberList.get(i));
				ListT4.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("인턴")){
				List15.add(memberList.get(i));
				ListT5.add(memberList.get(i));
			}
			
		}else if(memberList.get(i).getTEAM().equals("샤시힐스검증팀")){
			List2.add(memberList.get(i));
			ListT.add(memberList.get(i));
			if(memberList.get(i).getRANK().equals("수석")){
				List21.add(memberList.get(i));
				ListT1.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("책임")){
				List22.add(memberList.get(i));
				ListT2.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("선임")){
				List23.add(memberList.get(i));
				ListT3.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("전임")){
				List24.add(memberList.get(i));
				ListT4.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("인턴")){
				List25.add(memberList.get(i));
				ListT5.add(memberList.get(i));
			}
			
		}else if(memberList.get(i).getTEAM().equals("바디힐스검증팀")){
			List3.add(memberList.get(i));
			ListT.add(memberList.get(i));
			if(memberList.get(i).getRANK().equals("수석")){
				List31.add(memberList.get(i));
				ListT1.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("책임")){
				List32.add(memberList.get(i));
				ListT2.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("선임")){
				List33.add(memberList.get(i));
				ListT3.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("전임")){
				List34.add(memberList.get(i));
				ListT4.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("인턴")){
				List35.add(memberList.get(i));
				ListT5.add(memberList.get(i));
			}
			
		}else if(memberList.get(i).getTEAM().equals("제어로직검증팀")){
			List4.add(memberList.get(i));
			ListT.add(memberList.get(i));
			if(memberList.get(i).getRANK().equals("수석")){
				List41.add(memberList.get(i));
				ListT1.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("책임")){
				List42.add(memberList.get(i));
				ListT2.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("선임")){
				List43.add(memberList.get(i));
				ListT3.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("전임")){
				List44.add(memberList.get(i));
				ListT4.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("인턴")){
				List45.add(memberList.get(i));
				ListT5.add(memberList.get(i));
			}
			
		}else if(memberList.get(i).getTEAM().equals("기능안전검증팀")){
			List5.add(memberList.get(i));
			ListT.add(memberList.get(i));
			if(memberList.get(i).getRANK().equals("수석")){
				List51.add(memberList.get(i));
				ListT.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("책임")){
				List52.add(memberList.get(i));
				ListT2.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("선임")){
				List53.add(memberList.get(i));
				ListT3.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("전임")){
				List54.add(memberList.get(i));
				ListT4.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("인턴")){
				List55.add(memberList.get(i));
				ListT5.add(memberList.get(i));
			}
			
		}else if(memberList.get(i).getTEAM().equals("자율주행검증팀")){
			List6.add(memberList.get(i));
			ListT.add(memberList.get(i));
			if(memberList.get(i).getRANK().equals("수석")){
				List61.add(memberList.get(i));
				ListT1.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("책임")){
				List62.add(memberList.get(i));
				ListT2.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("선임")){
				List63.add(memberList.get(i));
				ListT3.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("전임")){
				List64.add(memberList.get(i));
				ListT4.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("인턴")){
				List65.add(memberList.get(i));
				ListT5.add(memberList.get(i));
			}
		}
		
		
	}
%>	
		
          google.charts.load("current", {packages:["timeline"]});
          google.charts.setOnLoadCallback(drawChart);
          
          function drawChart() {
        	   	<%
        		for(int i=0; i<memberList.size(); i++){
        			for(int j=0; j<projectList.size(); j++){
        				schBean PMsch = new schBean();
    					if(memberList.get(i).getID().equals(projectList.get(j).getPROJECT_MANAGER())){
    						PMsch.setName(memberList.get(i).getID());
    						PMsch.setName(memberList.get(i).getNAME());
    						PMsch.setTeam(memberList.get(i).getTEAM());
    						PMsch.setRank(memberList.get(i).getRANK());
    						PMsch.setProjectName(projectList.get(j).getPROJECT_NAME());
    						PMsch.setStart(projectList.get(j).getPROJECT_START());
    						PMsch.setEnd(projectList.get(j).getPROJECT_END());
    						schList.add(PMsch);
    					}
        				for(int z=0; z<projectList.get(j).getWORKER_LIST().split(" ").length; z++){
        					if(!(memberList.get(i).getID().equals(projectList.get(j).getPROJECT_MANAGER())) && memberList.get(i).getID().equals(projectList.get(j).getWORKER_LIST().split(" ")[z])){
        						//프로젝트 명, 착수, 종료, (이름, 소속팀, 직급)
        						schBean sch = new schBean();
        						sch.setId(memberList.get(i).getID());
        						sch.setName(memberList.get(i).getNAME());
        						sch.setTeam(memberList.get(i).getTEAM());
        						sch.setRank(memberList.get(i).getRANK());
        						sch.setProjectName(projectList.get(j).getPROJECT_NAME());
        						sch.setStart(projectList.get(j).getPROJECT_START());
        						sch.setEnd(projectList.get(j).getPROJECT_END());
        						schList.add(sch);
        					}	
        				}
        			}
        		}
        	%>

            var container = document.getElementById('timelineChart');
            var chart = new google.visualization.Timeline(container);
            var dataTable = new google.visualization.DataTable();
      
            dataTable.addColumn({ type: 'string', id: 'Position' });
            dataTable.addColumn({ type: 'string', id: 'Name' });
            dataTable.addColumn({ type: 'date', id: 'Start' });
            dataTable.addColumn({ type: 'date', id: 'End' });
            dataTable.addRows([
              		['<%=schList.get(0).getName()%>', '<%=schList.get(0).getProjectName()%>', new Date('<%=schList.get(0).getStart()%>'), new Date('<%=schList.get(0).getEnd()%>')]
              		<%
	            		for(int b=1; b<schList.size(); b++){%>
	            			,['<%=schList.get(b).getName()%>', '<%=schList.get(b).getProjectName()%>', new Date('<%=schList.get(b).getStart()%>'), new Date('<%=schList.get(b).getEnd()%>')]
	            		<%}
            	%>
            ]);
            chart.draw(dataTable);
            var st = container.getElementsByTagName("div")[0];
			st.style.position = 'inherit';
          }
          
          
          function drawChartOp(team, rank){
              var container = document.getElementById('timelineChart');
              var chart = new google.visualization.Timeline(container);
              var dataTable = new google.visualization.DataTable();
        
              dataTable.addColumn({ type: 'string', id: 'Position' });
              dataTable.addColumn({ type: 'string', id: 'Name' });
              dataTable.addColumn({ type: 'date', id: 'Start' });
              dataTable.addColumn({ type: 'date', id: 'End' });
        	  	<%
		      	  	  for(int i=0; i<schList.size(); i++){%>
		      	  	  	if(rank=='total'){
			      	  	  	if(team == '<%=schList.get(i).getTeam()%>'){
			    	  			 dataTable.addRows([
			    	              		['<%=schList.get(i).getName()%>', '<%=schList.get(i).getProjectName()%>', new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
			    	            ]);
			    	  		} else if(team == 'total'){
			    	  			dataTable.addRows([
		    	              		['<%=schList.get(i).getName()%>', '<%=schList.get(i).getProjectName()%>', new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
			    	            ]);
			    	  		}
		      	  	  	}
		      	  	  	else{
			      	  	  	if(team == '<%=schList.get(i).getTeam()%>' && rank == '<%=schList.get(i).getRank()%>'){
			    	  			dataTable.addRows([
			    	              		['<%=schList.get(i).getName()%>', '<%=schList.get(i).getProjectName()%>', new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
			    	            ]);
			    	  		}else if(team == 'total' && rank == '<%=schList.get(i).getRank()%>'){
			    	  			dataTable.addRows([
		    	              		['<%=schList.get(i).getName()%>', '<%=schList.get(i).getProjectName()%>', new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
			    	            ]);
			    	  		}
		      	  	  	}
    
      	  	  <%}%>    	 
      	  	chart.draw(dataTable);
      	  	memberInfoTable(team, rank);
       }	//end
         
          function memberInfoTable(team, rank){
        	  	var inner="";   	  	
          	  	if(team == '미래차검증전략실'){
          	  		if(rank == 'total'){
          	  			inner="";
          	  			<%
          	  				
          	  				for(int a=0; a<List1.size(); a++){
          	  					str = "";
          	  				%>
       	  						inner += "<tr>";
       	  						inner += "<td>"+'<%=List1.get(a).getPART()%>'+"</td>";
       		  					inner += "<td>"+'<%=List1.get(a).getTEAM()%>'+"</td>";
    	      	  				inner += "<td>"+'<%=List1.get(a).getNAME()%>'+"</td>";
       	  						inner += "<td>"+'<%=List1.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List1.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List1.get(a).getADDRESS()%>'+"</td>";
       	  						<%
    	   	  						for(int b=0; b<List1.get(a).getCareer().split("\n").length; b++){
    	   	  							str += List1.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
    	   	  						}
       	  						%>
       	  						inner += "<td>"+'<%=str%>'+"</td>";
       	  						inner += "</tr>";
       	  					<%}%>
       	  					$('#memberINFO').empty();
       	  					$('#memberINFO').append(inner);
          	  			}
          			else if(rank == '수석'){
          				inner="";
           	  			<%
        	  				for(int a=0; a<List11.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List11.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List11.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List11.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List11.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List11.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List11.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List11.get(a).getCareer().split("\n").length; b++){
        	  							str += List11.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '책임'){
          				inner="";
           	  			<%
        	  				for(int a=0; a<List12.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List12.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List12.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List12.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List12.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List12.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List12.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List12.get(a).getCareer().split("\n").length; b++){
        	  							str += List12.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '선임'){
          				inner="";
           	  			<%
        	  				for(int a=0; a<List13.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List13.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List13.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List13.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List13.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List13.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List13.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List13.get(a).getCareer().split("\n").length; b++){
        	  							str += List13.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '전임'){
          				inner="";
           	  			<%
        	  				for(int a=0; a<List14.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List14.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List14.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List14.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List14.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List14.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List14.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List14.get(a).getCareer().split("\n").length; b++){
        	  							str += List14.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '인턴'){
          				inner="";
           	  			<%
        	  				for(int a=0; a<List15.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List15.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List15.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List15.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List15.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List15.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List15.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List15.get(a).getCareer().split("\n").length; b++){
        	  							str += List15.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}	  		
          	  		}
          	  	
          	  	else if(team == '샤시힐스검증팀'){
          	  		if(rank == 'total'){
          	  		inner="";
          	  			<%
          	  				for(int a=0; a<List2.size(); a++){
          	  					str = "";
          	  				%>
       	  						inner += "<tr>";
       	  						inner += "<td>"+'<%=List2.get(a).getPART()%>'+"</td>";
       		  					inner += "<td>"+'<%=List2.get(a).getTEAM()%>'+"</td>";
    	      	  				inner += "<td>"+'<%=List2.get(a).getNAME()%>'+"</td>";
       	  						inner += "<td>"+'<%=List2.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List2.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List2.get(a).getADDRESS()%>'+"</td>";
       	  						<%
    	   	  						for(int b=0; b<List2.get(a).getCareer().split("\n").length; b++){
    	   	  							str += List2.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
    	   	  						}
       	  						%>
       	  						inner += "<td>"+'<%=str%>'+"</td>";
       	  						inner += "</tr>";
       	  					<%}%>
       	  					$('#memberINFO').empty();
       	  					$('#memberINFO').append(inner);
          	  			}
          			else if(rank == '수석'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List21.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List21.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List21.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List21.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List21.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List21.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List21.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List21.get(a).getCareer().split("\n").length; b++){
        	  							str += List21.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '책임'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List22.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List22.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List22.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List22.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List22.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List22.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List22.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List22.get(a).getCareer().split("\n").length; b++){
        	  							str += List22.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '선임'){
           	  			<%
        	  				for(int a=0; a<List23.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List23.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List23.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List23.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List23.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List23.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List23.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List23.get(a).getCareer().split("\n").length; b++){
        	  							str += List23.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '전임'){
           	  			<%
        	  				for(int a=0; a<List24.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List24.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List24.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List24.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List24.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List24.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List24.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List24.get(a).getCareer().split("\n").length; b++){
        	  							str += List24.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '인턴'){
           	  			<%
        	  				for(int a=0; a<List25.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List25.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List25.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List25.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List25.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List25.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List25.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List25.get(a).getCareer().split("\n").length; b++){
        	  							str += List25.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}	
          	  		}
          	  	
          	  	else if(team == '바디힐스검증팀'){
          	  		if(rank == 'total'){
          	  		inner="";
          	  			<%
          	  				for(int a=0; a<List3.size(); a++){
          	  					str = "";
          	  				%>
       	  						inner += "<tr>";
       	  						inner += "<td>"+'<%=List3.get(a).getPART()%>'+"</td>";
       		  					inner += "<td>"+'<%=List3.get(a).getTEAM()%>'+"</td>";
    	      	  				inner += "<td>"+'<%=List3.get(a).getNAME()%>'+"</td>";
       	  						inner += "<td>"+'<%=List3.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List3.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List3.get(a).getADDRESS()%>'+"</td>";
       	  						<%
    	   	  						for(int b=0; b<List3.get(a).getCareer().split("\n").length; b++){
    	   	  							str += List3.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
    	   	  						}
       	  						%>
       	  						inner += "<td>"+'<%=str%>'+"</td>";
       	  						inner += "</tr>";
       	  					<%}%>
       	  					$('#memberINFO').empty();
       	  					$('#memberINFO').append(inner);
          	  			}
          			else if(rank == '수석'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List31.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List31.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List31.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List31.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List31.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List31.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List31.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List31.get(a).getCareer().split("\n").length; b++){
        	  							str += List31.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '책임'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List32.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List32.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List32.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List32.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List32.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List32.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List32.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List32.get(a).getCareer().split("\n").length; b++){
        	  							str += List32.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '선임'){
           	  			<%
        	  				for(int a=0; a<List33.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List33.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List33.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List33.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List33.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List33.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List33.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List33.get(a).getCareer().split("\n").length; b++){
        	  							str += List33.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '전임'){
           	  			<%
        	  				for(int a=0; a<List34.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List34.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List34.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List34.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List34.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List34.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List34.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List34.get(a).getCareer().split("\n").length; b++){
        	  							str += List34.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '인턴'){
           	  			<%
        	  				for(int a=0; a<List35.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List35.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List35.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List35.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List35.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List35.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List35.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List35.get(a).getCareer().split("\n").length; b++){
        	  							str += List35.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          	  		}
          	  	
          	  	else if(team == '제어로직검증팀'){
          	  		if(rank == 'total'){
          	  		inner="";
          	  			<%
          	  				for(int a=0; a<List4.size(); a++){
          	  					str = "";
          	  				%>
       	  						inner += "<tr>";
       	  						inner += "<td>"+'<%=List4.get(a).getPART()%>'+"</td>";
       		  					inner += "<td>"+'<%=List4.get(a).getTEAM()%>'+"</td>";
    	      	  				inner += "<td>"+'<%=List4.get(a).getNAME()%>'+"</td>";
       	  						inner += "<td>"+'<%=List4.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List4.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List4.get(a).getADDRESS()%>'+"</td>";
       	  						<%
    	   	  						for(int b=0; b<List4.get(a).getCareer().split("\n").length; b++){
    	   	  							str += List4.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
    	   	  						}
       	  						%>
       	  						inner += "<td>"+'<%=str%>'+"</td>";
       	  						inner += "</tr>";
       	  					<%}%>
       	  					$('#memberINFO').empty();
       	  					$('#memberINFO').append(inner);
          	  			}
          			else if(rank == '수석'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List41.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List41.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List41.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List41.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List41.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List41.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List41.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List41.get(a).getCareer().split("\n").length; b++){
        	  							str += List41.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '책임'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List42.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List42.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List42.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List42.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List42.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List42.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List42.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List42.get(a).getCareer().split("\n").length; b++){
        	  							str += List42.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '선임'){
           	  			<%
        	  				for(int a=0; a<List43.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List43.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List43.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List43.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List43.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List43.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List43.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List43.get(a).getCareer().split("\n").length; b++){
        	  							str += List43.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '전임'){
           	  			<%
        	  				for(int a=0; a<List44.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List44.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List44.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List44.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List44.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List44.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List44.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List44.get(a).getCareer().split("\n").length; b++){
        	  							str += List44.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '인턴'){
           	  			<%
        	  				for(int a=0; a<List45.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List45.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List45.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List45.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List45.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List45.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List45.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List45.get(a).getCareer().split("\n").length; b++){
        	  							str += List45.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          	  		
          	  		}
          	  	
          	  	else if(team == '기능안전검증팀'){
          	  		if(rank == 'total'){
          	  		inner="";
          	  			<%
          	  				for(int a=0; a<List5.size(); a++){
          	  					str = "";
          	  				%>
       	  						inner += "<tr>";
       	  						inner += "<td>"+'<%=List5.get(a).getPART()%>'+"</td>";
       		  					inner += "<td>"+'<%=List5.get(a).getTEAM()%>'+"</td>";
    	      	  				inner += "<td>"+'<%=List5.get(a).getNAME()%>'+"</td>";
       	  						inner += "<td>"+'<%=List5.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List5.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List5.get(a).getADDRESS()%>'+"</td>";
       	  						<%
    	   	  						for(int b=0; b<List5.get(a).getCareer().split("\n").length; b++){
    	   	  							str += List5.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
    	   	  						}
       	  						%>
       	  						inner += "<td>"+'<%=str%>'+"</td>";
       	  						inner += "</tr>";
       	  					<%}%>
       	  					$('#memberINFO').empty();
       	  					$('#memberINFO').append(inner);
          	  			}
          			else if(rank == '수석'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List51.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List51.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List51.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List51.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List51.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List51.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List51.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List51.get(a).getCareer().split("\n").length; b++){
        	  							str += List51.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '책임'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List52.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List52.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List52.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List52.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List52.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List52.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List52.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List52.get(a).getCareer().split("\n").length; b++){
        	  							str += List52.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '선임'){
           	  			<%
        	  				for(int a=0; a<List53.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List53.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List53.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List53.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List53.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List53.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List53.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List53.get(a).getCareer().split("\n").length; b++){
        	  							str += List53.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '전임'){
           	  			<%
        	  				for(int a=0; a<List54.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List54.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List54.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List54.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List54.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List54.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List54.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List54.get(a).getCareer().split("\n").length; b++){
        	  							str += List54.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '인턴'){
           	  			<%
        	  				for(int a=0; a<List55.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List55.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List55.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List55.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List55.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List55.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List55.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List55.get(a).getCareer().split("\n").length; b++){
        	  							str += List55.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          	  		}
          	  	
          	  	else if(team == '자율주행검증팀'){
          	  		if(rank == 'total'){
          	  		inner="";
          	  			<%
          	  				for(int a=0; a<List6.size(); a++){
          	  					str = "";
          	  				%>
       	  						inner += "<tr>";
       	  						inner += "<td>"+'<%=List6.get(a).getPART()%>'+"</td>";
       		  					inner += "<td>"+'<%=List6.get(a).getTEAM()%>'+"</td>";
    	      	  				inner += "<td>"+'<%=List6.get(a).getNAME()%>'+"</td>";
       	  						inner += "<td>"+'<%=List6.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List6.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List6.get(a).getADDRESS()%>'+"</td>";
       	  						<%
    	   	  						for(int b=0; b<List6.get(a).getCareer().split("\n").length; b++){
    	   	  							str += List6.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
    	   	  						}
       	  						%>
       	  						inner += "<td>"+'<%=str%>'+"</td>";
       	  						inner += "</tr>";
       	  					<%}%>
       	  					$('#memberINFO').empty();
       	  					$('#memberINFO').append(inner);
          	  			}
          			else if(rank == '수석'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List61.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List61.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List61.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List61.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List61.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List61.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List61.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List61.get(a).getCareer().split("\n").length; b++){
        	  							str += List61.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '책임'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List62.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List62.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List62.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List62.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List62.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List62.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List62.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List62.get(a).getCareer().split("\n").length; b++){
        	  							str += List62.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '선임'){
           	  			<%
        	  				for(int a=0; a<List63.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List63.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List63.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List63.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List63.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List63.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List63.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List63.get(a).getCareer().split("\n").length; b++){
        	  							str += List63.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '전임'){
           	  			<%
        	  				for(int a=0; a<List64.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List64.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List64.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List64.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List64.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List64.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List64.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List64.get(a).getCareer().split("\n").length; b++){
        	  							str += List64.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '인턴'){
           	  			<%
        	  				for(int a=0; a<List65.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=List65.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List65.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=List65.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=List65.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=List65.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=List65.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<List65.get(a).getCareer().split("\n").length; b++){
        	  							str += List65.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          	  		}
          	  	
          	  	else if(team == 'total'){
          	  		if(rank == 'total'){
          	  		inner="";
          	  			<%
          	  				for(int a=0; a<ListT.size(); a++){
          	  					str = "";
          	  				%>
       	  						inner += "<tr>";
       	  						inner += "<td>"+'<%=ListT.get(a).getPART()%>'+"</td>";
       		  					inner += "<td>"+'<%=ListT.get(a).getTEAM()%>'+"</td>";
    	      	  				inner += "<td>"+'<%=ListT.get(a).getNAME()%>'+"</td>";
       	  						inner += "<td>"+'<%=ListT.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=ListT.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=ListT.get(a).getADDRESS()%>'+"</td>";
       	  						<%
    	   	  						for(int b=0; b<ListT.get(a).getCareer().split("\n").length; b++){
    	   	  							str += ListT.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
    	   	  						}
       	  						%>
       	  						inner += "<td>"+'<%=str%>'+"</td>";
       	  						inner += "</tr>";
       	  					<%}%>
       	  					$('#memberINFO').empty();
       	  					$('#memberINFO').append(inner);
          	  			}
          			else if(rank == '수석'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<ListT1.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=ListT1.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=ListT1.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=ListT1.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=ListT1.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=ListT1.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=ListT1.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<ListT1.get(a).getCareer().split("\n").length; b++){
        	  							str += ListT1.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '책임'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<ListT2.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=ListT2.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=ListT2.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=ListT2.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=ListT2.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=ListT2.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=ListT2.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<ListT2.get(a).getCareer().split("\n").length; b++){
        	  							str += ListT2.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '선임'){
           	  			<%
        	  				for(int a=0; a<ListT3.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=ListT3.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=ListT3.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=ListT3.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=ListT3.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=ListT3.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=ListT3.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<ListT3.get(a).getCareer().split("\n").length; b++){
        	  							str += ListT3.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '전임'){
           	  			<%
        	  				for(int a=0; a<ListT4.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=ListT4.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=ListT4.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=ListT4.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=ListT4.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=ListT4.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=ListT4.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<ListT4.get(a).getCareer().split("\n").length; b++){
        	  							str += ListT4.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '인턴'){
           	  			<%
        	  				for(int a=0; a<ListT5.size(); a++){
        	  					str = "";
        	  				%>
         						inner += "<tr>";
         						inner += "<td>"+'<%=ListT5.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=ListT5.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td>"+'<%=ListT5.get(a).getNAME()%>'+"</td>";
         						inner += "<td>"+'<%=ListT5.get(a).getRANK()%>'+"</td>";
         						inner += "<td>"+'<%=ListT5.get(a).getMOBILE()%>'+"</td>";
         						inner += "<td>"+'<%=ListT5.get(a).getADDRESS()%>'+"</td>";
         						<%
        	  						for(int b=0; b<ListT5.get(a).getCareer().split("\n").length; b++){
        	  							str += ListT5.get(a).getCareer().split("\n")[b].replaceAll("\\s+$", "")+"<br>";
        	  						}
         						%>
         						inner += "<td>"+'<%=str%>'+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          	  		}
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
	<div id="wrapper" style="overflow-y: hidden">

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
			<li class="nav-item active"><a class="nav-link"
				href="../schedule/schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>스케줄</span></a></li>

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
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

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
				<table class="memberTable" id="dataTable">
				<thead>
	                  <tr style="background-color:#15a3da52;">
		                    <th></th>
		                    <th>total</th>
		                    <th>수석</th>
		                    <th>책임</th>
		                    <th>선임</th>
		                    <th>전임</th>
		                    <th>인턴</th>
	                    </tr>
                    </thead>
                    <tbody>
	                    <tr>
		                    <th>미래차검증전략실</th>
		                    <td onclick="drawChartOp('미래차검증전략실','total')"><%=List1.size()%></td>
		                    <td onclick="drawChartOp('미래차검증전략실','수석')"><%=List11.size() %></td>
		                    <td onclick="drawChartOp('미래차검증전략실','책임')"><%=List12.size() %></td>
		                    <td onclick="drawChartOp('미래차검증전략실','선임')"><%=List13.size() %></td>
		                    <td onclick="drawChartOp('미래차검증전략실','전임')"><%=List14.size() %></td>
		                    <td onclick="drawChartOp('미래차검증전략실','인턴')"><%=List15.size() %></td>
	                    </tr>
	                   <tr>
	          		 		<th>샤시힐스검증팀</th>
	                 		<td onclick="drawChartOp('샤시힐스검증팀','total')"><%=List2.size()%></td>
		                    <td onclick="drawChartOp('샤시힐스검증팀','수석')"><%=List21.size()%></td>
		                    <td onclick="drawChartOp('샤시힐스검증팀','책임')"><%=List22.size()%></td>
		                    <td onclick="drawChartOp('샤시힐스검증팀','선임')"><%=List23.size()%></td>
		                    <td onclick="drawChartOp('샤시힐스검증팀','전임')"><%=List24.size()%></td>
		                    <td onclick="drawChartOp('샤시힐스검증팀','인턴')"><%=List25.size()%></td>
	                   </tr> 
	                   <tr>
	          		 		<th>바디힐스검증팀</th>
	                   		<td onclick="drawChartOp('바디힐스검증팀','total')"><%=List3.size()%></td>
		                    <td onclick="drawChartOp('바디힐스검증팀','수석')"><%=List31.size()%></td>
		                    <td onclick="drawChartOp('바디힐스검증팀','책임')"><%=List32.size()%></td>
		                    <td onclick="drawChartOp('바디힐스검증팀','선임')"><%=List33.size()%></td>
		                    <td onclick="drawChartOp('바디힐스검증팀','전임')"><%=List34.size()%></td>
		                    <td onclick="drawChartOp('바디힐스검증팀','인턴')"><%=List35.size()%></td>
	                   </tr> 
	                   <tr>
	          		 		<th>제어로직검증팀</th>
	                   		<td onclick="drawChartOp('제어로직검증팀','total')"><%=List4.size()%></td>
		                    <td onclick="drawChartOp('제어로직검증팀','수석')"><%=List41.size()%></td>
		                    <td onclick="drawChartOp('제어로직검증팀','책임')"><%=List42.size()%></td>
		                    <td onclick="drawChartOp('제어로직검증팀','선임')"><%=List43.size()%></td>
		                    <td onclick="drawChartOp('제어로직검증팀','전임')"><%=List44.size()%></td>
		                    <td onclick="drawChartOp('제어로직검증팀','인턴')"><%=List45.size()%></td>
	                   </tr> 
	                   <tr>
	          		 		<th>기능안전검증팀</th>
	                   		<td onclick="drawChartOp('기능안전검증팀','total')"><%=List5.size()%></td>
		                    <td onclick="drawChartOp('기능안전검증팀','수석')"><%=List51.size()%></td>
		                    <td onclick="drawChartOp('기능안전검증팀','책임')"><%=List52.size()%></td>
		                    <td onclick="drawChartOp('기능안전검증팀','선임')"><%=List53.size()%></td>
		                    <td onclick="drawChartOp('기능안전검증팀','전임')"><%=List54.size()%></td>
		                    <td onclick="drawChartOp('기능안전검증팀','인턴')"><%=List55.size()%></td>
	                   </tr> 
	                   <tr>
	          		 		<th>자율주행검증팀</th>
	                   		<td onclick="drawChartOp('자율주행검증팀','total')"><%=List6.size()%></td>
		                    <td onclick="drawChartOp('자율주행검증팀','수석')"><%=List61.size()%></td>
		                    <td onclick="drawChartOp('자율주행검증팀','책임')"><%=List62.size()%></td>
		                    <td onclick="drawChartOp('자율주행검증팀','선임')"><%=List63.size()%></td>
		                    <td onclick="drawChartOp('자율주행검증팀','전임')"><%=List64.size()%></td>
		                    <td onclick="drawChartOp('자율주행검증팀','인턴')"><%=List65.size()%></td>
	                   </tr>
						<tr>
	          		 		<th>total</th>
	                        <td onclick="drawChartOp('total','total')"><%=ListT.size()%></td>
		                    <td onclick="drawChartOp('total','수석')"><%=ListT1.size()%></td>
		                    <td onclick="drawChartOp('total','책임')"><%=ListT2.size()%></td>
		                    <td onclick="drawChartOp('total','선임')"><%=ListT3.size()%></td>
		                    <td onclick="drawChartOp('total','전임')"><%=ListT4.size()%></td>
		                    <td onclick="drawChartOp('total','인턴')"><%=ListT5.size()%></td>
	                   </tr>
                   </tbody>
                </table>

				<table class="table table-bordered">
	                <thead>
	                    <tr  style="text-align:center;background-color:#15a3da52;">
		                    <th>소속</th>
		                    <th>팀</th>
		                    <th>이름</th>
		                    <th>직급</th>
		                    <th>Mobile</th>
		                    <th>주소</th>
							<th>프로젝트 수행이력</th>	                   	         
	                    </tr>
                    </thead>
                    <tbody id="memberINFO"></tbody>
                </table>
                
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
