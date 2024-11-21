<cfcomponent>
    <cfset this.sessionmanagement = true>
    <cfset this.dataSource = "myData">

    <cffunction  name="onApplicationStart">
        <cfset application.object = createObject("component","Component.function")>
    </cffunction>

    <cffunction  name="onRequestStart">
        <cfif structKeyExists(url,"reload") AND url.reload EQ 1>
            <cfset onApplicationStart()>
        </cfif>
    </cffunction>

    <cffunction  name="onRequest">
        <cfargument name="requestedPage" required="true">
        <cfset local.excludedPages = ["/Address Book/Login.cfm"
        ,"/Address Book/signUp.cfm"]>
        <cfif arrayContains(local.excludedPages,arguments.requestedPage)>
            <cflocation  url="#arguments.requestedPage#">
            <cfelseif structKeyExists(session, "login") AND structKeyExists(session, "username")>
                <cfinclude  template="#arguments.requestedPage#">
            <cfelse>
                <cfinclude template="login.cfm">
        </cfif>
    </cffunction>

</cfcomponent>