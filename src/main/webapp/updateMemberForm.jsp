<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//로그인이 되어 있지 않을때 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

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
	<link rel="shortcut icon" href="./resorces/img/icons/icon-48x48.png" />
	<link rel="canonical" href="https://demo-basic.adminkit.io/pages-sign-up.html" />
	<title>updateMemberForm</title>
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
							<h1 class="h2">비밀번호 변경</h1>
							<%
								// 정보입력 없으면, 현재pw, 변경pw 다를시 msg 출력
								if(msg != null){
							%>
									 <%=msg%>
							<%
								}
							%>
						</div>

						<div class="card">
							<div class="card-body">
								<div class="m-sm-4">
									<form action="<%=request.getContextPath()%>/updateMemberAction.jsp" method="post">
										<div class="mb-3">
											<label class="form-label">현재 비밀번호</label>
											<input class="form-control form-control-lg" type="password" name="memberPw" placeholder="Enter your password" />
										</div>
										<div class="mb-3">
											<label class="form-label">변경할 비밀번호</label>
											<input class="form-control form-control-lg" type="password" name="newPw" placeholder="Enter your new password" />
										</div>
										<div class="mb-3">
											<label class="form-label">변경할 비밀번호 확인</label>
											<input class="form-control form-control-lg" type="password" name="newPwCk" placeholder="Enter your new password" />
										</div>
										<div class="text-center mt-3">
											<button type="submit" class="btn btn-lg btn-primary">변경하기</button>
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