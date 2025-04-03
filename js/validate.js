function checkLength(input,errorMessageId){
    if(input.trim().length==0){
        $("#"+errorMessageId).text("Please fill this field");
        $("#"+errorMessageId).prev().focus();
        return false;
    }else{
        $("#"+errorMessageId).text("");
        return true;
    }
}
function checkPincode(input,errorMessageId){
    let isSuccess = true;
    if(input.trim().length==0){
        $("#"+errorMessageId).text("Please enter the pincode");
        isSuccess = false;
    }else if(isNaN(input)){
        $("#"+errorMessageId).text("Please enter a valid pincode");
        isSuccess = false;
    }else if(input.trim().length != 6) {
        $("#"+errorMessageId).text("Pincode must be 6 digits");
        isSuccess = false;
    }else{
        $("#"+errorMessageId).text("");
    }
    if(isSuccess == false){
        $("#"+errorMessageId).prev().focus();
    }
    return isSuccess;
}
function checkPhone(input,errorMessageId){
    let isSuccess = true;
    if(input.trim().length==0){
        $("#"+errorMessageId).text("Please enter the phone number");
        isSuccess = false;
    }
    else if(isNaN(input)){
        $("#"+errorMessageId).text("Please enter a valid number");
        isSuccess = false;
    }else if(input.trim().length != 10){
        $("#"+errorMessageId).text("Phone number must be 10 digits");
        isSuccess = false;
    }else{
        $("#"+errorMessageId).text("");
    }
    if(isSuccess == false){
        $("#"+errorMessageId).prev().focus();
    }
    return isSuccess;
}
function checkImage(input,errorMessageId){
    let isSuccess = true;
    let allowedExtentions=["jpg","jpeg","png"];
    let fileExtension = String(/[^.]+$/.exec(input)).toLowerCase();

    if(allowedExtentions.includes(fileExtension)){
        $("#"+errorMessageId).text("");
    }else{
        $("#"+errorMessageId).text("Only JPG,JPEG and PNG files are allowed");
        isSuccess = false;
    }
    if(isSuccess == false){
        $("#"+errorMessageId).prev().focus();
    }
    return isSuccess;
}
function checkEmail(input,errorMessageId){
    let isSuccess = true;
	let emailFormat=/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    if(input.trim().length==0){
        $("#"+errorMessageId).text("Please enter the email");
        isSuccess = false;
    }
    else if(emailFormat.test(input)!=true) {
        $("#"+errorMessageId).text("Please enter a valid email");
        isSuccess = false;
    }else{
        $("#"+errorMessageId).text("");
    }
    if(isSuccess == false){
        $("#"+errorMessageId).prev().focus();
    }
    return isSuccess;
}