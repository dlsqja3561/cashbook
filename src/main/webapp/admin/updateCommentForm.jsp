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
	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	Comment comment = new Comment();
	// Model 호출
	CommentDao commentDao = new CommentDao();
	comment = commentDao.selectCommentOne(commentNo);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>답변내용 수정</h1>
	<form action="<%=request.getContextPath()%>/admin/updateCommentAction.jsp" method="post">
		<input type="hidden" name="commentNo" value="<%=commentNo%>">
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
				<th>수정내용</th>
			</tr>
			<tr>
				<td>
					<textarea rows="4" cols="50" name="commentMemo"><%=comment.getCommentMemo()%></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>