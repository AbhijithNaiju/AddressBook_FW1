$(document).ready(function(){
    $("#closeEditModal").click(function(){
        $("#createForm")[0].reset();
    });
});

function openEditModal(editId){
    $(".errorMessage").text('');
    document.getElementById("profileImageEdit").src = "./assets/contactPictures/l60Hf.png";
    if(editId.value == ""){
        $("#modalHeading").text("CREATE CONTACT")
    }else{
        $("#modalHeading").text("EDIT CONTACT")
        $.ajax({
            type:"POST",
            url:"index.cfm",
            data:{
                contactId:editId.value,
                action:"jsFunctions.getContactData"
            },
            success: function(result) {
                if(result.success){
                    $("#title").val(result.contactDetails.title);
                    $("#firstName").val(result.contactDetails.firstName);
                    $("#lastName").val(result.contactDetails.lastName);
                    $("#gender").val(result.contactDetails.gender);
                    $("#dateOfBirth").val(result.contactDetails.dateOfBirth);
                    $("#profileDefault").val(result.contactDetails.profileImage);
                    $("#address").val(result.contactDetails.address);
                    $("#streetName").val(result.contactDetails.streetName);
                    $("#pincode").val(result.contactDetails.pincode);
                    $("#district").val(result.contactDetails.district);
                    $("#state").val(result.contactDetails.state);
                    $("#country").val(result.contactDetails.country);
                    $("#phoneNumber").val(result.contactDetails.phoneNumber);
                    $("#email").val(result.contactDetails.emailId);
                    if((result.contactDetails.profileImage).length){
                        document.getElementById("profileImageEdit").src = result.contactDetails.profileImage;
                    }
                    $("#submitEditModalBtn").val(editId.value);
                }else{
                    alert("Error ocuured while fetching data please try again");
                }
            },
            error:function(){
                alert("An error occured")
            }
        });
    }
}

function openViewModal(viewId)
{
    viewModalBody=document.getElementById("viewModalBody");
    $(".contactItemValue").text('');
    document.getElementById("viewModal").classList.remove("displayNone");
    $.ajax({
        type:"POST",
        url:"index.cfm",
        data:{
            contactId:viewId.value,
            action:"jsFunctions.getContactData"
        },
        success: function(result) {
            if(result.success)
            {
                const contactName=result.contactDetails.title +' '+result.contactDetails.firstName+' '+result.contactDetails.lastName;
                const contactAddress=result.contactDetails.address +', '+result.contactDetails.streetName+', '+result.contactDetails.district+', '+result.contactDetails.state+', '+result.contactDetails.country;
                $("#viewContactName").text(contactName);
                $("#viewContactGender").text(result.contactDetails.gender);
                $("#viewContactDateOfBirth").text(result.contactDetails.dateOfBirth);
                $("#viewContactAddress").text(contactAddress);
                $("#viewContactPincode").text(result.contactDetails.pincode);
                $("#viewContactEmailId").text(result.contactDetails.emailId);
                $("#viewContactPhoneNumber").text(result.contactDetails.phoneNumber);
                if((result.contactDetails.profileImage).length){
                    imageSrc="./assets/contactPictures/"+result.contactDetails.profileImage;
                    document.getElementById("viewProfileImage").src = imageSrc;
                }
            }else if(result.error){
                alert("An error occured please reload the page and try again");
            }else{
                alert("Unexpected error occured");
            }
        },
        error:function()
        {
            alert("An error occured")
        }
    });
}

function submitEditModal(contactId)
{
    let title = $("#title").val();
    let firstName = $("#firstName").val();
    let lastName = $("#lastName").val();
    let gender = $("#gender").val();
    let dateOfBirth = $("#dateOfBirth").val();
    let address = $("#address").val();
    let streetName = $("#streetName").val();
    let pincode = $("#pincode").val();
    let district = $("#district").val();
    let state = $("#state").val();
    let country = $("#country").val();
    let phoneNumber = $("#phoneNumber").val();
    let email = $("#email").val();
    let profileImage = $("#profileImage").val();

    let allowedExtentions=["jpg","jpeg","png"];
    let fileExtension = String(/[^.]+$/.exec(profileImage)).toLowerCase();
	let email_match=/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    
    var titleError = "";
    var firstNameError = "";
    var lastNameError = "";
    var genderError = "";
    var dateOfBirthError = "";
    var addressError = "";
    var streetNameError = "";
    var pincodeError = "";
    var districtError = "";
    var stateError = "";
    var countryError = "";
    var phoneNumberError = "";
    var emailError = "";
    var profileImageError = "";
    
    if(title.trim().length==0){
        titleError = "Please enter title";
    }
    $("#titleError").text(titleError)

    if(firstName.trim().length==0){
        firstNameError = "Please enter first name";
    }
    $("#firstNameError").text(firstNameError);

    if(lastName.trim().length==0){
        lastNameError = "Please enter last name";
    }
    $("#lastNameError").text(lastNameError);

    if(gender.trim().length==0){
        genderError = "Please enter the gender";
    }
    $("#genderError").text(genderError);

    if(dateOfBirth.trim().length==0){
        dateOfBirthError = "Please enter the DOB";
    }
    $("#dateOfBirthError").text(dateOfBirthError);

    if(address.trim().length==0){
        addressError = "Please enter the address";
    }
    $("#addressError").text(addressError);

    if(streetName.trim().length==0){
        streetNameError = "Please enter the street name";
    }
    $("#streetNameError").text(streetNameError);

    if(pincode.trim().length==0){
        pincodeError = "Please enter the pincode";
    }else if(isNaN(pincode)){
        pincodeError = "Please enter a valid number";
    }else if(pincode.trim().length != 6) {
        pincodeError = "Pincode must be 6 digits";
    }
    $("#pincodeError").text(pincodeError);

    if(district.trim().length==0){
        districtError = "Please enter the district";
    }
    $("#districtError").text(districtError);

    if(state.trim().length==0){
        stateError = "Please enter the state";
    }
    $("#stateError").text(stateError);

    if(country.trim().length==0){
        countryError = "Please enter the country";
    }
    $("#countryError").text(countryError);

    if(phoneNumber.trim().length==0){
        phoneNumberError = "Please enter the phone number";
    }
    else if(isNaN(phoneNumber)){
        phoneNumberError = "Please enter a valid number";
    }else if(phoneNumber.trim().length != 10){
        phoneNumberError = "Phone number must be 10 digits";
    }
    $("#phoneNumberError").text(phoneNumberError);


    if(!profileImage || allowedExtentions.includes(fileExtension)){
        profileImageError = "";
    }else{
        profileImageError = "Only JPG,JPEG and PNG files are allowed";
    }
    $("#profileImageError").text(profileImageError);

    if(email.trim().length==0){
        emailError = "Please enter the email";
    }
    else if(email_match.test(email)!=true) {
        emailError = "Please enter a valid email";
    }
    $("#emailError").text(emailError);
    
    if( titleError  == "" &&
        firstNameError  == "" &&
        lastNameError  == "" &&
        genderError  == "" &&
        dateOfBirthError  == "" &&
        addressError  == "" &&
        streetNameError == "" &&
        pincodeError == "" &&
        districtError == "" &&
        stateError == "" &&
        countryError == "" &&
        phoneNumberError == "" &&
        emailError == "" &&
        profileImageError == ""){

        var formElement = document.getElementById("createForm");
        var formData = new FormData(formElement);
        formData.append("action","jsFunctions.addOrEditContact")
        formData.append("editContactId", contactId.value);
        $.ajax({
            type: "POST",
            url: "index.cfm",
            data: formData,
            processData: false,
            contentType: false,
            success: function(result) {
                if(result.error){
                    $("#editModalError").text(editModalError);
                }
                if(result.emailError){
                    $("#emailError").text(result.emailError);
                    $("#email").focus();
                }
                else{
                    // location.reload();
                }
            }
        });
    }
}
function logout(){
	Swal.fire({
        title: "Are you sure?",
        text: "You will log out of this page and need to authenticate again to login",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Logout"
    }).then((result) => {
        if (result.isConfirmed){
            $.ajax({
                type:"POST",
                url:"index.cfm",
                data:{action:"jsFunctions.logout"},
                success: function() {
                    location.reload();
                }
            });
        }
	});
}

function deleteContact(deleteId){
    if(confirm("Confirm delete"))
        {
            $.ajax({
                type:"POST",
                url:"./Components/addressBook.cfc?method=deleteContact",
                data:{deleteId:deleteId.value},
                success: function(result) {
                    if(result)
                    {
                        deleteId.parentElement.parentElement.remove();
                    }
                },
                error:function()
                {
                    alert("An error occured")
                }
            });
        }
}