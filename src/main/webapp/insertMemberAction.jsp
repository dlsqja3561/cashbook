<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// 로그인이 되어 있을때는 접근불가
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	// 1.
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	System.out.println(memberId+"memberId");
	System.out.println(memberPw+"memberPw");
	System.out.println(memberName+"memberName");
	
	// 입력값 없으면 msg출력 return
	if(memberId == null || memberId.equals("")
		|| memberPw == null || memberPw.equals("")
		|| memberName == null || memberName.equals("")) {
		String msg = URLEncoder.encode("정보를 입력해 주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}
	
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	paramMember.setMemberName(memberName);
	
	
	// 분리된 M(모델)을 호출
	MemberDao memberDao = new MemberDao();
	int resultUpdate = memberDao.insertMember(paramMember);
	if(resultUpdate == 1) {
		System.out.println("성공----");
	} else {
		System.out.println("실패----");
	}


	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");

%>

