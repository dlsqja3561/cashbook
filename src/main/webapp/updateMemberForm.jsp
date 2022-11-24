<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//로그인이 되어 있지 않을때 접근불가
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
	<form action="<%=request.getContextPath()%>/updateMemberAction.jsp">
		<div>
			<h1>비밀번호 변경</h1>
			<table>
			<%
				// 정보입력 없으면, 현재pw, 변경pw 다를시 msg 출력
				if(msg != null){
			%>
					 <%=msg%>
			<%
				}
			%>
				<tr>
					<th>현재 비밀번호</th>
					<td><input type="password" name ="memberPw"></td>
				</tr>
				<tr>
					<th>변경할 비밀번호</th>
					<td><input type="password" name ="newPw"></td>
				</tr>
				<tr>
					<th>변경할 비밀번호 확인</th>
					<td><input type="password" name ="newPwCk"></td>
				</tr>
			</table>
			<button type="submit" class="btn btn-outline-primary">변경하기</button>
		</div>
	</form>
</body>
</html>