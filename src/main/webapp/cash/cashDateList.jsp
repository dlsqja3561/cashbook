<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>

<%	
	// 한글 처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// 비로그인시 loginForm으로
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = request.getParameter("msg");

	//seesion에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	System.out.println(year);
	System.out.println(month);
	System.out.println(date);

	// Model 호출 : 일별 cash 목록
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
	
	
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
	<title>cashDateList</title>
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
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/adminMain.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">Admin page</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">Manage announcements</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/categoryList.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">Manage category</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/memberList.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">Manage member</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/helpListAll.jsp">
							<i class="align-middle" data-feather="#"></i> <span class="align-middle">Manage customer service</span>
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
					<h1 class="h3 mb-3"><strong>수입/지출 내역입력</strong></h1>
					<div class="row">
						<div class="col-12 col-lg-10 col-xxl-5 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<h5 class="card-title mb-0">Calendar</h5>
								</div>
								<!-- cash 입력 폼 -->
								<div class="text-center">
								<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
									<input type="hidden" name="year" value="<%=year%>">
									<input type="hidden" name="month" value="<%=month%>">
									<input type="hidden" name="date" value="<%=date%>">
									<table class="table table-hover my-0">
										<%
											// 입력 없으면 msg 출력
											if(msg != null){
										%>
												 <%=msg%>
										<%
											}
										%>
										<tr>
											<td>categoryNo</td>
											<td>
												<select name = "categoryNo" class="form-select form-select-lg">
													<%
														// category 목록 출력
														for(Category c : categoryList) {
													%>
															<option value="<%=c.getCategoryNo()%>">
																<%=c.getCategoryKind()%> / <%=c.getCategoryName()%>
															</option>
													<%
														}
													%>
												</select>
											</td>
										</tr>
										<tr>
											<td>cashDate</td>
											<td>
												<input type="text" name="cashDate" class="form-control form-control-lg" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
											</td>
										</tr>
										<tr>
											<td>cashPrice</td>
											<td>
												<input type="text" name="cashPrice" class="form-control form-control-lg">
											</td>
										</tr>
										<tr>
											<td>cashMemo</td>
											<td>
												<textarea rows="3" cols="50" name="cashMemo" class="form-control form-control-lg"></textarea>
											</td>
										</tr>
									</table>
									<button type="submit" class="btn btn-primary">입력</button>
								</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
			
			<main class="content">
				<div class="container-fluid p-5">
					<h1 class="h3 mb-3"><strong>수입/지출 내역확인</strong></h1>
					<div class="row">
						<div class="col-12 col-lg-10 col-xxl-10 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<h5 class="card-title mb-0"><%=year%>-<%=month%>-<%=date%></h5>
								</div>
								<!-- cash 목록 출력 -->
								<table class="table table-hover my-0">
									<tr>
										<th>categoryKind</th>
										<th>categoryName</th>
										<th>cashPrice</th>
										<th>cashMemo</th>
										<th>수정</th> <!-- /cash/updateCashForm.jsp?cashNo= -->
										<th>삭제</th>	<!-- /cash/deleteCash.jsp?cashNo= -->
									</tr>
									<%
										for(HashMap<String, Object> m : list) {
									%>
											<tr>
												<td><%=m.get("categoryKind")%></td>
												<td><%=m.get("categoryName")%></td>
												<td><%=m.get("cashPrice")%>원</td>
												<td><%=m.get("cashMemo")%></td>
												<td><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=m.get("cashNo")%>&year=<%=year%>&month=<%=month%>&date=<%=date%>&categoryKind=<%=m.get("categoryKind")%>&categoryName=<%=m.get("categoryName")%>&cashPrice=<%=m.get("cashPrice")%>&cashMemo=<%=m.get("cashMemo")%>" class="btn btn-outline-info">수정</a></td>
												<td><a href="<%=request.getContextPath()%>/cash/deleteCash.jsp?cashNo=<%=m.get("cashNo")%>&year=<%=year%>&month=<%=month%>&date=<%=date%>" class="btn btn-outline-danger">삭제</a></td>
											</tr>
									<%
										}
									%>
								</table>
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