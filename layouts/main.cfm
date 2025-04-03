<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/x-icon" href="assets/images/address-book.png">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/default.css">
        <link rel="stylesheet" href="css/home.css">
        <title>Home</title>
    </head>
    <body>
        <main class="main">
            <div class="header">
                <cfoutput>
                    <a href="#buildURL('main')#" class="logo">
                        <img src="assets/images/contact_book_logo.png" alt="Image not found">
                        <span>ADDRESS BOOK</span>
                    </a>
                </cfoutput>
                <cfif rc.action == "main.login">
                    <!--- <div class="header_buttons">
                        <a href="./signup.cfm">
                            <img src="assets/images/user_icon.png" alt="Image not found">
                            Sign Up
                        </a>
                        <a href="./login.cfm">
                            <img src="assets/images/login-2.png" alt="Image not found">
                            Login
                        </a>
                    </div> --->
                <cfelse>
                    <div class="logoutButton">
                        <button id="logout">
                            <img src="assets/images/logout.png" alt="Image not found">
                            Logout
                        </button>
                    </div>
                </cfif>
            </div>
            <cfoutput>
                #body#
            </cfoutput>
        </main>
    </body>
    <script src="js/jquery-3.7.1.js"></script>
    <script src="js/sweetalert2.all.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/validate.js"></script>
    <script src="js/login.js"></script>
    <script src="js/home.js"></script>
</html>