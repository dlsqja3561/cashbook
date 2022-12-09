<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// Controller
	// 로그인 안되어 있거나 level 0인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int beginRow = 0;
	int rowPerPage = 5;
	
	
	// Model : notice list, member list, help list
	NoticeDao noticeDao = new NoticeDao();
	MemberDao memberDao = new MemberDao();
	HelpDao helpDao = new HelpDao();
	
	
	// 최근공지 5개, 최근멤버 5명, 최근문의 5개
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(beginRow, rowPerPage);

	// View
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
	<link rel="canonical" href="https://demo-basic.adminkit.io/" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<title>adminMain</title>
	<link href="../resorces/css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
</head>

<body>
	<div class="wrapper">
		<nav id="sidebar" class="sidebar js-sidebar">
			<div class="sidebar-content js-simplebar">
				<a class="sidebar-brand" href="<%=request.getContextPath()%>/cash/cashList.jsp">
					<span class="align-middle">IBCashBook</span>
				</a>

				<ul class="sidebar-nav">
					<li class="sidebar-header">
						Member menu
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/cash/cashList.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">가계부 리스트</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/help/helpList.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">고객센터</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/updateMemberForm.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">비밀번호 변경</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/deleteMemberForm.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">회원탈퇴</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/logout.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">로그아웃</span>
						</a>
					</li>

					<li class="sidebar-header">
						Admin menu
					</li>

					<li class="sidebar-item active">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/adminMain.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">관리자 페이지</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">공지사항 관리</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/categoryList.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">카테고리 관리</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/memberList.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">멤버 관리</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/helpListAll.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">문의사항 관리</span>
						</a>
					</li>


					<li class="sidebar-header">
						Plugins / Addons
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="charts-chartjs.html">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">Charts</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="maps-google.html">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">Maps</span>
						</a>
					</li>
				</ul>

				<div class="sidebar-cta">
					<div class="sidebar-cta-content">
						<strong class="d-inline-block mb-2">Upgrade to Pro</strong>
						<div class="mb-3 text-sm">
							Are you looking for more components? Check out our premium version.
						</div>
						<div class="d-grid">
							<a href="upgrade-to-pro.html" class="btn btn-primary">Upgrade to Pro</a>
						</div>
					</div>
				</div>
			</div>
		</nav>

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
				<div class="container-fluid p-2">
					<h1 class="h3 mb-3"><strong>공지사항</strong></h1>
					<div class="row">
						<div class="col-12 col-lg-10 col-xxl-8 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<h5 class="card-title mb-0">NoticeList</h5>
								</div>
								<!-- 최근공지 목록 -->
								<div>
									<table class="table table-hover my-0">
										<tr class="h5">
											<th>공지내용</th>
											<th>공지날짜</th>
										</tr>
										<%
											for(Notice n : noticeList) {
										%>
												<tr>
													<td><%=n.getNoticeMemo()%></td>
													<td><%=n.getCreatedate()%></td>
												</tr>
										<%
											}
										%>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
			
			<main class="content">
				<div class="container-fluid p-2">
					<h1 class="h3 mb-3"><strong>문의사항</strong></h1>
					<div class="row">
						<div class="col-12 col-lg-10 col-xxl-8 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<h5 class="card-title mb-0">Help List</h5>
								</div>
								<!-- 최근문의 목록 -->
								<div>
									<table class="table table-hover my-0">
										<tr class="h5">
											<th>문의내용</th>
											<th>회원아이디</th>
											<th>문의날짜</th>
										</tr>
										<%
											for(HashMap<String, Object> h : helpList) {
										%>
												<tr>
													<td><%=h.get("helpMemo")%></td>
													<td><%=h.get("memberId")%></td>
													<td><%=h.get("helpCreatedate")%></td>
												</tr>
										<%
											}
										%>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
			
			<main class="content">
				<div class="container-fluid p-2">
					<h1 class="h3 mb-3"><strong>멤버현황</strong></h1>
					<div class="row">
						<div class="col-10 col-lg-8 col-xxl-8 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<h5 class="card-title mb-0">Member List</h5>
								</div>
								<!-- 최근멤버 목록 -->
								<div>
									<table class="table table-hover my-0">
										<tr class="h5">
											<th>아이디</th>
											<th>레벨</th>
											<th>이름</th>
											<th>생성일</th>
										</tr>
										<%
											for(Member m : memberList) {
										%>
												<tr>
													<td><%=m.getMemberId()%></td>
													<td><%=m.getMemberLevel()%></td>
													<td><%=m.getMemberName()%></td>
													<td><%=m.getCreatedate()%></td>
												</tr>
										<%
											}
										%>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
			
			<!-- footer -->
			<footer class="footer">
				<div class="container-fluid">
					<div class="row text-muted">
						<div class="col-6 text-start">
							<p class="mb-0">
								<a class="text-muted" href="#" target="_blank"><strong>IBCashBook</strong></a> - <a class="text-muted" href="#" target="_blank"><strong>Copyright</strong></a>								&copy;
							</p>
						</div>
						<div class="col-6 text-end">
							<ul class="list-inline">
								<li class="list-inline-item">
									<a class="text-muted" href="<%=request.getContextPath()%>/help/helpList.jsp" target="_blank">Support</a>
								</li>
								<li class="list-inline-item">
									<a class="text-muted" href="<%=request.getContextPath()%>/help/helpList.jsp" target="_blank">Help Center</a>
								</li>
								<li class="list-inline-item">
									<a class="text-muted" href="#" target="_blank">Privacy</a>
								</li>
								<li class="list-inline-item">
									<a class="text-muted" href="#" target="_blank">Terms</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>

</body>
</html>