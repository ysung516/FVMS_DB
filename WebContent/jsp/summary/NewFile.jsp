<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="java.util.ArrayList"
	import="java.util.List" import="jsp.DB.method.*"
	import="jsp.Bean.model.*"
	import="java.text.SimpleDateFormat" import="java.util.Date"%>
<!DOCTYPE html>
<html lang="kor">

<head>
<%
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
		}
		
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		int nowYear = Integer.parseInt(sdf.format(now));
		
		MemberDAO memberDao = new MemberDAO();
		SummaryDAO summaryDao = new SummaryDAO();
		
		ArrayList<ProjectBean> projectList = summaryDao.getProjectList();
		ArrayList<careerSummary_Bean> careerSmList = summaryDao.getCareerSummary();
		
		//팀별 매출
		float fh_chasisSale = 0;
		float fh_bodySale = 0;
		float fh_controlSale = 0;
		float fh_safeSale = 0;
		float fh_autoSale = 0;
		float fh_vtSale = 0;
		
		System.out.println("=================");
		for(ProjectBean pro : projectList){
			if(pro.getTEAM_SALES().equals("샤시힐스검증팀")){
				fh_chasisSale += pro.getFH_SALES();
			}else if(pro.getTEAM_SALES().equals("바디힐스검증팀")){
				fh_bodySale += pro.getFH_SALES();
			}else if(pro.getTEAM_SALES().equals("제어로직검증팀")){
				fh_controlSale += pro.getFH_SALES();
			}else if(pro.getTEAM_SALES().equals("기능안전검증팀")){
				fh_safeSale += pro.getFH_SALES();
			}else if(pro.getTEAM_SALES().equals("자율주행검증팀")){
				fh_autoSale += pro.getFH_SALES();
			}else if(pro.getTEAM_SALES().equals("미래차검증전략실")){
				fh_vtSale += pro.getFH_SALES();
			}
			for(careerSummary_Bean cs : careerSmList){
				// 같은 프로젝트일 때 팀이 다른 경우 - 매출보정이 필요한 경우
				if(pro.getNO() == cs.getNo() && !(cs.getTeam().equals(pro.getTEAM_SALES()))){
					int compe = cs.getCompensation() / 100;
					if(cs.getTeam().equals("샤시힐스검증팀")){
						fh_chasisSale += compe;
						if(pro.getTEAM_SALES().equals("바디힐스검증팀")){
							fh_bodySale -= compe;
							System.out.println("샤시<-바디" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("제어로직검증팀")){
							fh_controlSale -= compe;
							System.out.println("샤시<-제어" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("기능안전검증팀")){
							fh_safeSale -= compe;
							System.out.println("샤시<-기능" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("자율주행검증팀")){
							fh_autoSale -= compe;
							System.out.println("샤시<-자율" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("미래차검증전략실")){
							fh_vtSale -= compe;
							System.out.println("샤시<-실" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}
					}
					if(cs.getTeam().equals("바디힐스검증팀")){
						fh_bodySale += compe;
						if(pro.getTEAM_SALES().equals("샤시힐스검증팀")){
							fh_chasisSale -= compe;
							System.out.println("바디<-샤시" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("제어로직검증팀")){
							fh_controlSale -= compe;
							System.out.println("바디<-제어" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("기능안전검증팀")){
							fh_safeSale -= compe;
							System.out.println("바디<-기능" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("자율주행검증팀")){
							fh_autoSale -= compe;
							System.out.println("바디<-자율" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("미래차검증전략실")){
							fh_vtSale -= compe;
							System.out.println("바디<-실" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}
					}
					if(cs.getTeam().equals("제어로직검증팀")){
						fh_controlSale += compe;
						if(pro.getTEAM_SALES().equals("샤시힐스검증팀")){
							fh_chasisSale -= compe;
							System.out.println("제어<-샤시" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("바디힐스검증팀")){
							fh_bodySale -= compe;
							System.out.println("제어<-바디" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("기능안전검증팀")){
							fh_safeSale -= compe;
							System.out.println("제어<-기능" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("자율주행검증팀")){
							fh_autoSale -= compe;
							System.out.println("제어<-자율" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("미래차검증전략실")){
							fh_vtSale -= compe;
							System.out.println("제어<-실" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}
					}
					if(cs.getTeam().equals("기능안전검증팀")){
						fh_safeSale += compe;
						if(pro.getTEAM_SALES().equals("샤시힐스검증팀")){
							fh_chasisSale -= compe;
							System.out.println("기능<-샤시" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("바디힐스검증팀")){
							fh_bodySale -= compe;
							System.out.println("기능<-바디" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("제어로직검증팀")){
							fh_controlSale -= compe;
							System.out.println("기능<-제어" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("자율주행검증팀")){
							fh_autoSale -= compe;
							System.out.println("기능<-자율" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("미래차검증전략실")){
							fh_vtSale -= compe;
							System.out.println("기능<-실" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}
					}
					if(cs.getTeam().equals("자율주행검증팀")){
						fh_autoSale += compe;
						if(pro.getTEAM_SALES().equals("샤시힐스검증팀")){
							fh_chasisSale -= compe;
							System.out.println("자율<-샤시" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("바디힐스검증팀")){
							fh_bodySale -= compe;
							System.out.println("자율<-바디" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("제어로직검증팀")){
							fh_controlSale -= compe;
							System.out.println("자율<-제어" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("기능안전검증팀")){
							fh_safeSale -= compe;
							System.out.println("자율<-기능" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("미래차검증전략실")){
							fh_vtSale -= compe;
							System.out.println("자율<-실" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}
					}
					if(cs.getTeam().equals("미래차검증전략실")){
						fh_vtSale += compe;
						if(pro.getTEAM_SALES().equals("샤시힐스검증팀")){
							fh_chasisSale -= compe;
							System.out.println("실<-샤시" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("바디힐스검증팀")){
							fh_bodySale -= compe;
							System.out.println("실<-바디" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("제어로직검증팀")){
							fh_controlSale -= compe;
							System.out.println("실<-제어" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("기능안전검증팀")){
							fh_safeSale -= compe;
							System.out.println("실<-기능" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}else if(pro.getTEAM_SALES().equals("자율주행검증팀")){
							fh_autoSale -= compe;
							System.out.println("실<-자율" + " : " + cs.getName() + "-" + Integer.toString(compe));
						}
					}
				}
			}
		}
		System.out.println(fh_chasisSale);
		System.out.println(fh_bodySale);
		System.out.println(fh_controlSale);
		System.out.println(fh_safeSale);
		System.out.println(fh_autoSale);
		System.out.println(fh_vtSale);
		
	%>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - Meeting_view</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="../../https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
	
<script>
</script>

<style>
</style>

<body id="page-top">
	<table class="table table-bordered" id="dataTable">
		<thead>
			<tr>
			 	<td colspan="3" style="border:0px;"></td>
				<td colspan="5"style="text-align:center;background-color:#5a6f7730;">상세내역(단위: 백만)</td>
				<td>
				%>
				</td>
			</tr>  
			<tr style="text-align:center;background-color:#5a6f7730;">
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
			<tr class="firstTD orderTD dataTD">
				<td rowspan="10" style="text-align:center; font-size: medium; padding-top: 10px" class="firstTD firstTag">상반기</td>
				<td style="text-align:center;">목표 수주</td>
				<td></td>
				<td><input class="sale" name="FH_chassis_PJ" value=''></td>
				<td><input class="sale" name="FH_body_PJ" value=''></td>
				<td><input class="sale" name="FH_control_PJ" value=''></td>
				<td><input class="sale" name="FH_safe_PJ" value=''></td>
				<td><input class="sale" name="FH_auto_PJ" value=''></td>
				<td><input class="sale" name="FH_vt_PJ" value=''></td>
			</tr>
			<tr class="firstTD orderTD dataTD">
				<td>예상 수주</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr class="firstTD orderTD rateTD">
				<td>예상 수주(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
			</tr>
			<tr class="firstTD orderTD dataTD">
				<td>달성</td> 	
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr class="firstTD orderTD rateTD">
				<td>수주 달성률</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
			</tr>
			<tr class="firstTD saleTD dataTD">
				<td>목표 매출</td>
			    <td></td>
				<td><input class="sale" name="FH_chassis_SALES" value=' '></td>
				<td><input class="sale" name="FH_body_SALES" value=' '></td>
				<td><input class="sale" name="FH_control_SALES" value=' '></td>
				<td><input class="sale" name="FH_safe_SALES" value=' '></td>
				<td><input class="sale" name="FH_auto_SALES" value=' '></td>
				<td><input class="sale" name="FH_vt_SALES" value=' '></td>
			</tr>
			<tr class="firstTD saleTD dataTD">
				<td>예상 매츨</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr class="firstTD saleTD rateTD">
				<td>예상 매출(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
			</tr>
			<tr class="firstTD saleTD dataTD">
				<td>달성</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr class="firstTD saleTD rateTD">
				<td>매출 달성률</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
				<td>(%)</td>
			</tr>
			<tr class="lastTD orderTD dataTD">
				<td rowspan="10" style="text-align:center; font-size: medium; padding-top: 10px" class="lastTD lastTag">하반기</td>
				<td style="text-align:center;">목표 수주</td>
				<td></td>
				<td><input class="sale" name="SH_chassis_PJ" value=' '></td>
				<td><input class="sale" name="SH_body_PJ" value=' '></td>
				<td><input class="sale" name="SH_control_PJ" value=' '></td>
				<td><input class="sale" name="SH_safe_PJ" value=' '></td>
				<td><input class="sale" name="SH_auto_PJ" value=' '></td>
				<td><input class="sale" name="SH_vt_PJ" value=' '></td>
			</tr>
			<tr class="lastTD orderTD dataTD">
				<td>예상 수주</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
            </tr>
            <tr class="lastTD orderTD rateTD">
	           	<td>예상 수주(%)</td>
				<td>(%)</td>	
	           	<td>(%)</td>
	           	<td>(%)</td>
	           	<td>(%)</td>
	           	<td>(%)</td>
	           	<td>(%)</td>
	           	<td>(%)</td>
           </tr>
           <tr class="lastTD orderTD dataTD">
				<td>달성</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
           </tr>
           <tr class="lastTD orderTD rateTD">
	           	<td>수주 달성률</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
           </tr>
			<tr class="lastTD saleTD dataTD">
              	<td>목표 매출</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
               <tr class="lastTD saleTD dataTD">
              	<td>예상 매츨</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
              </tr>
               <tr class="lastTD saleTD rateTD">
              	<td>예상 매출(%)</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
              </tr>
               <tr class="lastTD saleTD dataTD">
              	<td>달성</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
              	
              </tr>
               <tr class="lastTD saleTD rateTD">
              	<td>매출 달성률</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
              </tr>
              
              <tr class="yearTD orderTD dataTD">
              	<td rowspan="10" style="text-align:center; font-size: medium; padding-top: 10px" class="yearTD yearTag">연간</td>
				<td style="text-align:center;">목표 수주</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
              </tr>
              <tr class="yearTD orderTD dataTD">
              	<td>예상 수주</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
              </tr>
               <tr class="yearTD orderTD rateTD">
              	<td>예상 수주(%)</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
              </tr>
               <tr class="yearTD orderTD dataTD">
              	<td>달성</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
              </tr>
               <tr class="yearTD orderTD rateTD">
              	<td>수주 달성률</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
              </tr>
               <tr class="yearTD saleTD dataTD">
              	<td>목표 매출</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
              </tr>
               <tr class="yearTD saleTD dataTD">
              	<td>예상 매츨</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
              </tr>
               <tr class="yearTD saleTD rateTD">
              	<td>예상 매출(%)</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
              </tr>
               <tr class="yearTD saleTD dataTD">
              	<td>달성</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
              </tr>
               <tr class="yearTD saleTD rateTD">
              	<td>매출 달성률</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
              </tr>
		</tbody>                            
	</table>
               		 
	<table class="table table-bordered" id="os_chart">
			 <thead>
			 	<tr>
			 		<td></td>
			 		<td colspan="10" class="firstTD">상반기</td>
			 		<td colspan="10" class="lastTD">하반기</td>
					 <td colspan="10" class="yearTD">연간</td>
			 	</tr>
			 </thead>
			 <tbody>
			 	<tr>
			 		<td></td>
			 		<td colspan="5" class="firstTD orderTD">수주</td>
			 		<td colspan="5" class="firstTD saleTD">매출</td>
			 		<td colspan="5" class="lastTD orderTD">수주</td>
			 		<td colspan="5" class="lastTD saleTD">매출</td>
			 		<td colspan="5" class="yearTD orderTD">수주</td>
			 		<td colspan="5" class="yearTD saleTD">매출</td>
			 	</tr>
			 	
			 	<tr>
			 		<td></td>
			 		<td class="firstTD orderTD dataTD">목표수주</td>
			 		<td class="firstTD orderTD dataTD">예상수주</td>
			 		<td class="firstTD orderTD rateTD">예상수주(%)</td>
			 		<td class="firstTD orderTD dataTD">달성</td>
			 		<td class="firstTD orderTD rateTD">수주달성률</td>
			 		
			 		<td class="firstTD saleTD dataTD">목표매출</td>
			 		<td class="firstTD saleTD dataTD">예상매출</td>
			 		<td class="firstTD saleTD rateTD">예상매출(%)</td>
			 		<td class="firstTD saleTD dataTD">달성</td>
			 		<td class="firstTD saleTD rateTD">매출달성률</td>
			 		
			 		<td class="lastTD orderTD dataTD">목표수주</td>
			 		<td class="lastTD orderTD dataTD">예상수주</td>
			 		<td class="lastTD orderTD rateTD">예상수주(%)</td>
			 		<td class="lastTD orderTD dataTD">달성</td>
			 		<td class="lastTD orderTD rateTD">수주달성률</td>
			 		
			 		<td class="lastTD saleTD dataTD" >목표매출</td>
			 		<td class="lastTD saleTD dataTD">예상매출</td>
			 		<td class="lastTD saleTD rateTD">예상매출(%)</td>
			 		<td class="lastTD saleTD dataTD">달성</td>
			 		<td class="lastTD saleTD rateTD">매출달성률</td>
			 		
			 		<td class="yearTD orderTD dataTD">목표수주</td>
			 		<td class="yearTD orderTD dataTD">예상수주</td>
			 		<td class="yearTD orderTD rateTD">예상수주(%)</td>
			 		<td class="yearTD orderTD dataTD">달성</td>
			 		<td class="yearTD orderTD rateTD">수주달성률</td>
			 		
			 		<td class="yearTD saleTD dataTD">목표매출</td>
			 		<td class="yearTD saleTD dataTD">예상매출</td>
			 		<td class="yearTD saleTD rateTD">예상매출(%)</td>
			 		<td class="yearTD saleTD dataTD">달성</td>
			 		<td class="yearTD saleTD rateTD">매출달성률</td>
			 	</tr>
			 	
			 	<tr class="chasisOs">
			 		<td class="chasisOs">샤시힐스</td>
			 		<td class="chasisOs firstTD orderTD dataTD"></td>
			 		<td class="chasisOs firstTD orderTD dataTD"></td>
			 		<td class="chasisOs firstTD orderTD rateTD"></td>
			 		<td class="chasisOs firstTD orderTD dataTD"></td>
			 		<td class="chasisOs firstTD orderTD rateTD"></td>
			 		
			 		<td class="chasisOs firstTD saleTD dataTD"></td>
			 		<td class="chasisOs firstTD saleTD dataTD"></td>
			 		<td class="chasisOs firstTD saleTD rateTD"></td>
			 		<td class="chasisOs firstTD saleTD dataTD"></td>
			 		<td class="chasisOs firstTD saleTD rateTD"></td>
			 		
			 		<td class="chasisOs lastTD orderTD dataTD"></td>
			 		<td class="chasisOs lastTD orderTD dataTD"></td>
			 		<td class="chasisOs lastTD orderTD rateTD"></td>
			 		<td class="chasisOs lastTD orderTD dataTD"></td>
			 		<td class="chasisOs lastTD orderTD rateTD"></td>
			 		
			 		<td class="chasisOs lastTD saleTD dataTD"></td>
			 		<td class="chasisOs lastTD saleTD dataTD"></td>
			 		<td class="chasisOs lastTD saleTD rateTD"></td>
			 		<td class="chasisOs lastTD saleTD dataTD"></td>
			 		<td class="chasisOs lastTD saleTD rateTD"></td>
			 		
			 		<td class="chasisOs yearTD orderTD dataTD"></td>
			 		<td class="chasisOs yearTD orderTD dataTD"></td>
			 		<td class="chasisOs yearTD orderTD rateTD"></td>
			 		<td class="chasisOs yearTD orderTD dataTD"></td>
			 		<td class="chasisOs yearTD orderTD rateTD"></td>
			 		
			 		<td class="chasisOs yearTD saleTD dataTD"></td>
			 		<td class="chasisOs yearTD saleTD dataTD"></td>
			 		<td class="chasisOs yearTD saleTD rateTD"></td>
			 		<td class="chasisOs yearTD saleTD dataTD"></td>
			 		<td class="chasisOs yearTD saleTD rateTD"></td>
			 	</tr>
			 	
			 	<tr class="bodyOs">
			 		<td class="bodyOs">바디힐스</td>
			 		<td class="bodyOs firstTD orderTD dataTD"></td>
			 		<td class="bodyOs firstTD orderTD dataTD"></td>
			 		<td class="bodyOs firstTD orderTD rateTD"></td>
			 		<td class="bodyOs firstTD orderTD dataTD"></td>
			 		<td class="bodyOs firstTD orderTD rateTD"></td>
			 		
			 		<td class="bodyOs firstTD saleTD dataTD"></td>
			 		<td class="bodyOs firstTD saleTD dataTD"></td>
			 		<td class="bodyOs firstTD saleTD rateTD"></td>
			 		<td class="bodyOs firstTD saleTD dataTD"></td>
			 		<td class="bodyOs firstTD saleTD rateTD"></td>
			 		
			 		<td class="bodyOs lastTD orderTD dataTD"></td>
			 		<td class="bodyOs lastTD orderTD dataTD"></td>
			 		<td class="bodyOs lastTD orderTD rateTD"></td>
			 		<td class="bodyOs lastTD orderTD dataTD"></td>
			 		<td class="bodyOs lastTD orderTD rateTD"></td>
			 		
			 		<td class="bodyOs lastTD saleTD dataTD"></td>
			 		<td class="bodyOs lastTD saleTD dataTD"></td>
			 		<td class="bodyOs lastTD saleTD rateTD"></td>
			 		<td class="bodyOs lastTD saleTD dataTD"></td>
			 		<td class="bodyOs lastTD saleTD rateTD"></td>
			 		
			 		<td class="bodyOs yearTD orderTD dataTD"></td>
			 		<td class="bodyOs yearTD orderTD dataTD"></td>
			 		<td class="bodyOs yearTD orderTD rateTD"></td>
			 		<td class="bodyOs yearTD orderTD dataTD"></td>
			 		<td class="bodyOs yearTD orderTD rateTD"></td>
			 		
			 		<td class="bodyOs yearTD saleTD dataTD"></td>
			 		<td class="bodyOs yearTD saleTD dataTD"></td>
			 		<td class="bodyOs yearTD saleTD rateTD"></td>
			 		<td class="bodyOs yearTD saleTD dataTD"></td>
			 		<td class="bodyOs yearTD saleTD rateTD"></td>
			 	</tr>
			 	
			 	<tr class="controlOs">
			 		<td class="controlOs">제어로직</td>
			 		<td class="controlOs firstTD orderTD dataTD"></td>
			 		<td class="controlOs firstTD orderTD dataTD"></td>
			 		<td class="controlOs firstTD orderTD rateTD"></td>
			 		<td class="controlOs firstTD orderTD dataTD"></td>
			 		<td class="controlOs firstTD orderTD rateTD"></td>
			 		
			 		<td class="controlOs firstTD saleTD dataTD"></td>
			 		<td class="controlOs firstTD saleTD dataTD"></td>
			 		<td class="controlOs firstTD saleTD rateTD"></td>
			 		<td class="controlOs firstTD saleTD dataTD"></td>
			 		<td class="controlOs firstTD saleTD rateTD"></td>
			 		
			 		<td class="controlOs lastTD orderTD dataTD"></td>
			 		<td class="controlOs lastTD orderTD dataTD"></td>
			 		<td class="controlOs lastTD orderTD rateTD"></td>
			 		<td class="controlOs lastTD orderTD dataTD"></td>
			 		<td class="controlOs lastTD orderTD rateTD"></td>
			 		
			 		<td class="controlOs lastTD saleTD dataTD"></td>
			 		<td class="controlOs lastTD saleTD dataTD"></td>
			 		<td class="controlOs lastTD saleTD rateTD"></td>
			 		<td class="controlOs lastTD saleTD dataTD"></td>
			 		<td class="controlOs lastTD saleTD rateTD"></td>
			 		
			 		<td class="controlOs yearTD orderTD dataTD"></td>
			 		<td class="controlOs yearTD orderTD dataTD"></td>
			 		<td class="controlOs yearTD orderTD rateTD"></td>
			 		<td class="controlOs yearTD orderTD dataTD"></td>
			 		<td class="controlOs yearTD orderTD rateTD"></td>
			 		
			 		<td class="controlOs yearTD saleTD dataTD"></td>
			 		<td class="controlOs yearTD saleTD dataTD"></td>
			 		<td class="controlOs yearTD saleTD rateTD"></td>
			 		<td class="controlOs yearTD saleTD dataTD"></td>
			 		<td class="controlOs yearTD saleTD rateTD"></td>
			 	</tr>
			 	
			 	<tr class="safeOs">
			 		<td class="safeOs">기능안전</td>
			 		<td class="safeOs firstTD orderTD dataTD"></td>
			 		<td class="safeOs firstTD orderTD dataTD"></td>
			 		<td class="safeOs firstTD orderTD rateTD"></td>
			 		<td class="safeOs firstTD orderTD dataTD"></td>
			 		<td class="safeOs firstTD orderTD rateTD"></td>
			 		
			 		<td class="safeOs firstTD saleTD dataTD"></td>
			 		<td class="safeOs firstTD saleTD dataTD"></td>
			 		<td class="safeOs firstTD saleTD rateTD"></td>
			 		<td class="safeOs firstTD saleTD dataTD"></td>
			 		<td class="safeOs firstTD saleTD rateTD"></td>
			 		
			 		<td class="safeOs lastTD orderTD dataTD"></td>
			 		<td class="safeOs lastTD orderTD dataTD"></td>
			 		<td class="safeOs lastTD orderTD rateTD"></td>
			 		<td class="safeOs lastTD orderTD dataTD"></td>
			 		<td class="safeOs lastTD orderTD rateTD"></td>
			 		
			 		<td class="safeOs lastTD saleTD dataTD"></td>
			 		<td class="safeOs lastTD saleTD dataTD"></td>
			 		<td class="safeOs lastTD saleTD rateTD"></td>
			 		<td class="safeOs lastTD saleTD dataTD"></td>
			 		<td class="safeOs lastTD saleTD rateTD"></td>
			 		
			 		<td class="safeOs yearTD orderTD dataTD"></td>
			 		<td class="safeOs yearTD orderTD dataTD"></td>
			 		<td class="safeOs yearTD orderTD rateTD"></td>
			 		<td class="safeOs yearTD orderTD dataTD"></td>
			 		<td class="safeOs yearTD orderTD rateTD"></td>
			 		
			 		<td class="safeOs yearTD saleTD dataTD"></td>
			 		<td class="safeOs yearTD saleTD dataTD"></td>
			 		<td class="safeOs yearTD saleTD rateTD"></td>
			 		<td class="safeOs yearTD saleTD dataTD"></td>
			 		<td class="safeOs yearTD saleTD rateTD"></td>
			 	</tr>
			 	
			 	<tr class="autoOs">
			 		<td class="autoOs">자율주행</td>
			 		<td class="autoOs firstTD orderTD dataTD"></td>
			 		<td class="autoOs firstTD orderTD dataTD"></td>
			 		<td class="autoOs firstTD orderTD rateTD"></td>
			 		<td class="autoOs firstTD orderTD dataTD"></td>
			 		<td class="autoOs firstTD orderTD rateTD"></td>
			 		
			 		<td class="autoOs firstTD saleTD dataTD"></td>
			 		<td class="autoOs firstTD saleTD dataTD"></td>
			 		<td class="autoOs firstTD saleTD rateTD"></td>
			 		<td class="autoOs firstTD saleTD dataTD"></td>
			 		<td class="autoOs firstTD saleTD rateTD"></td>
			 		
			 		<td class="autoOs lastTD orderTD dataTD"></td>
			 		<td class="autoOs lastTD orderTD dataTD"></td>
			 		<td class="autoOs lastTD orderTD rateTD"></td>
			 		<td class="autoOs lastTD orderTD dataTD"></td>
			 		<td class="autoOs lastTD orderTD rateTD"></td>
			 		
			 		<td class="autoOs lastTD saleTD dataTD"></td>
			 		<td class="autoOs lastTD saleTD dataTD"></td>
			 		<td class="autoOs lastTD saleTD rateTD"></td>
			 		<td class="autoOs lastTD saleTD dataTD"></td>
			 		<td class="autoOs lastTD saleTD rateTD"></td>
			 		
			 		<td class="autoOs yearTD orderTD dataTD"></td>
			 		<td class="autoOs yearTD orderTD dataTD"></td>
			 		<td class="autoOs yearTD orderTD rateTD"></td>
			 		<td class="autoOs yearTD orderTD dataTD"></td>
			 		<td class="autoOs yearTD orderTD rateTD"></td>
			 		
			 		<td class="autoOs yearTD saleTD dataTD"></td>
			 		<td class="autoOs yearTD saleTD dataTD"></td>
			 		<td class="autoOs yearTD saleTD rateTD"></td>
			 		<td class="autoOs yearTD saleTD dataTD"></td>
			 		<td class="autoOs yearTD saleTD rateTD"></td>	
			 	</tr>
			 	
			 	<tr class="vtOs">
			 		<td class="vtOs">VT</td>
			 		<td class="vtOs firstTD orderTD dataTD"></td>
			 		<td class="vtOs firstTD orderTD dataTD"></td>
			 		<td class="vtOs firstTD orderTD rateTD"></td>
			 		<td class="vtOs firstTD orderTD dataTD"></td>
			 		<td class="vtOs firstTD orderTD rateTD"></td>
			 		
			 		<td class="vtOs firstTD saleTD dataTD"></td>
			 		<td class="vtOs firstTD saleTD dataTD"></td>
			 		<td class="vtOs firstTD saleTD rateTD"></td>
			 		<td class="vtOs firstTD saleTD dataTD"></td>
			 		<td class="vtOs firstTD saleTD rateTD"></td>
			 		
			 		<td class="vtOs lastTD orderTD dataTD"></td>
			 		<td class="vtOs lastTD orderTD dataTD"></td>
			 		<td class="vtOs lastTD orderTD rateTD"></td>
			 		<td class="vtOs lastTD orderTD dataTD"></td>
			 		<td class="vtOs lastTD orderTD rateTD"></td>
			 		
			 		<td class="vtOs lastTD saleTD dataTD"></td>
			 		<td class="vtOs lastTD saleTD dataTD"></td>
			 		<td class="vtOs lastTD saleTD rateTD"></td>
			 		<td class="vtOs lastTD saleTD dataTD"></td>
			 		<td class="vtOs lastTD saleTD rateTD"></td>
			 		
			 		<td class="vtOs yearTD orderTD dataTD"></td>
			 		<td class="vtOs yearTD orderTD dataTD"></td>
			 		<td class="vtOs yearTD orderTD rateTD"></td>
			 		<td class="vtOs yearTD orderTD dataTD"></td>
			 		<td class="vtOs yearTD orderTD rateTD"></td>
			 		
			 		<td class="vtOs yearTD saleTD dataTD"></td>
			 		<td class="vtOs yearTD saleTD dataTD"></td>
			 		<td class="vtOs yearTD saleTD rateTD"></td>
			 		<td class="vtOs yearTD saleTD dataTD"></td>
			 		<td class="vtOs yearTD saleTD rateTD"></td>	
			 	</tr>
			 	
			 	<tr class="totalOs">
			 		<td class="totalOs">total</td>
			 		<td class="totalOs firstTD orderTD dataTD"></td>
			 		<td class="totalOs firstTD orderTD dataTD"></td>
			 		<td class="totalOs firstTD orderTD rateTD"></td>
			 		<td class="totalOs firstTD orderTD dataTD"></td>
			 		<td class="totalOs firstTD orderTD rateTD"></td>
			 		
			 		<td class="totalOs firstTD saleTD dataTD"></td>
			 		<td class="totalOs firstTD saleTD dataTD"></td>
			 		<td class="totalOs firstTD saleTD rateTD"></td>
			 		<td class="totalOs firstTD saleTD dataTD"></td>
			 		<td class="totalOs firstTD saleTD rateTD"></td>
			 		
			 		<td class="totalOs lastTD orderTD dataTD"></td>
			 		<td class="totalOs lastTD orderTD dataTD"></td>
			 		<td class="totalOs lastTD orderTD rateTD"></td>
			 		<td class="totalOs lastTD orderTD dataTD"></td>
			 		<td class="totalOs lastTD orderTD rateTD"></td>
			 		
			 		<td class="totalOs lastTD saleTD dataTD"></td>
			 		<td class="totalOs lastTD saleTD dataTD"></td>
			 		<td class="totalOs lastTD saleTD rateTD"></td>
			 		<td class="totalOs lastTD saleTD dataTD"></td>
			 		<td class="totalOs lastTD saleTD rateTD"></td>
			 		
			 		<td class="totalOs yearTD orderTD dataTD"></td>
			 		<td class="totalOs yearTD orderTD dataTD"></td>
			 		<td class="totalOs yearTD orderTD rateTD"></td>
			 		<td class="totalOs yearTD orderTD dataTD"></td>
			 		<td class="totalOs yearTD orderTD rateTD"></td>
			 		
			 		<td class="totalOs yearTD saleTD dataTD"></td>
			 		<td class="totalOs yearTD saleTD dataTD"></td>
			 		<td class="totalOs yearTD saleTD rateTD"></td>
			 		<td class="totalOs yearTD saleTD dataTD"></td>
			 		<td class="totalOs yearTD saleTD rateTD"></td>
			 	</tr>
			 </tbody> 				 
	 </table>
				 
</body>

</html>