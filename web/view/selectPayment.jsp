<%-- 
    Document   : selectPayment
    Created on : 16-feb-2016, 20:09:12
    Author     : victo
--%>
<%@page import="model.User"%>
<%@page import="model.Booking"%>
<% 
   HttpSession ses = request.getSession(); 
  
%>
<section class="main" >
            <div id="login_cont" class="container">
                <script type="text/javascript" src="./js/payments.js"></script>
                <% if(ses.getAttribute("user")==null){
                    response.sendRedirect("fifthStep.html");
                }else { User userL = (User)ses.getAttribute("user"); %>
                
                <h1 class="h1center">Payment Data</h1>
                <form action="Dispatcher" method="post">
                        <div style="float:left;width:48%;padding:1%">
                        <input type="hidden" name="action" value="saveBooking" />
                        <label for="creditCard">
                            <span>Card Type</span>
                            <select name="ctype" id="ctype" onchange="checkCard();" required >
                                <option value="visa">VISA</option>
                                <option value="visaElectron">VISA ELECTRON</option>
                                <option value="masterCard">MASTER CARD</option>
                            </select>
                        </label>
                        <label for="creditCard">
                            <span>Card Number (xxxx-xxxx-xxxx-xxxx)</span>
                            <input type="text" name="cnumber" id="cnumber" onchange="checkCard();" required />
                            <span id="error"></span>
                        </label>
                        <label for="cvv">
                            <span>CVV</span>
                            
                            <input onchange="checkCVV();" style="float:left;" type="text" name="cvv" size="2" minlength="3" maxlength="3" id="cvv" required/>
                            <img src="./img/cvv.jpg" style="width:20%;cursor:pointer;" onclick="showCVV(this)"  />
                            <div style="clear:left" ></div>
                            <span id="errorcvv"></span>
                            
                        </label>
                        </div>
                          
                        <div style="float:left;width:48%;padding:1%">
                            <label for="name">
                               <span>Expiration (MM / YY)</span>
                              <input type="text" size="1" minlength="2" maxlength="2" name="cmonth" id="cmonth" style="display:inline-block;" required/> 
                              <input type="text" size="1" minlength="2" maxlength="2" name="cyear" id="cyear" style="display:inline-block;"  required/>
                            </label>
                            <label for="nif">
                              <span>Cardholder</span>
                              <input type="text" name="cholder" id="cholder" required/>
                            </label>
                        </div>
                        <div style="clear:left"></div>
                        <input style="margin-left:7%;" type="checkbox" value="1" /> <span style="font-size:0.85em">I accept the Zapdos Airlines <a href="#">terms and conditions</a>.</span>
                        <% if(userL.getLastPayment()!=null){ %><input class="login_button" type="button" onclick="useData('<%=userL.getLastPayment().getCreditCard() %>','<%=userL.getLastPayment().getCreditUser() %>','<%=userL.getLastPayment().getCyear() %>','<%=userL.getLastPayment().getCmonth() %>')" value="Use the last booking payment data" />  <% } %>
                        <input type="submit" id="register_b" class="login_button" value="Payment" />   
                    </form>
                <% } %>
            </div>
            <section class="sessionBox"> 
            <h1 class="sessionBox_head">Shopping cart</h1>
            <div class="sessionBox_content" id="cart"> Loading... </div>
            <script>refreshCart();</script>
             <button onClick="window.location = 'sixthStep.html';" class="previous_butt_small">Previous Step</button>
           
            </section>
            <div style="clear:left"></div>
</section >