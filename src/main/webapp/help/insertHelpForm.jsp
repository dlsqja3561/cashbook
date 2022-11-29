<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// 로그인이 안되어 있을때는 접근불가
	if(session.getAttribute("loginMember") == null) {
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
	<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
		<table border="1">
		<%
			// 문의입력 없으면 msg 출력
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
			<tr>
				<th>문의내용</th>
			</tr>
			<tr>
				<td><textarea rows="4" cols="50" name="helpMemo"></textarea></td>
			</tr>
		</table>
		<button type="submit">문의입력</button>
	</form>
</body>
</html>