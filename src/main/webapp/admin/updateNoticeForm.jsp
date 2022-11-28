<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");

	// 로그인 안되어 있거나 level 0인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// 입력값 없을때 msg
	String msg = request.getParameter("msg");

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	Notice notice = null;
	
	NoticeDao noticeDao = new NoticeDao();
	notice = noticeDao.selectNoticeOne(noticeNo);
	
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>공지 수정</h1>
	<form action="<%=request.getContextPath()%>/admin/updateNoticeAction.jsp" method="post">
		<table border="1">
		<%
			// 입력값 없으면 msg
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
			<tr>
				<th>번호</th>
				<th>내용</th>
			</tr>
			<tr>
				<td><input type="text" name="noticeNo" value="<%=notice.getNoticeNo()%>" readonly="readonly"></td>
				<td><textarea rows="4" cols="50" name="noticeMemo"><%=notice.getNoticeMemo()%></textarea></td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>