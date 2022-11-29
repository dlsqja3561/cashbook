<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");

	//로그인이 안되어 있을때는 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// 입력값 없으면 msg출력 return
	if(request.getParameter("helpMemo") == null 
		|| request.getParameter("helpMemo").equals("")) {
		String msg = URLEncoder.encode("문의사항을 입력해 주세요.", "utf-8"); // 입력X msg insertHelpForm
		response.sendRedirect(request.getContextPath()+"/help/insertHelpForm.jsp?msg="+msg);
		return;
	}
	// 세션 로그인중인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	String memberId = loginMember.getMemberId();
	String helpMemo = request.getParameter("helpMemo");
	System.out.println("memberId" + memberId);
	System.out.println("helpMemo" + helpMemo);
	
	Help help = new Help();
	help.setHelpMemo(helpMemo);
	help.setMemberId(memberId);
	
	// 2. Model 호출
	HelpDao helpDao = new HelpDao();
	int row = helpDao.insertHelp(help);
	if(row == 1) {
		System.out.println("문의입력 성공");
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
	}

%>


