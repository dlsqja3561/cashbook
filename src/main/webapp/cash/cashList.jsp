<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
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
	String loginMemberName = loginMember.getMemberName();
	
	if(request.getParameter("memberName") != null) { // 멤버 이름 변경후 넘어온값
		loginMemberName = request.getParameter("memberName");
	}
	
	// request 년, 월
	int year = 0;
	int month = 0;
	
	if((request.getParameter("year") == null) || request.getParameter("month") == null) {
		Calendar today = Calendar.getInstance(); // 오늘날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// month -> -1, month -> 12 일경우
		if(month == -1) {
			month = 11;
			year -= 1;
		}
		if(month == 12) {
			month = 0;
			year += 1;
		}
	}
	
	// 출력하고자 하는 년,월과 월의 1일의 요일(일 1, 월 2, 화 3, ... 토 7)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	// firstDay는 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // 요일(일 1, 월 2, 화 3, ... 토 7)

	// 마지막날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);
	
	// begin blank개수는 firstDay - 1
	// 달력 출력태이블의 시작 공백셀(td)과 마지막 공백셀(td)의 개수
	int beginBlank = firstDay - 1;
	int endBlank = 0; // beginBlank + lastDate + endBlank --> 7로 나누어 떨어진다->totalTd
	if((beginBlank+lastDate) % 7 != 0) {
		endBlank = 7 - ((beginBlank+lastDate) % 7);
	}
	// 전체 td의 개수 : 7로 나누어 떨어져야 한다
	int totalTd = beginBlank + lastDate + endBlank;
	
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);


	// View : 달력출력 + 일별 cash 목록
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
	<title>cashList</title>
	<link href="../resorces/css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
	<script src='https://kit.fontawesome.com/a076d05399.js'></script>
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

					<li class="sidebar-item active">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/cash/cashList.jsp">
							<i class="align-middle far fa-calendar-alt"></i> <span class="align-middle">가계부 리스트</span>
						</a>
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/cash/statsListYear.jsp">
							<i class="align-middle far fa-chart-bar"></i> <span class="align-middle">년도별 수입/지출 통계</span>
						</a>
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/cash/statsListMonth.jsp">
							<i class="align-middle far fa-chart-bar"></i> <span class="align-middle">월별 수입/지출 통계</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/help/helpList.jsp">
							<i class="align-middle far fa-calendar-alt"></i> <span class="align-middle">고객센터</span>
						</a>
					</li>

					<li class="sidebar-header">
						Admin menu
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/adminMain.jsp">
							<i class="align-middle fas fa-cog"></i> <span class="align-middle">관리자 페이지</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp">
							<i class="align-middle fas fa-cog"></i> <span class="align-middle">공지사항 관리</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/categoryList.jsp">
							<i class="align-middle fas fa-cog"></i> <span class="align-middle">카테고리 관리</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/memberList.jsp">
							<i class="align-middle fas fa-cog"></i> <span class="align-middle">멤버 관리</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/helpListAll.jsp">
							<i class="align-middle fas fa-cog"></i> <span class="align-middle">문의사항 관리</span>
						</a>
					</li>
					
					<li class="sidebar-header">
						Account management
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/updateMemberForm.jsp">
							<i class="align-middle fas fa-bullseye"></i> <span class="align-middle">비밀번호 변경</span>
						</a>
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/updateMemberNameForm.jsp">
							<i class="align-middle fas fa-bullseye"></i> <span class="align-middle">이름 변경</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/deleteMemberForm.jsp">
							<i class="align-middle fas fa-bullseye"></i> <span class="align-middle">회원탈퇴</span>
						</a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/logout.jsp">
							<i class="align-middle fas fa-bullseye"></i> <span class="align-middle">로그아웃</span>
						</a>
					</li>
				</ul>
			</div>
		</nav>

		<div class="main">
			<!-- navbar include -->
			<jsp:include page="/inc/memberMenu.jsp"></jsp:include>
			
			<main class="content">
				<div class="container-fluid p-0">

					<h1 class="h2 mb-3"><strong>MyCashBook</strong></h1>

					
					<h1 class="text-center h3">
						<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>"><i class='far fa-caret-square-left' style='font-size:24px'></i></a>
						
						<span><%=year%>년 <%=month+1%>월</span>
						
						<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>"><i class='far fa-caret-square-right' style='font-size:24px'></i></a>
					</h1>


					<div class="row">
						<div class="col-12 col-lg-10 col-xxl-12 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<h5 class="card-title mb-0">Calendar</h5>
								</div>
								<!-- 달력 출력 -->
								<table class="table table-hover my-0">
									<tr class="text-center table-active">
										<th class="text-danger">일</th>
										<th>월</th>
										<th>화</th>
										<th>수</th>
										<th>목</th>
										<th>금</th>
										<th class="text-primary">토</th>
									</tr>
									<tr style="height:150px">
									<%
										for(int i=1; i<=totalTd; i++) {
									%>
											<td style="width:150px">
									<%
												int date = i-beginBlank;
												// 토요일, 일요일 색 변경하기
												Calendar colDate = Calendar.getInstance();
												colDate.set(Calendar.YEAR, year);
												colDate.set(Calendar.MONTH, month);
												colDate.set(Calendar.DATE, date);
												int coldate = colDate.get(Calendar.DAY_OF_WEEK);
												if(date > 0 && date <= lastDate) {
													if(coldate == 7) { // 토요일 파란색
									%>
														<div>
															<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
																<span class="text-primary"><%=date%></span>
															</a>
														</div>
									<%
													} else if(coldate == 1) { // 일요일 빨간색
									%>
														<div>
															<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
																<span class="text-danger"><%=date%></span>
															</a>
														</div>
									<%
													} else { // 평일 검은색
									%>
														<div>
															<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
																<span class="text-dark"><%=date%></span>
															</a>
														</div>
									<%
													}
									%>
														
													<div>
									<%
														for(HashMap<String, Object> m : list) {
															String cashDate = (String)(m.get("cashDate"));
															if(Integer.parseInt(cashDate.substring(8)) == date) {
									%>
																<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
									<%
																	if(((String)(m.get("categoryKind"))).equals("수입")) {
									%>
																		<span class="text-primary">[<%=(String)(m.get("categoryKind"))%>]</span>
									<%
																	} else {
									%>
																		<span class="text-success">[<%=(String)(m.get("categoryKind"))%>]</span>
									<%
																	}
									%>
																	<span class="text-dark"><%=(String)(m.get("categoryName"))%></span>
																	<span class="text-dark"><%=(Long)(m.get("cashPrice"))%>원</span>
																	<br>
																</a>
																
									<%
											
															}
														}
									%>
													</div>
									<%
												}
									%>
											</td>
									<%		
												if(i%7 == 0 && i != totalTd) {
									%>
													</tr><tr style="height:150px"> <!-- td 7개 만들고 테이블 줄바꿈 -->
									<%
												}
										}
									%>
									</tr>
								</table>
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