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
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	
	// 멤버 lastPage
	int memberCount = memberDao.selectMemberCount();
	int memberLastPage = memberCount / rowPerPage;
	if(memberCount % rowPerPage != 0) {
		memberLastPage += 1;
	}
	
	// 멤버목록
	ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	
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
	<title>memberList</title>
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
					<h1 class="h3 mb-3"><strong>멤버관리</strong></h1>
					<div class="row">
						<div class="col-12 col-lg-10 col-xxl-7 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<h5 class="card-title mb-0">Member List</h5>
								</div>
								<div>
								<!-- memberList contents ... -->
									<table class="table table-hover my-0">
										<tr class="h5">
											<th>멤버번호</th>
											<th>아이디</th>
											<th>레벨</th>
											<th>이름</th>
											<th>마지막수정일자</th>
											<th>생성일자</th>
											<th>레벨수정</th>
											<th>강제탈퇴</th>
										</tr>
										<%
											for(Member m : list) {
										%>
												<tr>
													<td><%=m.getMemberNo()%></td>
													<td><%=m.getMemberId()%></td>
													<td><%=m.getMemberLevel()%></td>
													<td><%=m.getMemberName()%></td>
													<td><%=m.getUpdatedate()%></td>
													<td><%=m.getCreatedate()%></td>
													<td><a href="<%=request.getContextPath()%>/admin/updateLevelForm.jsp?memberNo=<%=m.getMemberNo()%>" class="btn btn-outline-info">레벨수정</a></td>
													<td><a href="<%=request.getContextPath()%>/admin/deleteMember.jsp?memberNo=<%=m.getMemberNo()%>" class="btn btn-outline-danger">강제탈퇴</a></td>
												</tr>
										<%
											}
										%>
									</table>
								</div>
								
								<!-- 공지 페이징 -->
								<div class="text-center">
									<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1"><i class='fas fa-angle-double-left'></i>&nbsp;</a>
								<%
									if(currentPage > 1) {
								%>
										<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>"><i class='fas fa-angle-left'></i></a>
								<%	// 1페이지일때 이전버튼 클릭시 
									} else {
								%>
										<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1"><i class='fas fa-angle-left'></i></a>
								<%
									}
								%>
									<span>&nbsp;<%=currentPage%> / <%=memberLastPage%>&nbsp;</span>
								<%
									if(currentPage < memberLastPage) {
								%>
										<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>"><i class='fas fa-angle-right'></i></a>
								<%	// 마지막페이지 일때 다음버튼 클릭시
									} else {
								%>
										<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=memberLastPage%>"><i class='fas fa-angle-right'></i></a>
								<%
									}
								%>
									<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=memberLastPage%>">&nbsp;<i class='fas fa-angle-double-right'></i></a>
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