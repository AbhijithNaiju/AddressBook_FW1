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
         /* writeDump(rc)  */
         local.isEmailCheck=variables.addressService.isEmailExist(
            email=rc.email,
            contactId=rc.editContactId,
            userId=session.userId
        )
        if(local.isEmailCheck.isEmailExist){
            local.resultStruct["emailError"]="Email already exists for another contact";
        }else{
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
                profileimage = rc.profileimage,
                profiledefault = rc.profiledefault,
                email = rc.email,
                editcontactid = rc.editcontactid
            ); 
        }
        variables.framework.renderData().data( local.resultStruct ).type( "json" );
    }
}