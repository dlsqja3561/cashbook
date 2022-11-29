<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	//로그인 안되어 있거나 level 0인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	System.out.println("helpNo" + helpNo);
	
	// 입력값 없으면 msg출력 return
	if(request.getParameter("commentMemo") == null 
		|| request.getParameter("commentMemo").equals("")) {
		String msg = URLEncoder.encode("답변내용을 입력해 주세요.", "utf-8"); // 입력X msg insertCommentForm
		response.sendRedirect(request.getContextPath()+"/admin/insertCommentForm.jsp?msg="+msg+"&helpNo="+helpNo);
		return;
	}
	String memberId = loginMember.getMemberId();
	String commentMemo = request.getParameter("commentMemo");
	System.out.println("memberId" + memberId);
	System.out.println("commentMemo" + commentMemo);
	System.out.println("helpNo" + helpNo);
	
	Comment comment = new Comment();
	comment.setCommentMemo(commentMemo);
	comment.setMemberId(memberId);
	comment.setHelpNo(helpNo);
	
	// Model 호출
	CommentDao commentDao = new CommentDao();
	int row = commentDao.insertComment(comment);
	if(row == 1) {
		System.out.println("답변입력 성공");
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
	}
%>