<%-- 
    Document   : loginRegister
    Created on : 16-feb-2016, 10:34:36
    Author     : victo
--%>

<%@page import="model.Booking"%>
<% 
   HttpSession ses = request.getSession(true); 
   Booking booking = (Booking)ses.getAttribute("booking");
   ses.setAttribute("section", "sixthStep.html");
  
%>
 <% if(ses.getAttribute("user")!=null){ 
     response.sendRedirect("sixthStep.html");
} %>
<section class="main" >
            <div id="login_cont" class="container">
                <div class="div50" id="login">
                    <h1 class="h1center">Have an account?</h1>
                    <form action="userLogin" method="post" >
                        <div style="padding:2%;">
                        <label for="username">
                            <span>Email</span>
                            <input type="email" name="username" />
                        </label>
                        <label for="password">
                            <span>Password</span>
                            <input type="password" name="password" />
                        </label>
                       <input type="hidden" value="sixthStep.html" name="returnS" />
                        </div>
                        <button type="submit" id="login" class="login_button" >Login</button>
                         <a href="#" class="min">Lost account?</a>
                        
                    </form>
                </div>
                <div class="div50" style="border-left:1px #121f52 solid" id="register">
                    <script type="text/javascript" src="./js/checkRegisterForm.js" ></script>
                     <h1 class="h1center">New register</h1>
                      <form action="Dispatcher" method="post">
                        <div style="float:left;width:40%;padding:2%">
                        <input type="hidden" name="action" value="userRegister" />
                        <label for="email">
                            <span>Email</span>
                            <input type="email" name="email" id="email" onchange="checkEmail(this.value);" required />
                        </label>
                        <label for="password">
                            <span>Password</span>
                            <input type="password" name="password" minlength="8" maxlength="16" id="rpassword" onchange="checkPassword()" required/>
                        </label>
                        <label for="confpassword">
                            <span>Repeat Password</span>
                            <input type="password" name="confpassword"  minlength="8" maxlength="16" id="rconfpassword" onchange="checkPassword()" required/>
                        </label>
                        </div>
                          
                        <div style="float:left;width:40%;padding:2%">
                            <label for="name">
                              <span>Name</span>
                              <input type="text" name="name" required/>
                          </label>
                            <label for="surname">
                              <span>Surname</span>
                              <input type="text" name="surname" required/>
                          </label>
                            <label for="nif">
                              <span>NIF</span>
                              <input type="text" name="nif" id="nif" onchange="checkNIF(this.value);" required/>
                          </label>
                        </div>
                          <div style="clear:left"></div>
                        <input type="submit" id="register_b" class="login_button" onclick="checkData()" value="Create account" />   
                    </form>
                </div>
            
            </div>
            <section class="sessionBox"> 
            <h1 class="sessionBox_head">Shopping cart</h1>
            <div class="sessionBox_content" id="cart"> Loading... </div>
            <script>refreshCart();</script>
                 <button onClick="window.location = 'fourthStep.html';" class="previous_butt_small">Previous Step</button> 
            </section>
            <div style="clear:left"></div>
</section >