<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");

	//Controller
	// 로그인 안되어 있거나 level 0인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// 입력값 없으면 msg출력 return
	if(request.getParameter("categoryKind") == null 
		|| request.getParameter("categoryKind").equals("")
		|| request.getParameter("categoryName") == null 
		|| request.getParameter("categoryName").equals("")) {
		String msg = URLEncoder.encode("정보를 입력해 주세요.", "utf-8"); // 입력X msg insertCategoryForm
		response.sendRedirect(request.getContextPath()+"/admin/insertCategoryForm.jsp?msg="+msg);
		return;
	}

	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	System.out.println(categoryKind);
	System.out.println(categoryName);
	
	Category category = new Category();
	category.setCategoryKind(categoryKind);
	category.setCategoryName(categoryName);
	
	// 2. Model 호출
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.insertCategory(category);
	if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
	}
	
	
%>