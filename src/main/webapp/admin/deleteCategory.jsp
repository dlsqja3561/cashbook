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

	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));


	// 2. Model 호출
	CategoryDao categoryDao = new CategoryDao();
	
	categoryDao.deleteCategory(categoryNo);
	System.out.println("category 삭제성공");
	response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
%>