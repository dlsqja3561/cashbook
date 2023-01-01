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
	
	// 페이징 구하기
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1) * rowPerPage;
	
	
	// Model : notice list
	NoticeDao noticeDao = new NoticeDao();
	
	// 공지 lastPage
	int noticeCount = noticeDao.selectNoticeCount();
	int noticeLastPage = noticeCount / rowPerPage;
	if(noticeCount % rowPerPage != 0) {
		noticeLastPage += 1;
	}
	
	// 공지목록
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	

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
	<title>noticeList</title>
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
					<h1 class="h3 mb-3"><strong>공지사항</strong></h1>
					<div class="row">
						<div class="col-12 col-lg-10 col-xxl-7 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<div class="card-title mb-0">
										<a href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp" class="btn btn-primary">공지추가</a>
									</div>
								</div>
								<!-- 공지목록 , 페이징 -->
								<div>
									<table class="table table-hover my-0">
										<tr class="h5">
											<th>공지내용</th>
											<th>공지날짜</th>
											<th>수정</th>
											<th>삭제</th>
										</tr>
										<%
											for(Notice n : noticeList) {
										%>
												<tr>
													<td><%=n.getNoticeMemo()%></td>
													<td><%=n.getCreatedate()%></td>
													<td><a href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>" class="btn btn-outline-info">수정</a></td>
													<td><a href="<%=request.getContextPath()%>/admin/deleteNotice.jsp?noticeNo=<%=n.getNoticeNo()%>" class="btn btn-outline-danger">삭제</a></td>
												</tr>
										<%
											}
										%>
									</table>
								</div>
								<!-- 공지 페이징 -->
								<div class="text-center">
									<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1"><i class='fas fa-angle-double-left'></i>&nbsp;</a>
								<%
									if(currentPage > 1) {
								%>
										<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>"><i class='fas fa-angle-left'></i></a>
								<%	// 1페이지일때 이전버튼 클릭시 
									} else {
								%>
										<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1"><i class='fas fa-angle-left'></i></a>
								<%
									}
								%>
									<span>&nbsp;<%=currentPage%> / <%=noticeLastPage%>&nbsp;</span>
								<%
									if(currentPage < noticeLastPage) {
								%>
										<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>"><i class='fas fa-angle-right'></i></a>
								<%	// 마지막페이지 일때 다음버튼 클릭시
									} else {
								%>
										<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=noticeLastPage%>"><i class='fas fa-angle-right'></i></a>
								<%
									}
								%>
									<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=noticeLastPage%>">&nbsp;<i class='fas fa-angle-double-right'></i></a>
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