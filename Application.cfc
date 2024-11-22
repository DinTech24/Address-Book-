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
</cfcomponent>