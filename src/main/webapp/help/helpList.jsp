<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// 로그인이 안되어 있을때는 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 세션 멤버id
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	System.out.println(memberId + "memberId");
	
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(memberId);
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
	<title>helpList</title>
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
					<h1 class="h3 mb-3"><strong>고객센터</strong> 문의하기</h1>
					<div class="row">
						<div class="col-12 col-lg-10 col-xxl-8 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<div class="card-title mb-0">
										<a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp" class="btn btn-primary">문의추가</a>
									</div>
								</div>
								<table class="table table-hover my-0">
									<tr style="height:50px">
										<th>문의내용</th>
										<th>문의날짜</th>
										<th>답변내용</th>
										<th>답변날짜</th>
										<th>수정</th>
										<th>삭제</th>
									</tr>
									<%
										for(HashMap<String, Object> m : list) {
									%>
											<tr style="height:60px">
												<td><%=m.get("helpMemo")%></td>
												<td><%=m.get("helpCreatedate")%></td>
												<td>
												<%
													if(m.get("commentMemo") == null) {
												%>
														답변이 등록되지 않았습니다.
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
														답변이 등록되지 않았습니다.
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
														<a href="<%=request.getContextPath()%>/help/updateHelpForm.jsp?helpNo=<%=m.get("helpNo")%>" class="btn btn-outline-info">수정</a>   
												<%      
													} else {
												%>
														&nbsp;
												<%   
													}
												%>   
												</td>
												<td>
												<%
													if(m.get("commentMemo") == null) {
												%>
														<a href="<%=request.getContextPath()%>/help/deleteHelp.jsp?helpNo=<%=m.get("helpNo")%>" class="btn btn-outline-danger">삭제</a>   
												<%      
													} else {
												%>
														&nbsp;
												<%   
													}
												%>
												</td>
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