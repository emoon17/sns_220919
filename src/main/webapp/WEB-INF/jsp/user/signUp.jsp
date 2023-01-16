<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="input-boxs justify-content-center col-12">
<h2 class="sign-text">친구들의 사진과 동영상을 보려면 가입하세요.</h2>

	<form id="signUpForm" method="post" action="/user/sign_up">
		<input type="text" id="address" name="email"
			placeholder="이메일주소 " style="height: 50px;"
			class="form-control pl-3 mt-3"> 
			<div id="emailCheckLength" class="small text-danger d-none">이메일이 비었습니다.</div>
			
			
			<input type="text" id="name"
			name="name" placeholder="성명" style="height: 50px;"
			class="form-control pl-3 mt-3"> 
			<div id="nameCheckLength" class="small text-danger d-none">이름이 비었습니다.</div>
			
			<div class="d-flex">
				<input type="text" id="loginId"
				name="loginId" placeholder="아이디" style="height: 50px;"
				class="form-control pl-3 mt-3"> 
				<button type="button" class="btn btn-primary"
					id="loginCheckBtn" style="margin-top:16px; height: 50px;">중복</button>
			</div>
			<div id="userIdCheckLength" class="small text-danger d-none col-8">아이디가 비었습니다.</div>
			<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
			<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
				
			
			<input type="password"
			id="password" name="password" placeholder="비밀번호" style="height: 50px;"
			class="form-control pl-3 mt-3">
			<div id="passwordIdCheckLength" class="small text-danger d-none">비밀번호가 비었습니다.</div>
			
		<div class="login_btn">
			<button type="submit" class="btn btn-primary mt-5"
				style="width: 370px; height: 50px;" id="submitBtn">가입</button>
		</div>
	</form>
		<div class="line"></div>
	</div>
<script>
	$(document).ready(function(){
		// 아이디 중복확인
		$('#loginCheckBtn').on('click', function() {
			//alert('dd');
			let loginId = $('#loginId').val().trim();

			//초기화
			$('#userIdCheckLength').addClass('d-none');
			$('#idCheckDuplicated').addClass('d-none');
			$('#idCheckOk').addClass('d-none');
			
			
			if (loginId.length < 4){
				$('#userIdCheckLength').removeClass('d-none') // 경고문구 노출
				$('#idCheckDuplicated').addClass('d-none') //숨김
				$('#idCheckOk').addClass('d-none') //숨김
				return;
			}	
			
			// ajax
			$.ajax({
				//request
				url:"/user/is_duplicated_id"
				, data:{"loginId":loginId}
				//response
				, success:function(data){
					if (data.code == 1) {
						// 성공
						// 중복
						$('#idCheckDuplicated').removeClass('d-none');
					} else {
						// 실패
						$('#idCheckOk').removeClass('d-none');
					}
				}
				, error:function(e){
					alert("중복확인에 실패하였습니다.");
				}
			});
			
		});
		
		
		// 가입버튼을 눌렀을 때
		$('#signUpForm').on('submit', function(e) {
			e.preventDefault(); // 서브밋 기능 중단
			//alert("dd");
			
			// 비어있는지 확인
			let email = $('#email').val();
			let name = $('#name').val().trim();
			let loginId = $('#loginId').val().trim();
			let password = $('#password').val().trim();
			// d-none 초기화
			$('#nameCheckLength').addClass('d-none');
			$('#emailCheckLength').addClass('d-none');
			$('#userIdCheckLength').addClass('d-none');
			$('#passwordIdCheckLength').addClass('d-none');
			
			if (email == '') {
				$('#emailCheckLength').removeClass('d-none');
				return false;
			}
			
			if (name == '') {
				$('#nameCheckLength').removeClass('d-none')
				return false;
			}
		
			if (loginId == '') {
				$('#userIdCheckLength').removeClass('d-none');
				$('#idCheckDuplicated').addClass('d-none');
				$('#idCheckOk').addClass('d-none');
				return false;
			}
			
			if (password == '') {
				$('#passwordIdCheckLength').removeClass('d-none');
				return false;
			}
			
			if ($('#idCheckOk').hasClass('d-none')) {
				alert("아이디 중복확인을 다시 해주세요.");
				return false;
			}
			
			let url = $(this).attr('action');
			let params = $(this).serialize(); // form 태그에 있는 name으로 파라미터 구성
			
			$.post(url, params) // request
			.done(function(data) { //response
				if (data.code == 1 ){
					alert("가입을 환영합니다. 로그인 해주세요.");
					location.href="/user/sign_in_view";
				} else {
					//실패
					alert(data.errorMessage);
				}
			});
		});
	});
</script>