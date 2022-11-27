<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 한글 처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// 로그인 안되어 있으면 loginForm으로
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	System.out.println(year+ "year");
	System.out.println(month+ "month");
	System.out.println(date+ "date");
	
	// 입력값 없으면 msg출력 return
		if(request.getParameter("cashPrice") == null || request.getParameter("cashPrice").equals("")
			|| request.getParameter("cashMemo") == null || request.getParameter("cashMemo").equals("")
			|| request.getParameter("cashDate") == null || request.getParameter("cashDate").equals("")) {
			String msg = URLEncoder.encode("정보를 입력해 주세요.", "utf-8"); // 입력X msg updateCashForm
			response.sendRedirect(request.getContextPath()+"/cash/updateCashForm.jsp?msg="+msg+"&year="+year+"&month="+month+"&date="+date);
			return;
		}

	//seesion에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	System.out.println(memberId+ "memberId");
	
	
	// updateCashForm.jsp 입력값
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashDate = request.getParameter("cashDate");
	String cashMemo = request.getParameter("cashMemo");
	System.out.println(categoryNo + "categoryNo");
	System.out.println(cashNo + "cashNo");
	System.out.println(cashPrice + "cashPrice");
	System.out.println(cashDate + "cashDate");
	System.out.println(cashMemo + "cashMemo");
	
	
	Cash cash = new Cash();
	cash.setCategoryNo(categoryNo);
	cash.setCashDate(cashDate);
	cash.setCashPrice(cashPrice);
	cash.setCashMemo(cashMemo);
	cash.setMemberId(memberId);
	cash.setCashNo(cashNo);

	
	CashDao cashDao = new CashDao();
	int row = cashDao.updateCash(cash);
	if(row == 1) {
		System.out.println("수정 성공");
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
	} else {
		System.out.println("수정 실패");
	}
	
%>