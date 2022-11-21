<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// C
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	// 분리된 M(모델)을 호출
	MemberDao memberDao = new MemberDao();
	Member resultMember = memberDao.login(paramMember);
	
	String redirectUrl = "/loginForm.jsp";
	
	if(resultMember != null) {
		session.setAttribute("loginMember", resultMember); // session안에 로그인 아이디 & 이름을 저장
		redirectUrl = "/cash/cashList.jsp";
	}
	
	
	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);

	



	

%>

























