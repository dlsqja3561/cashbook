<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// 입력값 없으면 loginForm 으로
	if(request.getParameter("memberId")==null 
		|| request.getParameter("memberPw")==null 
		|| request.getParameter("memberId").equals("") 
		|| request.getParameter("memberPw").equals("")){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// C
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	System.out.println(memberId);
	System.out.println(memberPw);
	
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	// 분리된 M(모델)을 호출
	MemberDao memberDao = new MemberDao();
	Member resultMember = memberDao.login(paramMember);
	
	String redirectUrl = "/loginForm.jsp";
	if(resultMember != null) {
		System.out.println("로그인");
		session.setAttribute("loginMember", resultMember); // session안에 로그인 아이디 & 이름을 저장
		redirectUrl = "/cash/cashList.jsp";
	}
	
	
	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);

	



	

%>

























