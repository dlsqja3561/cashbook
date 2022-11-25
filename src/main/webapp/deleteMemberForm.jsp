<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	//로그인 안되어 있을때는 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = request.getParameter("msg");
	
	// seesion에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/deleteMemberAction.jsp" method="post">
		<h1>회원탈퇴</h1>
		<table border="1">
			<tr>
				<td><%=loginMember.getMemberId()%>(<%=loginMember.getMemberName()%>)님 탈퇴 하시겠습니까?</td>
			</tr>
			<%
				// 비밀번호 입력 오류 msg
				if(msg != null) {
			%>
					<%=msg%>
			<%
				}
			%>
			<tr>
				<td><input type="password" name="memberPw" placeholder="비밀번호를 입력해 주세요."></td>
			</tr>
		</table>
		<button type="submit">탈퇴하기</button>
	</form>
</body>
</html>