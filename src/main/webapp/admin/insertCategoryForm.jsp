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
	<form action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" method="post">
		<table>
		<%
			// 정보입력 없으면, id 중복시 msg 출력
			if(msg != null){
		%>
				 <%=msg%>
		<%
			}
		%>
			<tr>
				<th>categoryKind</th>
				<td>
					<input type="radio" name ="categoryKind" value="수입">수입
					<input type="radio" name ="categoryKind" value="지출">지출
				</td>
			</tr>
			<tr>
				<th>categoryName</th>
				<td><input type="text" name="categoryName"></td>
			</tr>
		</table>
		<button type="submit">추가</button>
	</form>
</body>
</html>