<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>

<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// 로그인이 안되어 있을때는 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = request.getParameter("msg");

	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	Help help = new Help();
	// Model 호출
	HelpDao helpDao = new HelpDao();
	help = helpDao.selectHelpOne(helpNo);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>문의내용 수정</h1>
	<form action="<%=request.getContextPath()%>/help/updateHelpAction.jsp" method="post">
		<input type="hidden" name="helpNo" value="<%=helpNo%>">
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
					<textarea rows="4" cols="50" name="helpMemo"><%=help.getHelpMemo()%></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>