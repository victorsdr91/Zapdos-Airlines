<%-- 
    Document   : loginRegister
    Created on : 16-feb-2016, 10:34:36
    Author     : victo
--%>

<%@page import="model.User"%>
<% 
   HttpSession ses = request.getSession(true); 
   User userL = (User) ses.getAttribute("user");
   if(userL==null){
%>

<section class="main" >
            <div id="login_cont" class="container_extended">
                <div >
                    <h1 class="h1center">Have an account?</h1>
                    <form action="userLogin" method="post" >
                        <div style="text-align:center; width: 100%">
                        <label style="margin:0" for="username">
                            <span>Email</span>
                            <input type="email" name="username" />
                        </label>
                        <label style="margin:0" for="password">
                            <span>Password</span>
                            <input type="password" name="password" />
                        </label>
                       <input type="hidden" value="<%=ses.getAttribute("section")%>" name="returnS" />
                        </div>
                        <button type="submit" id="login" class="login_button" style="display:block;margin:auto;margin-top:20px; text-align:center;" >Login</button>
                         <a href="#" class="min">Lost account?</a>
                        
                    </form>
                </div>
                
            <div style="clear:left"></div>
            </div>
</section >

<% 
   }else{ %>
   <script>window.history.go(-1);</script> 
   <% }
%>