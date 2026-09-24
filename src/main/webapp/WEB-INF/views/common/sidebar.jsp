<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<aside class="sidebar">

    <!-- 로고 -->
    <div class="sidebar-logo">
        <a href="${pageContext.request.contextPath}/dashboard">
            TradeLog
        </a>
    </div>


    <!-- 메뉴 -->
    <nav class="sidebar-nav">

        <a href="${pageContext.request.contextPath}/dashboard"
           class="sidebar-link">
            대시보드
        </a>

        <a href="${pageContext.request.contextPath}/trade/list"
           class="sidebar-link">
            매매일지 관리
        </a>

        <a href="${pageContext.request.contextPath}/analysis"
           class="sidebar-link">
            매매 분석
        </a>

        <a href="${pageContext.request.contextPath}/rules"
           class="sidebar-link">
            매매 원칙
        </a>

    </nav>


    <!-- 사용자 영역 -->
    <div class="sidebar-user">

        <div class="sidebar-user-info">
            <span class="sidebar-user-label">
                로그인 계정
            </span>

            <strong>
                <c:out value="${sessionScope.loginMember.loginId}" />
            </strong>
        </div>

	    <!-- 회원 탈퇴 -->
		<div class="sidebar-user-actions">
		
		    <form action="${pageContext.request.contextPath}/member/logout"
		          method="post">
		
		        <button type="submit"
		                class="sidebar-logout">
		            로그아웃
		        </button>
		
		    </form>
		
		    <a href="${pageContext.request.contextPath}/member/withdraw"
		       class="sidebar-withdraw">
		        회원 탈퇴
		    </a>
		
		</div>

    </div>

</aside>
