<%-- 
    Document   : PassengerData
    Created on : 02-feb-2016, 12:03:47
    Author     : victo
--%>

<%@page import="model.Passenger"%>
<%@page import="model.Booking"%>
<section class="main" >
    <div id="passengers_data" class="container"> 
        <h1><fmt:message key="Passenger.Data" /></h1>
        <form action="savePassengers" method="post" >
            <%
                HttpSession ses = request.getSession();
                Booking booking = (Booking) ses.getAttribute("booking");
                int i = 0, j = 0;
                for (Passenger passenger : booking.getDepartureFlight().getPassengers()) {
                     String name = (passenger.getName()!=null) ? passenger.getName() : "";
                     String surname = (passenger.getSurName()!=null) ? passenger.getSurName() : "";
                     String nif = (passenger.getNif()!=null) ? passenger.getNif() : "";
                     String country = (passenger.getCountry()!=null) ? passenger.getCountry() : "";
                     String state = (passenger.getState()!=null) ? passenger.getState() : "";
                     String birthdate = (passenger.getBirthDate()!=null) ? passenger.getBirthDate().toString() : "";
            %>
            <div id="<% out.print(passenger.getType() + "_" + (i + j)); %>" class="passenger_lbl">

                <h1><% if (passenger.getType().equals("adult")) { %>
                        <fmt:message key='Adult' /> <% out.print("" + (i + 1));
                        i++;
                    }
                    if (passenger.getType().equals("child")) { %>
                        <fmt:message key='Child' /> <%out.print(" " + (j + 1));
                        j++;
                    }
                    %> </h1>
                <label for="name_passenger_<% out.print(i + j); %>">
                    <span><fmt:message key='Name' />: </span>
                    <input type="text" name="name_passenger_<% out.print(i + j); %>" value="<%=name%>" required/>
                </label>
                <label for="nif_passenger_<% out.print(i + j); %>">
                    <span>DNI/NIF: </span>
                    <input type="text"  class="nif" onchange="checkNIF(this.value);"  name="nif_passenger_<% out.print(i + j); %>" value="<%=nif%>" required/>
                </label>
                <label for="surname_passenger_<% out.print(i + j); %>">
                    <span><fmt:message key='Surname' />: </span>
                    <input type="text" name="surname_passenger_<% out.print(i + j); %>" value="<%=surname%>" required/>
                </label>
                <%if(passenger.getType().equals("adult")){ %>
                <label for="birthdate_passenger_<% out.print(i + j); %>">
                        <span><fmt:message key='Birthdate' />: </span>
                        <input type="text" class="birthdatepicker_adult" name="birthdate_passenger_<% out.print(i + j); %>" value="<%=birthdate%>" required />
                </label>
                <% }else if(passenger.getType().equals("child")){ %>
                <label for="birthdate_passenger_<% out.print(i + j); %>">
                        <span><fmt:message key='Birthdate' />: </span>
                        <input type="text" class="birthdatepicker_child" name="birthdate_passenger_<% out.print(i + j); %>" value="<%=birthdate%>" required />
                </label>
                <% } %>
                <hr />
                <label for="country_passenger_<% out.print(i + j); %>">
                    <span><fmt:message key='Country' />: </span>
                    <select type="text" id="country_passenger_<% out.print(i + j); %>" name="country_passenger_<% out.print(i + j); %>" required >
                        <%@include file="./countries.jsp" %>
                    </select>    
                </label>
                <label for="state_passenger_<% out.print(i + j); %>">
                    <span><fmt:message key='State' />: </span>
                    <input type="text" name="state_passenger_<% out.print(i + j); %>" value="<%=state%>" required/>
                </label>
                <script>checkCountry('country_passenger_<% out.print(i + j); %>','<%=country%>');</script>
                <% if (passenger.getBaby() != null) { 
                     String nameB = (passenger.getBaby().getName()!=null) ? passenger.getBaby().getName() : "";
                     String surnameB = (passenger.getBaby().getSurName()!=null) ? passenger.getBaby().getSurName() : "";
                     String nifB = (passenger.getBaby().getNif()!=null) ? passenger.getBaby().getNif() : "";
                     String countryB = (passenger.getBaby().getCountry()!=null) ? passenger.getBaby().getCountry() : "";
                     String stateB = (passenger.getBaby().getState()!=null) ? passenger.getBaby().getState() : "";
                     String birthdateB = (passenger.getBaby().getBirthDate()!=null) ? passenger.getBaby().getBirthDate().toString() : "";
                
                %>
                <div id="baby_<% out.print(i); %>" class="baby_passenger_lbl">
                    <h1><fmt:message key='Infant' /> <% out.print(i); %></h1>
                    <label for="name_babypassenger_<% out.print(i + j); %>">
                        <span><fmt:message key='Name' />: </span>
                        <input type="text" name="name_babypassenger_<% out.print(i + j); %>" value="<%=nameB%>" required/>
                    </label>
                    <label for="nif_babypassenger_<% out.print(i + j); %>">
                        <span>DNI/NIF: </span>
                        <input type="text" class="nif" onchange="checkNIF(this.value);" name="nif_babypassenger_<% out.print(i + j); %>" value="<%=nifB%>" required/>
                    </label>
                    <label for="surname_babypassenger_<% out.print(i + j); %>">
                        <span><fmt:message key='Surname' />: </span>
                        <input type="text" name="surname_babypassenger_<% out.print(i + j); %>" value="<%=surnameB%>" required/>
                    </label>
                    <label for="birthdate_babypassenger_<% out.print(i + j); %>">
                        <span><fmt:message key='Birthdate' />: </span>
                        <input type="text" class="birthdatepicker_baby" name="birthdate_babypassenger_<% out.print(i + j); %>" value="<%=birthdateB%>" required />
                    </label>
                    <hr />
                    <label for="country_babypassenger_<% out.print(i + j); %>">
                        <span><fmt:message key='Country' />: </span>
                        <select type="text" name="country_babypassenger_<% out.print(i + j); %>"  required >
                            <%@include file="./countries.jsp" %>
                        </select>    
                    </label>
                    <label for="state_babypassenger_<% out.print(i + j); %>">
                        <span><fmt:message key='State' />: </span>
                        <input type="text" name="state_babypassenger_<% out.print(i + j); %>" value="<%=stateB%>" required/>
                    </label>
                </div>
                    <script>checkCountry('<%=country%>','b');</script>
                <% } %>
            </div>
            <%

                }
            %>
            <button type="submit" id="continue" class="continue_butt"><fmt:message key="main.fly.label.continue" /></button>
        </form>
         <script>loadbirthdatepicker();</script>
    </div> 
    <section class="sessionBox"> 
        <h1 class="sessionBox_head"><fmt:message key="Shopping.cart" /></h1>
        <div class="sessionBox_content" id="cart"> Loading... </div>
        <script>refreshCart();</script>
        <% if(ses.getAttribute("booking")!=null && ((Booking)ses.getAttribute("booking")).getDepartureFlight()!=null){
                        %> <button onClick="window.location = 'firstStep.html';" class="previous_butt_small">Previous Step</button> <%
                    } %>
        <% if(ses.getAttribute("booking")!=null && (((Booking)ses.getAttribute("booking")).getDepartureFlight().getPassengers()!= null) && (((Booking)ses.getAttribute("booking")).getDepartureFlight().getPassengers().get(0).getName()!= null)){
                        %> <button onClick="window.location = 'thirdStep.html';" class="continue_butt_small">Next Step</button> <%
                    } %>
    </section>
    <div style="clear:left"></div>
</section >