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
        <div class="modal fade " id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog ">
                <div class=" editModal modal-content">
                    <div class="d-flex">
                        <div class="ms-3 modalMainBody">
                            <div class="text-center">
                                <div class="contactModalHead mx-auto">CONTACT DETAILS</div>
                            </div>
                            <div>
                                <div class="profileEachDataDiv ">
                                    <div class="modalProfileHead">Name</div>
                                    <div class="modalColon">&colon;</div>
                                    <div class="modalProfileData">Miss Anjana</div>
                                </div>
                                <div class="profileEachDataDiv ">
                                    <div class="modalProfileHead">Gender</div>
                                    <div class="modalColon">&colon;</div>
                                    <div class="modalProfileData">Female</div>
                                </div>
                                <div class="profileEachDataDiv ">
                                    <div class="modalProfileHead">Date of Birth</div>
                                    <div class="modalColon">&colon;</div>
                                    <div class="modalProfileData">12-05-2021</div>
                                </div>
                                <div class="profileEachDataDiv ">
                                    <div class="modalProfileHead">Adress</div>
                                    <div class="modalColon">&colon;</div>
                                    <div class="modalProfileData">
                                        House No, Street Name,Place
                                        District, State , India
                                    </div>
                                </div>
                                <div class="profileEachDataDiv ">
                                    <div class="modalProfileHead">Pincode</div>
                                    <div class="modalColon">&colon;</div>
                                    <div class="modalProfileData">000000</div>
                                </div>
                                <div class="profileEachDataDiv ">
                                    <div class="modalProfileHead">Email Id</div>
                                    <div class="modalColon">&colon;</div>
                                    <div class="modalProfileData">anjana@gmail.com</div>
                                </div>
                                <div class="profileEachDataDiv ">
                                    <div class="modalProfileHead">Phone</div>
                                    <div class="modalColon">&colon;</div>
                                    <div class="modalProfileData">0000000000</div>
                                </div>
                            </div>
                            <div class="text-center">
                                <button type="button py-3" class="modalBtnClose " data-bs-dismiss="modal" aria-label="Close">CLOSE</button>
                            </div>
                        </div>
                        <div class="d-flex justify-content-center w-25 pt-5">
                            <div class="">
                                <img height="100" class="mt-5" src="./Assets/Images/addressProfilePic.jpeg" alt="">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="staticBackdropEdit" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog ">
                <div class=" editMainModal modal-content">
                    <div class="d-flex">
                        <div class="ms-3 modalEditMainBody">
                            <div class="editModalContent mx-auto">
                                <div class="text-center">
                                    <div class="contactEditModalHead mx-auto" id="createContactHead">CREATE CONTACT</div>
                                </div>
                                <form action="" method="POST" enctype="multipart/form-data">
                                    <div>
                                        <div class="mb-3 personalDetailsHead">Personal Contact</div>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3">
                                        <div class="createContactFields">Title <span>*</span></div>
                                        <div class="createContactFields">First Name <span>*</span></div>
                                        <div class="createContactFields me-5">Last Name <span>*</span></div>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <select name="selectTitle" id="selectTitleId" class="editContactPersonalInput">
                                                <option value="" selected hidden></option>
                                                <option value="Mr">Mr</option>
                                                <option value="Ms">Ms</option>
                                            </select>
                                             <div id="titleWarning" class="registerWarning"></div>
                                        </div>
                                        <div>
                                            <input name="firstName" id="firstNameId" class="editContactPersonalInput" placeholder="First Name" type="text">
                                            <div id="firstWarning" class="registerWarning"></div>
                                        </div>
                                        <div>
                                            <input name="lastName" id="lastNameId" class="editContactPersonalInput" placeholder="Last Name" type="text">
                                            <div id="lastWarning" class="registerWarning"></div>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3 mt-3">
                                        <div class="createContactFields">Gender <span>*</span></div>
                                        <div class="me-5 createContactFields">Date Of Birth <span>*</span></div>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3">
                                        <div>
                                            <select name="selectGender" id="selectGenderId" class="editContactPersonalInput">
                                                <option value="" selected hidden></option>
                                                <option value="Male">Male</option>
                                                <option value="Female">Female</option>
                                            </select>
                                            <div id="genderWarning" class="registerWarning"></div>
                                        </div>
                                        <div>
                                            <input name="dob" id="dobId" class="editContactPersonalInput" type="date">
                                            <div id="dateWarning" class="registerWarning"></div>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="mb-2 createContactFields">Upload Photo </div>
                                    </div>
                                    <div>
                                        <input name="profilePic" id="profilePicId" class="editContactPersonalInputFile" type="file">
                                        <div id="picWarning" class="registerWarning"></div>
                                    </div>
                                    <div>
                                        <div class="mb-3 mt-2 personalDetailsHead">Contact Details</div>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3 mt-3">
                                        <div class="createContactFields">Address<span>*</span></div>
                                        <div class="createContactFields">Street <span>*</span></div>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <input name="address" id="addressId" class="editContactPersonalInput" placeholder="Address" type="text">
                                            <div id="addressWarning" class="registerWarning"></div>
                                        </div>
                                        <div>
                                            <input name="street" id="sreetId" class="editContactPersonalInput" placeholder="Street Name" type="text">
                                            <div id="streetWarning" class="registerWarning"></div>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3 mt-3">
                                        <div class="createContactFields">District <span>*</span></div>
                                        <div class="createContactFields">State <span>*</span></div>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <input name="district" id="districtId"  class="editContactPersonalInput" placeholder="District" type="text">
                                            <div id="districtWarning" class="registerWarning"></div>
                                        </div>
                                        <div>
                                            <input name="state" id="stateId" class="editContactPersonalInput" placeholder="State" type="text">
                                            <div id="stateWarning" class="registerWarning"></div>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3 mt-3">
                                         <div class="createContactFields me-5">Country <span>*</span></div>
                                        <div class="createContactFields me-5">Pincode <span>*</span></div>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <input name="country" id="countryId" class="editContactPersonalInput" placeholder="Country" type="text">
                                            <div id="countryWarning" class="registerWarning"></div>
                                        </div>
                                        <div>
                                            <input name="pincode" id="pincodeId" class="editContactPersonalInput" placeholder="Pin-Code" type="text">
                                            <div id="pincodeWarning" class="registerWarning"></div>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3 mt-3">
                                        <div class="createContactFields me-5">Email Id <span>*</span></div>
                                        <div class="createContactFields me-5">Phone <span>*</span></div>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <input name="emailId" id="emailIds" class="editContactPersonalInput" placeholder="Email Id" type="text">
                                            <div id="emailWarning" class="registerWarning"></div>
                                        </div>
                                        <div>
                                            <input name="phone" id="phoneId" class="editContactPersonalInput" placeholder="Phone" type="text">
                                            <div id="phoneWarning" class="registerWarning"></div>
                                        </div>
                                    </div>
                                    <div class="text-center mt-4">
                                        <button onclick="return addContact()" type="submit" name="createSubmit" class="modalBtnClose">SUBMIT</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="w-25">
                            <div class="d-flex justify-content-end mt-4">
                                <button class="btn btn-close"  class="modalBtnClose " data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="d-flex justify-content-center w-100 pt-5">
                                <div class="w-100">
                                    <img height="100" class="mt-5 ms-5" src="./Assets/Images/addressProfilePic.jpeg" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="d-flex accessPageHead justify-content-between py-2">
            <div class="ms-5">
                <img width="30" src="./Assets/Images/Application_Logo.png" alt="logo">
                <span>ADDRESS BOOK</span>
            </div>
            <div class="d-flex me-5">
                <a href="./Login.cfm">Logout</a>
            </div>
        </div>
        <div class="row">
            <div class="col-1"></div>
            <div class="col-10 ">
                <div class="bg-white mt-3 d-flex justify-content-end rounded">
                    <div class="py-2">
                        <a href="" class="ms-3"><img width="30" src="./Assets/Images/adobe.png" alt="1"></a>
                        <a href="" class="ms-3"><img width="30" src="./Assets/Images/spreadsheet.png" alt="2"></a>
                        <a href="" class="mx-3"><img width="30" src="./Assets/Images/print.png" alt="3"></a>
                    </div>
                </div>
                <div class="d-flex mt-3">
                    <div class="me-3">
                        <div class="text-center profileBox">
                            <img width="100" src="./Assets/Images/profileImage.png" alt="">
                            <div class="profileUserName">Name</div>
                            <button   data-bs-toggle="modal" onclick="createContact()" data-bs-target="##staticBackdropEdit" class="rounded-pill createContactbutton px-1 py-1">CREATE CONTACT</button>
                        </div>
                    </div>
                    <div class="userAddedContacts px-2">
                        <div class="d-flex userContactsHead py-3">
                            <div class="userContactsName">NAME</div>
                            <div class="userContactsEmail">EMAIL ID</div>
                            <div class="userContactsPhone">PHONE NUMBER</div>
                        </div>
                        <div class="d-flex py-4 eachContact">
                            <img width="80" class="contactProfileImage me-4" src="/Assets/Images/addressProfilePic.jpeg" alt="">
                            <div class="eachContactName">name</div>
                            <div class="eachContactMail">email@gmail.com</div>
                            <div class="eachContactNumber">000000000</div>
                            <button class="eachContactButton"  type="button" onclick="editContact()"  data-bs-toggle="modal"  data-bs-target="##staticBackdropEdit">EDIT</button>
                            <button class="eachContactButton">DELETE</button>
                            <button class="eachContactButton " data-bs-toggle="modal" data-bs-target="##staticBackdrop">VIEW</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-1"></div>
        </div>
        
        <cfif structKeyExists(form,"createSubmit")>
            <cfset local.structure = structNew()>
            <cfset local.expandContactPath = "Assets/UploadedImages">
            <cfloop collection="#form#" item="item">
                <cfset local.structure[item] = form[item]>
            </cfloop>
            <cfif form.profilePic EQ "">
                <cfelse>
                    <cffile  
                    action="upload"
                    filefield="form.profilePic"
                    destination="#expandPath(local.expandContactPath)#"
                    nameConflict="MakeUnique"
                    result="contactFile">
            </cfif>
            <cfset local.object = new Component.function()>
            <cfset local.result = local.object.addContacts(local.structure,contactFile.serverfile)>
            <cfif local.result EQ false>
                <div class="text-center">
                    <div class="text-danger fw-bold">Email already exists<div>
                <div>
            </cfif>
        </cfif>
    </cfoutput>
    <script src="./JavaScript/script.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>