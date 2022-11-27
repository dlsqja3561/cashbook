<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
<%
//한글 처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// 비로그인시 loginForm으로
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = request.getParameter("msg");

	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	System.out.println(year);
	System.out.println(month);
	System.out.println(cashNo);
	System.out.println(date);
	System.out.println(cashPrice);
	System.out.println(cashMemo);

	// Model 호출 : 일별 cash 목록
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	

	
	
	// View
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- cash 수정 폼 -->
	<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post">
		<input type="hidden" name="year" value="<%=year%>">
		<input type="hidden" name="month" value="<%=month%>">
		<input type="hidden" name="date" value="<%=date%>">
		<input type="hidden" name="cashNo" value="<%=cashNo%>">
		<h1>수정하기</h1>
		<table border="1">
			<%
				// 수정 입력 없으면 msg 출력
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
					<input type="text" name="cashPrice" value="<%=cashPrice%>">
				</td>
			</tr>
			<tr>
				<td>cashMemo</td>
				<td>
					<textarea rows="3" cols="50" name="cashMemo"><%=cashMemo%></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>