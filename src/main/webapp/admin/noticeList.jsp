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
	
	
	// 최근공지 5개, 최근멤버 5명
	

	// View
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/">고객센터관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">맴버관리(목록, 레벨수정, 강제탈퇴)</a></li>
		<li><a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></li>
	</ul>
	<!-- 공지목록 , 페이징 -->
	<div>
		<h1>공지</h1>
		<a href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp">공지추가</a>
		<table border="1">
			<tr>
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
						<td><a href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/admin/deleteNotice.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a></td>
					</tr>
			<%
				}
			%>
		
		</table>
	</div>
	
	<!-- 공지 페이징 -->
	<div>
		<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1">처음</a>
	<%
		if(currentPage > 1) {
	%>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>"><%="<"%></a>
	<%	// 1페이지일때 이전버튼 클릭시 
		} else {
	%>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1"><%="<"%></a>
	<%
		}
	%>
		<span><%=currentPage%> / <%=noticeLastPage%></span>
	<%
		if(currentPage < noticeLastPage) {
	%>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>"><%=">"%></a>
	<%	// 마지막페이지 일때 다음버튼 클릭시
		} else {
	%>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=noticeLastPage%>"><%=">"%></a>
	<%
		}
	%>
		<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=noticeLastPage%>">마지막</a>
	</div>
</body>
</html>