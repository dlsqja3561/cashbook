<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	//로그인 안되어 있거나 level 0인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;
	
	HelpDao helpDao = new HelpDao();
	
	// lastPage
	int count = helpDao.selectHelpCount();
	int lastPage = count / rowPerPage;
	if(count % rowPerPage != 0) {
		lastPage += 1; 
	}

	// 문의 목록
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
	
	// View
%>


<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link rel="shortcut icon" href="../resorces/img/icons/icon1-48x48.png" />
	<link rel="canonical" href="https://demo-basic.adminkit.io/" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<title>helpListAll</title>
	<link href="../resorces/css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
	<script src='https://kit.fontawesome.com/a076d05399.js'></script>
	<style>
		table {
			text-align: center;
		}
	</style>
</head>

<body>
	<div class="wrapper">
		<!-- sidebar include -->
		<jsp:include page="/inc/sidebar.jsp"></jsp:include>

		<div class="main">
			<nav class="navbar navbar-expand navbar-light navbar-bg">
				<a class="sidebar-toggle js-sidebar-toggle">
		          <i class="hamburger align-self-center"></i>
		        </a>

				<div class="navbar-collapse collapse">
					<ul class="navbar-nav navbar-align">
						<li class="nav-item dropdown">
							<a class="nav-icon dropdown-toggle" href="#" id="alertsDropdown" data-bs-toggle="dropdown">
								<span class="position-relative">
									<i class="align-middle" data-feather="bell"></i>
									<span class="indicator">4</span>
								</span>
							</a>
							<div class="dropdown-menu dropdown-menu-lg dropdown-menu-end py-0" aria-labelledby="alertsDropdown">
								<div class="dropdown-menu-header">
									4 New Notifications
								</div>
								<div class="list-group">
									<a href="#" class="list-group-item">
										<span class="row g-0 align-items-center">
											<span class="col-2">
												<i class="text-danger" data-feather="alert-circle"></i>
											</span>
											<span class="col-10">
												<span class="text-dark">Update completed</span><br>
												<span class="text-muted small mt-1">Restart server 12 to complete the update.</span><br>
												<span class="text-muted small mt-1">30m ago</span>
											</span>
										</span>
									</a>
									<a href="#" class="list-group-item">
										<span class="row g-0 align-items-center">
											<span class="col-2">
												<i class="text-warning" data-feather="bell"></i>
											</span>
											<span class="col-10">
												<span class="text-dark">Lorem ipsum</span><br>
												<span class="text-muted small mt-1">Aliquam ex eros, imperdiet vulputate hendrerit et.</span><br>
												<span class="text-muted small mt-1">2h ago</span>
											</span>
										</span>
									</a>
									<a href="#" class="list-group-item">
										<span class="row g-0 align-items-center">
											<span class="col-2">
												<i class="text-primary" data-feather="home"></i>
											</span>
											<span class="col-10">
												<span class="text-dark">Login from 192.186.1.8</span><br>
												<span class="text-muted small mt-1">5h ago</span>
											</span>
										</span>
									</a>
									<a href="#" class="list-group-item">
										<span class="row g-0 align-items-center">
											<span class="col-2">
												<i class="text-success" data-feather="user-plus"></i>
											</span>
											<span class="col-10">
												<span class="text-dark">New connection</span><br>
												<span class="text-muted small mt-1">Christina accepted your request.</span><br>
												<span class="text-muted small mt-1">14h ago</span>
											</span>
										</span>
									</a>
								</div>
								<div class="dropdown-menu-footer">
									<a href="#" class="text-muted">Show all notifications</a>
								</div>
							</div>
						</li>
						
						
						<!-- ------------------------------------------------------------------------ -->
						<li class="nav-item dropdown">
							<a class="nav-icon dropdown-toggle d-inline-block d-sm-none" href="#" data-bs-toggle="dropdown">
								<i class="align-middle" data-feather="#"></i>
							</a>

							<a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-bs-toggle="dropdown">
								<span class="text-dark"><%=loginMember.getMemberId()%>(<%=loginMember.getMemberName()%>)</span>
							</a>
							<div class="dropdown-menu dropdown-menu-end">
								<a class="dropdown-item" href="#"><i class="align-middle me-1" data-feather="#"></i> Profile</a>
								<a class="dropdown-item" href="<%=request.getContextPath()%>/admin/adminMain.jsp"><i class="align-middle me-1" data-feather="#"></i> 관리자 페이지</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="<%=request.getContextPath()%>/updateMemberForm.jsp"><i class="align-middle me-1" data-feather="#"></i> 비밀번호 변경</a>
								<a class="dropdown-item" href="<%=request.getContextPath()%>/deleteMemberForm.jsp"><i class="align-middle me-1" data-feather="#"></i> 회원탈퇴</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="<%=request.getContextPath()%>/logout.jsp"> 로그아웃</a>
							</div>
						</li>
					</ul>
				</div>
			</nav>

			<main class="content">
				<div class="container-fluid p-5">
					<h1 class="h3 mb-3"><strong>멤버 문의 관리</strong> </h1>
					<div class="row">
						<div class="col-12 col-lg-10 col-xxl-10 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<h5 class="card-title mb-0">Help List</h5>
								</div>
								<!-- 고객센터 문의 목록 -->
								<table class="table table-hover my-0">
									<tr class="h5">
										<th>문의내용</th>
										<th>멤버ID</th>
										<th>문의날짜</th>
										<th>답변내용</th>
										<th>답변날짜</th>
										<th>답변추가 / 수정 / 삭제</th>
									</tr>
									<%
										for(HashMap<String, Object> m : list) {
									%>
											<tr>
												<td><%=m.get("helpMemo")%></td>
												<td><%=m.get("memberId")%></td>
												<td><%=m.get("helpCreatedate")%></td>
												<td>
													<%
														if(m.get("commentMemo") == null) {
													%>
															<span class="text-warning">답변이 등록되지 않았습니다</span>
													<%
														} else {
													%>
															<%=m.get("commentMemo")%>
													<%
														}
													%>
												</td>
												<td>
													<%
														if(m.get("commentCreatedate") == null) {
													%>
															<span class="text-warning">답변이 등록되지 않았습니다</span>
													<%
														} else {
													%>
															<%=m.get("commentCreatedate")%>
													<%
														}
													%>
												</td>
												<td>
													<%
														if(m.get("commentMemo") == null) {
													%>
															<a href="<%=request.getContextPath()%>/admin/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>" class="btn btn-outline-primary">답변입력</a>
													<%
														} else {
													%>
															<a href="<%=request.getContextPath()%>/admin/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>" class="btn btn-outline-info">답변수정</a>
															<a href="<%=request.getContextPath()%>/admin/deleteComment.jsp?commentNo=<%=m.get("commentNo")%>" class="btn btn-outline-danger">답변삭제</a>
													<%
														}
													%>
												</td>
											</tr>
									<%
										}
									%>
								</table>
								<!-- 페이징 -->
								<div class="text-center">
									<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1"><i class='fas fa-angle-double-left'><<</i>&nbsp;</a>
								<%
									if(currentPage > 1) {
								%>
										<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1%>"><i class='fas fa-angle-left'><</i></a>
								<%	// 1페이지일때 이전버튼 클릭시 
									} else {
								%>
										<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1"><i class='fas fa-angle-left'><</i></a>
								<%
									}
								%>
									<span>&nbsp;<%=currentPage%> / <%=lastPage%>&nbsp;</span>
								<%
									if(currentPage < lastPage) {
								%>
										<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1%>"><i class='fas fa-angle-right'>></i></a>
								<%	// 마지막페이지 일때 다음버튼 클릭시
									} else {
								%>
										<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>"><i class='fas fa-angle-right'>></i></a>
								<%
									}
								%>
									<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>">&nbsp;<i class='fas fa-angle-double-right'>>></i></a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
				
			<!-- footer include -->
			<jsp:include page="/inc/footer.jsp"></jsp:include>
			
		</div>
	</div>

</body>
</html>