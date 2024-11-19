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

function login(){
    var userName = document.getElementById("userNameId").value;
    var password = document.getElementById("password").value;
    if(userName === ""){
        document.getElementById("userWarning").innerHTML = "username is required"
        flag = false;
    }else{
        document.getElementById("userWarning").innerHTML = ""
    }
    if(password === ""){
        document.getElementById("passWarning").innerHTML = "password is required"
        flag = false;
    }else{
        document.getElementById("passWarning").innerHTML = ""
    }
    return flag;
}

function createContact(){
    document.getElementById("createContactHead").innerHTML = "CREATE CONTACT"
}

function editContact(){
    document.getElementById("createContactHead").innerHTML = "EDIT CONTACT"
}

function addContact(){
    var title = document.getElementById("selectTitleId").value;
    var firstName = document.getElementById("firstNameId").value;
    var lastName = document.getElementById("lastNameId").value;
    var gender = document.getElementById("selectGenderId").value;
    var dateOfBirth = document.getElementById("dobId").value;
    var address = document.getElementById("addressId").value;
    var street = document.getElementById("sreetId").value;
    var district = document.getElementById("districtId").value;
    var state = document.getElementById("stateId").value;
    var country = document.getElementById("countryId").value;
    var pincode = document.getElementById("pincodeId").value;
    var emailId = document.getElementById("emailIds").value;
    var phone = document.getElementById("phoneId").value;
    var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    var phonePattern = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/;
    var flag = true;
    if(title === ""){
        document.getElementById("titleWarning").innerHTML = "select title";
        flag = false;
    }else{
        document.getElementById("titleWarning").innerHTML = "";
    }

    if(firstName === ""){
        document.getElementById("firstWarning").innerHTML = "add firstname";
        flag = false;
    }else if(firstName.includes(" ")){
        document.getElementById("firstWarning").innerHTML = "No spaces in first name";
        flag = false;
    }else{
        document.getElementById("firstWarning").innerHTML = "";
    }

    if(lastName === ""){
        document.getElementById("lastWarning").innerHTML = "add lastname";
        flag = false;
    }else if(lastName.includes(" ")){
        document.getElementById("lastWarning").innerHTML = "No spaces in last name";
        flag = false;
    }else{
        document.getElementById("lastWarning").innerHTML = "";
    }

    if(gender === ""){
        document.getElementById("genderWarning").innerHTML = "select gender";
        flag = false;
    }else{
        document.getElementById("genderWarning").innerHTML = "";
    }

    if(dateOfBirth === ""){
        document.getElementById("dateWarning").innerHTML = "add Date of birth";
        flag = false;
    }else{
        document.getElementById("dateWarning").innerHTML = "";
    }

    if(address === ""){
        document.getElementById("addressWarning").innerHTML = "add address";
        flag = false;
    }else{
        document.getElementById("addressWarning").innerHTML = "";
    }

    if(street === ""){
        document.getElementById("streetWarning").innerHTML = "add street";
        flag = false;
    }else{
        document.getElementById("streetWarning").innerHTML = "";
    }

    if(district === ""){
        document.getElementById("districtWarning").innerHTML = "add district";
        flag = false;
    }else{
        document.getElementById("districtWarning").innerHTML = "";
    }

    if(state === ""){
        document.getElementById("stateWarning").innerHTML = "add state";
        flag = false;
    }else{
        document.getElementById("stateWarning").innerHTML = "";
    }

    if(country === ""){
        document.getElementById("countryWarning").innerHTML = "add country";
        flag = false;
    }else{
        document.getElementById("countryWarning").innerHTML = "";
    }

    if(pincode === ""){
        document.getElementById("pincodeWarning").innerHTML = "add pincode";
        flag = false;
    }else{
        if(pincode.length !== 6){
            document.getElementById("pincodeWarning").innerHTML = "enter 6 digit pincode";
            flag = false;
        }else if(/^[0-9]{6}$/.test(pincode) === false){
            document.getElementById("pincodeWarning").innerHTML = "pincode should only contain digits";
            flag = false;
        }else{
            document.getElementById("pincodeWarning").innerHTML = "";
        }
    }

    if(emailId === ""){
        document.getElementById("emailWarning").innerHTML = "add email id"
        flag = false;
    }else{
        if(emailPattern.test(emailId) === false){
            document.getElementById("emailWarning").innerHTML = "should follow email Pattern"
            flag = false;
        }else{
            document.getElementById("emailWarning").innerHTML = ""
        }
    }

    if(phone === ""){
        document.getElementById("phoneWarning").innerHTML = "add phone number";
        flag = false;
    }else{
        if(phonePattern.test(phone) === false){
            document.getElementById("phoneWarning").innerHTML = "phone should follow the pattern";
            flag = false;
        }else{
            document.getElementById("phoneWarning").innerHTML = ""
        }
    }

    if(flag == false){
        event.preventDefault();
    }
    return flag;

}