<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*"%>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	//로그인 안되어 있거나 level 0인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = request.getParameter("msg");
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	Help help = new Help();
	
	CommentDao commentDao = new CommentDao();
	help = commentDao.selectHelpOne(helpNo);
	
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
	<title>insertCommentForm</title>
	<link href="../resorces/css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
</head>

<body>
	<main class="d-flex w-100">
		<div class="container d-flex flex-column">
			<div class="row vh-0">
				<div class="col-sm-10 col-md-8 col-lg-6 mx-auto d-table h-100">
					<div class="d-table-cell align-middle">
						<div class="text-center mt-5">
							<h1 class="h2">고객 문의내용</h1>
						</div>
						<div class="card">
							<div class="card-body">
								<div class="m-sm-4">
									<table class="table table-hover my-0">
										<tr>
											<th>회원ID</th>
											<td><%=help.getMemberId()%></td>
										</tr>
										<tr>
											<th>문의날짜</th>
											<td><%=help.getCreatedate()%></td>
										</tr>
										<tr>
											<th>문의내용</th>
											<td><%=help.getHelpMemo()%></td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	
	<!-- 답변입력 form -->
	<main class="d-flex w-100">
		<div class="container d-flex flex-column">
			<div class="row vh-50">
				<div class="col-sm-10 col-md-8 col-lg-6 mx-auto d-table h-100">
					<div class="d-table-cell align-middle">
						<div class="text-center mt-1">
							<h1 class="h2">문의답변 입력하기</h1>
							<%
								// 답변입력 없으면 msg 출력
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
									<form action="<%=request.getContextPath()%>/admin/insertCommentAction.jsp" method="post">
										<input type="hidden" name="helpNo" value="<%=helpNo%>">
										<div class="mb-3">
											<label class="form-label">답변내용</label>
											<textarea rows="5" cols="70" name="commentMemo" class="form-control form-control-lg"></textarea>
										</div>
										<div class="text-center mt-3">
											<button type="submit" class="btn btn-lg btn-primary">답변입력</button>
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