<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	// seesion에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<div>
	<!-- 로그인 정보(세션 loginMember 변수) 출력 -->
	<span><%=loginMember.getMemberId()%>(<%=loginMember.getMemberName()%>)</span>님 반갑습니다.
	<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
	<a href="<%=request.getContextPath()%>/updateMemberForm.jsp">비밀번호변경</a>
	<a href="<%=request.getContextPath()%>/deleteMemberForm.jsp">회원탈퇴</a>
	<%
		if(loginMember.getMemberLevel() > 0) {
	%>
			<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자 페이지</a>
	<%
		}
	%>
</div>