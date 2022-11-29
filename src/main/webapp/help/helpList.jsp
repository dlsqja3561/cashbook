<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// 로그인이 안되어 있을때는 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 세션 멤버id
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	System.out.println(memberId + "memberId");
	
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(memberId);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <h1>고객센터</h1>
   <div>
      <a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp">문의추가</a>
   </div>
   <table border="1">
      <tr>
         <th>문의내용</th>
         <th>문의날짜</th>
         <th>답변내용</th>
         <th>답변날짜</th>
         <th>수정</th>
         <th>삭제</th>
      </tr>
      <%
         for(HashMap<String, Object> m : list) {
      %>
            <tr>
               <td><%=m.get("helpMemo")%></td>
               <td><%=m.get("helpCreatedate")%></td>
               <td>
                  <%
                     if(m.get("commentMemo") == null) {
                  %>
                        답변전
                  <%      
                     } else {
                  %>
                        <%=m.get("commentMemo")%>
                  <%   
                     }
                  %>   
               </td>
               <td>
                  <%
                     if(m.get("commentCreatedate") == null) {
                  %>
                        답변전   
                  <%      
                     } else {
                  %>
                        <%=m.get("commentCreatedate")%>
                  <%   
                     }
                  %>   
               </td>
               <td>
                  <%
                     if(m.get("commentMemo") == null) {
                  %>
                        <a href="">수정</a>   
                  <%      
                     } else {
                  %>
                        &nbsp;
                  <%   
                     }
                  %>   
               </td>
               <td>
                  <%
                     if(m.get("commentMemo") == null) {
                  %>
                        <a href="">삭제</a>   
                  <%      
                     } else {
                  %>
                        &nbsp;
                  <%   
                     }
                  %>
               </td>
            </tr>
      <%      
         }
      %>
   </table>

</body>
</html>