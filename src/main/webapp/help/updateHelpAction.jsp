<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// 로그인이 안되어 있을때는 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	System.out.println("helpNo"+helpNo);
	
	if(request.getParameter("helpMemo") == null
		|| request.getParameter("helpMemo").equals("")) {
		String msg = URLEncoder.encode("수정내용을 입력하세요.", "utf-8"); // msg updateHelpForm
		response.sendRedirect(request.getContextPath()+"/help/updateHelpForm.jsp?msg="+msg+"&helpNo="+helpNo);
		return;
	}
	
	String helpMemo = request.getParameter("helpMemo");
	System.out.println("helpMemo"+helpMemo);
	
	Help help = new Help();
	help.setHelpNo(helpNo);
	help.setHelpMemo(helpMemo);
	
	// Model 호출
	HelpDao helpDao = new HelpDao();
	int row = helpDao.updateHelp(help);
	if(row == 1) {
		System.out.println("문의 수정성공");
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
	}
%>