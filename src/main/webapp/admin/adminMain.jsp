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
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link rel="shortcut icon" href="../resorces/img/icons/icon1-48x48.png" />
	<link rel="canonical" href="https://demo-basic.adminkit.io/" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<title>adminMain</title>
	<link href="../resorces/css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
	<script src='https://kit.fontawesome.com/a076d05399.js'></script>
	<style>
		table {
			text-align: center;
		}
	</style>
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
				<div class="container-fluid p-2">
					<h1 class="h3 mb-3"><strong>공지사항</strong></h1>
					<div class="row">
						<div class="col-12 col-lg-10 col-xxl-10 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<h5 class="card-title mb-0"><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">Notice List</a></h5>
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
						<div class="col-12 col-lg-10 col-xxl-10 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<h5 class="card-title mb-0"><a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">Help List</a></h5>
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
						<div class="col-10 col-lg-8 col-xxl-10 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<h5 class="card-title mb-0"><a href="<%=request.getContextPath()%>/admin/memberList.jsp">Member List</a></h5>
								</div>
								<!-- 최근멤버 목록 -->
								<div>
									<table class="table table-hover my-0" >
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
			
			<!-- footer include -->
			<jsp:include page="/inc/footer.jsp"></jsp:include>
			
		</div>
	</div>

</body>
</html>