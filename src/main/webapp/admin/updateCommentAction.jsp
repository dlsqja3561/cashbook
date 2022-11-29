<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	//로그인 안되어 있거나 level 0인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	System.out.println("commentNo"+commentNo);
	
	if(request.getParameter("commentMemo") == null
		|| request.getParameter("commentMemo").equals("")) {
		String msg = URLEncoder.encode("수정내용을 입력하세요.", "utf-8"); // msg updateCommentForm
		response.sendRedirect(request.getContextPath()+"/admin/updateLevelForm.jsp?msg="+msg+"&commentNo="+commentNo);
		return;
	}

	String commentMemo = request.getParameter("commentMemo");
	System.out.println("commentMemo"+commentMemo);
	
	Comment comment = new Comment();
	comment.setCommentNo(commentNo);
	comment.setCommentMemo(commentMemo);
	
	// Model 호출
	CommentDao commentDao = new CommentDao();
	int row = commentDao.updateComment(comment);
	if(row == 1) {
		System.out.println("답변 수정성공");
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
	}
%>