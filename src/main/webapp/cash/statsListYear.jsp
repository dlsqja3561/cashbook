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
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link rel="shortcut icon" href="../resorces/img/icons/icon1-48x48.png" />
	<link rel="canonical" href="https://demo-basic.adminkit.io/" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<title>statsListYear</title>
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
									<!-- 년도별 수입/지출 리스트 -->
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
				
			<!-- footer include -->
			<jsp:include page="/inc/footer.jsp"></jsp:include>
			
		</div>
	</div>

</body>
</html>