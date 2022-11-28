<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import="java.net.*"%>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");

	//로그인 안되어 있거나 level 0인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String categoryName = request.getParameter("categoryName");
	System.out.println("categoryNo"+categoryNo);
	System.out.println("categoryName"+categoryName);
	
	// 입력값 없으면 updateCategoryForm 으로
	if(categoryName == null 
		|| categoryName.equals("")){
		String msg = URLEncoder.encode("정보를 입력해 주세요.", "utf-8"); // 입력X msg updateCategoryForm
		response.sendRedirect(request.getContextPath()+"/admin/updateCategoryForm.jsp?msg="+msg+"&categoryNo="+categoryNo);
		return;
	}

	
	Category category = new Category();
	category.setCategoryNo(categoryNo);
	category.setCategoryName(categoryName);
	
	// 2. Model호출
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.updateCategoryName(category);
	System.out.println("변경성공");
	response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");

%>