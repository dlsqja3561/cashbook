<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*"%>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");

	// 로그인 안되어 있거나 level 0인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// 입력값 없을때 msg
	String msg = request.getParameter("msg");
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	Category category = null;
	// Model 호출
	CategoryDao categoryDao = new CategoryDao();
	category = categoryDao.selectCategoryOne(categoryNo);
	
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
	<link rel="shortcut icon" href="../resorces/img/icons/icon-48x48.png" />
	<link rel="canonical" href="https://demo-basic.adminkit.io/pages-sign-up.html" />
	<title>updateCategoryForm</title>
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
							<h1 class="h2">카테고리 이름수정</h1>
							<%
								// 입력 없으면 msg 출력
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
									<form action="<%=request.getContextPath()%>/admin/updateCategoryAction.jsp" method="post">
										<div class="mb-3">
											<label class="form-label">카테고리 번호</label>
											<input class="form-control form-control-lg" type="text" name="categoryNo" value="<%=category.getCategoryNo()%>" readonly="readonly">
										</div>
										<div class="mb-3">
											<label class="form-label">수입/지출</label>
											<input class="form-control form-control-lg" type="text" name="categoryKind" value="<%=category.getCategoryKind()%>" readonly="readonly">
										</div>
										<div class="mb-3">
											<label class="form-label">카테고리 이름</label>
											<input class="form-control form-control-lg" type="text" name="categoryName" value="<%=category.getCategoryName()%>">
										</div>
										<div class="text-center mt-3">
											<button type="submit" class="btn btn-lg btn-primary">수정하기</button>
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