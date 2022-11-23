<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String msg = null;

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
				// 정보입력 없으면, id 중복시 msg1 출력
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