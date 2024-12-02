<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ERROR PAGE</title>
    <link rel="stylesheet" href="./Bootstrap/bootstrap.min.css"/>
</head>
<body>
    <cfoutput>
        <div class="text-center mx-auto mt-5">
            <img src="./Assets/Images/Error.jpg">
            <div class="fs-1 fw-bold">ERROR OCCURED</div>
            <div class="text-danger fs-4 fw-bold">#url.error#</div>
            <cfset structClear(session)>
            <a href="./Login.cfm" class="fw-bold">Back to Login Page</a>
        </div>
    </cfoutput>
</body>
</html>