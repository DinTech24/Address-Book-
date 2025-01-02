<cfcomponent>

    <cffunction name="addUser" returnType="boolean">
        <cfargument  name="fullName">
        <cfargument  name="emailId">
        <cfargument  name="userName">
        <cfargument  name="password">
        <cfargument  name="profilePicId">
        <cfset local.encryptedPassword = hash("#arguments.password#","sha-256","UTF-8")>
        <cfquery name="local.checkUserExists">
            SELECT 
                count(username) AS userCount
            FROM 
                userTable
            WHERE   
                username = <cfqueryparam value = '#arguments.userName#' cfsqltype = "cf_sql_varchar">
                OR emailId = <cfqueryparam value = '#arguments.emailId#' cfsqltype = "cf_sql_varchar">;
        </cfquery>
        <cfif local.checkUserExists.userCount>
            <cfreturn false>
            <cfelse>
                <cfquery name=local.registerUser>
                    INSERT INTO 
                        userTable (
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
        <cfquery name="local.checkUser">
            SELECT 
                count(username) AS userCount
            FROM 
                userTable
            WHERE 
                username = <cfqueryparam value = '#arguments.userName#' cfsqltype = "cf_sql_varchar">
                AND password = <cfqueryparam value = '#local.encryptedPassword#' cfsqltype = "cf_sql_varchar">;
        </cfquery>
        <cfquery name="local.selectEmailId">
            SELECT 
                emailId
            FROM 
                userTable
            WHERE 
                username = <cfqueryparam value = '#arguments.userName#' cfsqltype = "cf_sql_varchar">
        </cfquery>
        <cfset session.userEmailId = local.selectEmailId.emailId>
        <cfif local.checkUser.userCount EQ 1>
            <cfset session.userName = arguments.userName>
            <cfset session.login = true>
            <cflocation url="./homePage.cfm">
            <cfelse>
                <cfreturn false>
        </cfif>
    </cffunction>

    <cffunction  name="ssoLoginUser" returntype="boolean">
        <cfquery name="local.selectExistsEmailId">
            SELECT 
                count(emailId) AS emailCount
            FROM 
                userTable
            WHERE 
                emailId = <cfqueryparam value = '#session.ssoVariable.other.email#' cfsqltype = "cf_sql_varchar">
                AND loginType IS NULL 
        </cfquery>
        <cfquery name="local.selectEmailId">
            SELECT 
                count(emailId) AS emailSsoCount
            FROM 
                userTable
            WHERE 
                emailId = <cfqueryparam value = '#session.ssoVariable.other.email#' cfsqltype = "cf_sql_varchar">
                AND loginType = <cfqueryparam value = 'ssoGoogle' cfsqltype = "cf_sql_varchar">
        </cfquery>
        <cfif local.selectExistsEmailId.emailCount GT 0>
            <cfreturn false>
            <cfelse>
                <cfif local.selectEmailId.emailSsoCount EQ 0>
                    <cfquery name=local.registerUser>
                        INSERT INTO 
                            userTable (
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
                    <cfelseif local.selectEmailId.emailSsoCount EQ 1>
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
            <cfquery name="local.userExists">
                SELECT 
                    count(contactId) AS userCount
                FROM 
                    contactTable
                WHERE 
                    _createdBy = <cfqueryparam value = '#session.username#' cfsqltype = "cf_sql_varchar">
                    AND active = <cfqueryparam value = '1' cfsqltype = "cf_sql_integer">
                    AND (emailId = <cfqueryparam value = '#arguments.email#' cfsqltype = "cf_sql_varchar">
                    OR phoneNumber = <cfqueryparam value = '#arguments.phone#' cfsqltype = "cf_sql_varchar">)
            </cfquery>
            <cfif local.userExists.userCount GT 0>
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
            <cfquery name="local.userEditExists">
                SELECT 
                    count(contactId) AS userCount
                FROM 
                    contactTable
                WHERE 
                    _createdBy = <cfqueryparam value = '#session.username#' cfsqltype = "cf_sql_varchar" >
                    AND contactId != <cfqueryparam value = '#arguments.contactId#' cfsqltype = "cf_sql_varchar" >
                    AND active = <cfqueryparam value = '1' cfsqltype = "cf_sql_integer">
                    AND (emailId = <cfqueryparam value = '#arguments.email#' cfsqltype = "cf_sql_varchar" >
                    OR phoneNumber = <cfqueryparam value = '#arguments.phone#' cfsqltype = "cf_sql_varchar" >);
            </cfquery>
            <cfif local.userEditExists.userCount GT 0>
                <cfreturn true>
                <cfelse>
                    <cfreturn false>
            </cfif>
            <cfelse>
                <cfreturn true>
        </cfif>
    </cffunction>

    <cffunction name="addContacts">
        <cfargument name="structure">
        <cfquery name="local.addContact" result = "generatedVal">
            INSERT INTO 
                contactTable (
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
                _createdOn,
                active
                )
            VALUES (
                <cfqueryparam value = '#arguments.structure["selectTitle"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["firstName"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["lastName"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["selectGender"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["dob"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["profilePic"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["address"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["street"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["district"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["state"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["country"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["pinCode"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["emailId"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#arguments.structure["phone"]#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#session.username#' cfsqltype = "cf_sql_varchar">,
                <cfqueryparam value = '#dateFormat(now(),"yyyy-mm-dd")#' cfsqltype = "cf_sql_date">,
                <cfqueryparam value = '1' cfsqltype = "cf_sql_integer">
                )
        </cfquery>
        <cfloop list="#structure["roleSelector"]#" item="item" delimiters=",">
            <cfquery name="local.enterRoles">
                INSERT INTO
                    contactsRoleTable 
                    values(
                    <cfqueryparam value = '#generatedVal.generatedkey#' cfsqltype = "cf_sql_integer">
                    ,<cfqueryparam value = '#item#' cfsqltype = "cf_sql_integer">
                    )
            </cfquery>
        </cfloop>
    </cffunction>

    <cffunction name="displayHomepage" returnType="query">
        <cfquery name="local.displayUser">
            SELECT 
                name
                ,profileImage
            FROM 
                userTable
            WHERE 
                username = <cfqueryparam value = '#session.userName#' cfsqltype = "cf_sql_varchar" >
        </cfquery>
        <cfreturn local.displayUser>
    </cffunction>

    <cffunction name="displayContact" returnType="query">
        <cfquery name="local.addContact">
            SELECT 
                contactId,
                firstName,
                lastName,
                emailId,
                phoneNumber,
                profileImage
            FROM 
                contactTable
            WHERE 
                _createdBy = <cfqueryparam value = '#session.userName#' cfsqltype = "cf_sql_varchar">
        </cfquery>
        <cfreturn local.addContact>
    </cffunction>

    <cffunction name="deleteContact" access="remote" returnType="boolean">
        <cfargument name="contactId">
        <cfquery name="local.deleteRoles">
            update 
                contactTable set active = <cfqueryparam value = 0 cfsqltype = "cf_sql_integer"> 
            WHERE 
                contactId = <cfqueryparam value = '#arguments.contactId#' cfsqltype = "cf_sql_integer">;
        </cfquery>
        <cfreturn true>
    </cffunction>

    <cffunction  name="getAllDetails" returnType="query">
        <cfargument  name="contactId" default="empty">
        <cfquery name="local.getDetailsQuery">
            SELECT 
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
                ct.contactId,
                string_agg(crt.roleId,',') AS roleId,
                string_agg(rt.roleName, ',') AS roleName
            FROM 
                contactTable as ct
            LEFT JOIN 
                contactsRoleTable as crt ON ct.contactId = crt.contactId
            LEFT JOIN 
                RoleTable as rt ON crt.roleId = rt.roleId 
            <cfif arguments.contactId EQ "empty">
                WHERE 
                    _createdBy = <cfqueryparam value = '#session.username#' cfsqltype = "cf_sql_varchar" >
                    AND active = <cfqueryparam value = 1 cfsqltype = "cf_sql_integer">
                     
                    <cfelse>
                WHERE 
                    ct.ContactId = <cfqueryparam value = '#arguments.contactId#' cfsqltype = "cf_sql_varchar">
                    AND active = <cfqueryparam value = 1 cfsqltype = "cf_sql_integer"> 
            </cfif>
            GROUP BY 
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
                ct.contactId,
                _createdBy
        </cfquery>
        <cfreturn local.getDetailsQuery>
    </cffunction>

    <cffunction  name="getRolesFunction">
        <cfquery name = "local.getRolesQuery">
            SELECT 
                roleId,
                roleName 
            FROM 
                roleTable;
        </cfquery>
        <cfreturn local.getRolesQuery>
    </cffunction>

    <cffunction name="viewModal" access="remote" returnFormat="JSON" returnType="struct">
        <cfargument name="contactIdModal">
        <cfargument  name="editval" default="#false#">
        <cfset local.structure = structNew()>
        <cfset local.viewQuery = getAllDetails(arguments.contactIdModal)>
        <cfset local.roleIdArray = arrayNew(1)>
        <cfset local.structure["title"] = local.viewQuery.title>
        <cfset local.structure["firstName"] = local.viewQuery.firstName>
        <cfset local.structure["lastName"] = local.viewQuery.lastName>
        <cfset local.structure["gender"] = local.viewQuery.gender>
        <cfif arguments.editVal EQ true>
            <cfset local.structure["dateOfBirth"] = dateFormat(local.viewQuery.dateOfBirth,"yyyy-mm-dd")>
            <cfelse>
                <cfset local.structure["dateOfBirth"] = dateFormat(local.viewQuery.dateOfBirth,"dd-mm-yyyy")>
        </cfif>
        
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
        <cfset local.structure["roles"] = local.viewQuery.roleName>
         <cfset local.structure["joinQuery"] = local.viewQuery.roleId>
        <cfreturn local.structure>
    </cffunction>

    <cffunction name="editContacts">
        <cfargument name="structure">
        <cfquery name = "local.editContact">
            UPDATE
                contactTable
            SET
                title = <cfqueryparam value = '#arguments.structure["selectTitle"]#' cfsqltype = "cf_sql_varchar">,
                firstName = <cfqueryparam value = '#arguments.structure["firstName"]#' cfsqltype = "cf_sql_varchar">,
                lastName = <cfqueryparam value = '#arguments.structure["lastName"]#' cfsqltype = "cf_sql_varchar">,
                gender = <cfqueryparam value = '#arguments.structure["selectGender"]#' cfsqltype = "cf_sql_varchar">,
                dateOfBirth = <cfqueryparam value = '#arguments.structure["dob"]#' cfsqltype = "cf_sql_varchar">,
                <cfif arguments.structure["profileImage"] NEQ "">
                    profileImage = <cfqueryparam value = '#arguments.structure["profileImage"]#' cfsqltype = "cf_sql_varchar">,
                </cfif>
                address = <cfqueryparam value = '#arguments.structure["address"]#' cfsqltype = "cf_sql_varchar">,
                street = <cfqueryparam value = '#arguments.structure["street"]#' cfsqltype = "cf_sql_varchar">,
                district = <cfqueryparam value = '#arguments.structure["district"]#' cfsqltype = "cf_sql_varchar">,
                STATE = <cfqueryparam value = '#arguments.structure["state"]#' cfsqltype = "cf_sql_varchar">,
                country = <cfqueryparam value = '#arguments.structure["country"]#' cfsqltype = "cf_sql_varchar">,
                pincode = <cfqueryparam value = '#arguments.structure["pinCode"]#' cfsqltype = "cf_sql_varchar">,
                emailId = <cfqueryparam value = '#arguments.structure["emailId"]#' cfsqltype = "cf_sql_varchar">,
                phoneNumber = <cfqueryparam value = '#arguments.structure["phone"]#' cfsqltype = "cf_sql_varchar">,
                _UpdatedOn = <cfqueryparam value = '#dateFormat(now(),"yyyy-mm-dd")#' cfsqltype = "cf_sql_varchar">
            WHERE 
                contactId = <cfqueryparam value = '#arguments.structure["editSubmit"]#' cfsqltype = "cf_sql_varchar">
        </cfquery>
        <cfquery name="local.deleteRoles">
            delete from contactsRoleTable 
            where contactId = <cfqueryparam value = '#arguments.structure["editSubmit"]#' cfsqltype = "cf_sql_varchar">
        </cfquery>
        <cfloop list="#structure["roleSelector"]#" item="item" delimiters=",">
            <cfquery name="local.updateRoles">
                insert into contactsRoleTable values(
                    <cfqueryparam value = '#arguments.structure["editSubmit"]#' cfsqltype = "cf_sql_integer">
                    ,<cfqueryparam value = '#item#' cfsqltype = "cf_sql_integer">
                )
            </cfquery>
        </cfloop>
    </cffunction>

    <cffunction name="SpreadSheet" access="remote" returnType="void">
        <cfset local.details = getAllDetails()>
        <cfset local.spreadSheet = "#local.details._createdBy# -" & "#dateTimeFormat(now(),"dd-mm-yyy-HH.nn.ss")#" & ".xlsx">
        <cfset local.filePath = ExpandPath("../Spreadsheets/" & #local.spreadSheet#)>
        <cfspreadsheet action="write" query="local.details" filename="#local.filePath#" overwrite="no">
    </cffunction>

    <cffunction name="printPdf" returnType="query">
        <cfset local.details = getAllDetails()>
        <cfreturn local.details>
    </cffunction>

    <cffunction  name="convertToQuery" access="remote">
        <cfargument name="uploadedSpreadSheet">
        <cfspreadsheet action = "read" headerrow="1" excludeheaderrow="true" query = "resultQuery" src = "#arguments.uploadedSpreadSheet#">
        <cfset downloadExcelException(resultQuery)>
    </cffunction>

    <cffunction name="downloadExcelException">
        <cfargument name="exceptionQuery">
        <cfset local.exceptions = arrayNew(1)>
        <cfset local.DataStructure = structNew()>
        <cfset local.resultQuery = getRolesFunction()>
        <cfset dataArray = ["TITLE","FIRSTNAME","LASTNAME","GENDER","DATEOFBIRTH","ADDRESS","STREET","DISTRICT","STATE","COUNTRY","PINCODE","EMAILID","PHONENUMBER","ROLENAME"]>
        <cfloop query = "arguments.exceptionQuery">
            <cfset local.exceptions[arguments.exceptionQuery.currentRow] = "ERRORS - ">
            <cfloop array="#dataArray#" item="i">
                <cfif arguments.exceptionQuery[i].toString() EQ "">
                    <cfset local.exceptions[arguments.exceptionQuery.currentRow] = "#local.exceptions[arguments.exceptionQuery.currentRow]#" & "#i#" & " IS EMPTY, ">
                    <cfelse>
                        <cfif i EQ "EMAILID">
                            <cfset emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$">
                            <cfif NOT reFind(emailPattern,'#arguments.exceptionQuery["EMAILID"].toString()#')>
                                <cfset local.exceptions[arguments.exceptionQuery.currentRow] = "#local.exceptions[arguments.exceptionQuery.currentRow]#" & "#i#" & " SHOULD FOLLOW PATTERN, ">
                                <cfelse>
                                    <cfset local.DataStructure["emailId"] = arguments.exceptionQuery["EMAILID"].toString()>
                            </cfif>
                            <cfelseif i EQ "PHONENUMBER">
                                <cfif NOT isNumeric(arguments.exceptionQuery["PHONENUMBER"].toString())>
                                    <cfset local.exceptions[arguments.exceptionQuery.currentRow] = "#local.exceptions[arguments.exceptionQuery.currentRow]#" & "#i#" & " SHOULD BE NUMERIC, ">
                                    <cfelseif arguments.exceptionQuery["PHONENUMBER"].toString().len() NEQ 10>
                                        <cfset local.exceptions[arguments.exceptionQuery.currentRow] = "#local.exceptions[arguments.exceptionQuery.currentRow]#" & "#i#" & " SHOULD HAVE 10 DIGITS, ">
                                    <cfelse>
                                        <cfset local.DataStructure["phone"] = arguments.exceptionQuery["PHONENUMBER"].toString()>
                                </cfif> 
                            <cfelseif i EQ "TITLE">
                                <cfif trim(arguments.exceptionQuery["TITLE"].toString()) EQ "Mr" OR trim(arguments.exceptionQuery["TITLE"].toString()) EQ "Ms">
                                    <cfset local.DataStructure["selectTitle"] = arguments.exceptionQuery["TITLE"].toString()>
                                    <cfelse>
                                        <cfset local.exceptions[arguments.exceptionQuery.currentRow] = "#local.exceptions[arguments.exceptionQuery.currentRow]#" & "#i#" & "SHOULD BE Mr OR Ms , ">
                                </cfif>
                            <cfelseif i EQ "GENDER">
                                <cfif trim(arguments.exceptionQuery["GENDER"].toString()) EQ "Male" OR trim(arguments.exceptionQuery["GENDER"].toString()) EQ "Female">
                                    <cfset local.DataStructure["selectGender"] = arguments.exceptionQuery["GENDER"].toString()>
                                    <cfelse>
                                        <cfset local.exceptions[arguments.exceptionQuery.currentRow] = "#local.exceptions[arguments.exceptionQuery.currentRow]#" & "#i#" & "SHOULD BE Male OR Female , ">
                                </cfif>
                            <cfelseif i EQ "PINCODE">
                                <cfif arguments.exceptionQuery["PINCODE"].toString().len() NEQ 6>
                                    <cfset local.exceptions[arguments.exceptionQuery.currentRow] = "#local.exceptions[arguments.exceptionQuery.currentRow]#" & "#i#" & "SHOULD HAVE 6 DIGITS , ">
                                    <cfelse>
                                        <cfset local.DataStructure["pinCode"] = arguments.exceptionQuery["PINCODE"].toString()>
                                </cfif>
                            <cfelseif i EQ "ROLENAME">
                                <cfset local.rolesId = "">
                                <cfloop list="#arguments.exceptionQuery["ROLENAME"].toString()#" item="item" delimiters=",">
                                    <cfset local.flag = 1>
                                    <cfloop query="local.resultQuery">
                                        <cfif item EQ local.resultQuery.roleName>
                                            <cfif local.rolesId EQ "">
                                                <cfset local.rolesId = local.resultQuery.roleId>
                                                <cfelse>
                                                    <cfset local.rolesId = local.rolesId & "," & local.resultQuery.roleId >
                                            </cfif>
                                            <cfset local.flag = local.flag  * 0>
                                        </cfif>
                                    </cfloop>
                                    <cfif local.flag EQ 1>
                                        <cfset local.exceptions[arguments.exceptionQuery.currentRow] = "#local.exceptions[arguments.exceptionQuery.currentRow]#" & "#i#" & " IS INVALID , ">
                                        <cfbreak>
                                    </cfif>
                                </cfloop>
                                <cfif local.flag EQ 0>
                                    <cfset local.DataStructure["roleSelector"] = "#local.rolesId#">
                                </cfif>
                                <cfif local.exceptions[arguments.exceptionQuery.currentRow] EQ "ERRORS - ">
                                    <cfquery name="checkEmailId">
                                        SELECT 
                                            emailId,contactId 
                                        FROM
                                            contactTable
                                        WHERE
                                            emailId =  <cfqueryparam value = '#arguments.exceptionQuery["EMAILID"].toString()#' cfsqltype = "cf_sql_varchar">
                                            AND 
                                            active =  <cfqueryparam value = '1' cfsqltype = "cf_sql_integer">
                                            AND
                                            _createdBy = <cfqueryparam value = '#session.username#' cfsqltype = "cf_sql_varchar">
                                    </cfquery>
                                    <cfset local.DataStructure["firstName"] = arguments.exceptionQuery["FIRSTNAME"].toString()>
                                    <cfset local.DataStructure["lastName"] = arguments.exceptionQuery["LASTNAME"].toString()>
                                    <cfset local.DataStructure["dob"] = arguments.exceptionQuery["DATEOFBIRTH"].toString()>
                                    <cfset local.DataStructure["address"] = arguments.exceptionQuery["ADDRESS"].toString()>
                                    <cfset local.DataStructure["street"] = arguments.exceptionQuery["STREET"].toString()>
                                    <cfset local.DataStructure["state"] = arguments.exceptionQuery["STATE"].toString()>
                                    <cfset local.DataStructure["district"] = arguments.exceptionQuery["DISTRICT"].toString()>
                                    <cfset local.DataStructure["country"] = arguments.exceptionQuery["COUNTRY"].toString()>
                                    <cfif checkEmailId.recordCount EQ 0>
                                        <cfset local.exceptions[arguments.exceptionQuery.currentRow] = "Row Added">
                                        <cfset local.DataStructure["profilePic"] = "/Assets/Images/addressProfilePic.jpeg">
                                        <cfset addContacts(local.DataStructure)>
                                        <cfelse>
                                            <cfset local.exceptions[arguments.exceptionQuery.currentRow] = "Row Updated">
                                            <cfset local.DataStructure["editSubmit"] = checkEmailId.contactId>
                                            <cfset local.DataStructure["profileImage"] = "">
                                            <cfset editContacts(local.DataStructure)>
                                    </cfif>
                                </cfif>  
                        </cfif>
                </cfif>
            </cfloop>  
        </cfloop>
        <cfset queryAddColumn(arguments.exceptionQuery, "Exceptions",local.exceptions)>
        <cfset  querySort(
            arguments.exceptionQuery,
            function(rowA,rowB){
                return compare(rowA.exceptions, rowB.exceptions)
            }
        )>
        <cfspreadsheet action = "write" query = "arguments.exceptionQuery" filename = "#ExpandPath("../Spreadsheets/dataSpreadSheet.xlsx")#" overwrite="yes">
    </cffunction>

    <cffunction name="downloadExcel" access="remote">
        <cfset local.rowAddedExcel = spreadsheetNew("name")>
        <cfset spreadsheetAddRow(local.rowAddedExcel,'TITLE,FIRSTNAME,LASTNAME,GENDER,DATEOFBIRTH,ADDRESS,STREET,DISTRICT,STATE,COUNTRY,PINCODE,EMAILID,PHONENUMBER')>
        <cfspreadsheet action = "write" name="local.rowAddedExcel" filename = "../Spreadsheets/plainSpreadSheet.xlsx" overwrite="yes">
    </cffunction>

    <cffunction name="scheduleWish" returnType="void">
        <cfset local.dateToday = dateFormat(now(),"mm-dd")>
        <cfquery name="local.selectDob">
            select emailId,firstName,dateOfBirth from contactTable
        </cfquery>
        <cfloop query="local.selectDob">
            <cfif dateFormat(local.selectDob.dateOfBirth,"mm-dd")>
                <cfmail  from="dinilvallikunnil@gmail.com"  subject="Birthday Wishes"  to="#local.selectDob.emailId#" mimeattach="/Assets/Images/birthdayWish.jpg">
                    Happy birthday dear #local.selectDob.firstName#
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