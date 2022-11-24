<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//1. Controller
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// 로그인이 되어 있을때는 접근불가
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

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
		String msg = URLEncoder.encode("정보를 입력해 주세요.", "utf-8"); // 입력X msg insertMemberForm
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}
	// 회원가입 값
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberName(memberName);
	
	
	// 2. Model 호출
	MemberDao memberDao = new MemberDao();

	// Id 중복 확인
	if(memberDao.memberIdCk(memberId)) {
		System.out.println("중복ID----");
		String msg = URLEncoder.encode("중복된 아이디입니다.", "utf-8"); // 중복아이디 msg insertMemberForm
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}
	// 회원가입
	int row = memberDao.insertMember(member);
	// 회원가입 성공 msg loginForm
	System.out.println(row + "<-- insertMemberAction.jsp row 성공---- ");
	String msg = URLEncoder.encode("회원가입 성공.", "utf-8");
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);


%>

