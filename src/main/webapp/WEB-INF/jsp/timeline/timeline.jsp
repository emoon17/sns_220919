<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>

    <div class="d-flex justify-content-center">
    	<div class="contents-box">
    		<%-- 글쓰기 영역 --%>
			<div class="write-box border rounded m-3">
				<textarea id="writeTextArea" placeholder="내용을 입력해주세요" class="w-100 border-0"></textarea>
	
				<%-- 이미지 업로드를 위한 아이콘과 업로드 버튼을 한 행에 멀리 떨어뜨리기 위한 div --%>
				<div class="d-flex justify-content-between">
					<div class="file-upload d-flex">
						<%-- file 태그는 숨겨두고 이미지를 클릭하면 file 태그를 클릭한 것처럼 이벤트를 줄 것이다. --%>
						<input type="file" id="file" class="" accept=".gif, .jpg, .png, .jpeg">
						<%-- 이미지에 마우스 올리면 마우스커서가 링크 커서가 변하도록 a 태그 사용 --%>
						<a href="#" id="fileUploadBtn"><img width="35" src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-image-512.png"></a>
	
						<%-- 업로드 된 임시 파일 이름 저장될 곳 --%>
						<div id="fileName" class="ml-2">
						</div>
					</div>
					<button id="writeBtn" class="btn btn-primary">게시</button>
					
				</div>
	    		
	    	</div> <%--글쓰기 영역 끝 --%>
	    	
	    	<%--타임라인 영역 --%>
	    	<div class="d-flex justify-content-center ">
		    	<div class="timeline-box d-flex justify-content-center">
		    		<%--카드 1 --%>
		    		<div class="card border rounded mt-3 ">
		    		
		    			<%-- 글쓴이, 더보기(삭제) --%>
						<div class="p-2 d-flex justify-content-between">
							<span class="font-weight-bold">${loginId}</span>
		
							<%-- 더보기 --%>
							<a href="#" class="more-btn" data-toggle="modal" data-target="#modal" data-post-id="${card.post.id}">
								<img src="https://www.iconninja.com/files/860/824/939/more-icon.png" width="30">
							</a>
						</div>
		    			
		    			<%--카드 이미지 --%>
		    			<div class="card-img">
		    				<img src="https://cdn.pixabay.com/photo/2023/01/02/04/13/dog-7691238_960_720.jpg" class="w-100" alt="본문 이미지">
						</div>
						
						<%-- 좋아요 --%>
						<div class="card-like m-3">
							<a href="#" class="like-btn">
							<img src="https://www.iconninja.com/files/214/518/441/heart-icon.png" width="18" height="18" alt="empty heart">
							좋아요 10개
							</a>
						</div>
						
						<%-- 글 내용 --%>
						<div class="card-comment-desc border-bottom">
							<div class="ml-3 mb-1 font-weight-bold">댓글</div>
						</div>
						
						<%-- 댓글 목록 --%>
						<div class="card-comment-list m-2">
							<div class="card-comment m-1 ">
								<span class="font-weight-bold ">댓글쓴이: </span>
								<span > 댓글 내용입니당</span>
								
								<%-- 댓글 삭제 버튼 --%>
								<a href="#" class="commentDelBtn"><img src="https://www.iconninja.com/files/603/22/506/x-icon.png" width="10px" height="10px"></a>
							</div>
						</div>
						
						<%-- 댓글 쓰기 --%>
						<div class="comment-write d-flex border-top mt-2">
							<input type="text" class="form-control border-0 mr-2" placeholder="댓글 달기"/> 
							<button type="button" class="comment-btn btn btn-light" data-post-id="${card.post.id}">게시</button>
						</div>
					</div>
					<%--// 댓글 목록 끝 --%>
		    	</div>
	    	</div>
	    </div>
	    	
   		</div>
   	</div>
   	
   	<script>
   		$(document).ready(function() {
   			// 게시 버튼을 눌렀을 때 (업로드 될 수 있도록)
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
   		});
   	</script>