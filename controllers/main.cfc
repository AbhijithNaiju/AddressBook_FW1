component accessors=true{
    property addressService;
    property userService;
    function default( struct rc ) {
        param name="rc.name" default="anonymous";
        param name="rc.loginButton" default="";
        param name="rc.emailId" default="";
        param name="rc.password" default="";
        if(len(rc.loginButton) AND len(rc.emailId) AND len(rc.password)){
            local.loginResult=variables.userService.userLogin(emailId=rc.emailId,password=rc.password)
            if(structKeyExists(local.loginResult, "success")){
                location("index.cfm?action=main.home");
            }
        }
    }

    function home( struct rc ) {
        param name="rc.name" default="anonymous";
        rc.contactList = variables.addressService.contactList(userId=2)
        rc.userDetails = variables.userService.getUserDetails(userId=2)
    }
}