<cfcomponent>
<cffunction  name="contactList" returntype = "query">
        <cfargument name = "contactId" default = "" required = "false">
        <cfargument name = "userId" default = "" required = "false">

        <cfquery name = "local.qryContactDetails">
             SELECT 
                <cfif LEN(arguments.contactId)>
                    CD.fldTitle AS title,
                    CD.fldGender AS gender,
                    CD.fldDOB AS DOB,
                    CD.fldAddress AS address,
                    CD.fldStreetName AS streetName,
                    CD.fldDistrict AS district,
                    CD.fldSTATE AS STATE,
                    CD.fldCountry AS country,
                    CD.fldPincode AS pincode,
                </cfif>
                CD.fldContact_Id AS contactId,
                CD.fldFirstName AS firstName,
                CD.fldLastName AS lastName,
                CD.fldEmailId AS emailId,
                CD.fldPhoneNumber AS phoneNumber,
                CD.fldProfileImage AS profileImage
            FROM 
                tblContactDetails AS CD
            WHERE 
                <cfif len(arguments.contactId)>
                    CD.fldContact_ID = <cfqueryparam value = '#arguments.contactId#' cfsqltype = "integer">
                <cfelseif len(arguments.userId)>
                    CD.fldUserId = <cfqueryparam value = '#arguments.userId#' cfsqltype = "integer">
                </cfif>
                AND CD.fldActive = <cfqueryparam value = 1 cfsqltype = "integer">
                GROUP BY 
                    CD.fldContact_ID,
                    CD.fldTitle,
                    CD.fldFirstName,
                    CD.fldLastName,
                    CD.fldGender,
                    CD.fldDOB,
                    CD.fldProfileImage,
                    CD.fldAddress,
                    CD.fldStreetName,
                    CD.fldDistrict,
                    CD.fldSTATE,
                    CD.fldCountry,
                    CD.fldPincode,
                    CD.fldEmailId,
                    CD.fldPhoneNumber;
        </cfquery>

        <cfreturn local.qryContactDetails>
    </cffunction>

    <cffunction name = "isEmailExist" returntype = "struct">
        <cfargument name = "email" type = "string" required = "true">
        <cfargument name = "userId" type = "integer" required = "true">
        <cfargument name = "contactId" type = "integer" required = "false" default="">

        <cfset local.resultStruct = structNew()>
        <cfquery name="local.qryEmailInContacts" >
            SELECT 
                count(fldemailId) AS emailCount
            FROM 
                tblContactDetails
            WHERE 
                fldActive = 1
                AND fldUserId = <cfqueryparam value = '#arguments.userId#' cfsqltype = "bigint">
                AND fldemailId = <cfqueryparam value = '#arguments.email#' cfsqltype = "varchar">
                <cfif len(arguments.contactId)>
                    AND fldContact_ID != <cfqueryparam value = '#arguments.contactId#' cfsqltype = "bigint">
                </cfif>;
        </cfquery>
        <cfif local.qryEmailInContacts.emailCount>
            <cfset local.resultStruct["isEmailExist"] = true>
        <cfelse>
            <cfset local.resultStruct["isEmailExist"] = false>
        </cfif>

        <cfreturn local.resultStruct>
    </cffunction>
    <cffunction  name="addOrEditContact">
        <cfargument name = "title" type = "string" required = "true">
        <cfargument name = "userId" type = "integer" required = "true">
        <cfargument name = "firstName" type = "string" required = "true">
        <cfargument name = "lastName" type = "string" required = "true">
        <cfargument name = "gender" type = "string" required = "true">
        <cfargument name = "dateOfBirth" required = "true">
        <cfargument name = "address" type = "string" required = "true">
        <cfargument name = "streetName" type = "string" required = "true">
        <cfargument name = "pincode" type = "string" required = "true">
        <cfargument name = "district" type = "string" required = "true">
        <cfargument name = "state" type = "string" required = "true">
        <cfargument name = "country" type = "string" required = "true">
        <cfargument name = "email" type = "string" required = "true">
        <cfargument name = "phoneNumber" type = "string" required = "true">
        <cfargument name = "profileImage" required = "false">
        <cfargument name = "profileDefault" type = "string" required = "true">
        <cfargument name = "editContactId" type = "string" required = "true">

        <!--- <cfdump  var="#arguments#"> --->

<!---         <cfset local.uploadDirectory = "../Assets/contactPictures/">

        <cfif structKeyExists(arguments, "profileImage") && len(arguments.profileImage)>
            <cffile action="upload"
                    destination="#expandPath(local.uploadDirectory)#"
                    nameconflict="makeunique"
                    result="fileDetails">
            <cfset local.imageSrc = local.uploadDirectory & fileDetails.serverfile>
        <cfelseif structKeyExists(arguments,"profileDefault")>
            <cfset local.imageSrc = arguments.profileDefault>
        <cfelse>
            <cfset local.imageSrc = "">
        </cfif> --->
            <cfset local.imageSrc = "">
        
        <cfset local.resultStruct = structNew()>
        <cfset local.updateDate = dateformat(now(),"yyyy-mm-dd")>

        <cftry>
            <cfquery>
                UPDATE 
                    tblContactDetails
                SET 
                    fldTitle = <cfqueryparam value = '#arguments["title"]#' cfsqltype = "varchar">,
                    fldFirstName = <cfqueryparam value = '#arguments["firstName"]#' cfsqltype = "varchar">,
                    fldLastName = <cfqueryparam value = '#arguments["lastName"]#' cfsqltype = "varchar">,
                    fldGender = <cfqueryparam value = '#arguments["gender"]#' cfsqltype = "varchar">,
                    fldDOB = <cfqueryparam value = '#arguments["dateOfBirth"]#' cfsqltype = "date">,
                    fldProfileImage = <cfqueryparam value = '#local.imageSrc#' cfsqltype = "varchar">,
                    fldAddress = <cfqueryparam value = '#arguments["address"]#' cfsqltype = "varchar">,
                    fldStreetName = <cfqueryparam value = '#arguments["streetName"]#' cfsqltype = "varchar">,
                    fldDistrict = <cfqueryparam value = '#arguments["district"]#' cfsqltype = "varchar">,
                    fldState = <cfqueryparam value = '#arguments["state"]#' cfsqltype = "varchar">,
                    fldCountry = <cfqueryparam value = '#arguments["country"]#' cfsqltype = "varchar">,
                    fldPincode = <cfqueryparam value = '#arguments["pincode"]#' cfsqltype = "varchar">,
                    fldEmailId = <cfqueryparam value = '#arguments["email"]#' cfsqltype = "varchar">,
                    fldPhoneNumber = <cfqueryparam value = '#arguments["phoneNumber"]#' cfsqltype = "varchar">,
                    fldUpdatedBy = <cfqueryparam value = '#session.userId#' cfsqltype = " bigint">,
                    fldUpdatedOn = <cfqueryparam value = '#local.updateDate#' cfsqltype = "date">
                WHERE
                    fldContact_ID = <cfqueryparam value = '#arguments["editContactId"]#' cfsqltype = "bigint">
                    AND fldUserId = <cfqueryparam value = '#session.userId#' cfsqltype = "bigint">;
            </cfquery>
            <cfcatch type="any">
                <cfset local.resultStruct["error"] = "Error occured while updating">
            </cfcatch>
        </cftry>
        <cfreturn local.resultStruct>
    </cffunction>
</cfcomponent>