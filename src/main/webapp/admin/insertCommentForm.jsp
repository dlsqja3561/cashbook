<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*"%>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	//로그인 안되어 있거나 level 0인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = request.getParameter("msg");
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	Help help = new Help();
	
	CommentDao commentDao = new CommentDao();
	help = commentDao.selectHelpOne(helpNo);
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<table border="1">
			<tr>
				<th>문의내용</th>
				<th>회원ID</th>
				<th>문의날짜</th>
			</tr>
			<tr>
				<td><%=help.getHelpMemo()%></td>
				<td><%=help.getMemberId()%></td>
				<td><%=help.getCreatedate()%></td>
			</tr>
		</table>
	</div>
	<form action="<%=request.getContextPath()%>/admin/insertCommentAction.jsp" method="post">
		<input type="hidden" name="helpNo" value="<%=helpNo%>">
		<table border="1">
		<%
			// 답변입력 없으면 msg 출력
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
			<tr>
				<th>답변내용</th>
			</tr>
			<tr>
				<td><textarea rows="4" cols="50" name="commentMemo"></textarea></td>
			</tr>
		</table>
		<button type="submit">답변입력</button>
	</form>
</body>
</html>