function registerUser(){
    var fullName = document.getElementById("fullNameId").value;
    var emailId = document.getElementById("emailIds").value;
    var userName = document.getElementById("userNameId").value;
    var password = document.getElementById("passwordId").value;
    var rePassword = document.getElementById("rePasswordId").value;
    var profileImage = document.getElementById("profilePicId").value;
    var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    var flag = true;

    if(fullName.trim() === ""){
        document.getElementById("nameWarning").innerHTML = "Name is required"
        flag = false;
    }else{
        document.getElementById("nameWarning").innerHTML = ""
    }

    if(emailId.trim() === ""){
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

    if(userName.trim() === ""){
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

    if(password.trim() === ""){
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
    if(profileImage.trim() === ""){
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
    document.getElementById("editModalId").src ="./Assets/Images/addressProfilePic.jpeg";
    document.getElementById("createContactForm").reset();
    document.getElementById("createSubmitId").name="createSubmit";
}

function formatDate() {
    var d = new Date(),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) 
        month = '0' + month;
    if (day.length < 2) 
        day = '0' + day;

    return [year, month, day].join('-');
}


function addContact(){
    var title = document.getElementById("selectTitleId").value;
    var firstName = document.getElementById("firstNameId").value;
    var lastName = document.getElementById("lastNameId").value;
    var gender = document.getElementById("selectGenderId").value;
    var dateOfBirth = document.getElementById("dobId").value;
    var address = document.getElementById("addressId").value;
    var street = document.getElementById("streetId").value;
    var district = document.getElementById("districtId").value;
    var state = document.getElementById("stateId").value;
    var country = document.getElementById("countryId").value;
    var pincode = document.getElementById("pincodeId").value;
    var emailId = document.getElementById("emailIds").value;
    var phone = document.getElementById("phoneId").value;
    var role = document.getElementById("rolesId").value;
    var editModal = document.getElementById("createSubmitId").name;

    
    var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    var phonePattern = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/;
    var flag = true;


    if(role === ""){
        document.getElementById("rolesWarning").innerHTML = "select roles";
        flag = false;
    }else{
        document.getElementById("rolesWarning").innerHTML = "";
    }

    if(title.trim() === ""){
        document.getElementById("titleWarning").innerHTML = "select title";
        flag = false;
    }else{
        document.getElementById("titleWarning").innerHTML = "";
    }

    if(firstName.trim() === ""){
        document.getElementById("firstWarning").innerHTML = "add firstname";
        flag = false;
    }else if(firstName.includes(" ")){
        document.getElementById("firstWarning").innerHTML = "No spaces in first name";
        flag = false;
    }else{
        document.getElementById("firstWarning").innerHTML = "";
    }

    if(lastName.trim() === ""){
        document.getElementById("lastWarning").innerHTML = "add lastname";
        flag = false;
    }else if(lastName.includes(" ")){
        document.getElementById("lastWarning").innerHTML = "No spaces in last name";
        flag = false;
    }else{
        document.getElementById("lastWarning").innerHTML = "";
    }

    if(gender.trim() === ""){
        document.getElementById("genderWarning").innerHTML = "select gender";
        flag = false;
    }else{
        document.getElementById("genderWarning").innerHTML = "";
    }

    if(dateOfBirth === ""){
        document.getElementById("dateWarning").innerHTML = "add Date of birth";
        flag = false;
    }else if(dateOfBirth > formatDate()){
        document.getElementById("dateWarning").innerHTML = "Date of birth should be valid";
        flag = false;
    }else{
        document.getElementById("dateWarning").innerHTML = "";
    }

    if(address.trim() === ""){
        document.getElementById("addressWarning").innerHTML = "add address";
        flag = false;
    }else{
        document.getElementById("addressWarning").innerHTML = "";
    }

    if(street.trim() === ""){
        document.getElementById("streetWarning").innerHTML = "add street";
        flag = false;
    }else{
        document.getElementById("streetWarning").innerHTML = "";
    }

    if(district.trim() === ""){
        document.getElementById("districtWarning").innerHTML = "add district";
        flag = false;
    }else{
        document.getElementById("districtWarning").innerHTML = "";
    }

    if(state.trim() === ""){
        document.getElementById("stateWarning").innerHTML = "add state";
        flag = false;
    }else{
        document.getElementById("stateWarning").innerHTML = "";
    }

    if(country.trim() === ""){
        document.getElementById("countryWarning").innerHTML = "add country";
        flag = false;
    }else{
        document.getElementById("countryWarning").innerHTML = "";
    }

    if(pincode.trim() === ""){
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

    if(emailId.trim() === ""){
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

    if(phone.trim() === ""){
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

function deleteContact(contactId){
    if(confirm("Are you sure to delete the contact?")){
        $.ajax({
            type:"POST",
            url:"Component/AddressBookMethods.cfc?method=deleteContact",
            data:{contactId:contactId.value},
            success:function(result){
                if(result){
                    document.getElementById(contactId.value).remove()
                }
            }
        })
    }
}

function viewModalData(viewContact){
    $.ajax({
        type:"POST",
        url:"Component/AddressBookMethods.cfc?method=viewModal",
        data:{contactIdModal:viewContact.value},
        success:function(result){
            var struct = JSON.parse(result);
            document.getElementById("viewModalName").innerHTML = struct.title + " "+struct.firstName+" "+struct.lastName;
            document.getElementById("viewModalGender").innerHTML = struct.gender;
            document.getElementById("viewModalDate").innerHTML =struct.dateOfBirth;
            document.getElementById("viewModalAddress").innerHTML = struct.address +" "+struct.street+" "+struct.district+" "+struct.state+" "+struct.country;
            document.getElementById("viewModalPincode").innerHTML = struct.pincode;
            document.getElementById("viewModalEmail").innerHTML = struct.emailId;
            document.getElementById("viewModalPhone").innerHTML = struct.phoneNumber;
            document.getElementById("viewModalProfilePic").src = struct.profileImage;
            document.getElementById("viewModalRole").innerHTML = struct.roles;
        }
    })
}

function editContact(editId){
    document.getElementById("createSubmitId").name = "editSubmit";
    $.ajax({
        type:"POST",
        url:"Component/AddressBookMethods.cfc?method=viewModal",
        data:{contactIdModal:editId.value},
        success:function(result){
            var struct = JSON.parse(result);
            document.getElementById("createContactForm").reset();
            document.getElementById("createContactHead").innerHTML = "EDIT CONTACT"
            document.getElementById("selectTitleId").value = struct.title;
            document.getElementById("firstNameId").value = struct.firstName;
            document.getElementById("lastNameId").value = struct.lastName;
            document.getElementById("selectGenderId").value = struct.gender;
            document.getElementById("dobId").value = struct.dateOfBirth;
            document.getElementById("addressId").value = struct.address;
            document.getElementById("streetId").value = struct.street;
            document.getElementById("districtId").value = struct.district;
            document.getElementById("stateId").value = struct.state;
            document.getElementById("countryId").value = struct.country;
            document.getElementById("pincodeId").value = struct.pincode;
            document.getElementById("emailIds").value = struct.emailId;
            document.getElementById("phoneId").value = struct.phoneNumber;
            document.getElementById("editModalId").src = struct.profileImage;
            document.getElementById("hiddenInput").value = struct.profileImage;
            document.getElementById("createSubmitId").value = struct.createSubmitId;
            $("#rolesId").val(struct.joinQuery);
        }
    })
}

function closeModal(){
    var nodeList = document.querySelectorAll(".registerWarning");
    for (let i = 0; i < nodeList.length; i++) {
        nodeList[i].innerHTML = "";
    }
    document.getElementById("userWarning").innerHTML =""
    document.getElementById("rolesId").value = ""
}

function pageLogout(){
    if(confirm("Confirm to logout")){
        $.ajax({
            type:"POST",
            url:"Component/AddressBookMethods.cfc?method=logout",
            success:function(result){
                if(result){
                    location.reload();
                }
            }
        })
    }
}

function printTable(){
    var printContents = document.getElementById("contactsTable").innerHTML;
	var originalContents = document.body.innerHTML;
	document.body.innerHTML = printContents;
	window.print();
    
	document.body.innerHTML = originalContents;
}

function printToPdf(){
    if(confirm("confirm to download PDF")){
        return true;
    }else{
        return false;
    }
 }

function addSpreadSheet(){
    if(confirm("confirm to download spreadsheet")){
        $.ajax({
            type:"POST",
            url:"Component/AddressBookMethods.cfc?method=SpreadSheet"
        })
        alert("Spreadsheet downloaded")
    }
    
}

if ( window.history.replaceState ) {
    window.history.replaceState( null, null, window.location.href );
}