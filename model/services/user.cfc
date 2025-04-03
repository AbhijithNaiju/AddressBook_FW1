<cfcomponent>
    <cffunction name = "getUserDetails" returntype = "query">
        <cfargument name = "userId" type = "integer" required = "true">
        
        <cfquery name = "local.qryUserDetails">
            SELECT  
                U.fldFullName AS fullName,
                U.fldProfileImage AS profileImage,
                U.fldEmail AS email
            FROM
                tblUser U 
            WHERE 
                U.fldUser_ID =<cfqueryparam value = "#arguments.userId#" cfSqlType = "integer">;
        </cfquery>
        <cfreturn local.qryUserDetails>
    </cffunction>
    <cffunction  name="userLogin" returntype="struct">
        <cfargument  name="emailId" type="string">
        <cfargument  name="password" type="string">

        <cfset local.structResult = structNew()>
        <cfset local.hashedPassword = hash(arguments.password, "SHA-256")> 

        <cfquery name = "local.selectUser" >
            SELECT 
                U.fldUser_Id AS userId,
                U.fldFullName AS fullName
            FROM 
                tblUser U
            WHERE
                U.fldEmail = <cfqueryparam value = '#arguments.emailId#' cfsqltype = "varchar">
                AND U.fldPassword = <cfqueryparam value = '#local.hashedPassword#' cfsqltype = "varchar">;
        </cfquery>
        
        <cfif local.selectUser.recordcount>
            <cfset session.userId = local.selectUser.userId>
            <cfset session.userName = local.selectUser.fullName>
            <cfset local.structResult["success"] = "success">
        <cfelse>
            <cfset local.structResult["error"] = "Please enter a valid email and password">
        </cfif>

        <cfreturn local.structResult>
    </cffunction>
</cfcomponent>