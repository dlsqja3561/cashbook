<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// Controller : seesion, request
	
	// 로그인이 안되어 있을때는 접근불가 로그인 폼으로
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// seesion에 저장된 멤버(현재 로그인 사용자)
		Member loginMember = (Member)session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
	
	// Model 호출
	StatsDao statsDao = new StatsDao();
	ArrayList<HashMap<String, Object>> list = statsDao.selectSumAvgByYear(memberId);

	// 숫자 콤마 포맷
	DecimalFormat df = new DecimalFormat("###,###");
	
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
	<title>categoryList</title>
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
					
					<li class="sidebar-item active">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/cash/statsListYear.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">년도별 수입/지출 통계</span>
						</a>
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/cash/statsListMonth.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">월별 수입/지출 통계</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/help/helpList.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">고객센터</span>
						</a>
					</li>

					<li class="sidebar-header">
						Admin menu
					</li>
					
					<li class="sidebar-item">
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
						Account management
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/updateMemberForm.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">비밀번호 변경</span>
						</a>
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/updateMemberNameForm.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">이름 변경</span>
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
				</ul>
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
				<div class="container-fluid p-5">
					<h1 class="h3 mb-3"><strong>년도별 수입/지출 합계</strong></h1>
					<div class="row">
						<div class="col-12 col-lg-10 col-xxl-7 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<div class="card-title mb-0">
										<span>통계 현황</span>
									</div>
								</div>
								<div>
									<!-- categoryList contents ... -->
									<table class="table table-hover my-0 ">
										<tr class="h5 text-center">
											<th>년도</th>
											<th>수입횟수</th>
											<th>수입합계</th>
											<th>수입평균</th>
											<th>지출횟수</th>
											<th>지출합계</th>
											<th>지출평균</th>
										</tr>
										<%
											for(HashMap<String, Object> m : list) {
										%>
												<tr class="text-center">
													<td>
														<a href="<%=request.getContextPath()%>/cash/statsListMonth.jsp?year=<%=m.get("year")%>"><%=m.get("year")%>년</a>
													</td>
													<td><%=df.format(m.get("cntImport"))%>회</td>
													<td><%=df.format(m.get("sumImport"))%>원</td>
													<td><%=df.format(m.get("avgImport"))%>원</td>
													<td><%=df.format(m.get("cntExport"))%>회</td>
													<td><%=df.format(m.get("sumExport"))%>원</td>
													<td><%=df.format(m.get("avgExport"))%>원</td>
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