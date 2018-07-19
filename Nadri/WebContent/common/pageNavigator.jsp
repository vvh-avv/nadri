<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 
<div class="container text-center">

	<nav>
		<ul class="pagination" >
		  
			<li ${resultPage.beginUnitPage == 1 ? 'class="disabled"':''}>
				<a href="javascript:fncGetList('${resultPage.beginUnitPage == 1 ? 1 : resultPage.beginUnitPage-1}');" aria-label="Previous">
					<span aria-hidden="true">&laquo;</span>
				</a>
			</li>
			
			<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
				<li ${resultPage.currentPage != i ? '':'class="active"'}>
					<a href="javascript:fncGetList('${ i }');">${ i }<span class="sr-only">(current)</span></a>
				</li>
			</c:forEach>
			
			<li ${resultPage.endUnitPage == resultPage.maxPage ? 'class="disabled"':''}>
				<a href="javascript:fncGetList('${resultPage.endUnitPage == resultPage.maxPage ? resultPage.maxPage : resultPage.endUnitPage+1}');" aria-label="Next">
					<span aria-hidden="true">&raquo;</span>
				</a>
			</li>
		</ul>
	</nav>
		
</div>
 