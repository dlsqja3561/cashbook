<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	//로그인 안되어 있을때는 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = request.getParameter("msg");
	
	// seesion에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
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
	<title>deleteMemberForm</title>
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
							<h1 class="h2">회원탈퇴</h1>
							<%
								// 비밀번호 입력 오류 msg
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
									<form action="<%=request.getContextPath()%>/deleteMemberAction.jsp" method="post">
										<div class="mb-5 text-center">
											<h1 class="h3"><%=loginMember.getMemberId()%>(<%=loginMember.getMemberName()%>)님 탈퇴 하시겠습니까?</h1>
										</div>
										<div class="mb-3">
											<label class="form-label">비밀번호 입력</label>
											<input class="form-control form-control-lg" type="password" name="memberPw" placeholder="Enter your password" />
										</div>
										<div class="text-center mt-3">
											<button type="submit" class="btn btn-lg btn-primary">탈퇴하기</button>
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
</body>

</html>