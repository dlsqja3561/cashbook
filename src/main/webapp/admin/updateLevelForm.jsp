<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*"%>
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
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	Member member = memberDao.selectMemberOne(memberNo);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>멤버레벨 수정</h1>
	<form action="<%=request.getContextPath()%>/admin/updateLevelAction.jsp" method="post">
		<table border="1">
		<%
			// msg 출력 
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
			<tr>
				<th>번호</th>
				<th>레벨</th>
			</tr>
			<tr>
				<td><input type="text" name="memberNo" value="<%=member.getMemberNo()%>" readonly="readonly"></td>
				<td><input type="text" name="memberLevel" value="<%=member.getMemberLevel()%>"></td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>