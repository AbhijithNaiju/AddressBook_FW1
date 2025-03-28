component extends="framework.one"{
     this.datasource = "addressBookFW1";
     this.sessionManagement = true;
     this.sessionTimeout = CreateTimeSpan(0,1,0,0);
     // function setUpRequest(){
     //      writeDump(CGI)
     //      if(structKeyExists(session, "userId")){
     //           return true;
     //      }
     // }
}