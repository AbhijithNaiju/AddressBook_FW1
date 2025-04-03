$(document).ready(function(){
    $(document).on("click",".openEditModal",function(){
    editId=this.value;
    $("#createForm")[0].reset();
    $(".errorMessage").text('');
    document.getElementById("profileImageEdit").src = "assets/contactPictures/l60Hf.png";
    if(editId == ""){
        $("#modalHeading").text("CREATE CONTACT")
    }else{
        $("#modalHeading").text("EDIT CONTACT")
        $.ajax({
            type:"POST",
            url:"index.cfm",
            data:{
                contactId:editId,
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
                        imageFilename = result.contactDetails.profileImage;
                    }else{
                        imageFilename="l60Hf.png"
                    }
                    document.getElementById("profileImageEdit").src = "assets/contactPictures/"+imageFilename;
                    $("#submitEditModalBtn").val(editId);
                }else{
                    alert("Error ocuured while fetching data please try again");
                }
            },
            error:function(){
                alert("An error occured")
            }
        });
    }
    });

    $(document).on("click",".openViewModal",function(){
        viewId = this.value;
        viewModalBody=document.getElementById("viewModalBody");
        $(".contactItemValue").text('');
        document.getElementById("viewModal").classList.remove("displayNone");
        $.ajax({
            type:"POST",
            url:"index.cfm",
            data:{
                contactId:viewId,
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
                        imageSrc=result.contactDetails.profileImage;
                    }else{
                        imageSrc="l60Hf.png"
                    }
                    document.getElementById("viewProfileImage").src = "./assets/contactPictures/"+imageSrc;
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
     });

    $(document).on("click",".deleteContact",function(){
        const deleteId=this.value;
        Swal.fire({
            title: "Are you sure?",
            text: "This contact will be removed from addressbokk.",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Remove"
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type:"POST",
                    url:"index.cfm",
                    data:{
                        contactId:deleteId,
                        action:"jsFunctions.deleteContact"
                    },
                    success: function(result) {
                        if(result.success){
                            $("#contactItem_"+deleteId).remove();
                        }else{
                            alert("An unexpected error occured")
                        }
                    },
                    error:function(){
                        alert("An error occured")
                    }
                });
            }
        });
    });

    $("#profileImage").change(function(){
        if(checkImage(this)){
            $("#profileImageEdit").attr("src",URL.createObjectURL(this.files.item(0)));
            $(this).val('');
        }else{
            if($("#profileDefault").val()){
                defaultProfileImage=$("#profileDefault").val();
            }else{
                defaultProfileImage="l60Hf.png";
            }
            $("#profileImageEdit").attr("src","./assets/contactPictures/"+defaultProfileImage);
        }
    });

    $("#submitEditModalBtn").click(function(){
        const contactId = this.value;
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
        let profileImage = document.getElementById("profileImage");

        isError=false;

        if(checkLength(title,"titleError") == false){
            isError=true;
        }
        if(checkLength(firstName,"firstNameError") == false){
            isError=true;
        }
        if(checkLength(lastName,"lastNameError") == false){
            isError=true;
        }
        if(checkLength(gender,"genderError") == false){
            isError=true;
        }
        if(checkLength(dateOfBirth,"dateOfBirthError") == false){
            isError=true;
        }
        if(checkLength(address,"addressError") == false){
            isError=true;
        }
        if(checkLength(streetName,"streetNameError") == false){
            isError=true;
        }
        if(checkLength(district,"districtError") == false){
            isError=true;
        }
        if(checkLength(state,"stateError") == false){
            isError=true;
        }
        if(checkLength(country,"countryError") == false){
            isError=true;
        }
        if(checkPincode(pincode,"pincodeError") == false){
            isError=true;
        }
        if(checkPhone(phoneNumber,"phoneNumberError") == false){
            isError=true;
        }
        if(profileImage && checkImage(profileImage,"profileImageError") == false){
            isError=true;
        }
        if(checkEmail(email,"emailError") == false){
            isError=true;
        }
        
        if(!isError){
            var formElement = document.getElementById("createForm");
            var formData = new FormData(formElement);
            formData.append("action","jsFunctions.addOrEditContact")
            if(contactId){
                formData.append("editContactId", contactId);
            }
            $.ajax({
                type: "POST",
                url: "index.cfm",
                data: formData,
                processData: false,
                contentType: false,
                success: function(result) {
                    if(result.error){
                        $("#editModalError").text(result.error);
                    }
                    if(result.emailError){
                        $("#emailError").text(result.emailError);
                        $("#email").focus();
                    }
                    if(result.imageError){
                        $("#profileImageError").text(result.imageError);
                        $("#profileImage").focus();
                    }
                    if(result.success){
                        if(result.profileImage){
                            newImageFilename="assets/contactPictures/"+result.profileImage;
                        }else{
                            newImageFilename="assets/contactPictures/l60Hf.png"
                        }
                        if(contactId){
                            $("#contactItem_"+contactId).find(".listName").text(firstName+' '+lastName);
                            $("#contactItem_"+contactId).find(".listEmail").text(email);
                            $("#contactItem_"+contactId).find(".listPhone").text(phoneNumber);
                            $("#contactItem_"+contactId).find(".profileImage").attr("src",newImageFilename);
                        }else{
                            let contactItem=`
                                <tr class="contactListItem" id="contactItem_${result.contactId}">
                                    <td class="listProfile">
                                        <img src="${newImageFilename}" alt="Image not found" class="profileImage">
                                    </td>
                                    <td class="listName">${firstName+' '+lastName}</td>
                                    <td class="listEmail">${email}</td>
                                    <td class="listPhone">${phoneNumber}</td>
                                    <td class="listButton">
                                        <button type="button" 
                                            value="${result.contactId}" 
                                            onclick="openEditModal(this)" 
                                            class = "contactButtons"
                                            data-bs-toggle="modal" 
                                            data-bs-target="#editModal" 
                                        >
                                            EDIT
                                        </button>
                                        <button type="button" 
                                            value="${result.contactId}" 
                                            onclick="deleteContact(this)" 
                                            class = "contactButtons"
                                        >
                                            DELETE
                                        </button>
                                        <button 
                                            type="button" 
                                            value="${result.contactId}" 
                                            onclick="openViewModal(this)" 
                                            class = "contactButtons"
                                            data-bs-toggle="modal" 
                                            data-bs-target="#viewModal" 
                                        >
                                            VIEW
                                        </button>
                                    </td>
                                </tr>
                            `;
                            $("#contactList").append(contactItem);
                        }
                        $("#editModal").modal("hide");
                    }
                }
            });
        }
    });
    
    $("#logout").click(function(){
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
    });
});

