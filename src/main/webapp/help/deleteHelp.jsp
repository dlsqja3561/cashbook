<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//로그인이 안되어 있을때는 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	System.out.println(helpNo + "helpNo");

	// Model 호출
	HelpDao helpDao = new HelpDao();
	int row = helpDao.deleteHelp(helpNo);
	if(row == 1) {
		System.out.println("문의 삭제성공");
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
	}
%>