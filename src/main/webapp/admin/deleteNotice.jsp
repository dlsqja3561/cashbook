<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	//로그인 안되어 있거나 level 0인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo + "noticeNo");
	
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	
	// 2. Model 호출
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.deleteNotice(notice);
	System.out.println("공지삭제 성공");
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
	
%>