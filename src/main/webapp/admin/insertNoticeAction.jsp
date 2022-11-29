<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>

<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");

	//Controller
	// 로그인 안되어 있거나 level 0인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// 입력값 없으면 msg출력 return
	if(request.getParameter("noticeMemo") == null 
		|| request.getParameter("noticeMemo").equals("")) {
		String msg = URLEncoder.encode("정보를 입력해 주세요.", "utf-8"); // 입력X msg insertNoticeForm
		response.sendRedirect(request.getContextPath()+"/admin/insertNoticeForm.jsp?msg="+msg);
		return;
	}
	
	String noticeMemo = request.getParameter("noticeMemo");
	System.out.println(noticeMemo);
	
	Notice notice = new Notice();
	notice.setNoticeMemo(noticeMemo);

	// 2. Model 호출
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.insertNotice(notice);
	System.out.println("공지 입력 성공");
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
%>