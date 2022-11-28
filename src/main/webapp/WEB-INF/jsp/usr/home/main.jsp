<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEOK ZZANG" />
<%@ include file="../common/head.jspf"%>

<div class=" h-20 flex container mx-auto text-2xl">

		<div class="flex-grow"></div>
		<ul class="flex">
				<li class="hover:underline">
					<a class="h-full px-3 flex items-center" href="/">
						<span>HOME</span>
					</a>
				</li>
				<li class="hover:underline">
					<a class="h-full px-3 flex items-center" href="/usr/article/list?boardId=1">
						<span>NOTICE</span>
					</a>
				</li>
				<li class="hover:underline">
					<a class="h-full px-3 flex items-center" href="/usr/article/list?boardId=2">
						<span>FREE</span>
					</a>
				</li>
				<li class="hover:underline">
					<a class="h-full px-3 flex items-center" href="/usr/article/write">
						<span>WRITE</span>
					</a>
				</li>
				<c:if test="${!rq.isLogined()}">
					<li class="hover:underline">
						<a class="h-full px-3 flex items-center" href="/usr/member/login">
							<span>LOGIN</span>
						</a>
						</li>
				</c:if>
				<c:if test="${rq.isLogined()}">
					<li class="hover:underline">
						<a class="h-full px-3 flex items-center" href="/usr/member/doLogout">
							<span>LOGOUT</span>
						</a>
					</li>
				</c:if>
				<c:if test="${rq.isLogined()}">
					<li class="hover:underline">
						<a class="h-full px-3 flex items-center" href="/usr/member/myPage">
							<span>MYPAGE</span>
						</a>
					</li>
				</c:if>
		</ul>
</div>

</body>
</html>