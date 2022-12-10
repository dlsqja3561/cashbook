<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// 로그인이 되어 있지 않을때 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// 입력값 없으면 updateMemberForm 으로
	if(request.getParameter("newName")==null 
		|| request.getParameter("newName").equals("")){
		String msg = URLEncoder.encode("정보를 입력해 주세요.", "utf-8"); // 입력X msg updateMemberNameForm
		response.sendRedirect(request.getContextPath()+"/updateMemberNameForm.jsp?msg="+msg);
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	System.out.println("memberId"+memberId);

	String memberName = request.getParameter("newName");
	System.out.println("memberName"+memberName);
	
	// 2. Model 호출
	MemberDao memberDao = new MemberDao();
	

	// 이름 변경
	int row = memberDao.updateName(memberId, memberName);
	if(row == 1) { // 변경성공
		System.out.println("변경성공");
		String utfName = URLEncoder.encode(memberName, "utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?memberName="+utfName);
	} else { // 변경실패
		System.out.println("변경실패");
	}
	

%>

