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
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">맴버관리(목록, 레벨수정, 강제탈퇴)</a></li>
	</ul>
	<div>
	<!-- memberList contents ... -->
		<h1>멤버</h1>
		<table border="1">
			<tr>
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
						<td><a href="<%=request.getContextPath()%>/admin/insertLevel.jsp?memberNo=<%=m.getMemberNo()%>">레벨수정</a></td>
						<td><a href="<%=request.getContextPath()%>/admin/deleteMember.jsp?memberNo=<%=m.getMemberNo()%>">강제탈퇴</a></td>
					</tr>
			<%
				}
			%>
		</table>
	</div>
	
	<!-- 공지 페이징 -->
	<div>
		<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1">처음</a>
	<%
		if(currentPage > 1) {
	%>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>"><%="<"%></a>
	<%	// 1페이지일때 이전버튼 클릭시 
		} else {
	%>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1"><%="<"%></a>
	<%
		}
	%>
		<span><%=currentPage%> / <%=memberLastPage%></span>
	<%
		if(currentPage < memberLastPage) {
	%>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>"><%=">"%></a>
	<%	// 마지막페이지 일때 다음버튼 클릭시
		} else {
	%>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=memberLastPage%>"><%=">"%></a>
	<%
		}
	%>
		<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=memberLastPage%>">마지막</a>
	</div>
	
</body>
</html>