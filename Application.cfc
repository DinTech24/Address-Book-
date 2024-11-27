<cfcomponent>

    <cfset this.sessionmanagement = true>
    <cfset this.dataSource = "myData">
    <cfset this.name = "MyApplication">
    <cfset this.applicationTimeout = createTimeSpan(0, 12, 0, 0)>
    
<!---     <cffunction name="onApplicationStart" returntype="boolean" output="false">
        <cfset application.object = new Component.function()>
        <cfreturn true>
    </cffunction> --->

<!---     <cffunction  name="onError" returnType="void">
        <cfargument name="exception" type="string">
        <cfargument name="eventName" type="string">
        <cflocation  url="./errorPage.cfm?error=#arguments.eventName#">
    </cffunction> --->

    <cffunction  name="onRequest">
        <cfargument name="requestedPage" required="true">
        <cfset local.excludedPages = ["/Login.cfm"
        ,"/signUp.cfm","/errorPage.cfm","/ssoLogin.cfm"]>
        <cfif arrayContains(local.excludedPages,arguments.requestedPage)>
            <cfinclude  template="#arguments.requestedPage#">
            <cfelseif structKeyExists(session, "login") AND structKeyExists(session, "username")>
                <cfinclude  template="#arguments.requestedPage#">
            <cfelse>
                <cfinclude template="Login.cfm">
        </cfif>
    </cffunction>

</cfcomponent>