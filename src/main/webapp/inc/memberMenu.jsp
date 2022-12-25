<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	// seesion에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
	<nav class="navbar navbar-expand navbar-light navbar-bg">
		<a class="sidebar-toggle js-sidebar-toggle">
          <i class="hamburger align-self-center"></i>
        </a>

		<div class="navbar-collapse collapse">
			<ul class="navbar-nav navbar-align">
				<li class="nav-item dropdown">
					<a class="nav-icon dropdown-toggle" href="#" id="alertsDropdown" data-bs-toggle="dropdown">
						<span class="position-relative">
							<i class="align-middle far fa-comment" data-feather="bell"></i>
							<span class="indicator">4</span>
						</span>
					</a>
					<div class="dropdown-menu dropdown-menu-lg dropdown-menu-end py-0" aria-labelledby="alertsDropdown">
						<div class="dropdown-menu-header">
							4 New Notifications
						</div>
						<div class="list-group">
							<a href="#" class="list-group-item">
								<span class="row g-0 align-items-center">
									<span class="col-2">
										<i class="text-danger" data-feather="alert-circle"></i>
									</span>
									<span class="col-10">
										<span class="text-dark">Update completed</span><br>
										<span class="text-muted small mt-1">Restart server 12 to complete the update.</span><br>
										<span class="text-muted small mt-1">30m ago</span>
									</span>
								</span>
							</a>
							<a href="#" class="list-group-item">
								<span class="row g-0 align-items-center">
									<span class="col-2">
										<i class="text-warning" data-feather="bell"></i>
									</span>
									<span class="col-10">
										<span class="text-dark">Lorem ipsum</span><br>
										<span class="text-muted small mt-1">Aliquam ex eros, imperdiet vulputate hendrerit et.</span><br>
										<span class="text-muted small mt-1">2h ago</span>
									</span>
								</span>
							</a>
							<a href="#" class="list-group-item">
								<span class="row g-0 align-items-center">
									<span class="col-2">
										<i class="text-primary" data-feather="home"></i>
									</span>
									<span class="col-10">
										<span class="text-dark">Login from 192.186.1.8</span><br>
										<span class="text-muted small mt-1">5h ago</span>
									</span>
								</span>
							</a>
							<a href="#" class="list-group-item">
								<span class="row g-0 align-items-center">
									<span class="col-2">
										<i class="text-success" data-feather="user-plus"></i>
									</span>
									<span class="col-10">
										<span class="text-dark">New connection</span><br>
										<span class="text-muted small mt-1">Christina accepted your request.</span><br>
										<span class="text-muted small mt-1">14h ago</span>
									</span>
								</span>
							</a>
						</div>
						<div class="dropdown-menu-footer">
							<a href="#" class="text-muted">Show all notifications</a>
						</div>
					</div>
				</li>
				
				
				<!-- ------------------------------------------------------------------------ -->
				<li class="nav-item dropdown">
					<a class="nav-icon dropdown-toggle d-inline-block d-sm-none" href="#" data-bs-toggle="dropdown">
						<i class="align-middle"></i>
					</a>

					<a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-bs-toggle="dropdown">
						<span class="text-dark"><%=loginMember.getMemberName()%>(<%=loginMember.getMemberId()%>)</span>
						<i class="align-middle fas fa-house-user" style="font-size:20px"></i>
					</a>
					<div class="dropdown-menu dropdown-menu-end">
						<a class="dropdown-item" href="<%=request.getContextPath()%>/help/helpList.jsp"> 고객센터</a>
						<a class="dropdown-item" href="<%=request.getContextPath()%>/admin/adminMain.jsp"> 관리자 페이지</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="<%=request.getContextPath()%>/updateMemberForm.jsp"> 비밀번호 변경</a>
						<a class="dropdown-item" href="<%=request.getContextPath()%>/updateMemberNameForm.jsp"> 이름 변경</a>
						<a class="dropdown-item" href="<%=request.getContextPath()%>/deleteMemberForm.jsp"> 회원탈퇴</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="<%=request.getContextPath()%>/logout.jsp"> 로그아웃</a>
					</div>
				</li>
			</ul>
		</div>
	</nav>