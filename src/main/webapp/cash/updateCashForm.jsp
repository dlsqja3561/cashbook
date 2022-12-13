<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
<%
	//한글 처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// 비로그인시 loginForm으로
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = request.getParameter("msg");

	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	System.out.println(year);
	System.out.println(month);
	System.out.println(cashNo);
	System.out.println(date);
	System.out.println(cashPrice);
	System.out.println(cashMemo);

	// Model 호출 : 일별 cash 목록
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
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
	<link rel="canonical" href="https://demo-basic.adminkit.io/pages-sign-up.html" />
	<title>updateCashForm</title>
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
							<h1 class="h2">수정하기</h1>
							<%
								// 수정 입력 없으면 msg 출력
								if(msg != null){
							%>
									 <%=msg%>
							<%
								}
							%>
						</div>
						<div class="p-1 bg-primary rounded"></div>
						<div class="card">
							<div class="card-body">
								<div class="m-sm-4">
									<!-- cash 수정 폼 -->
									<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post">
										<input type="hidden" name="year" value="<%=year%>">
										<input type="hidden" name="month" value="<%=month%>">
										<input type="hidden" name="date" value="<%=date%>">
										<input type="hidden" name="cashNo" value="<%=cashNo%>">
										<div class="text-center">
											<table class="table table-hover my-0">
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
														<input type="text" name="cashPrice" class="form-control form-control-lg" value="<%=cashPrice%>">
													</td>
												</tr>
												<tr>
													<td>cashMemo</td>
													<td>
														<textarea rows="5" cols="70" name="cashMemo" class="form-control form-control-lg"><%=cashMemo%></textarea>
													</td>
												</tr>
											</table>
											<button type="submit" class="btn btn-lg btn-primary">수정완료</button>
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