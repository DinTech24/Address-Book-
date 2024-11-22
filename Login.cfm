<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./Bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="./Style/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    <cfoutput>
        <div class="d-flex accessPageHead justify-content-between py-2">
            <div class="ms-5">
                <img width="30" src="./Assets/Images/Application_Logo.png" alt="logo">
                <span>ADDRESS BOOK</span>
            </div>
            <div class="d-flex me-5">
                <div class="me-4">Sign Up</div>
                <div>Login</div>
            </div>
        </div>
        <div class="row">
            <div class="col-3"></div>
            <div class="col-6 mt-5">
                <div class="d-flex align-items-center accessBodyMainDiv">
                    <div class="addressLoginMainDiv d-flex align-items-center">
                        <div class="addressLogoDiv">
                            <img width="70" height="80" src="./Assets/Images/Application_Logo.png" alt="logo">
                        </div>
                    </div>
                    <div class="text-center loginMainDiv">
                        <div class="accessHeading">LOGIN</div>
                        <form action="" method="POST">
                            <div>
                                <div>
                                    <input name="username" id="" class="inputStyle" placeholder="Username" type="text">
                                </div>
                                <div>
                                    <input name="password" class="inputStyle" placeholder="Password" type="password">
                                </div>
                                <div>
                                    <button name="loginButton" class="accessButton py-1 mt-5">LOGIN</button>
                                </div>
                                <div>
                                    <span>Or Sign in Using</span>
                                    <div class="d-flex justify-content-center">
                                        <a href="" class="me-2">
                                            <img  width="40" src="./Assets/Images/FaceBook.png" alt="">
                                        </a>
                                        <a href="">
                                            <img width="40" src="./Assets/Images/GoogleIcon.png" alt="">
                                        </a>
                                    </div>
                                </div>
                                <div>
                                    <div>Don't have an account? <a class="registerClass" href="./signUp.cfm">Register Here</a></div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-3"></div>
        </div>
        <cfif structKeyExists(form, "loginButton")>
            <cfset local.object = new Component.function()>
            <cfset local.result = local.object.loginUser(form.username,form.password)>
            <cfif local.result EQ false>
                <div class="text-center">
                    <div class="text-danger fw-bold">Invalid Credentials<div>
                <div>
                <cfelse>
                    <div class="text-center">
                        <div class="text-success fw-bold">valid Credentials<div>
                    <div>
            </cfif>
        </cfif>
    </cfoutput>
</body>
</html>