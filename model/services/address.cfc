<cfcomponent>
<cffunction  name="contactList" returntype = "query">
        <cfargument name = "contactId" default = "" required = "false">
        <cfargument name = "userId" default = "" required = "false">

        <cfquery name = "local.qryContactDetails">
             SELECT 
                <cfif LEN(arguments.userId)>
                    CD.fldPhoneNumber AS phoneNumber,
                    CD.fldTitle AS title,
                    CD.fldGender AS gender,
                    CD.fldDOB AS DOB,
                    CD.fldProfileImage AS profileImage,
                    CD.fldAddress AS address,
                    CD.fldStreetName AS streetName,
                    CD.fldDistrict AS district,
                    CD.fldSTATE AS STATE,
                    CD.fldCountry AS country,
                    CD.fldPincode AS pincode,
                    GROUP_CONCAT(CR.fldRoleId) AS roleIds,
                    GROUP_CONCAT(R.fldName) AS roleNames,
                </cfif>
                CD.fldContact_Id AS contactId,
                CD.fldFirstName AS firstName,
                CD.fldLastName AS lastName,
                CD.fldEmailId AS emailId
            FROM 
                tblContactDetails AS CD
                LEFT JOIN tblContactRoles AS CR ON CD.fldContact_Id = CR.fldContactId
                LEFT JOIN tblRoles AS R ON R.fldRole_ID = CR.fldRoleId
            WHERE 
                <cfif len(arguments.contactId)>
                    CD.fldContactId = <cfqueryparam value = '#arguments.contactId#' cfsqltype = "integer">
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
    <!---     Get all roles for from role table --->
    <cffunction  name="getAllRoles" returntype="query">
        <cfquery name = "local.contactRoles">
            SELECT 
                R.fldRoleId AS role,
                R.fldName AS name
            FROM 
                tblRoles R;
        </cfquery>
        <cfreturn local.contactRoles>
    </cffunction>
<!--- component { 
    public query function contactList(any userId) {
        qryContactDetails = queryExecute(
            "SELECT 
                CD.contactId,
                CD.title,
                CD.firstName,
                CD.lastName,
                CD.gender,
                CD.DOB,
                CD.profileImage,
                CD.address,
                CD.streetName,
                CD.district,
                CD.STATE,
                CD.country,
                CD.pincode,
                CD.emailId,
                CD.phoneNumber,
                STRING_AGG(CR.roleId, ',') AS roleIds,
                STRING_AGG(r.name, ',') AS roleNames
            FROM 
                contactDetails AS CD
                LEFT JOIN contactRoles AS CR ON CD.contactId = CR.contactId
                LEFT JOIN roles AS r ON r.roleId = CR.roleId
            WHERE 
                CD._CReatedBy = :CReatedBy
                AND CD.active = 1
                GROUP BY 
                    CD.contactId,
                    CD.title,
                    CD.firstName,
                    CD.lastName,
                    CD.gender,
                    CD.DOB,
                    CD.profileImage,
                    CD.address,
                    CD.streetName,
                    CD.district,
                    CD.STATE,
                    CD.country,
                    CD.pincode,
                    CD.emailId,
                    CD.phoneNumber;",
                {CReatedBy = { value = arguments.userId,cfsqltype = 'INTEGER'}}
        )
        return qryContactDetails;
    } 
} --->
</cfcomponent>