component extends="framework.one"{
     this.datasource = "addressBookFW1";
     this.sessionManagement = true;
     this.sessionTimeout = CreateTimeSpan(0,1,0,0);
     function setUpRequest(){
         controller("security.checkAuthentication");
     }
}