component accessors=true{
    property addressService;
    property userService;
    function default( struct rc ) {
        if(structKeyExists(session, "userId")){
            rc.contactList = variables.addressService.contactList(userId=session.userId)
            rc.userDetails = variables.userService.getUserDetails(userId=session.userId)
        }else{
            location("index.cfm?action=main.login","false");
        }
    }

    function login( struct rc ) {
        param name="rc.loginButton" default="";
        param name="rc.emailId" default="";
        param name="rc.password" default="";
        param name="rc.error" default="";
        if(len(rc.loginButton) AND len(rc.emailId) AND len(rc.password)){
            local.loginResult=variables.userService.userLogin(emailId=rc.emailId,password=rc.password);
            if(structKeyExists(local.loginResult, "success")){
                location("index.cfm?action=main","false");
            }else if(structKeyExists(local.loginResult, "error")){
                rc.error = local.loginResult.error;
            }
        }
    }
/*     remote struct function getRoles()(returnFormat="JSON"){
        local.roles=variables.addressService.getAllRoles();
        return local.roles
    } */
    remote struct function logout()returnFormat="JSON"{
        structClear(session);
        local.resultStruct["success"]=true;
        return local.resultStruct;
    }
}