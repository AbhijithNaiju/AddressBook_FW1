<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/default.css">
        <link rel="stylesheet" href="css/home.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <title>Home</title>
    </head>
    <body>
        <cfset local.uploadDirectory = "assets/contactPictures/">

        <cfif NOT directoryExists(expandPath(local.uploadDirectory))>
            <cfset directoryCreate(expandPath(local.uploadDirectory))>
        </cfif>

        <main class="main position_absolute">
            <div class="header">
                <cfoutput>
                    <a href="#buildURL('main')#" class="logo">
                        <img src="assets/images/contact_book_logo.png" alt="Image not found">
                        <span>ADDRESS BOOK</span>
                    </a>
                </cfoutput>
                <div class="logout_button">
                    <button onclick="logout()">
                        <img src="assets/images/logout.png" alt="Image not found">
                        Logout
                    </button>
                </div>
            </div>
            <div class="home_body">
                <div class="home_elements">
                    <div class="profile_box">
                    <cfoutput>
                        <cfif rc.userDetails.profileImage EQ "">
                            <cfset local.userProfileImage = "assets/contactPictures/l60Hf.png">
                        <cfelse>
                            <cfset local.userProfileImage = rc.userDetails.profileImage>
                        </cfif>
                        <img src="#local.userProfileImage#" alt="image not found">
                        <div class="profile_name">#rc.userDetails.fullName#</div>
                    </cfoutput>
                        <button onclick="openEditModal(this)" value="">CREATE CONTACT</button>
                    </div>

                    <div class="contact_list" id="contactList">
                        <div class="contact_list_heading">
                            <div class="list_profile">

                            </div>
                            <div class="list_name">
                                NAME
                            </div>
                            <div class="list_email">
                                EMAIL ID
                            </div>
                            <div class="list_phone">
                                PHONE NUMBER
                            </div>
                            <div class="list_button">
                                
                            </div>
                        </div>

                        <cfloop query="rc.contactList">
                            <cfoutput>
                                <div class="contact_list_item" id="#rc.contactList.contactId#">
                                    <div class="list_profile">
                                        <img src="assets/contactPictures/l60Hf.png" alt="Image not found">
                                    </div>
                                    <div class="list_name">
                                        #rc.contactList.firstName# #rc.contactList.lastName#
                                    </div>
                                    <div class="list_email">
                                        #rc.contactList.emailId#
                                    </div>
                                    <div class="list_phone">
                                        #rc.contactList.phoneNumber#
                                    </div>
                                    <div class="list_button">
                                        <button type="button" value="#rc.contactList.contactId#" onclick="openEditModal(this)" class = "contactButtons">EDIT</button>
                                        <button type="button" value="#rc.contactList.contactId#" onclick="deleteContact(this)" class = "contactButtons">DELETE</button>
                                        <button type="button" value="#rc.contactList.contactId#" onclick="openViewModal(this)" class = "contactButtons">VIEW</button>
                                    </div>
                                </div>
                            </cfoutput>
                        </cfloop>
                    </div>
                </div>

            </div>
        </main>
    </body>
</html>