<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>

<%	
	// 한글 처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// 비로그인시 loginForm으로
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = request.getParameter("msg");

	//seesion에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	System.out.println(year);
	System.out.println(month);
	System.out.println(date);

	// Model 호출 : 일별 cash 목록
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
	
	
	// View
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- cash 입력 폼 -->
	<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
		<input type="hidden" name="year" value="<%=year%>">
		<input type="hidden" name="month" value="<%=month%>">
		<input type="hidden" name="date" value="<%=date%>">
		<table border="1">
			<%
				// 정보입력 없으면, id 중복시 msg1 출력
				if(msg != null){
			%>
					 <%=msg%>
			<%
				}
			%>
			<tr>
				<td>categoryNo</td>
				<td>
					<select name = "categoryNo">
						<%
							// category 목록 출력
							for(Category c : categoryList) {
						%>
								<option value="<%=c.getCategoryNo()%>">
									<%=c.getCategoryKind()%> / <%=c.getCategoryName()%>
								</option>
						<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>cashDate</td>
				<td>
					<input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>cashPrice</td>
				<td>
					<input type="text" name="cashPrice">
				</td>
			</tr>
			<tr>
				<td>cashMemo</td>
				<td>
					<textarea rows="3" cols="50" name="cashMemo"></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">입력</button>
	</form>
	
	<!-- cash 목록 출력 -->
	<table border="1">
		<tr>
			<th>categoryKind</th>
			<th>categoryName</th>
			<th>cashPrice</th>
			<th>cashMemo</th>
			<th>수정</th> <!-- /cash/updateCashForm.jsp?cashNo= -->
			<th>삭제</th>	<!-- /cash/deleteCash.jsp?cashNo= -->
		</tr>
		<%
			for(HashMap<String, Object> m : list) {
		%>
				<tr>
					<td><%=m.get("categoryKind")%></td>
					<td><%=m.get("categoryName")%></td>
					<td><%=m.get("cashPrice")%></td>
					<td><%=m.get("cashMemo")%></td>
					<td><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=m.get("cashNo")%>&year=<%=year%>&month=<%=month%>&date=<%=date%>&categoryKind=<%=m.get("categoryKind")%>&categoryName=<%=m.get("categoryName")%>&cashPrice=<%=m.get("cashPrice")%>&cashMemo=<%=m.get("cashMemo")%>">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/cash/deleteCash.jsp?cashNo=<%=m.get("cashNo")%>&year=<%=year%>&month=<%=month%>&date=<%=date%>">삭제</a></td>
				</tr>
		<%
			}
		%>
	</table>
</body>
</html>