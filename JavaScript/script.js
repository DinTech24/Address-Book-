function registerUser(){
    var fullName = document.getElementById("fullNameId").value;
    var emailId = document.getElementById("emailIds").value;
    var userName = document.getElementById("userNameId").value;
    var password = document.getElementById("passwordId").value;
    var rePassword = document.getElementById("rePasswordId").value;
    var profileImage = document.getElementById("profilePicId").value;
    var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    var flag = true;

    if(fullName === ""){
        document.getElementById("nameWarning").innerHTML = "Name is required"
        flag = false;
    }else{
        document.getElementById("nameWarning").innerHTML = ""
    }

    if(emailId === ""){
        document.getElementById("emailWarning").innerHTML = "email-id is required"
        flag = false;
    }else{
        if(emailPattern.test(emailId) === false){
            document.getElementById("emailWarning").innerHTML = "should follow email Pattern"
            flag = false;
        }else{
            document.getElementById("emailWarning").innerHTML = ""
        }
    }

    if(userName === ""){
        document.getElementById("userWarning").innerHTML = "username is required"
        flag = false;
    }else{
        if(userName.includes(" ")){
            document.getElementById("userWarning").innerHTML = "username shouldn't contain spaces"
            flag = false;
        }else{
            document.getElementById("userWarning").innerHTML = ""
        }
    }

    if(password === ""){
        document.getElementById("passWarning").innerHTML = "password is required"
        flag = false;
    }else{
        if(password.includes(" ")){
            document.getElementById("passWarning").innerHTML = "password shouldn't contain spaces"
            flag = false;
        }else if(password.length < 6){
            document.getElementById("passWarning").innerHTML = "password should atleast have 6 characters"
            flag = false;
        }else if(password !== rePassword){
            document.getElementById("passWarning").innerHTML = ""
            document.getElementById("repassWarning").innerHTML = "passwords doesn't match"
            flag = false;
        }else{
            document.getElementById("repassWarning").innerHTML = ""
            document.getElementById("passWarning").innerHTML = ""
        }
    }

    var allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;
    console.log(profileImage);
    if(profileImage === ""){
        document.getElementById("profPicWarning").innerHTML = "Profile image should be added"
        flag = false;
    }else{
        if(!allowedExtensions.exec(profileImage)){
            document.getElementById("profPicWarning").innerHTML = "Allowed extensions are JPG/JPEG/PNG"
            flag = false;
        }else{
            document.getElementById("profPicWarning").innerHTML = ""
        }
    }
    
    if(flag == false){
        event.preventDefault();
    }
    return flag;
}