component{
    function checkAuthentication(required struct rc){
        param name="rc.action" default="";
        if(structKeyExists(session, "userId") || rc.action == "main.login"){
            return true;
        }else{
            location(url="index.cfm?action=main.login",addtoken=false)
        }
    }
}