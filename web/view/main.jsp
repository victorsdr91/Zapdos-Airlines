<%-- 
    Document   : main
    Created on : 28-ene-2016, 22:06:26
    Author     : victo
--%>
<%@page import="model.User"%>
<%@page import="model.Booking"%>
<section class="main flightbg" >
            <div id="fly_id" >
            
                <%  HttpSession ses = request.getSession();
                    String fromAirport = (ses.getAttribute("booking")!=null) ? (((Booking)ses.getAttribute("booking")).getDepartureFlight()!=null) ? ((Booking)ses.getAttribute("booking")).getDepartureFlight().getConnection().getOriginAirport().getCountry()+": "+((Booking)ses.getAttribute("booking")).getDepartureFlight().getConnection().getOriginAirport().getCity() : "" : "";
                    String toAirport = (ses.getAttribute("booking")!=null) ? (((Booking)ses.getAttribute("booking")).getDepartureFlight()!=null) ? ((Booking)ses.getAttribute("booking")).getDepartureFlight().getConnection().getDestinationAirport().getCountry()+": "+((Booking)ses.getAttribute("booking")).getDepartureFlight().getConnection().getDestinationAirport().getCity() : "" : "";
                    String depDate = (ses.getAttribute("booking")!=null) ? (((Booking)ses.getAttribute("booking")).getDepartureFlight()!=null) ? ((Booking)ses.getAttribute("booking")).getDepartureFlight().getDepartureDate().toString() : "" : "";
                    String backDate = (ses.getAttribute("booking")!=null) ? (((Booking)ses.getAttribute("booking")).getBackFlight()!=null) ? ((Booking)ses.getAttribute("booking")).getBackFlight().getDepartureDate().toString() : "" : "";
                    int adults = ses.getAttribute("adults")!=null ? (Integer)ses.getAttribute("adults") : 0;
                    int childs = ses.getAttribute("childs")!=null ? (Integer)ses.getAttribute("childs") : 0;
                    int infants = ses.getAttribute("infants")!=null ? (Integer)ses.getAttribute("infants"): 0;
                    
                
                %>
                
                <div class="header"> <span ><fmt:message key="main.fly.span.flight" /></span><% if(ses.getAttribute("user")!=null) { %> <span class="inactive" onclick="window.location='checkin.html'" ><fmt:message key="check.in" /></span> <% if(((User)ses.getAttribute("user")).isAdmin()){ %><span class="inactive" onclick="window.location='admin.html'" >Admin Panel</span> <% }} %></div>
                <script type="text/javascript" src="js/temperature.js" ></script> 
                <form action="Dispatcher" method="post" >
                     <input type="hidden" id="action" name="action" value="loadFlights" />
                    <input type="hidden" id="adults" name="adults" value="<% out.print(adults); %>" />
                    <input type="hidden" id="childs" name="childs" value="<% out.print(childs); %>" />
                    <input type="hidden" id="infants" name="infants" value="<% out.print(infants); %>" />
                    
                    <div class="label">
                        <span><fmt:message key="main.fly.label.from" /></span>
                        <select class="input" name="from" id="fromAirports" onchange="loadTo(this.value);" ></select>
                        <script>
                            loadFrom();
                        </script>
                        <br/>
                        <div class="temp" id="fromtemp">
                            Loading...
                        </div>
                    </div>
                    <div class="label">
                        <span><fmt:message key="main.fly.label.to" /> </span>
                         <select class="input" name="to" id="toAirports" ></select>
                         <br/>
                        <div class="temp" id="totemp">
                            Loading...
                        </div>
                    </div>
                    <div class="label2">
                        <span><fmt:message key="main.fly.label.departuredate" /> </span>
                         <input type="text" name="fromDate" class="input hasDatePicker" id="fromDate" name="fromDate" autocomplete="off" value="<% out.print(depDate); %>" required />
                    </div>
                    <div class="label2">
                        <span><fmt:message key="main.fly.label.dateback" /> </span>
                         <input type="text" name="toDate" class="input hasDatePicker"  id="toDate" name="toDate" autocomplete="off"  value="<% out.print(backDate); %>"/>
                    </div>
                    <div class="label2" style="min-width:180px;">
                        <span><fmt:message key="main.fly.label.passengers" /> </span>
                        <input type="text" class="input" id="passengers" onclick="showPassengers()"   value="<% out.print(adults+childs+infants); %> Pasajeros" required autocomplete="off"/>
                    </div>
                        <button type="submit" id="continue" class="continue_butt"><fmt:message key="main.fly.label.continue" /></button>
                </form>
                <script>
                    adults = <% out.print(adults); %>;
                    child = <% out.print(childs); %>;
                    infant = <% out.print(infants); %>;
                </script>
            </div>
              <section class="sessionBox"> 
                <h1 class="sessionBox_head">Shopping cart</h1>
                <div class="sessionBox_content" id="cart"> Loading... </div>
                <script>refreshCart();</script>
                <% if(ses.getAttribute("booking")!=null && ((Booking)ses.getAttribute("booking")).getDepartureFlight()!=null){
                        %> <button onClick="window.location = 'firstStep.html';" class="continue_butt_small">Next Step</button> <%
                    }
                %>
            </section>
        </section >
        <section class="sec">
            
        </section>
