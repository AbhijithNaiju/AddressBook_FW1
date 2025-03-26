component{
    public query function getUserDetails(integer userId) {
        qryUserDetails = queryExecute(
            "SELECT  
                fullName,
                profileImage,
                email
            FROM
                userTable
            WHERE 
                userId = :userId",
                {userId = { value = arguments.userId,cfsqltype = 'INTEGER'}}
        )
        return qryUserDetails;
    } 
    public struct function userLogin(string emailId,string password) {
        local.structResult = structNew()
        local.hashedPassword = hash(arguments.password, "SHA-256") 
        local.selectUser = queryExecute(
            "
                SELECT 
                    userId,
                    fullName
                FROM 
                    userTable
                WHERE
                    email = :emailId
                    AND password = :password
            ",{
                emailId = { value = arguments.emailId,cfsqltype = 'varchar'},
                password = { value = local.hashedPassword,cfsqltype = 'varchar'}
            }
        )
        if(local.selectUser.recordcount){
            session.userId = local.selectUser.userId;
            session.userName = local.selectUser.fullName;
            local.structResult["success"] = "success";
        }else{
            local.structResult["error"] = "Please enter a valid email and password";
        }

        return local.structResult;
    } 
}