<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//한글처리 utf-8 인코딩
	request.setCharacterEncoding("utf-8");
	// 로그인이 안되어 있을때는 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = request.getParameter("msg");

	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	Help help = new Help();
	// Model 호출
	HelpDao helpDao = new HelpDao();
	help = helpDao.selectHelpOne(helpNo);
%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
	<meta name="author" content="AdminKit">
	<meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link rel="shortcut icon" href="../resorces/img/icons/icon1-48x48.png" />
	<link rel="canonical" href="https://demo-basic.adminkit.io/pages-sign-up.html" />
	<title>updateHelpForm</title>
	<link href="../resorces/css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
</head>

<body>
	<main class="d-flex w-100">
		<div class="container d-flex flex-column">
			<div class="row vh-100">
				<div class="col-sm-10 col-md-8 col-lg-6 mx-auto d-table h-100">
					<div class="d-table-cell align-middle">
						<div class="text-center mt-4">
							<h1 class="h2">문의내용 수정하기</h1>
							<%
								// msg 출력 
								if(msg != null){
							%>
									 <%=msg%>
							<%
								}
							%>
						</div>
						<div class="p-1 bg-primary rounded"></div>
						<div class="card">
							<div class="card-body">
								<div class="m-sm-4">
									<form id="form" action="<%=request.getContextPath()%>/help/updateHelpAction.jsp" method="post">
										<input type="hidden" name="helpNo" value="<%=helpNo%>">
										<div class="mb-3">
											<label class="form-label">문의내용</label>
											<textarea rows="6" cols="70" id="helpMemo" name="helpMemo" class="form-control form-control-lg"><%=help.getHelpMemo()%></textarea>
										</div>
										<div class="text-center mt-3">
											<button type="button" id="btn" class="btn btn-lg btn-primary">수정하기</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<script>
		let btn = document.querySelector('#btn');
		btn.addEventListener('click', function(){
			// 디버깅
			console.log('btn click!');
			
			// memo 폼 유효성 검사
			let helpMemo = document.querySelector('#helpMemo');
			if(helpMemo.value == '') {
				alert('문의사항을 입력해주세요');
				helpMemo.focus();
				return;
			}
			let form = document.querySelector('#form');
			form.submit(); 
		})
	</script>
</body>
</html>