<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물 작성" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiLib.jspf"%>

<script>
	// 커스텀
	let submitWriteFormDone = false;
	
	function submitWriteForm(form){
		if(submitWriteFormDone){
			alert('처리 중 입니다.');
			return;
		}
		
	  form.title.value = form.title.value.trim();
	  
	  if(form.title.value == 0){
	    alert('제목을 입력해주세요');
	    return;
	  }
	  
	  const editor = $(form).find('.toast-ui-editor').data('data-toast-editor');
	  const markdown = editor.getMarkdown().trim();
	  
	  if(markdown.length == 0){
	    alert('내용을 입력해주세요');
	    editor.focus();
	    
	    return;
	  }
	  
	  form.body.value = markdown;
	  submitWriteFormDone = true;
	  
	  form.submit();
	}
</script>

<section class="mt-8 text-xl con">
	<div class="container mx-auto px-3">
		<div class="table-box-type-1">
			<form class="table-box-type-1 overflow-x-auto" method="POST" action="../article/doWrite" onsubmit="submitWriteForm(this); return false;">
  			<input type="hidden" name="body">
				<table>
					<colgroup>
						<col width="200" />
					</colgroup>
	
	
					<tbody>
						<tr>
							<th class="text-indigo-700">작성자</th>
							<td>${rq.loginedMember.nickname }</td>
						</tr>
						<tr>
						<th class="text-indigo-700">게시판 선택</th>
						<td>
							<select name="boardId">
								<option disabled> 게시판 선택 </option>
								<c:if test="${rq.admin}">
									<option value="1"> 공 지 사 항 </option>
								</c:if>
								<option value="2"> 자 유 게 시 판 </option>
								<option value="3"> 질 문 게 시 판 </option>
							</select>

						</td>

					</tr>
						<tr>
							<th class="text-indigo-700">제목</th>
							<td><input required="required" class="w-full input input-bordered" type="text" name="title" placeholder="제목을 입력해주세요" /></td>
						</tr>
						<tr>
							<th class="text-indigo-700">내용</th>
							<td>
								<div class="toast-ui-editor">
	     							 <script type="text/x-template"></script>
								</div>
							</td>
						</tr>
						<tr>
							<th class="text-indigo-700"></th>
							<td class=""><button class=" btn-sm hover:text-red-500" type="submit" value="등록">등록</button></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>

		<div class="btns row my-4">
			<button class="cell-r hover:text-blue-900 " type="button" onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>



</body>
</html>