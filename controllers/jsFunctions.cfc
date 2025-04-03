component accessors="true"{
    property addressService;
    property userService;

    function init( fw ) {
        variables.framework = arguments.fw;
        return this;
    }
    public string function logout(){
        structClear(session);
        local.resultStruct["success"]=true;
        variables.framework.renderData().data( local.resultStruct ).type( "json" );
    }

    public string function getContactData(required struct rc){
        param name="rc.contactId" default="";
        local.resultStruct=structNew();
        if(len(rc.contactId)){
            local.detailQuery = variables.addressService.contactList(rc.contactId);
            if(local.detailQuery.recordCount){
                local.contactDetails["title"] = local.detailQuery.title;
                local.contactDetails["firstName"] = local.detailQuery.firstName;
                local.contactDetails["lastName"] = local.detailQuery.lastName;
                local.contactDetails["gender"] = local.detailQuery.gender;
                local.contactDetails["dateOfBirth"] = dateFormat(local.detailQuery.DOB,"yyyy-mm-dd");
                local.contactDetails["profileImage"] = local.detailQuery.profileImage;
                local.contactDetails["address"] = local.detailQuery.address;
                local.contactDetails["streetName"] = local.detailQuery.streetName;
                local.contactDetails["pincode"] = local.detailQuery.pincode;
                local.contactDetails["district"] = local.detailQuery.district;
                local.contactDetails["state"] = local.detailQuery.state;
                local.contactDetails["country"] = local.detailQuery.country;
                local.contactDetails["phoneNumber"] = local.detailQuery.phoneNumber;
                local.contactDetails["emailId"] = local.detailQuery.emailId;
                local.resultStruct["contactDetails"]=local.contactDetails;
                local.resultStruct["success"]=true;
            }else{
                local.resultStruct["error"]=true;
            }
        }else{
            local.resultStruct["error"]=true;
        }
        variables.framework.renderData().data( local.resultStruct ).type( "json" );
    }

    public string function addOrEditContact(required struct rc){
        param name="rc.editContactId" default=0;
        param name="rc.profileImage" default="";
        param name="rc.profileDefault" default="";
        param name="rc.title" default="";
        param name="rc.firstName" default="";
        param name="rc.lastName" default="";
        param name="rc.dateofbirth" default="";
        param name="rc.gender" default="";
        param name="rc.address" default="";
        param name="rc.streetname" default="";
        param name="rc.district" default="";
        param name="rc.state" default="";
        param name="rc.country" default="";
        param name="rc.phonenumber" default="";
        param name="rc.pincode" default="";
        param name="rc.email" default="";

        local.resultStruct = structNew();
        local.isError=false;

        if(
            len(rc.title) ==0 ||
            len(rc.firstName) ==0 ||
            len(rc.lastName) ==0 ||
            len(rc.dateofbirth) ==0 ||
            len(rc.gender) ==0 ||
            len(rc.address) ==0 ||
            len(rc.streetname) ==0 ||
            len(rc.district) ==0 ||
            len(rc.state) ==0 ||
            len(rc.country) ==0 ||
            len(rc.phonenumber) ==0 ||
            len(rc.pincode) ==0 ||
            len(rc.email) ==0
        ){
            local.error=true;
            local.resultStruct["error"]="Please fill all the fields";
        }else if(NOT isValid("email", rc.email)){
            local.error=true;
            local.resultStruct["emailError"]="Please enter a valid email";
        }else if(len(rc.phonenumber) != 10 || !isNumeric(rc.phonenumber)){
            local.error=true;
            local.resultStruct["error"]="Please enter a valid Phone number";
        }else if(len(rc.pincode) != 6 || !isNumeric(rc.pincode)){
            local.error=true;
            local.resultStruct["error"]="Please enter a valid pincode";
        }else{
            local.isEmailCheck=variables.addressService.isEmailExist(
                    email=rc.email,
                    contactId=rc.editContactId,
                    userId=session.userId
                )
                if(local.isEmailCheck.isEmailExist){
                    local.isError=true;
                    local.resultStruct["emailError"]="Email already exists for another contact";
                }else{
                    local.uploadDirectory = "Assets/contactPictures/";

                    if(len(arguments.rc.profileImage)){
                        try{
                            local.fileDetails = fileUpload(
                                destination="#expandPath(local.uploadDirectory)#",
                                onconflict="makeunique",
                                mimetype="image/*"
                            )
                            local.imageFileName = local.fileDetails.serverfile;
                        }catch(any e){
                            local.isError=true;
                            local.resultStruct["imageError"]="Please enter a valid image file";
                        }
                    }else if(len(arguments.rc.profileDefault)){
                        local.imageFileName = arguments.rc.profileDefault;
                    }else{
                        local.imageFileName = "";
                    }
                }
        }
        if(local.isError == false){
            local.resultStruct=variables.addressService.addOrEditContact(
                userId=session.userId,
                title = rc.title,
                firstname = rc.firstName,
                lastname = rc.lastName,
                dateofbirth = rc.dateofbirth,
                gender = rc.gender,
                address = rc.address,
                streetname = rc.streetname,
                district = rc.district,
                state = rc.state,
                country = rc.country,
                phonenumber = rc.phonenumber,
                pincode = rc.pincode,
                profileimage = local.imageFileName,
                email = rc.email,
                editcontactId = rc.editcontactId
            );
            if(structKeyExists(local.resultStruct,"success")){
                if(len(arguments.rc.profileDefault) && len(arguments.rc.profileImage)){
                    local.previousImagePath=expandPath("assets/contactPictures/#arguments.rc.profileDefault#");
                    if(fileExists(local.previousImagePath)){
                        fileDelete(local.previousImagePath);
                    }
                }
                local.resultStruct["profileImage"] = local.imageFileName;
            }
        }
        variables.framework.renderData().data( local.resultStruct ).type( "json" );
    }
    public string function deleteContact(required struct rc){
        param name="rc.contactId" default="";
        if(len(rc.contactId)){
            local.resultStruct=variables.addressService.deleteContact(
                contactId = rc.contactId,
                userId = session.userId
            )
        }
        variables.framework.renderData().data( local.resultStruct ).type( "json" );
    }
}