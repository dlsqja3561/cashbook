<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
		<div>
			아이디 :
			<input type="text" name="memberId">
		</div>
		<div>
			비밀번호 :
			<input type="password" name="memberPw">
		</div>
		<button type="submit">로그인</button>
	</form>
</body>
</html>