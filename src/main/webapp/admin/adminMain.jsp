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
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<!-- adminMain contents ... -->
	<!-- 최근공지 목록 -->
	<div>
		<h1>최근공지</h1>
		<table border="1">
			<tr>
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
	<!-- 최근멤버 목록 -->
	<div>
		<h1>최근멤버</h1>
		<table border="1">
			<tr>
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
	<!-- 최근문의 목록 -->
	<div>
		<h1>최근문의</h1>
		<table border="1">
			<tr>
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
</body>
</html>