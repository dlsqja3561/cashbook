<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	//로그인 안되어 있거나 level 0인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;
	
	HelpDao helpDao = new HelpDao();
	
	// lastPage
	int count = helpDao.selectHelpCount();
	int lastPage = count / rowPerPage;
	if(count % rowPerPage != 0) {
		lastPage += 1; 
	}

	// 문의 목록
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- include -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<!-- 고객센터 문의 목록 -->
	<table border="1">
		<tr>
			<th>문의내용</th>
			<th>회원ID</th>
			<th>문의날짜</th>
			<th>답변내용</th>
			<th>답변날짜</th>
			<th>답변추가 / 수정 / 삭제</th>
		</tr>
		<%
			for(HashMap<String, Object> m : list) {
		%>
				<tr>
					<td><%=m.get("helpMemo")%></td>
					<td><%=m.get("memberId")%></td>
					<td><%=m.get("helpCreatedate")%></td>
					<td>
						<%
							if(m.get("commentMemo") == null) {
						%>
								답변전
						<%
							} else {
						%>
								<%=m.get("commentMemo")%>
						<%
							}
						%>
					</td>
					<td>
						<%
							if(m.get("commentCreatedate") == null) {
						%>
								답변전
						<%
							} else {
						%>
								<%=m.get("commentCreatedate")%>
						<%
							}
						%>
					</td>
					<td>
						<%
							if(m.get("commentMemo") == null) {
						%>
								<a href="<%=request.getContextPath()%>/admin/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>">답변입력</a>
						<%
							} else {
						%>
								<a href="<%=request.getContextPath()%>/admin/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>">답변수정</a>
								<a href="<%=request.getContextPath()%>/admin/deleteComment.jsp?commentNo=<%=m.get("commentNo")%>">답변삭제</a>
						<%
							}
						%>
					</td>
				</tr>
		<%
			}
		%>
	</table>
	<!-- 페이징 -->
	<div>
		<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1">처음</a>
	<%
		if(currentPage > 1) {
	%>
			<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1%>"><%="<"%></a>
	<%	// 1페이지일때 이전버튼 클릭시 
		} else {
	%>
			<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1"><%="<"%></a>
	<%
		}
	%>
		<span><%=currentPage%> / <%=lastPage%></span>
	<%
		if(currentPage < lastPage) {
	%>
			<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1%>"><%=">"%></a>
	<%	// 마지막페이지 일때 다음버튼 클릭시
		} else {
	%>
			<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>"><%=">"%></a>
	<%
		}
	%>
		<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>">마지막</a>
	</div>
	
	<!-- include -->
</body>
</html>