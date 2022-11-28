<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// Controller
	// 로그인 안되어 있거나 level 0인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = request.getParameter("msg");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp" method="post">
		<table border="1">
		<%
			// 공지입력 없으면 msg 출력
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
			<tr>
				<th>공지내용</th>
			</tr>
			<tr>
				<td><textarea rows="4" cols="50" name="noticeMemo"></textarea></td>
			</tr>
		</table>
		<button type="submit">공지입력</button>
	</form>
</body>
</html>