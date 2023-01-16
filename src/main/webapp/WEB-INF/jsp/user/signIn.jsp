<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="wrap">
	<section class="contents d-flex">
		
		<form id="signInForm" action="/user/sign_in" method="post">
			<div class="input-boxs justify-content-center col-12">
				<input type="text" id="loginId" name="loginId"
					placeholder="아이디" style="height: 50px; width:370px;"
					class="form-control pl-3"> <input type="password"
					id="password" name="password" placeholder="비밀번호"
					style="height: 50px; width:370px;" class="form-control pl-3 mt-3">
				<div class="login_btn">
					<button type="submit" class="btn btn-primary mt-5"
						style="width: 370px; height: 50px;">로그인</button>
				</div>
				<div class="line"></div>
			
			</div>
		</form>
	</section>
</div>

<script>
	$(document).ready(function(){
		// submit form작동 할 때
		$('#signInForm').on('submit', function(e){
			//서브밋 기능 중단
			e.preventDefault();
			//alert("dd");
			
			//validation
			let loginId = $('#loginId').val().trim();
			let password = $('#password').val().trim();
			//alert(loginId);
			if (loginId == '') {
				alert("아이디를 입력해주세요");
				return false;
			}
			if (password == ''){
				alert("비밀번호를 입력해주세요");
				return false;
			}
			
			let url = $(this).attr('action'); // form태그의 action속성
			let params = $(this).serialize(); // form태그의 name 값들
			
			$.post(url, params) //request
			.done(function(data) { //response
				if (data.code == 1) {
					location.href="/timeline/timeline_view";
				} else {
					alert(data.errorMessage);
				}
			});
		});
	});
</script>