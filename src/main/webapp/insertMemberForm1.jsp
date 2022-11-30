<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그인이 되어 있을때는 접근불가
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	//정보입력 없으면, id 중복시 msg 값 받기
	String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
		<table border="1">
		<%
			// 정보입력 없으면, id 중복시 msg 출력
			if(msg != null){
		%>
				 <%=msg%>
		<%
			}
		%>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="memberId"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="memberName"></td>
			</tr>
		</table>
		<button type="submit">회원가입</button>
	</form>
</body>
</html>