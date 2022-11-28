<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//로그인 안되어 있거나 level 0인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));

	// 2. Model 호출
	MemberDao memberDao = new MemberDao();
	memberDao.deleteMemberByAdmin(memberNo);
	System.out.println("멤버 강퇴 성공");
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
%>