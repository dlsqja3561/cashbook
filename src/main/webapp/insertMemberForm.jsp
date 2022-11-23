<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
		<div>
			아이디 :
			<input type="text" name="memberId">
		</div>
		<div>
			비밀번호 :
			<input type="password" name="memberPw">
		</div>
		<div>
			이름 :
			<input type="text" name="memberName">
		</div>
		<button type="submit">회원가입</button>
	</form>
</body>
</html>