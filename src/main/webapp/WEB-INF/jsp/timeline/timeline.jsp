<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>

    <div class="d-flex justify-content-center">
    	<div class="contents-box">
    		<%-- 글쓰기 영역 : 로그인 된 상태에서만 보여짐 --%>
    		<c:if test="${not empty userId}">
				<div class="write-box border rounded m-3">
					<textarea id="writeTextArea" placeholder="내용을 입력해주세요" class="w-100 border-0"></textarea>
		
					<%-- 이미지 업로드를 위한 아이콘과 업로드 버튼을 한 행에 멀리 떨어뜨리기 위한 div --%>
					<div class="d-flex justify-content-between">
						<div class="file-upload d-flex">
							<%-- file 태그는 숨겨두고 이미지를 클릭하면 file 태그를 클릭한 것처럼 이벤트를 줄 것이다. --%>
							<input type="file" id="file" class="d-none" accept=".gif, .jpg, .png, .jpeg">
							<%-- 이미지에 마우스 올리면 마우스커서가 링크 커서가 변하도록 a 태그 사용 --%>
							<a href="#" id="fileUploadBtn"><img width="35" src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-image-512.png"></a>
		
							<%-- 업로드 된 임시 파일 이름 저장될 곳 --%>
							<div id="fileName" class="ml-2">
							</div>
						</div>
						<button id="writeBtn" class="btn btn-primary">게시</button>
						
					</div>
		    		
		    	</div> <%--글쓰기 영역 끝 --%>
	    	</c:if>
	    	
	    	<%--타임라인 영역 --%>
	    		<c:forEach var="card" items="${cardList}">
	    			<div class="d-flex justify-content-center ">
			    		<div class="timeline-box d-flex justify-content-center">
			    		<%--카드 1 --%>
				    		<div class="card border rounded mt-3 ">
				    			
				    			
				    			<%-- 글쓴이, 더보기(삭제) --%>
								<div class="p-2 d-flex justify-content-between">
									<span class="font-weight-bold">${card.user.loginId}</span>
				
									<%-- 더보기(내가 쓴 글일 때만 노출) --%>
									<c:if test="${userId eq card.user.id}">
									<a href="#" class="more-btn" data-toggle="modal" data-target="#modal" data-post-id="${card.post.id}">
										<img src="https://www.iconninja.com/files/860/824/939/more-icon.png" width="30">
									</a>
									</c:if>
								</div>
				    			
				    			<%--카드 이미지 --%>
				    			<div class="card-img">
				    				<img src="${card.post.imagePath}" class="w-100" alt="본문 이미지">
								</div>
								<%-- 글 쓰기 --%>
								<div class="card-img">
				    				<span class="font-weight-bold m-2">${card.user.loginId}</span><span class="m-3">"${card.post.content}"</span>
								</div>
								
								<%-- 좋아요 --%>
								<div class="card-like m-3">
									<%-- 좋아요가 되어있을 때 --%>
									<c:if test="${card.filledLike eq true}">
										<a href="#" class="like-btn" data-user-id="${userId}" data-post-id="${card.post.id}">
											<img src="https://www.iconninja.com/files/527/809/128/heart-icon.png" width="18" height="18" alt="filled heart" >
										</a>
									</c:if>
									<%-- 좋아요가 해제되어 있을 때 --%>
									<c:if test="${card.filledLike eq false}">
										<a href="#" class="like-btn" data-user-id="${userId}" data-post-id="${card.post.id}">
											<img src="https://www.iconninja.com/files/214/518/441/heart-icon.png" width="18" height="18" alt="empty heart" >
										</a>
									</c:if>
									좋아요 ${card.likeCount}개
								</div>
								
								<%-- 글 내용 --%>
								<div class="card-comment-desc border-bottom">
									<div class="ml-3 mb-1 font-weight-bold">댓글</div>
								</div>
								
								<%-- 댓글 목록 --%>
								<div class="card-comment-list m-2">
									
									<%-- 댓글내용 --%>
									<c:forEach items="${card.commentList}" var="commentView">
										<div class="card-comment m-1 ">
											<span class="font-weight-bold ">${commentView.user.loginId}: </span>
											<span > ${commentView.comment.content}</span>
											
											<%-- 댓글 삭제 버튼 --%>
											<a href="#" class="commentDelBtn"><img src="https://www.iconninja.com/files/603/22/506/x-icon.png" width="10px" height="10px"></a>
										</div>
									</c:forEach>
								</div>
								<%-- 댓글 쓰기 : 로그인 된 상태만 가능--%>
								<c:if test="${not empty userId}">
									<div class="comment-write d-flex border-top mt-2">
										<input type="text" class="form-control border-0 mr-2" placeholder="댓글 달기"/> 
										<button type="button" class="comment-btn btn btn-light" data-post-id="${card.post.id}">게시</button>
									</div>
								</c:if>
							</div>
							<%--// 댓글 목록 끝 --%>
			    		</div>
	    			</div>
		    	</c:forEach>
	  	  </div>
	    	
   		</div>
   	</div>
   	

<!-- Modal -->
<div class="modal fade" id="modal"> <%--...을 눌렀을 때 post-data-id를 모달에 심어놓을거다. --%>
 <%-- modal sm: 작은 모달 창  --%>
 <%-- modal centered: 모달 창 수직으로 가운데 정렬 --%>
  <div class="modal-dialog modal-sm modal-dialog-centered">
    <div class="modal-content text-center">
 	   <div class="py-3 border-bottom">
 	   	 <a href="#" id="deletePostBtn">삭제하기</a> 
 	   </div>
 	   <%-- data-dismiss="modal"추가하면 모달 창 닫힘 --%>
 	   <div class="py-3 border-bottom" data-dismiss="modal">
 	   	<a href="#">취소하기</a>
 	   </div>
 	   <%-- 수정하기 --%>
 	    <div class="py-3">
 	   	<a href="#" id="updatePostBtn">수정하기</a>
 	   </div>
    </div>
  </div>
</div>

   	<script>
   		$(document).ready(function() {
   			// 파일이미지를 클릴 할 때 => 숨겨져 있는 file input을 동작시킴
   			$('#fileUploadBtn').on('click', function(e){
   				//alert("ㅇㅇ");
   				// a태그를 누르면 스크롤이 맨 위로 올라감 -> 방지시킴
   				e.preventDefault();
   				$('#file').click(); // input file을 클릭한 것과 같은 효과
   			});
   			
   			// 사용자가 이미지를 선택했을 때 유효성 확인 및 업로드 된 파일 이름 노출
   			$('#file').on('change', function(e){
   				//alert("Dd");
   				let fileName = e.target.files[0].name; //e.target: this랑 같음 =>파일 0번째거의 파일명만 가져온다.
   				//frozen-lake-7658478_960_720.jpg
   			//	alert(fileName); 
   				
   				//확장자 유효성 확인
   				let ext = fileName.split(".").pop().toLowerCase();
   				if (ext != 'jpg' && ext != 'jepg' && ext != 'gif' && ext != 'png') {
   					alert("이미지 파일의 형식에 맞지 않습니다.");
   					$('#file').val('');// 파일 태그에 실제 파일 제거
   					$('#fileName').text(''); // 파일 이름 비우기
   					return;
   				}
   				// 유효성 검사에 통과하면 파일 이름을 노출시키기
   				$('#fileName').text(fileName);
   				
   			});
   			
   			// 게시글 게시 버튼을 눌렀을 때 (업로드 될 수 있도록)
   			$('#writeBtn').on('click', function() {
   				//alert("dd");
   				//validation check
   				let content = $('#writeTextArea').val();
   				if (content == ''){
   					alert("내용을 입력하여주세요.");
   					return;
   				}
   				
   				// 파일 저장
   				let file = $('#file').val();
   				//alert(file);
   				
   				if (file != '') {
   					// 파일이 업로드 됐을 경우에만 확장자 체크
   					let ext = file.split(".").pop().toLowerCase(); // toLowerCase: 다 소문자롤 바꿈
   					
   					// 배열 ext 에 [] 안에 있는 인덱스들이 있는지 확인 없으면 -1로 반환
   					if($.inArray(ext, ['jpg', 'jpeg', 'png', 'gif']) == -1) {
   						alert("이미지 파일 형식에 맞지 않는 파일입니다.");
   						$('#file').val(''); // file 비우기
   						return;
   					}
   				}
   				// ajax통신으로 파일 보내기 위한 순서
   				let formData = new FormData();
   				formData.append("content", content);
   				formData.append("file", $('#file')[0].files[0]); // 여러 개 올릴 때는 배열로 올려야 함.
   				
   				//ajax 통신으로 forData에 있는 데이터 전송
   				$.ajax({
   					//request
   					type:"post"
   					, url:"/post/create"
   					, data:formData // json이 아니라 form객체를 통으로 넣어야됌
   					
   					// 파일 업로드시 필요한 3가지 설정 - Requestbody에 json이 아니라 form객체가 담겨지는 설정
   					// 자바스크립트에서 폼태그 만들기
   					, enctype:"multipart/form-data"
   					, processData:false
   					, contentType:false
   					
   					//response
   					, success:function(data) {
   						if (data.code == 1) {
   							// 성공
   							alert("게시글 작성이 완료되었습니다.");
   							location.href="/timeline/timeline_view";
   						} else {
   							//실패
   							alert(data.errorMessage);
   						}
   					}
   					, error:function(e){
   						alert("메모저장에 실패하였습니다.")
   					}
   				});
   				
   			});
   			
   			// 댓글 버튼 눌렀을 때
   			$('.comment-btn').on('click', function(){
   				//alert("dd");
   				//validation
   				// 글 번호, 댓글 내용 가져오기
   				let postId = $(this).data('post-id');
   				//alert(postId);
   				
   				 // 지금 클릭 된 게시버튼 근처에 있는 형제의 input을 가져온다. : siblings
   				let comment = $(this).siblings('input').val();
   				//alert(comment);
   				if (comment == '') {
   					alert("등록할 내용이 없습니다");
   				}
   				
   				
   				//ajax
   				$.ajax({
   					//request
   					type:"get"
   					, url:"/comment/create"
   					, data:{"content":comment, "postId":postId}
   				
   					//response
   					, success:function(data){
   						if(data.code == 1) {
   							alert("댓글을 등록하였습니다.");
   							document.location.reload();
   							
   						} else {
   							alert(data.errorMessage);
   						}
   					}
   					, error:function(jqXHR, textStatus, ErrorThrown){
   						var errorMsg = jqXHR.responseJSON.status;
   						alert(errorMsg + ":" + textStatus);
   					}
   				});
   			});
   			
   			// 좋아요 버튼을 눌렀을 때
   			$('.like-btn').on('click', function(e) {
   				//alert("dd");
   				//  좋아요 누른 글의 아이디를 가져온다.
   				e.preventDefault();

   				let userId = $(this).data('user-id');
   				//alert(userId);
   				if (userId == '') {
   					alert("로그인을 해주세요");
   					return;
   				}
   				
   				let postId = $(this).data('post-id');
   				//alert(postId);
   				
   				$.ajax({
   					// request
   					 url:"/like/" + postId
   					// response
   					, success:function(data) {
   						if(data.code == 1) {
   							location.reload(true);
   						} else {
   							alert("오류발생")
   						}
   					}
   					,error:function(jqXHR, textStatus, ErrorThrown){
   						var errorMsg = jqXHR.responseJSON.status;
   						alert(errorMsg + ":" + textStatus);
   					}
   				});
   			});
   			
   			// 글삭제를 위한 더보기 버튼(...) 클릭
   			$('.more-btn').on('click', function(e){
   				e.preventDefault();
   				
   				let postId = $(this).data('post-id'); //getting (태그에 있는 걸 얻어오는것)
   				//alert(postId);
   				
   				$('#modal').data('post-id', postId); // setting(모달 태그에 data-post-id를 심어놓는것)
   				
   				
   			});
   			// 모달 안에 있는 삭제하기 버튼 클릭
   			$('#modal #deletePostBtn').on('click', function(e){
   				e.preventDefault();
   				
   				// 모달 post id 다시 가져오기
   				let postId = $('#modal').data('post-id');
   				//alert(postId);
   				
   				//ajax 글 삭제
   				$.ajax({
   					// request
   					type:"delete"
   					, url:"/post/delete"
   					, data:{"postId":postId}
   					//response
   					, success:function(data){
   						if (data.code == 1){
   							location.reload();
   							alert("삭제가 완료 되었습니다.");
   						} else {
   							alert(data.errorMessage);
   						}
   					}
   					,error:function(jqXHR, textStatus, ErrorThrown){
   						var errorMsg = jqXHR.responseJSON.status;
   						alert(errorMsg + ":" + textStatus);
   					}
   				});
   			});
   			
   			// 모달 수정하기 버튼을 눌렀을 때. 
   			$('#modal #updatePostBtn').on('click', function(){
   				//alert("ㅇㅇ");
   				let postId = $('#modal').data('post-id');
   			});
   		});
   	</script>