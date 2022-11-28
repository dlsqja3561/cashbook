<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));


	// 2. Model 호출
	CategoryDao categoryDao = new CategoryDao();
	
	int row = categoryDao.deleteCategory(categoryNo);
	System.out.println("category 삭제성공");
	response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
%>