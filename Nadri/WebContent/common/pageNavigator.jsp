<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 
<%-- <div class="container text-center">

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
		
</div> --%>

 <div class="text-center">
		 
		 <nav>
		  <ul class="pagination" >
		    
		    <!--  <<== 謝難 nav -->
		  	<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
		 		<li class="disabled">
			</c:if>
			<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
				<li>
			</c:if>
		      <a href="javascript:fncGetList('${ resultPage.currentPage-1}')" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		    
		    <!--  醞懈  -->
			<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
				
				<c:if test="${ resultPage.currentPage == i }">
					<!--  ⑷營 page 陛腦鑒唳辦 : active -->
				    <li class="active">
				    	<a href="javascript:fncGetList('${ i }');">${ i }<span class="sr-only">(current)</span></a>
				    </li>
				</c:if>	
				
				<c:if test="${ resultPage.currentPage != i}">	
					<li>
						<a href="javascript:fncGetList('${ i }');">${ i }</a>
					</li>
				</c:if>
			</c:forEach>
		    
		     <!--  辦難 nav==>> -->
		     <c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
		  		<li class="disabled">
			</c:if>
			<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
				<li>
			</c:if>
		      <a href="javascript:fncGetList('${resultPage.endUnitPage+1}')" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		  </ul>
		</nav>
		
</div> 
 