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
                                    <div class="contactEditModalHead mx-auto">EDIT CONTACT</div>
                                </div>
                                <form action="" method="">
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
                                            <select name="" id="" class="editContactPersonalInput">
                                                <option value="" selected hidden></option>
                                                <option value="Mr">Mr</option>
                                                <option value="Ms">Ms</option>
                                            </select>
                                        </div>
                                        <div>
                                            <input class="editContactPersonalInput" placeholder="Your First Name" type="text">
                                        </div>
                                        <div>
                                            <input class="editContactPersonalInput" placeholder="Your Lat Name" type="text">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3 mt-3">
                                        <div class="createContactFields">Gender <span>*</span></div>
                                        <div class="me-5 createContactFields">Date Of Birth <span>*</span></div>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3">
                                        <div>
                                            <select name="" id="" class="editContactPersonalInput">
                                                <option value="" selected hidden></option>
                                                <option value="Male">Male</option>
                                                <option value="Female">Female</option>
                                            </select>
                                        </div>
                                        <div>
                                            <input class="editContactPersonalInput" type="date">
                                        </div>
                                    </div>
                                    <div>
                                        <div class="mb-2 createContactFields">Upload Photo <span>*</span></div>
                                    </div>
                                    <div>
                                        <input class="editContactPersonalInputFile" type="file">
                                    </div>
                                    <div>
                                        <div class="mb-3 mt-2 personalDetailsHead">Contact Details</div>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3 mt-3">
                                        <div class="createContactFields">Address<span>*</span></div>
                                        <div class="createContactFields me-5">Street <span>*</span></div>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <input class="editContactPersonalInput" placeholder="Your Address" type="text">
                                        </div>
                                        <div>
                                            <input class="editContactPersonalInput" placeholder="Your Street Name" type="text">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3 mt-3">
                                        <div class="createContactFields">Address<span>*</span></div>
                                        <div class="createContactFields me-5">Street <span>*</span></div>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <input class="editContactPersonalInput" placeholder="Your Address" type="text">
                                        </div>
                                        <div>
                                            <input class="editContactPersonalInput" placeholder="Your Street Name" type="text">
                                        </div>
                                    </div>
                                </form>
                                <div class="text-center">
                                    <button type="button py-3" class="modalBtnClose " data-bs-dismiss="modal" aria-label="Close">CLOSE</button>
                                </div>
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
                            <button class="rounded-pill createContactbutton px-1 py-1">CREATE CONTACT</button>
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
                            <button class="eachContactButton"  data-bs-toggle="modal" data-bs-target="##staticBackdropEdit">EDIT</button>
                            <button class="eachContactButton">DELETE</button>
                            <button class="eachContactButton " data-bs-toggle="modal" data-bs-target="##staticBackdrop">VIEW</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-1"></div>
            
        </div>
    </cfoutput>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>