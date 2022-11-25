<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// 로그인 안되어 있을때는 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	//seesion에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String memberPw = request.getParameter("memberPw");
	System.out.println("memberId" + memberId);
	System.out.println("memberPw" + memberPw);
	
	// 입력값 없으면 msg출력 return
	String msg = null;
	if(memberPw == null || memberPw.equals("")) {
		msg = URLEncoder.encode("비밀번호를 입력해 주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp?msg="+msg);
		return;
	}
	
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	
	// 2. Model 호출
	MemberDao memberDao = new MemberDao();
	
	// 현재비밀번호 일치확인
	int row = 0;
	row = memberDao.pwCk(memberId, memberPw);
	if(row != 1) {
		System.out.println("비밀번호 다름");
		msg = URLEncoder.encode("비밀번호가 틀렸습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp?msg="+msg);
		return;
	}
	
	// 회원탈퇴
	row = memberDao.deleteMember(member);
	System.out.println("회원탈퇴 완료");
	session.invalidate(); // 세션 초기화
	msg = URLEncoder.encode("회원탈퇴 완료", "utf-8");
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
	
	
%>
 