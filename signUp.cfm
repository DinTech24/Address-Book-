<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./Bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="./Style/style.css">
</head>
<body>
    <cfoutput>
        <div class="d-flex accessPageHead justify-content-between py-2">
            <div class="ms-5">
                <img width="30" src="./Assets/Images/Application_Logo.png" alt="logo">
                <span>ADDRESS BOOK</span>
            </div>
            <div class="d-flex me-5">
                <div class="me-4"><a href="">Sign Up</a></div>
                <div><a href="./Login.cfm">Login</a></div>
            </div>
        </div>
        <div class="row">
            <div class="col-3"></div>
            <div class="col-6 mt-5 mb-5">
                <div class="d-flex align-items-center accessBodyMainDiv">
                    <div class="addressLogoMainDiv d-flex align-items-center">
                        <div class="addressLogoDiv">
                            <img width="70" height="80" src="./Assets/Images/Application_Logo.png" alt="logo">
                        </div>
                    </div>
                    <div class="text-center accessMainDiv">
                        <div class="accessHeading">SIGN UP</div>
                        <form action="" method="POST">
                            <div>
                                <div>
                                    <input name="fullName" id="fullNameId" class="inputStyle" type="text" placeholder="Full Name">
                                    <div id="nameWarning" class="registerWarning"></div>
                                </div>
                                <div>
                                    <input name="emailId" id="emailIds" class="inputStyle" type="email" placeholder="Email ID">
                                    <div id="emailWarning" class="registerWarning"></div>
                                </div>
                                <div>
                                    <input name="userName" id="userNameId" class="inputStyle" type="text" placeholder="Username">
                                    <div id="userWarning" class="registerWarning"></div>
                                </div>  
                                <div>
                                    <input name="password" id="passwordId" class="inputStyle" type="password" placeholder="Password">
                                    <div id="passWarning" class="registerWarning"></div>
                                </div>
                                <div>
                                    <input name="rePassword" id="rePasswordId" class="inputStyle confirmPassword" type="password" placeholder="Confirm Password">
                                    <div id="repassWarning" class="registerWarning"></div>
                                </div>
                                <div class="d-flex justify-content-between mx-4 align-items-center mb-3 mt-4">
                                    <label for="profilePicId">Add profile picture</label>    
                                    <input name="profilePic" id="profilePicId" class="form-control w-50" type="file">
                                </div>
                                <div id="profPicWarning" class="registerWarning"></div>
                                <div>
                                    <button name="signUpButton" onclick="return registerUser()" type="button" class="accessButton py-1 mt-3">REGISTER</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-3"></div>
        </div>
        <cfif structKeyExists(form,"signUpButton")>
            <cfset local.object = new Component.function()>
            <cfset local.result = local.object.addUser(form.fullName,form.emailId,form.userName,form.password,form.profilePic)>
            <cfif local.result EQ true>
                <div class="text-center">
                    <div class="text-success">User Registered Successfully<div>
                <div>
            </cfif>
        </cfif>
    </cfoutput>
    <script src="./JavaScript/script.js"></script>
</body>
</html>