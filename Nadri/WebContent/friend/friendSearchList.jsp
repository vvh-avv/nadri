<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<script type="text/javascript">

$(function(){
	var userId = $('#userId').val().trim();
	
	/* 친구 요청시(ajax를 이용) */
	$('.friendRequestY').on('click', function(){
		var friendId = $(this).parent().parent().find('.friendTitle').text();
		console.log(friendId);
		
		var searchUserId = $('#searchFriendId').val().trim();
		
		if(searchUserId != ''){//공백이 아닌 경우
			$.ajax({
				method: "post",
				url: "/friend/createFriend",
				data: JSON.stringify({searchUserId : searchUserId, userId : userId, friendId : friendId}),
				contentType: "application/json; charset=EUC-KR",
				dataType : "html",
				success: function(data) {
					$('#searchFriendList').html();
					$('#searchFriendList').html(data);
				},
				error : function(xhr) {
					console.log(xhr);
				}
			})
		
		} else {//공백입력시 아무런 반응 없음
			return;
		}
	})
	
	/* 친구 요청취소시(ajax를 이용) */
	$('.friendRequestN').on('click', function(){
		var friendId = $(this).parent().parent().find('.friendTitle').text();
		console.log(friendId);
		
		var searchUserId = $('#searchFriendId').val().trim();
		
		if(searchUserId != ''){//공백이 아닌 경우
			$.ajax({
				method: "post",
				url: "/friend/cancelFriend",
				data: JSON.stringify({searchUserId : searchUserId, userId : userId, friendId : friendId}),
				contentType: "application/json; charset=EUC-KR",
				dataType : "html",
				success: function(data) {
					$('#searchFriendList').html();
					$('#searchFriendList').html(data);
				},
				error : function(xhr) {
					console.log(xhr);
				}
			})
		
		} else {//공백입력시 아무런 반응 없음
			return;
		}
	})
})
</script>
<!-- 친구 찾은 목록 ajax로 리로딩 -->
<c:forEach items="${searchFriendList}" var="friendMemberVO">
	<div class="row">
			
		<div class="col-sm-8 col-xs-8">
			<span class="friendTitle friendName">${friend.userId}</span>
		</div>
		
		<div class="col-sm-4 col-xs-4">
			<c:choose>
				<c:when test="${friend.friendRequest == 'N'}">
					<button type="button" class="btn btn-danger friendRequestN">요청취소</button>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-success friendRequestY">친구요청</button>
				</c:otherwise>
			</c:choose>
		</div>
	</div><hr class="callList-line">
</c:forEach>
</html>
