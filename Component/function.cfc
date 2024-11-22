<cfcomponent>

    <cffunction  name="addUser" returnType="boolean">
        <cfargument  name="fullName">
        <cfargument  name="emailId">
        <cfargument  name="userName">
        <cfargument  name="password">
        <cfargument  name="profilePicId">
        <cfset local.encryptedPassword = hash("#arguments.password#","sha-256","UTF-8")>
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
                        <cfqueryparam value='#arguments.profilePicId#' cfsqltype="cf_sql_varchar">
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
    </cffunction>

    <cffunction  name="displayHomepage">
        <cfquery name="displayUser">
            select name,profileImage from userTable where username = '#session.username#'
        </cfquery>
        <cfquery name="addContact">
            select firstName,emailId,phoneNumber from contactTable 
            where _createdBy = <cfqueryparam value='#session.userName#' cfsqltype="cf_sql_varchar"> 
        </cfquery>
        <cfreturn displayUser>
    </cffunction>

    <cffunction  name="displayContact">
        <cfquery name="addContact">
            select contactId,firstName,lastName,emailId,phoneNumber,profileImage from contactTable 
            where _createdBy = <cfqueryparam value='#session.userName#' cfsqltype="cf_sql_varchar"> 
        </cfquery>
        <cfreturn addContact>
    </cffunction>

    <cffunction  name="deleteContact" access="remote" returnType="boolean">
        <cfargument name="contactId">
        <cfquery name="deleteQuery">
            delete from contactTable where contactId = <cfqueryparam value='#arguments.contactId#' cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn true>
    </cffunction>

    <cffunction  name="viewModal" access="remote" returnFormat="JSON">
        <cfargument name="contactIdModal">
        <cfset local.structure = structNew()>
        <cfquery name="viewQuery">
            select title ,firstName ,lastName ,gender ,dateOfBirth ,profileImage,address ,street ,district ,state ,country ,pincode ,emailId ,phoneNumber 
            from contactTable where ContactId ='#arguments.contactIdModal#'
        </cfquery>
        <cfset local.structure["title"] = viewQuery.title>
        <cfset local.structure["firstName"] = viewQuery.firstName>
        <cfset local.structure["lastName"] = viewQuery.lastName>
        <cfset local.structure["gender"] = viewQuery.gender>
        <cfset local.structure["dateOfBirth"] = dateFormat(viewQuery.dateOfBirth,"dd-mm-yyyy")>
        <cfset local.structure["profileImage"] = viewQuery.profileImage>
        <cfset local.structure["address"] = viewQuery.address>
        <cfset local.structure["street"] = viewQuery.street>
        <cfset local.structure["state"] = viewQuery.state>
        <cfset local.structure["district"] = viewQuery.district>
        <cfset local.structure["country"] = viewQuery.country>
        <cfset local.structure["pincode"] = viewQuery.pincode>
        <cfset local.structure["emailId"] = viewQuery.emailId>
        <cfset local.structure["phoneNumber"] = viewQuery.phoneNumber>
        <cfreturn local.structure>
    </cffunction>

    <cffunction  name="editModal"  access="remote" returnFormat="JSON">
        <cfargument  name="contactId">
        <cfset local.structure = structNew()>
        <cfquery name="editModalQuery">
            select title ,firstName ,lastName ,gender ,dateOfBirth ,profileImage,address ,street ,district ,state ,country ,pincode ,emailId ,phoneNumber 
            from contactTable where ContactId ='#arguments.contactId#'
        </cfquery>
        <cfset local.structure["title"] = editModalQuery.title>
        <cfset local.structure["firstName"] = editModalQuery.firstName>
        <cfset local.structure["lastName"] = editModalQuery.lastName>
        <cfset local.structure["gender"] = editModalQuery.gender>
        <cfset local.structure["dateOfBirth"] =dateFormat(editModalQuery.dateOfBirth,"yyyy-mm-dd")>
        <cfset local.structure["profileImage"] = editModalQuery.profileImage>
        <cfset local.structure["address"] = editModalQuery.address>
        <cfset local.structure["street"] = editModalQuery.street>
        <cfset local.structure["state"] = editModalQuery.state>
        <cfset local.structure["district"] = editModalQuery.district>
        <cfset local.structure["country"] = editModalQuery.country>
        <cfset local.structure["pincode"] = editModalQuery.pincode>
        <cfset local.structure["emailId"] = editModalQuery.emailId>
        <cfset local.structure["phoneNumber"] = editModalQuery.phoneNumber>
        <cfset local.structure["createSubmitId"] = arguments.contactId>
        <cfreturn local.structure>
    </cffunction>

    <cffunction name="editContacts">
        <cfargument name="structure">
        <cfargument default="#session.defaultPath#" name="profilePic">
        <cfquery name="editContact">
            update contactTable set
                title = <cfqueryparam value='#arguments.structure["selectTitle"]#' cfsqltype="cf_sql_varchar">,
                firstName = <cfqueryparam value='#arguments.structure["firstName"]#' cfsqltype="cf_sql_varchar">,
                lastName = <cfqueryparam value='#arguments.structure["lastName"]#' cfsqltype="cf_sql_varchar">,
                gender = <cfqueryparam value='#arguments.structure["selectGender"]#' cfsqltype="cf_sql_varchar">,
                dateOfBirth = <cfqueryparam value='#arguments.structure["dob"]#' cfsqltype="cf_sql_varchar">,
                profileImage = <cfqueryparam value='#arguments.profilePic#' cfsqltype="cf_sql_varchar">,
                address = <cfqueryparam value='#arguments.structure["address"]#' cfsqltype="cf_sql_varchar">,
                street = <cfqueryparam value='#arguments.structure["street"]#' cfsqltype="cf_sql_varchar">,
                district = <cfqueryparam value='#arguments.structure["district"]#' cfsqltype="cf_sql_varchar">,
                state = <cfqueryparam value='#arguments.structure["state"]#' cfsqltype="cf_sql_varchar">,
                country = <cfqueryparam value='#arguments.structure["country"]#' cfsqltype="cf_sql_varchar">,
                pincode = <cfqueryparam value='#arguments.structure["pinCode"]#' cfsqltype="cf_sql_varchar">,
                emailId = <cfqueryparam value='#arguments.structure["emailId"]#' cfsqltype="cf_sql_varchar">,
                phoneNumber = <cfqueryparam value='#arguments.structure["phone"]#' cfsqltype="cf_sql_varchar">,
                _createdBy = <cfqueryparam value='#session.username#' cfsqltype="cf_sql_varchar">,
                _createdOn = <cfqueryparam value='#dateFormat(now(),"yyyy-mm-dd")#' cfsqltype="cf_sql_date">,
                _UpdatedOn = <cfqueryparam value='#arguments.structure[selectTitle]#' cfsqltype="cf_sql_varchar"> 
            where contactId = '#arguments.structure[editSubmit]#'
        </cfquery>
    </cffunction>

    <cffunction  name="logout">
        <cfset structClear(session)>
        <cflocation url="./Login.cfm">
    </cffunction>

</cfcomponent>