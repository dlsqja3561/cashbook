<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	
	// 로그인이 되어 있지 않을때 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// 입력값 없으면 updateMemberForm 으로
	if(request.getParameter("memberPw")==null 
		|| request.getParameter("newPw")==null 
		|| request.getParameter("newPwCk")==null 
		|| request.getParameter("memberPw").equals("") 
		|| request.getParameter("newPw").equals("")
		|| request.getParameter("newPwCk").equals("")){
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp");
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	String memberPw = request.getParameter("memberPw");
	String newPw = request.getParameter("newPw");
	String newPwCk = request.getParameter("newPwCk");
	System.out.println("memberPw"+memberPw);
	System.out.println("newPw"+newPw);
	System.out.println("newPwCk"+newPwCk);
	
	MemberDao memberDao = new MemberDao();
	
	// 현재 비밀번호 확인
	int checkPw = memberDao.updatePwCk(memberId, memberPw);
	if(checkPw == 1) {// 현재 비밀번호 O
		System.out.println("현재pw일치");
		if(newPw.equals(newPwCk)) { // 변경 비밀번호 O
			System.out.println("newPw일치");
		} else { // 변경 비밀번호 X
			response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp");
			return;
		}
	} else { // 현재 비밀번호 X
		System.out.println("현재pw다름");
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp");
		return;
	}
	
	// 비밀번호 변경
	int updatePw = memberDao.updatePw(memberId, newPw);
	if(updatePw == 1) { // 변경성공
		System.out.println("변경성공");
	} else { // 변경실패
		System.out.println("변경실패");
	}
	
	

	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>

