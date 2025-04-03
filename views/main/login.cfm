
<div class="main_body">
    <div class="form_container">
        <div class="form_left">
            <img src="assets/images/contact_book_logo.png" alt="Image not found">
        </div>
        <form method="post" class="form_right">
            <div class="form_heading">
                LOGIN
            </div>
            <input 
                type="text" 
                placeholder="Email Id" 
                name = "emailId" 
                class="input_fields" 
                id="userName"
            >
            <div id="userNameError" class="errorMessage"></div>

            <input 
                type="password" 
                placeholder="Password" 
                name="password" 
                class="input_fields" 
                id="password"
            >
            <div id="passwordError" class="errorMessage"></div>

            <cfif len(rc.error)>
                <div class="errorMessage">
                    <cfoutput>
                        #rc.error#
                    </cfoutput>
                </div>
            </cfif>
            <input type="submit" onclick="loginValidate(event)" class="submit_btn" name="loginButton" value="LOGIN">

            <div class="sign_options">
                <span >
                    Or Sign in Using
                </span>
                <div>
                    <a href><img src="assets/images/facebook.png" alt="Image not found"></a>
                    <a href><img src="assets/images/Google.png" alt="Image not found"></a>
                </div>
            </div>
            <!--- <div class="register_link">
                Don't have an account? <a href="signup.cfm">Register here</a> 
            </div> --->
        </form>
    </div>
</div>
