<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//로그인 안되어 있거나 level 0인 멤버
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int memberLevel = Integer.parseInt(request.getParameter("memberLevel"));
	System.out.println("memberNo"+memberNo);
	System.out.println("memberLevel"+memberLevel);
	
	// 입력값 없으면 updateCategoryForm 으로
	if(memberLevel < 0 || memberLevel >= 2){
		String msg = URLEncoder.encode("잘못된 레벨 정보입니다.", "utf-8"); // msg updateLevelForm
		response.sendRedirect(request.getContextPath()+"/admin/updateLevelForm.jsp?msg="+msg+"&memberNo="+memberNo);
		return;
	}

	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberLevel(memberLevel);
	
	// 2. Model 호출
	MemberDao memberDao = new MemberDao();
	int row = memberDao.updateMemberLevel(member);
	if(row == 1) {
		System.out.println("레벨 변경성공");
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
	}
	
%>