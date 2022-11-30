<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%
	// 로그인이 되어 있을때는 접근불가
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	//회원가입 완료, 실패, 회원탈퇴 msg 출력
	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
	}
	// 로그인 정보입력 없으면 msg1
	String msg1 = request.getParameter("msg1");

	// 페이징 구하기
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1) * rowPerPage;

	NoticeDao noticeDao = new NoticeDao();

	// lastPage
	int count = noticeDao.selectNoticeCount();
	int lastPage = count / rowPerPage;
	if(count % rowPerPage != 0) {
		lastPage+=1;
	}
	// 공지목록
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
<body>
	<!-- 공지(5개)목록 , 페이징 -->
	<div>
		<table border="1">
			<tr>
				<th>공지내용</th>
				<th>날짜</th>
			</tr>
			<%
				for(Notice n : list) {
			%>
					<tr>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
					</tr>
			<%
				}
			%>
		</table>
	</div>
	
	<!-- 페이징 -->
	<div>
		<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1">처음</a>
	<%
		if(currentPage > 1) {
	%>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>"><%="<"%></a>
	<%	// 1페이지일때 이전버튼 클릭시 
		} else {
	%>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1"><%="<"%></a>
	<%
		}
	%>
		<span><%=currentPage%> / <%=lastPage%></span>
	<%
		if(currentPage < lastPage) {
	%>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>"><%=">"%></a>
	<%	// 마지막페이지 일때 다음버튼 클릭시
		} else {
	%>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>"><%=">"%></a>
	<%
		}
	%>
		<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">마지막</a>
	</div>
	
	<!-- 로그인 폼 -->
	<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
		<table border="1">
		<%
			// 로그인 정보입력 없으면 msg1 출력
			if(msg1 != null){
		%>
				 <%=msg1%>
		<%
			}
		%>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="memberId"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
		</table>
		<button type="submit">로그인</button>
		<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
	</form>
</body>
</html>