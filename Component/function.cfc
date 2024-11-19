<cfcomponent>
    <cffunction  name="addUser" returnType="any">
        <cfargument  name="fullName">
        <cfargument  name="emailId">
        <cfargument  name="userName">
        <cfargument  name="password">
        <cfargument  name="profilePicId">
        <cfset local.encryptedPassword = hash("password","sha-256","UTF-8")>
        <cfquery name=registerUser>
            insert into userTable(name,emailId,username,password,profileImage) values(
                name = <cfqueryparam value="#arguments.fullName#" cfsqltype="cf_sql_varchar">,
                emailId = <cfqueryparam value="#arguments.fullName#" cfsqltype="cf_sql_varchar">,
                username = <cfqueryparam value="#arguments.fullName#" cfsqltype="cf_sql_varchar">,
                password = <cfqueryparam value="#local.encryptedPassword#" cfsqltype="cf_sql_varchar">,
                profileImage = <cfqueryparam value="#arguments.fullName#" cfsqltype="cf_sql_varchar">
            )
        </cfquery>
        <cfreturn true>
    </cffunction>
</cfcomponent>