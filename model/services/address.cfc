component { 
    public query function contactList(any userId) {
        qryContactDetails = queryExecute(
            "SELECT 
                cd.contactId,
                cd.title,
                cd.firstName,
                cd.lastName,
                cd.gender,
                cd.DOB,
                cd.profileImage,
                cd.address,
                cd.streetName,
                cd.district,
                cd.STATE,
                cd.country,
                cd.pincode,
                cd.emailId,
                cd.phoneNumber,
                STRING_AGG(cr.roleId, ',') AS roleIds,
                STRING_AGG(r.name, ',') AS roleNames
            FROM 
                contactDetails AS cd
                LEFT JOIN contactRoles AS cr ON cd.contactId = cr.contactId
                LEFT JOIN roles AS r ON r.roleId = cr.roleId
            WHERE 
                cd._createdBy = :createdBy
                AND cd.active = 1
                GROUP BY 
                    cd.contactId,
                    cd.title,
                    cd.firstName,
                    cd.lastName,
                    cd.gender,
                    cd.DOB,
                    cd.profileImage,
                    cd.address,
                    cd.streetName,
                    cd.district,
                    cd.STATE,
                    cd.country,
                    cd.pincode,
                    cd.emailId,
                    cd.phoneNumber;",
                {createdBy = { value = arguments.userId,cfsqltype = 'INTEGER'}}
        )
        return qryContactDetails;
    } 
}