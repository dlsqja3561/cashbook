<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	//로그인이 되어 있을때는 접근불가
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	//정보입력 없으면, id 중복시 msg 값 받기
	String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
	<meta name="author" content="AdminKit">
	<meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link rel="shortcut icon" href="./resorces/img/icons/icon1-48x48.png" />
	<link rel="canonical" href="https://demo-basic.adminkit.io/pages-sign-up.html" />
	<title>insertMemberForm</title>
	<link href="./resorces/css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
</head>

<body>
	<main class="d-flex w-100">
		<div class="container d-flex flex-column">
			<div class="row vh-100">
				<div class="col-sm-10 col-md-8 col-lg-6 mx-auto d-table h-100">
					<div class="d-table-cell align-middle">
						<div class="text-center mt-4">
							<h1 class="h2">회원가입</h1>
							<%
								// 정보입력 없으면, id 중복시 msg 출력
								if(msg != null){
							%>
									 <%=msg%>
							<%
								}
							%>
						</div>
						<div class="p-1 bg-primary rounded"></div>
						<div class="card">
							<div class="card-body">
								<div class="m-sm-4">
									<form id="form" action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
										<div class="mb-3">
											<label class="form-label">ID</label>
											<input class="form-control form-control-lg" type="text" id="memberId" name="memberId" placeholder="Enter your id" />
										</div>
										<div class="mb-3">
											<label class="form-label">Password</label>
											<input class="form-control form-control-lg" type="password" id="memberPw" name="memberPw" placeholder="Enter your password" />
										</div>
										<div class="mb-3">
											<label class="form-label">Name</label>
											<input class="form-control form-control-lg" type="text" id="memberName" name="memberName" placeholder="Enter your name" />
										</div>
										<div class="text-center mt-3">
											<button type="button" id="btn" class="btn btn-lg btn-primary">회원가입</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<script>
		let btn = document.querySelector('#btn');
		btn.addEventListener('click', function(){
			// 디버깅
			console.log('btn click!');
			
			// id 폼 유효성 검사
			let memberId = document.querySelector('#memberId');
			if(memberId.value == '') {
				alert('ID를 입력해주세요');
				memberId.focus();
				return;
			}
			
			// pw 폼 유효성 검사
			let memberPw = document.querySelector('#memberPw');
			if(memberPw.value == '') {
				alert('PASSWORD를 입력해주세요');
				memberPw.focus();
				return;
			}
			
			// name 폼 유효성 검사
			let memberName = document.querySelector('#memberName');
			if(memberName.value == '') {
				alert('NAME을 입력해주세요');
				memberName.focus();
				return;
			}
			
			let form = document.querySelector('#form');
			form.submit(); 
		})
	</script>
</body>
</html>