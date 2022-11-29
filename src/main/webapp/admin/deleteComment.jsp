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

	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	System.out.println(commentNo + "commentNo");

	// 2. Model 호출
	CommentDao commentDao = new CommentDao();
	
	int row = commentDao.deleteComment(commentNo);
	if(row == 1) {
		System.out.println("답변 삭제성공");
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
	}
	
%>