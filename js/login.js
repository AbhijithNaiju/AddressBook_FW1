function loginValidate(event){
    $(".errorMessage").text("");
    let userName=$("#userName").val();
    let password=$("#password").val();
    let userNameError = "";
    let passwordError = "";

    if(userName.trim().length==0){
		userNameError= "Please enter your user name";
	}
    $("#userNameError").text(userNameError);

    if(password.trim().length==0){
		passwordError= "Please enter your password";
	}
    $("#passwordError").text(passwordError);

    if(passwordError != "" || userNameError != ""){
        event.preventDefault();
    }
}