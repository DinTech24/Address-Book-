<cfcomponent>

    <cffunction  name="addUser" returnType="boolean">
        <cfargument  name="fullName">
        <cfargument  name="emailId">
        <cfargument  name="userName">
        <cfargument  name="password">
        <cfargument  name="profilePicId">
        <cfset local.encryptedPassword = hash("#arguments.password#","sha-256","UTF-8")>
        <cfset local.profilePicId = expandPath("#arguments.profilePicId#")>
        <cfquery name="checkUserExists">
            select count(username) as userCount from userTable 
            where username = '#arguments.userName#' OR emailId = '#arguments.emailId#';
        </cfquery>
        <cfif checkUserExists.userCount EQ 1>
            <cfreturn false>
            <cfelse>
                <cfquery name=registerUser>
                    insert into userTable(name,emailId,username,password,profileImage) values(
                        <cfqueryparam value='#arguments.fullName#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#arguments.emailId#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#arguments.userName#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#local.encryptedPassword#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#local.profilePicId#' cfsqltype="cf_sql_varchar">
                    )
                </cfquery>
        </cfif>
        <cfreturn true>
    </cffunction>

    <cffunction  name="loginUser" returnType="boolean">
        <cfargument  name="userName">
        <cfargument  name="password">
        <cfset local.encryptedPassword = hash("#arguments.password#","sha-256","UTF-8")>
        <cfset session.userName = arguments.userName>
        <cfset session.defaultPath = "Assets/Images/profileImage.png">
        <cfquery name="checkUser">
            select count(username) as userCount from userTable 
            where username = <cfqueryparam value='#arguments.userName#' cfsqltype="cf_sql_varchar"> 
            AND password = <cfqueryparam value='#local.encryptedPassword#' cfsqltype="cf_sql_varchar">;
        </cfquery>
        <cfif checkUser.userCount EQ 1>
            <cflocation  url="./homePage.cfm">
            <cfelse>
                <cfreturn false>
        </cfif>
    </cffunction>

    <cffunction  name="addContacts">
        <cfargument name="structure">
        <cfargument default="#session.defaultPath#" name="profilePic">
        <cfquery name="checkContact">
            select count(emailId) as contactCount from contactTable 
            where emailId = <cfqueryparam value='#arguments.structure["emailId"]#' cfsqltype="cf_sql_varchar"> 
            AND phoneNumber = <cfqueryparam value='#arguments.structure["phone"]#' cfsqltype="cf_sql_varchar">;
        </cfquery>
        <cfif checkContact.contactCount EQ 1>
            <cfreturn false>
            <cfelse>
                <cfquery name="addContact">
                    insert into contactTable(title,firstName,lastName,gender,dateOfBirth,profileImage,address,
                        street,district,state,country,pincode,emailId,phoneNumber,_createdBy,_createdOn) values(
                        <cfqueryparam value='#arguments.structure["selectTitle"]#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#arguments.structure["firstName"]#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#arguments.structure["lastName"]#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#arguments.structure["selectGender"]#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#arguments.structure["dob"]#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#arguments.profilePic#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#arguments.structure["address"]#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#arguments.structure["street"]#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#arguments.structure["district"]#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#arguments.structure["state"]#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#arguments.structure["country"]#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#arguments.structure["pinCode"]#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#arguments.structure["emailId"]#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#arguments.structure["phone"]#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#session.username#' cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value='#dateFormat(now(),"yyyy-mm-dd")#' cfsqltype="cf_sql_date">
                    )
                </cfquery>
        </cfif>

        <!--- ,_UpdatedOn = <cfqueryparam value='#arguments.structure[selectTitle]#' cfsqltype="cf_sql_varchar">  --->
    </cffunction>

    <cffunction  name="listContacts">
        <cfargument  name="structure">
            <cfquery name="addContact">
                select firstName,emailId,phoneNumber from contactTable 
                where _createdBy = <cfqueryparam value='#session.userName#' cfsqltype="cf_sql_varchar"> 
            </cfquery>
    </cffunction>

</cfcomponent>