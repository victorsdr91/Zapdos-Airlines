<%-- 
    Document   : selectServices
    Created on : 04-feb-2016, 12:56:54
    Author     : victo
--%>
<%@page import="java.util.Iterator"%>
<%@page import="model.Service"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Passenger"%>
<%@page import="model.Booking"%>
<%
    HttpSession ses = request.getSession(true);
    ses.setAttribute("section", "thirdStep.html");
    Booking booking = (Booking) ses.getAttribute("booking");
    ArrayList<Service> services = (ArrayList<Service>) ses.getAttribute("services");
    String language = (String)session.getAttribute("language").toString();
%>
<section class="main" >
    <div id="services_cont" class="container"> 
        <div class="departure_services">
            <h2><fmt:message key="Departure.services" /></h2>
            <% int i = 0, a = 0, c = 0;
                        int j;
                        for (Passenger passenger : booking.getDepartureFlight().getPassengers()) { %>
            <div class="passenger_lbl" id="passengers_<% out.print(i);%>">
                <h1><%=passenger.getName()%> <%=passenger.getSurName()%> </h1>
                <% j = 0;
                            for (Service service : services) { %>
                <% if (!service.getCode().equals("B")) { %>
                <div class="service" id="<% out.print(service.getCode()); %>">
                    <h3><%if(language.contains("es_ES")) out.print(service.getDescripcion()); else if(language.contains("en_GB")) out.print(service.getDescription());  %></h3>
                    <span><fmt:message key="Price" />: <% out.print(service.getPrice()); %> &euro; </span>

                    <%  boolean getted = false;
                        Iterator itps = passenger.getServices().iterator();
                        while (itps.hasNext()) {
                            if (service.getCode().equals(((Service) itps.next()).getCode())) {
                                getted = true;
                            }
                        }
                        if (getted) {%>
                    <button class="continue_butt_small" style="color: red; margin-left:45%; " id="service_<%=j%><%=i%>_d" style="margin-left:45%" onclick="deleteBookingService('d',<%=i%>,<%=j%>);">Delete service</button>
                    <% } else {%>
                    <button class="continue_butt_small" id="service_<%=j%><%=i%>_d" style="margin-left:45%" onclick="addBookingService('d',<%=i%>,<%=j%>);">Add service</button>
                    <% } %>

                </div>
                <% }
                                    j++;
                                } %>
                <div style="clear:left" ></div>
            </div>
            <% i++;
                        } %>
        </div>
        <% if (booking.getBackFlight() != null) { %>
        <div class="back_services">
            <h2><fmt:message key="Back.services" /></h2>
            <%  i = 0;
                a = 0;
                c = 0;
                for (Passenger passenger : booking.getBackFlight().getPassengers()) { %>
            <div class="passenger_lbl" id="passengers_<% out.print(i);%>">
                <h1><%=passenger.getName()%> <%=passenger.getSurName()%></h1>
                <% j = 0;
                            for (Service service : services) { %>
                <% if (!service.getCode().equals("B")) { %>
                <div class="service" id="<% out.print(service.getCode()); %>">
                    <h3><% out.print(service.getDescripcion());  %></h3>
                    <span><fmt:message key="Price" />: <% out.print(service.getPrice()); %> &euro; </span>

                    <%  boolean getted = false;
                        Iterator itps = passenger.getServices().iterator();
                        while (itps.hasNext()) {
                            if (service.getCode().equals(((Service) itps.next()).getCode())) {
                                getted = true;
                            }
                        }
                        if (getted) {%>
                    <button class="continue_butt_small" style="color: red;" id="service_<%=j%><%=i%>_b" style="margin-left:45%" onclick="deleteBookingService('b',<%=i%>,<%=j%>);">Delete service</button>
                    <% } else {%>
                    <button class="continue_butt_small" id="service_<%=j%><%=i%>_b" style="margin-left:45%" onclick="addBookingService('b',<%=i%>,<%=j%>);">Add service</button>
                    <% } %>

                </div>
                <% }
                                    j++;
                                } %>
                <div style="clear:left" ></div>
            </div>
            <% i++;
                        } %>
        </div><% } %>
        <button id="continue" onclick="window.location = 'fourthStep.html';
                        " class="continue_butt"><fmt:message key="main.fly.label.continue" /></button>
    </div>
    <section class="sessionBox"> 
        <h1 class="sessionBox_head">Shopping cart</h1>
        <div class="sessionBox_content" id="cart"> Loading... </div>
        <script>refreshCart();</script>
        <% if (ses.getAttribute("booking") != null && (((Booking) ses.getAttribute("booking")).getDepartureFlight().getPassengers() != null) && (((Booking) ses.getAttribute("booking")).getDepartureFlight().getPassengers().get(0).getName() != null)) {
        %> <button onClick="window.location = 'secondStep.html';" class="previous_butt_small">Previous Step</button> <%
                            } %>
        <% if (ses.getAttribute("booking") != null) {
        %> <button onClick="window.location = 'fourthStep.html';" class="continue_butt_small">Next Step</button> <%
                            }%>
    </section>
    <div style="clear:left"></div>
</section >