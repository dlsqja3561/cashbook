<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%		
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// 로그인이 되어 있을때는 접근불가
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	//회원가입 완료, 실패, 회원탈퇴 msg 출력
	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
	}
	// 로그인 정보입력 없으면 msg1
	String msg1 = request.getParameter("msg1");

	// 페이징 구하기
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1) * rowPerPage;

	NoticeDao noticeDao = new NoticeDao();

	// lastPage
	int count = noticeDao.selectNoticeCount();
	int lastPage = count / rowPerPage;
	if(count % rowPerPage != 0) {
		lastPage+=1;
	}
	// 공지목록
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
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
	<link rel="canonical" href="https://demo-basic.adminkit.io/pages-sign-in.html" />
	<title>loginForm</title>
	<link href="./resorces/css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
	<script src='https://kit.fontawesome.com/a076d05399.js'></script>
</head>

<body>
	<!-- 공지목록 -->
	<main class="d-flex w-100">
		<div class="container d-flex flex-column">
			<div class="row pt-5">
				<div class="col-sm-10 col-md-8 col-lg-7 mx-auto d-table h-100">
					<div class="d-table-cell align-middle">
						<table class="table my-2 text-center">
							<tr>
								<th>공지내용</th>
								<th>날짜</th>
							</tr>
							<%
								for(Notice n : list) {
							%>
									<tr>
										<td><%=n.getNoticeMemo()%></td>
										<td><%=n.getCreatedate()%></td>
									</tr>
							<%
								}
							%>
						</table>
						<!-- 페이징 -->
						<div class="text-center pt-2">
							<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1"><i class='fas fa-angle-double-left'></i>&nbsp;</a>
						<%
							if(currentPage > 1) {
						%>
								<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>"><i class='fas fa-angle-left'></i></a>
						<%	// 1페이지일때 이전버튼 클릭시 
							} else {
						%>
								<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1"><i class='fas fa-angle-left'></i></a>
						<%
							}
						%>
							<span>&nbsp;<%=currentPage%> / <%=lastPage%>&nbsp;</span>
						<%
							if(currentPage < lastPage) {
						%>
								<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>"><i class='fas fa-angle-right'></i></a>
						<%	// 마지막페이지 일때 다음버튼 클릭시
							} else {
						%>
								<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>"><i class='fas fa-angle-right'></i></a>
						<%
							}
						%>
							<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">&nbsp;<i class='fas fa-angle-double-right'></i></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	
	<!-- 로그인 폼 -->
	<main class="d-flex w-100">
		<div class="container d-flex flex-column">
			<div class="row pt-5">
				<div class="col-sm-10 col-md-8 col-lg-6 mx-auto d-table h-100">
					<div class="d-table-cell align-middle">
						<div class="text-center mt-2">
							<h1 class="h2">로그인</h1>
							<%
								// 로그인 정보입력 없으면 msg1 출력
								if(msg1 != null){
							%>
									 <%=msg1%>
							<%
								}
							%>
							<div class="p-1 bg-primary rounded"></div>
						</div>
						<div class="card">
							<div class="card-body">
								<div class="m-sm-5">
									<!-- 로그인 폼 -->
									<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
										<div class="mb-3">
											<label class="form-label">ID</label>
											<input class="form-control form-control-lg" type="text" name="memberId" value="admin">
										</div>
										<div class="mb-3">
											<label class="form-label">Password</label>
											<input class="form-control form-control-lg" type="password" name="memberPw" value="1234">
											<small>
												<a href="loginForm.jsp">Forgot password?</a>
											</small>
										</div>
										<div>
											<label class="form-check">
												<input class="form-check-input" type="checkbox" value="remember-me" name="remember-me" checked>
												<span class="form-check-label">
													Remember me next time
												</span>
											</label>
										</div>
										<div class="text-center mt-3">
											<button type="submit" class="btn btn-primary">로그인</button>
											<a href="<%=request.getContextPath()%>/insertMemberForm.jsp" class="btn btn-primary">회원가입</a>
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