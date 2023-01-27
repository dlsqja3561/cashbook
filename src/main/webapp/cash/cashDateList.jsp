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
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link rel="shortcut icon" href="../resorces/img/icons/icon1-48x48.png" />
	<link rel="canonical" href="https://demo-basic.adminkit.io/" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<title>cashDateList</title>
	<link href="../resorces/css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
	<script src='https://kit.fontawesome.com/a076d05399.js'></script>
</head>

<body>
	<div class="wrapper">
		<!-- sidebar include -->
		<jsp:include page="/inc/sidebar.jsp"></jsp:include>

		<div class="main">
			<!-- navbar -->
			<span>
				<jsp:include page="/inc/memberMenu.jsp"></jsp:include>
			</span>

			<main class="content">
				<div class="container-fluid p-5">
					<h1 class="h3 mb-3"><strong>수입/지출 내역입력</strong></h1>
					<div class="row">
						<div class="col-8 col-lg-8 col-xxl-6 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<h5 class="card-title mb-0">Insert Category</h5>
								</div>
								<!-- cash 입력 폼 -->
								<div class="text-center">
								<form id="form" action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
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
												<select name="categoryNo" class="form-select form-select-lg">
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
												<input type="text" id="cashPrice" name="cashPrice" class="form-control form-control-lg">
											</td>
										</tr>
										<tr>
											<td>cashMemo</td>
											<td>
												<textarea rows="3" cols="50" id="cashMemo" name="cashMemo" class="form-control form-control-lg"></textarea>
											</td>
										</tr>
									</table>
									<button type="submit" class="btn btn-primary">입력하기</button>
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
						<div class="col-8 col-lg-8 col-xxl-10 d-flex">
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
			
			<!-- footer include -->
			<jsp:include page="/inc/footer.jsp"></jsp:include>
			
		</div>
	</div>
</body>
</html>