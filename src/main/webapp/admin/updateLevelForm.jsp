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
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	Member member = memberDao.selectMemberOne(memberNo);

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
	<title>updateLevelForm</title>
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
							<h1 class="h2">멤버 레벨 변경</h1>
							<%
								// msg 출력 
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
									<form action="<%=request.getContextPath()%>/admin/updateLevelAction.jsp" method="post">
										<div class="mb-3">
											<label class="form-label">memberNo</label>
											<input class="form-control form-control-lg" type="text" name="memberNo" value="<%=member.getMemberNo()%>" readonly="readonly">
										</div>
										<div class="mb-3">
											<label class="form-label">memberName</label>
											<input class="form-control form-control-lg" type="text" name="memberName" value="<%=member.getMemberName()%>" readonly="readonly">
										</div>
										<div class="mb-3">
											<label class="form-label">memberLevel</label>
											<select name="memberLevel" class="form-select form-select-lg">
												<option value="0">0</option>
												<option value="1">1</option>
											</select>
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