<body>
    <main class="main">
        <div class="header">
            <cfoutput>
                <a href="#buildURL('main')#" class="logo">
                    <img src="assets/images/contact_book_logo.png" alt="Image not found">
                    <span>ADDRESS BOOK</span>
                </a>
            </cfoutput>
            <div class="logoutButton">
                <button onclick="logout()">
                    <img src="assets/images/logout.png" alt="Image not found">
                    Logout
                </button>
            </div>
        </div>
        <div class="homeBody">
            <div class="homeElements">
                <div class="profileBox">
                    <cfoutput>
                        <cfif len(rc.userDetails.profileImage)>
                            <cfset local.userProfileImage = rc.userDetails.profileImage>
                        <cfelse>
                            <cfset local.userProfileImage = "l60Hf.png">
                        </cfif>
                        <img src="assets/contactPictures/#local.userProfileImage#" alt="image not found">
                        <div class="profileName">#rc.userDetails.fullName#</div>
                    </cfoutput>
                    <button 
                        onclick="openEditModal(this)" 
                        data-bs-toggle="modal" 
                        data-bs-target="#editModal" 
                        class = "createButton"
                        value=""
                    >
                        CREATE CONTACT
                    </button>
                </div>

                <div class="contactListContainer" id="contactList">
                    <table class="contactList">
                        <tr class="contactListHeading">
                            <th class="listProfile">

                            </th>
                            <th class="listName">
                                NAME
                            </th>
                            <th class="listEmail">
                                EMAIL ID
                            </th>
                            <th class="listPhone">
                                PHONE NUMBER
                            </th>
                            <th class="listButton">
                                
                            </th>
                        </tr>

                        <cfloop query="rc.contactList">
                            <cfoutput>
                                <tr class="contactListItem">
                                    <td class="listProfile">
                                        <cfif len(rc.contactList.profileImage)>
                                            <cfset variables.contactProfileImage = contactItem.getprofileImage()>
                                        <cfelse>
                                            <cfset variables.contactProfileImage = "assets/contactPictures/l60Hf.png">
                                        </cfif>
                                        <img src="#variables.contactProfileImage#" alt="Image not found">
                                    </td>
                                    <td class="listName">
                                        #rc.contactList.firstName# #rc.contactList.lastName#
                                    </td>
                                    <td class="listEmail">
                                        #rc.contactList.emailId#
                                    </td>
                                    <td class="listPhone">
                                        #rc.contactList.phoneNumber#
                                    </td>
                                    <td class="listButton">
                                        <button type="button" 
                                            value="#rc.contactList.contactId#" 
                                            onclick="openEditModal(this)" 
                                            class = "contactButtons"
                                            data-bs-toggle="modal" 
                                            data-bs-target="##editModal" 
                                        >
                                            EDIT
                                        </button>
                                        <button type="button" 
                                            value="#rc.contactList.contactId#" 
                                            onclick="deleteContact(this)" 
                                            class = "contactButtons"
                                        >
                                            DELETE
                                        </button>
                                        <button 
                                            type="button" 
                                            value="#rc.contactList.contactId#" 
                                            onclick="openViewModal(this)" 
                                            class = "contactButtons"
                                            data-bs-toggle="modal" 
                                            data-bs-target="##viewModal" 
                                        >
                                            VIEW
                                        </button>
                                    </td>
                                </tr>
                            </cfoutput>
                        </cfloop>
                    </table>
                </div>
            </div>
        </div>
    </main>
    <div class="modal" id="editModal" tabindex="-1">
        <form 
            method="post" 
            class="modal-dialog modal-dialog-scrollable modal-lg" 
            id="createForm" 
            enctype="multipart/form-data" 
            autocomplete
        >
            <div class="modal-content">
                <div class="modal-body d-flex my-2">
                    <div class = "editFormBody">
                        <div class="modalHeading" id="modalHeading"></div>

                        <div class="modalSubHeadng">
                            Personal details
                        </div>
                    
                        <div class="editModalElement">
                            <div class="width_20">
                                <label for="">Title *</label>
                                <select class="formElement" id="title" name="title">
                                    <option value=""></option>
                                    <option value="Mr">Mr</option>
                                    <option value="Mrs">Mrs</option>
                                </select>
                                <div class="errorMessage" id="titleError"></div>
                            </div>
                            <div class="width_30">
                                <label for="">First name *</label>
                                <input type="text" placeholder=" First name" class="formElement" id="firstName" name="firstName">
                                <div class="errorMessage" id="firstNameError"></div>
                            </div>
                            <div class="width_30">
                                <label for="">Last name *</label>
                                <input type="text" placeholder=" Last name" class="formElement" id="lastName" name="lastName">
                                <div class="errorMessage" id="lastNameError"></div>
                            </div>
                        </div>

                        <div class="editModalElement">
                            <div class="width_45">
                                <label for="">Gender *</label>
                                <select class="formElement" id="gender" name="gender">
                                    <option value=""></option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                                <div class="errorMessage" id="genderError"></div>
                            </div>
                            <div class="width_45">
                                <label for="">Date of Birth *</label>
                                <cfoutput>
                                    <input type="date" class="formElement" id="dateOfBirth" name="dateOfBirth" max="#dateformat(now(),"yyyy-mm-dd")#">
                                </cfoutput>
                                <div class="errorMessage" id="dateOfBirthError"></div>
                            </div>
                        </div>

                        <div class="editModalElement">
                            <div class="w-100">
                                <label for="">Upload Photo *</label>
                                <input type="file" class="formElement" id="profileImage" name="profileImage">
                                <input type="hidden" name="profileDefault" id="profileDefault">
                                <div class="errorMessage" id="profileImageError"></div>
                            </div>
                        </div>
                        <div class="modalSubHeadng">
                            Contact details
                        </div>

                        <div class="editModalElement">
                            <div class="width_45">
                                <label for="">Address *</label>
                                <input type="text" placeholder=" Address" class="formElement" name="address" id="address">
                                <div class="errorMessage" id="addressError"></div>
                            </div>
                            <div class="width_45">
                                <label for="">Street *</label>
                                <input type="text" placeholder=" Street Name" class="formElement" id="streetName" name="streetName">
                                <div class="errorMessage" id="streetNameError"></div>
                            </div>
                        </div>

                        <div class="editModalElement">
                        <div class="width_45">
                            <label for="">Pincode *</label>
                                <input type="text" placeholder=" Pincode" class="formElement" id="pincode" name="pincode">
                                <div class="errorMessage" id="pincodeError"></div>
                            </div>
                            <div class="width_45">
                                <label for="">District *</label>
                                <input type="text" placeholder=" District" class="formElement" id="district" name="district">
                                <div class="errorMessage" id="districtError"></div>
                            </div>
                        </div>

                        <div class="editModalElement">
                            <div class="width_45">
                                <label for="">State *</label>
                                <input type="text" placeholder=" State" class="formElement" name="state" id="state">
                                <div class="errorMessage" id="stateError"></div>
                            </div>
                            <div class="width_45">
                                <label for="">Country *</label>
                                <input type="text" placeholder=" Country" class="formElement" name="country" id="country">
                                <div class="errorMessage" id="countryError"></div>
                            </div>
                        </div>

                        <div class="editModalElement">
                            <div class="width_45">
                                <label for="">Phone *</label>
                                <input type="text" placeholder=" Phone" class="formElement" name="phoneNumber" id="phoneNumber">
                                <div class="errorMessage" id="phoneNumberError"></div>

                            </div>
                            <div class="width_45">
                                <label for="">Email *</label>
                                <input type="text" placeholder="Email" class="formElement" name="email" id="email">
                                <div class="errorMessage" id="emailError"></div>
                            </div>
                        </div>
                        <div class="errorMessage" id="editModalError"></div>

                    </div>
                    <div class="editFormImage">
                        <img src="assets/contactPictures/l60Hf.png" id="profileImageEdit" alt="Image not found">
                    </div>
                </div>
                <div class="modal-footer">
                    <button 
                        type="button" 
                        class="btn btn-secondary" 
                        data-bs-dismiss="modal"
                        id = "closeEditModal"
                    >
                        Close
                    </button>
                    <button 
                        type="button" 
                        id="submitEditModalBtn"
                        class="btn btn-primary"
                        onclick="submitEditModal(this)"
                    >
                        Save changes
                    </button>
                </div>
            </div>
        </form>
    </div>
    <div class="modal" id="viewModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-scrollable modal-lg">
            <div class="modal-content">
                <div class="d-flex modal-body">
                    <div class="editFormBody"  enctype="multipart/form-data">
                        <div class="modalHeading">
                            CONTACT DETAILS
                        </div>
                        <div id="viewModalBody">
                            <div class="contactDetails">
                                <div class="contactItemName">Name</div>
                                <div class="contactItemValue" id="viewContactName"></div>
                            </div>
                            <div class="contactDetails">
                                <div class="contactItemName">Gender</div>
                                <div class="contactItemValue" id="viewContactGender"></div>
                            </div>
                            <div class="contactDetails">
                                <div class="contactItemName">Date of birth</div>
                                <div class="contactItemValue" id="viewContactDateOfBirth"></div>
                            </div>
                            <div class="contactDetails">
                                <div class="contactItemName">Address</div>
                                <div class="contactItemValue" id="viewContactAddress"></div>
                            </div>
                            <div class="contactDetails">
                                <div class="contactItemName">Pincode</div>
                                <div class="contactItemValue" id="viewContactPincode"></div>
                            </div>
                            <div class="contactDetails">
                                <div class="contactItemName">Email Id</div>
                                <div class="contactItemValue" id="viewContactEmailId"></div>
                            </div>
                            <div class="contactDetails">
                                <div class="contactItemName">Phone Number</div>
                                <div class="contactItemValue" id="viewContactPhoneNumber"></div>
                            </div>
                        </div>
                    </div>
                    <div class="viewFormImage">
                        <img src="assets/contactPictures/l60Hf.png" alt="Image not found" id = "viewProfileImage">
                    </div>
                </div>
                <div class="modal-footer">
                    <button 
                        type="button" 
                        class="btn btn-secondary" 
                        data-bs-dismiss="modal"
                    >
                        Close
                    </button>
                </div>
            </div>
        </div>
    </div>
</body>