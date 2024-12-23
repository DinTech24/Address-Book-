<cfcomponent>

    <cffunction name="addUser" returnType="boolean">
        <cfargument  name="fullName">
        <cfargument  name="emailId">
        <cfargument  name="userName">
        <cfargument  name="password">
        <cfargument  name="profilePicId">
        <cfset local.encryptedPassword = hash("#arguments.password#","sha-256","UTF-8")>
        <cfquery name="checkUserExists">
            SELECT count(username) AS userCount
            FROM userTable
            WHERE username = <cfqueryparam value = '#arguments.userName#' cfsqltype = "cf_sql_varchar">
                OR emailId = <cfqueryparam value = '#arguments.emailId#' cfsqltype = "cf_sql_varchar">;
        </cfquery>
        <cfif checkUserExists.userCount>
            <cfreturn false>
            <cfelse>
                <cfquery name=registerUser>
                    INSERT INTO userTable (
                        name,
                        emailId,
                        username,
                        password,
                        profileImage
                        )
                    VALUES (
                        <cfqueryparam value = '#arguments.fullName#' cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = '#arguments.emailId#' cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = '#arguments.userName#' cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = '#local.encryptedPassword#' cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = '#arguments.profilePicId#' cfsqltype = "cf_sql_varchar">
                        )
                </cfquery>
        </cfif>
        <cfreturn true>
    </cffunction>

    <cffunction name="loginUser" returnType="boolean">
        <cfargument  name="userName">
        <cfargument  name="password">
        <cfset local.encryptedPassword = hash("#arguments.password#","sha-256","UTF-8")>
        <cfquery name="checkUser">
            SELECT count(username) AS userCount
            FROM userTable
            WHERE username = <cfqueryparam value = '#arguments.userName#' cfsqltype = "cf_sql_varchar">
                AND password = <cfqueryparam value = '#local.encryptedPassword#' cfsqltype = "cf_sql_varchar">;
        </cfquery>
        <cfquery name="selectEmailId">
            SELECT emailId
            FROM userTable
            WHERE username = <cfqueryparam value = '#arguments.userName#' cfsqltype = "cf_sql_varchar">
        </cfquery>
        <cfset session.userEmailId = selectEmailId.emailId>
        <cfif checkUser.userCount EQ 1>
            <cfset session.userName = arguments.userName>
            <cfset session.login = true>
            <cflocation url="./homePage.cfm">
            <cfelse>
                <cfreturn false>
        </cfif>
    </cffunction>

    <cffunction  name="ssoLoginUser" returntype="boolean">
        <cfquery name="selectExistsEmailId">
            SELECT count(emailId) AS emailCount
            FROM userTable
            WHERE emailId = <cfqueryparam value = '#session.ssoVariable.other.email#' cfsqltype = "cf_sql_varchar">
                AND loginType IS NULL 
        </cfquery>
        <cfquery name="selectEmailId">
            SELECT count(emailId) AS emailSsoCount
            FROM userTable
            WHERE emailId = <cfqueryparam value = '#session.ssoVariable.other.email#' cfsqltype = "cf_sql_varchar">
                AND loginType = <cfqueryparam value = 'ssoGoogle' cfsqltype = "cf_sql_varchar">
        </cfquery>
        <cfif selectExistsEmailId.emailCount GT 0>
            <cfreturn false>
            <cfelse>
                <cfif selectEmailId.emailSsoCount EQ 0>
                    <cfquery name=registerUser>
                        INSERT INTO userTable (
                            name,
                            username,
                            emailId,
                            profileImage,
                            loginType
                            )
                        VALUES (
                            <cfqueryparam value = '#session.ssoVariable.name#' cfsqltype = "cf_sql_varchar">,
                            <cfqueryparam value = '#session.ssoVariable.id#' cfsqltype = "cf_sql_varchar">,
                            <cfqueryparam value = '#session.ssoVariable.other.email#' cfsqltype = "cf_sql_varchar">,
                            <cfqueryparam value = '#session.ssoVariable.other.picture#' cfsqltype = "cf_sql_varchar">,
                            <cfqueryparam value = 'ssoGoogle' cfsqltype = "cf_sql_varchar">
                            )
                    </cfquery>
                    <cfset session.userEmailId = session.ssoVariable.other.email>
                    <cfset session.userName = session.ssoVariable.id>
                    <cfset session.login = true>
                    <cfreturn true>
                    <cfelseif selectEmailId.emailSsoCount EQ 1>
                        <cfset session.userEmailId = session.ssoVariable.other.email>
                        <cfset session.userName = session.ssoVariable.id>
                        <cfset session.login = true>
                        <cfreturn true>
                    <cfelse>
                        <cfreturn false>
                </cfif>
        </cfif>
    </cffunction>

    <cffunction name="checkUser" returnType="boolean">
        <cfargument name="email">
        <cfargument name="phone">
        <cfif arguments.email NEQ session.userEmailId>
            <cfquery name="userExists">
                SELECT count(contactId) AS userCount
                FROM contactTable
                WHERE _createdBy = <cfqueryparam value = '#session.username#' cfsqltype = "cf_sql_varchar">
                    AND (emailId = <cfqueryparam value = '#arguments.email#' cfsqltype = "cf_sql_varchar">
                    OR phoneNumber = <cfqueryparam value = '#arguments.phone#' cfsqltype = "cf_sql_varchar">)
            </cfquery>
            <cfif userExists.userCount GT 0>
                <cfreturn true>
                <cfelse>
                    <cfreturn false>
            </cfif>
            <cfelse>
                <cfreturn true>
        </cfif>
    </cffunction>

    <cffunction name="checkEditUser" returnType="boolean">
        <cfargument name="email">
        <cfargument name="phone">
        <cfargument name="contactId">
        <cfif arguments.email NEQ session.userEmailId>
            <cfquery name="userEditExists">
                SELECT count(contactId) AS userCount
                FROM contactTable
                WHERE _createdBy = <cfqueryparam value = '#session.username#' cfsqltype = "cf_sql_varchar" >
                    AND contactId != <cfqueryparam value = '#arguments.contactId#' cfsqltype = "cf_sql_varchar" >
                    AND (emailId = <cfqueryparam value = '#arguments.email#' cfsqltype = "cf_sql_varchar" >
                    OR phoneNumber = <cfqueryparam value = '#arguments.phone#' cfsqltype = "cf_sql_varchar" >);
            </cfquery>
            <cfif userEditExists.userCount GT 0>
                <cfreturn true>
                <cfelse>
                    <cfreturn false>
            </cfif>
            <cfelse>
                <cfreturn true>
        </cfif>
    </cffunction>

    <cffunction name="addContacts" returnType="boolean">
        <cfargument name="structure">
        <cfargument name="profilePic">
        <cfquery name="addContact">
            INSERT INTO contactTable (
                title,
                firstName,
                lastName,
                gender,
                dateOfBirth,
                profileImage,
                address,
                street,
                district,
                STATE,
                country,
                pincode,
                emailId,
                phoneNumber,
                _createdBy,
                _createdOn
                )
            VALUES (
                <cfqueryparam value = '#arguments.structure["selectTitle"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["firstName"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["lastName"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["selectGender"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["dob"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.profilePic#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["address"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["street"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["district"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["state"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["country"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["pinCode"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["emailId"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["phone"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#session.username#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#dateFormat(now(),"yyyy-mm-dd")#' cfsqltype = "cf_sql_date">
                )
        </cfquery>
        <cfloop list="#structure["roleSelector"]#" item="item" delimiters=",">
            <cfquery name="enterRoles">
                insert into contactsRoleTable values(
                    <cfqueryparam value = '#item#' cfsqltype = "cf_sql_varchar">,
                    (
                        select contactId from contactTable 
                        where emailId = <cfqueryparam value = '#arguments.structure["emailId"]#' cfsqltype = "cf_sql_varchar">
                            AND _createdBy = <cfqueryparam value = '#session.username#' cfsqltype = "cf_sql_varchar">
                    )
                )
            </cfquery>
        </cfloop>
        <cflocation url="./homePage.cfm">
    </cffunction>

    <cffunction name="displayHomepage" returnType="query">
        <cfquery name="displayUser">
            SELECT name
                ,profileImage
            FROM userTable
            WHERE username = <cfqueryparam value = '#session.userName#' cfsqltype = "cf_sql_varchar" >
        </cfquery>
        <cfreturn displayUser>
    </cffunction>

    <cffunction name="displayContact" returnType="query">
        <cfquery name="addContact">
            SELECT contactId,
                firstName,
                lastName,
                emailId,
                phoneNumber,
                profileImage
            FROM contactTable
            WHERE _createdBy = <cfqueryparam value = '#session.userName#' cfsqltype = "cf_sql_varchar">
        </cfquery>
        <cfreturn addContact>
    </cffunction>

    <cffunction name="deleteContact" access="remote" returnType="boolean">
        <cfargument name="contactId">
        <cfquery name="deleteRoles">
            delete from contactsRoleTable 
            where contactId = <cfqueryparam value = '#arguments.contactId#' cfsqltype = "cf_sql_varchar">
        </cfquery>
        <cfquery name="deleteQuery">
            DELETE
            FROM contactTable
            WHERE contactId = <cfqueryparam value = '#arguments.contactId#' cfsqltype = "cf_sql_varchar">
        </cfquery>
        <cfreturn true>
    </cffunction>

    <cffunction  name="getAllDetails" returnType="query">
        <cfargument  name="contactId" default="empty">
        <cfquery name="getDetailsQuery">
            SELECT title,
                firstName,
                lastName,
                gender,
                dateOfBirth,
                profileImage,
                address,
                street,
                district,
                STATE,
                country,
                pincode,
                emailId,
                phoneNumber,
                _createdBy,
                contactId
            FROM contactTable            
            <cfif arguments.contactId EQ "empty">
                WHERE _createdBy = <cfqueryparam value = '#session.username#' cfsqltype = "cf_sql_varchar">
                <cfelse>
                    WHERE ContactId = <cfqueryparam value = '#arguments.contactId#' cfsqltype = "cf_sql_varchar">
            </cfif>
        </cfquery>
        <cfreturn getDetailsQuery>
    </cffunction>

    <cffunction  name="joinRoles" access="remote" returnFormat="JSON">
        <cfargument name="contactIdModal">
        <cfquery name="getRoleQuery">
            select RoleTable.roleName,contactsRoleTable.roleId,contactsRoleTable.contactId from RoleTable 
            inner join contactsRoleTable on RoleTable.roleId = contactsRoleTable.roleId 
            where contactsRoleTable.contactId = <cfqueryparam value = '#arguments.contactIdModal#' cfsqltype = "cf_sql_varchar">
        </cfquery>
        <cfreturn getRoleQuery>
    </cffunction>

    <cffunction  name="getRolesFunction">
        <cfquery name = "getRolesQuery">
            select roleId,roleName from roleTable;
        </cfquery>
        <cfreturn getRolesQuery>
    </cffunction>

    <cffunction name="viewModal" access="remote" returnFormat="JSON" returnType="struct">
        <cfargument name="contactIdModal">
        <cfset local.structure = structNew()>
        <cfset local.viewQuery = getAllDetails(arguments.contactIdModal)>
        <cfset local.roleQuery = joinRoles(arguments.contactIdModal)>
        <cfset local.roleIdArray = arrayNew(1)>
        <cfset local.structure["title"] = local.viewQuery.title>
        <cfset local.structure["firstName"] = local.viewQuery.firstName>
        <cfset local.structure["lastName"] = local.viewQuery.lastName>
        <cfset local.structure["gender"] = local.viewQuery.gender>
        <cfset local.structure["dateOfBirth"] = dateFormat(local.viewQuery.dateOfBirth,"yyyy-mm-dd")>
        <cfset local.structure["profileImage"] = local.viewQuery.profileImage>
        <cfset local.structure["address"] = local.viewQuery.address>
        <cfset local.structure["street"] = local.viewQuery.street>
        <cfset local.structure["state"] = local.viewQuery.state>
        <cfset local.structure["district"] = local.viewQuery.district>
        <cfset local.structure["country"] = local.viewQuery.country>
        <cfset local.structure["pincode"] = local.viewQuery.pincode>
        <cfset local.structure["emailId"] = local.viewQuery.emailId>
        <cfset local.structure["phoneNumber"] = local.viewQuery.phoneNumber>
        <cfset local.structure["createSubmitId"] = arguments.contactIdModal>
        <cfloop query="#local.roleQuery#">
            <cfset arrayAppend(local.roleIdArray, local.roleQuery.roleId)>
        </cfloop>
        <cfset local.structure["joinQuery"] = local.roleIdArray>
        <cfset local.structure["roles"] = "">
        <cfloop query="local.roleQuery">
            <cfif local.structure["roles"] EQ "">
                <cfset local.structure["roles"] = local.structure["roles"] & getRoleQuery.roleName>
                <cfelse>
                    <cfset local.structure["roles"] = local.structure["roles"] & "," & getRoleQuery.roleName>
            </cfif>
        </cfloop>
        <cfreturn local.structure>
    </cffunction>

    <cffunction name="editContacts">
        <cfargument name="structure">
        <cfargument name="profilePic">
        <cfquery name="editContact">
            UPDATE contactTable
            SET title = <cfqueryparam value = '#arguments.structure["selectTitle"]#' cfsqltype = "cf_sql_varchar">,
                firstName = <cfqueryparam value = '#arguments.structure["firstName"]#' cfsqltype = "cf_sql_varchar">,
                lastName = <cfqueryparam value = '#arguments.structure["lastName"]#' cfsqltype = "cf_sql_varchar">,
                gender = <cfqueryparam value = '#arguments.structure["selectGender"]#' cfsqltype = "cf_sql_varchar">,
                dateOfBirth = <cfqueryparam value = '#arguments.structure["dob"]#' cfsqltype = "cf_sql_varchar">,
                profileImage = <cfqueryparam value = '#arguments.profilePic#' cfsqltype = "cf_sql_varchar">,
                address = <cfqueryparam value = '#arguments.structure["address"]#' cfsqltype = "cf_sql_varchar">,
                street = <cfqueryparam value = '#arguments.structure["street"]#' cfsqltype = "cf_sql_varchar">,
                district = <cfqueryparam value = '#arguments.structure["district"]#' cfsqltype = "cf_sql_varchar">,
                STATE = <cfqueryparam value = '#arguments.structure["state"]#' cfsqltype = "cf_sql_varchar">,
                country = <cfqueryparam value = '#arguments.structure["country"]#' cfsqltype = "cf_sql_varchar">,
                pincode = <cfqueryparam value = '#arguments.structure["pinCode"]#' cfsqltype = "cf_sql_varchar">,
                emailId = <cfqueryparam value = '#arguments.structure["emailId"]#' cfsqltype = "cf_sql_varchar">,
                phoneNumber = <cfqueryparam value = '#arguments.structure["phone"]#' cfsqltype = "cf_sql_varchar">,
                _UpdatedOn = <cfqueryparam value = '#dateFormat(now(),"yyyy-mm-dd")#' cfsqltype = "cf_sql_varchar">
            WHERE contactId = <cfqueryparam value = '#arguments.structure["editSubmit"]#' cfsqltype = "cf_sql_varchar">
        </cfquery>
        <cfquery name="deleteRoles">
            delete from contactsRoleTable 
            where contactId = <cfqueryparam value = '#arguments.structure["editSubmit"]#' cfsqltype = "cf_sql_varchar">
        </cfquery>
        <cfloop list="#structure["roleSelector"]#" item="item" delimiters=",">
            <cfquery name="updateRoles">
                insert into contactsRoleTable values(
                    <cfqueryparam value = '#item#' cfsqltype = "cf_sql_varchar">,
                    (
                        select contactId from contactTable 
                        where emailId = <cfqueryparam value = '#arguments.structure["emailId"]#' cfsqltype = "cf_sql_varchar">
                            AND _createdBy = <cfqueryparam value = '#session.username#' cfsqltype = "cf_sql_varchar">
                    )
                )
            </cfquery>
        </cfloop>
        <cflocation url="./homePage.cfm">
    </cffunction>

    <cffunction name="SpreadSheet" access="remote" returnType="void">
        <cfset local.details = getAllDetails()>
        <cfset local.spreadSheet = "#local.details._createdBy# -" & "#dateTimeFormat(now(),"dd-mm-yyy-HH.nn.ss")#" & ".xlsx">
        <cfset local.filePath = ExpandPath("../Spreadsheets/" & #local.spreadSheet#)>
        <cfset local.rolesArray = arrayNew(1)>
        <cfloop query="local.details">
            <cfset local.getRolQuery = joinRoles(local.details.contactId)>
            <cfset local.role = "">
            <cfloop query="local.getRolQuery">
                <cfif local.role EQ "">
                    <cfset local.role = local.role & getRolQuery.roleName>
                    <cfelse>
                        <cfset local.role = local.role & "," & getRolQuery.roleName>
                </cfif>
            </cfloop>
            <cfset arrayAppend(local.rolesArray,local.role)>
        </cfloop>
        <cfset queryAddColumn(local.details, "Roles", local.rolesArray)>
        <cfspreadsheet action="write" query="local.details" filename="#local.filePath#" overwrite="no">
    </cffunction>

    <cffunction name="printPdf" returnType="query">
        <cfset local.details = getAllDetails()>
        <cfreturn local.details>
    </cffunction>

    <cffunction  name="scheduleWish" returnType="void">
        <cfset local.dateToday = dateFormat(now(),"mm-dd")>
        <cfquery name="selectDob">
            select emailId,firstName,dateOfBirth from contactTable
        </cfquery>
        <cfloop query="selectDob">
            <cfif dateFormat(selectDob.dateOfBirth,"mm-dd")>
                <cfmail  from="dinilvallikunnil@gmail.com"  subject="Birthday Wishes"  to="#selectDob.emailId#" mimeattach="/Assets/Images/birthdayWish.jpg">
                    Happy birthday dear #selectDob.firstName#
                </cfmail>
            </cfif>
        </cfloop>
    </cffunction>

    <cffunction  name="scheduleTask" returnType="void">
        <cfschedule  
        action="update"  
        task="schedule" 
        operation="HTTPRequest" 
        url="http://addressbook.org/scheduleEmail.cfm"
        startDate="#dateFormat(now(),"yyyy-mm-dd")#"
        interval="daily"
        repeat="0"
        overwrite="true">
    </cffunction>

    <cffunction name="logout" access="remote" returnType="boolean">
        <cfset structClear(session)>
        <cfreturn true>
    </cffunction>

</cfcomponent>