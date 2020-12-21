<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%
	PrintWriter script =  response.getWriter();
	if(session.getAttribute("sessionID") != null){
		if(Integer.parseInt(session.getAttribute("permission").toString()) <= 1){
			script.print("<script> location.href = '../jsp/manager_schedule/manager_schedule.jsp'; </script>");
		} else{
			script.print("<script> location.href = '../jsp/report/report.jsp'; </script>");
		}
	}
%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=0, user-scalable=no, target-densitydpi=medium-dpi" >

<title>Sure FVMS - Login</title>

<!-- Custom fonts for this template-->
<link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<style>
.loading {
	position: absolute;
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
	position: absolute;
	top: 40%;
	left: 50%;
	transform: translate(-50%, -50%);
}
</style>

<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript">
	<!-- 로딩화면 -->
	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').hide();
	});
	
	
</script>
<body style="background-color: #4e73df;">
	<!--  로딩화면  시작  -->
	<div class="loading">
		<div id="load">
			<i class="fas fa-spinner fa-10x fa-spin"></i>
		</div>
	</div>
	<!--  로딩화면  끝  -->
	<div class="container">

		<!-- Outer Row -->
		<div class="row justify-content-center">
			<div class="col-xl-10 col-lg-12 col-md-9">
				<div>
					<div class="card o-hidden border-0 my-5">
						<div class="card-body p-0">
							<!-- Nested Row within Card Body -->
							<div class="row" style="background-color: #4e73df;">
								<div class="d-none d-lg-block"></div>
								<div class="card col-lg-6"
									style="margin: 0 auto; background-color: #fff;">
									<div class="p-5">
										<div class="text-center">
											<h1 class="h4 text-gray-900 mb-4">로그인</h1>
										</div>
										<form class="user" method="post" action="../jsp/LoginPro.jsp">
											<div class="form-group">
												<input type="text" class="form-control form-control-user"
													name="ID" id="ID" aria-describedby="emailHelp"
													placeholder="ID">
											</div>
											<div class="form-group">
												<input type="password"
													class="form-control form-control-user" name="PW" id="PW"
													placeholder="Password">
											</div>
											<!-- <div class="form-group">
                      <div class="custom-control custom-checkbox small">
                        <input type="checkbox" class="custom-control-input" id="customCheck">
                        <label class="custom-control-label" for="customCheck">자동로그인</label>
                      </div>
                    </div> -->
											<div>
												<input id="login" type="submit" name="login" value="Login"
													class="btn btn-primary btn-user btn-block">
											</div>

										</form>
										<hr>
										<div class="text-center">
											<a class="small" href="/jsp/release.html">FVMS_7.6_2020-12-21:12:00</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Bootstrap core JavaScript-->
		<script src="../vendor/jquery/jquery.min.js"></script>
		<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

		<!-- Core plugin JavaScript-->
		<script src="../vendor/jquery-easing/jquery.easing.min.js"></script>

		<!-- Custom scripts for all pages-->
		<script src="../js/sb-admin-2.min.js"></script>
</body>
</html> 