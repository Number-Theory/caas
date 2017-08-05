function loginSubmit() {

	var flag = user_login.validateData();
	if (!flag) {
		return false;
	}

	var checkCode = $("#checkCode").val();

	$.post(getPath() + "/checkCodeValid", {
		code : checkCode
	}, function(data) {
		if (data == false) {
			alert("验证码错误");
			return false;
		} else {
			$('#form-login').submit();
		}
	});
}

function getPath() {
	var path = $("#projectPath").val() + "/";
	return path;
}

var user_login = {
	validateData : function() {

		var name = $('#name').val();
		if (name == null || name == '') {
			alert('用户名不为空');
			return false;
		}
		var password = $('#userPwd').val();
		if (password == null || password == '') {
			alert('密码不为空');
			return false;
		}
		var checkCode = $('#checkCode').val();
		if (checkCode == null || checkCode == '') {
			alert('验证码不为空');
			return false;
		}

		return true;
	}
}

function keyLogin() {
	if (event.keyCode == 13) {
		loginSubmit();
	}
}
