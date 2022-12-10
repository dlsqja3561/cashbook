<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// 입력값 없으면 loginForm 으로
	if(request.getParameter("memberId")==null 
		|| request.getParameter("memberPw")==null 
		|| request.getParameter("memberId").equals("") 
		|| request.getParameter("memberPw").equals("")){
		String msg1 = URLEncoder.encode("정보를 입력해 주세요.", "utf-8"); // 입력X msg1 loginForm
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg1="+msg1);
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

























