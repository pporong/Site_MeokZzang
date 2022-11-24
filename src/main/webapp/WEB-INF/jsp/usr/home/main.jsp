<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEOK ZZANG" />
<%@ include file="../common/head.jspf"%>

				<c:if test="${!rq.isLogined()}">
					<div class="hover:underline">
						<a class="h-full px-3 flex items-center" href="/usr/member/login">
							<span>LOGIN</span>
						</a>
					</div>
				</c:if>
				<c:if test="${rq.isLogined()}">
					<div class="hover:underline">
						<a class="h-full px-3 flex items-center" href="/usr/member/doLogout">
							<span>LOGOUT</span>
						</a>
					</div>
				</c:if>

</body>
</html>