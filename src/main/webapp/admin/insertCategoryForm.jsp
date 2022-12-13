<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// Controller
	// 로그인 안되어 있거나 level 0인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
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
	<link rel="shortcut icon" href="../resorces/img/icons/icon1-48x48.png" />
	<link rel="canonical" href="https://demo-basic.adminkit.io/pages-sign-up.html" />
	<title>insertCategoryForm</title>
	<link href="../resorces/css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
</head>

<body>
	<main class="d-flex w-100">
		<div class="container d-flex flex-column">
			<div class="row vh-100">
				<div class="col-sm-10 col-md-8 col-lg-6 mx-auto d-table h-100">
					<div class="d-table-cell align-middle">
						<div class="text-center mt-4">
							<h1 class="h2">카테고리 내용추가</h1>
							<%
								// 입력 없으면 msg 출력
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
									<form action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" method="post">
										<div class="mb-1">
											<label class="form-check-label">수입 / 지출 선택</label>
										</div>
										<div class="mb-3">
											<input class="form-check-input" type="radio" id="radio1" name="categoryKind" value="수입">
											<label class="form-check-label" for="radio1">수입</label>&nbsp;&nbsp;
											<input class="form-check-input" type="radio" id="radio2" name="categoryKind" value="지출">
											<label class="form-check-label" for="radio2">지출</label>
										</div>
										<div class="mb-3">
											<label class="form-label">카테고리내용</label>
											<input class="form-control form-control-lg" type="text" name="categoryName">
										</div>
										<div class="text-center mt-3">
											<button type="submit" class="btn btn-lg btn-outline-primary">추가하기</button>
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