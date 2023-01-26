<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<nav id="sidebar" class="sidebar js-sidebar">
		<div class="sidebar-content js-simplebar">
			<a class="sidebar-brand" href="<%=request.getContextPath()%>/cash/cashList.jsp">
				<span class="align-middle">IBCashBook</span>
			</a>

			<ul class="sidebar-nav">
				<li class="sidebar-header">
					Member menu
				</li>

				<li class="sidebar-item">
					<a class="sidebar-link" href="<%=request.getContextPath()%>/cash/cashList.jsp">
						<i class="align-middle far fa-calendar-alt"></i> <span class="align-middle">가계부 리스트</span>
					</a>
				</li>
				
				<li class="sidebar-item">
					<a class="sidebar-link" href="<%=request.getContextPath()%>/cash/statsListYear.jsp">
						<i class="align-middle far fa-chart-bar"></i> <span class="align-middle">년도별 수입/지출 통계</span>
					</a>
				</li>
				
				<li class="sidebar-item">
					<a class="sidebar-link" href="<%=request.getContextPath()%>/cash/statsListMonth.jsp">
						<i class="align-middle far fa-chart-bar"></i> <span class="align-middle">월별 수입/지출 통계</span>
					</a>
				</li>

				<li class="sidebar-item">
					<a class="sidebar-link" href="<%=request.getContextPath()%>/help/helpList.jsp">
						<i class="align-middle fas fa-headset"></i> <span class="align-middle">고객센터</span>
					</a>
				</li>

				<li class="sidebar-header">
					Admin menu
				</li>
				
				<li class="sidebar-item">
					<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/adminMain.jsp">
						<i class="align-middle fas fa-cog"></i> <span class="align-middle">관리자 페이지</span>
					</a>
				</li>

				<li class="sidebar-item">
					<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp">
						<i class="align-middle fas fa-cog"></i> <span class="align-middle">공지사항 관리</span>
					</a>
				</li>

				<li class="sidebar-item">
					<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/categoryList.jsp">
						<i class="align-middle fas fa-cog"></i> <span class="align-middle">카테고리 관리</span>
					</a>
				</li>

				<li class="sidebar-item">
					<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/memberList.jsp">
						<i class="align-middle fas fa-cog"></i> <span class="align-middle">멤버 관리</span>
					</a>
				</li>

				<li class="sidebar-item">
					<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/helpListAll.jsp">
						<i class="align-middle fas fa-cog"></i> <span class="align-middle">문의사항 관리</span>
					</a>
				</li>
				
				<li class="sidebar-header">
					Account management
				</li>
				
				<li class="sidebar-item">
					<a class="sidebar-link" href="<%=request.getContextPath()%>/updateMemberForm.jsp">
						<i class="align-middle fas fa-bullseye"></i> <span class="align-middle">비밀번호 변경</span>
					</a>
				</li>
				
				<li class="sidebar-item">
					<a class="sidebar-link" href="<%=request.getContextPath()%>/updateMemberNameForm.jsp">
						<i class="align-middle fas fa-bullseye"></i> <span class="align-middle">이름 변경</span>
					</a>
				</li>

				<li class="sidebar-item">
					<a class="sidebar-link" href="<%=request.getContextPath()%>/deleteMemberForm.jsp">
						<i class="align-middle fas fa-bullseye"></i> <span class="align-middle">회원탈퇴</span>
					</a>
				</li>

				<li class="sidebar-item">
					<a class="sidebar-link" href="<%=request.getContextPath()%>/logout.jsp">
						<i class="align-middle fas fa-bullseye"></i> <span class="align-middle">로그아웃</span>
					</a>
				</li>
			</ul>
		</div>
	</nav>