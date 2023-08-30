<%-- 
    Document   : chekin
    Created on : 23-feb-2016, 11:52:48
    Author     : victo
--%>
<%@page import="model.User"%>
<%@page import="model.Booking"%>
<section class="main flightbg" >
    <div id="fly_id" >
        <%  HttpSession ses = request.getSession();
            ses.setAttribute("section", "checkin.html");
            User us = (User) ses.getAttribute("user");
            Booking bo = null;
            if(ses.getAttribute("booking")!=null){
             bo = (Booking) ses.getAttribute("booking");
            } 
            if (us != null) {
        %>
        <div class="header"> <span class="inactive" onclick="window.location = 'index.html'" ><fmt:message key="main.fly.span.flight" /></span><% if (ses.getAttribute("user") != null) { %> <span  ><fmt:message key="check.in" /></span> <% if(((User)ses.getAttribute("user")).isAdmin()){ %><span class="inactive" onclick="window.location='admin.html'" >Admin Panel</span> <% } } %></div>
        <div  class="checkin">
            <h1 class="checkinh1"><fmt:message key="available.bookings" /></h1>
            <%  int cont = 0;
                for (Booking b : us.getBookings()) {
                   if (bo == null || (bo!=null && (bo.getBookingCode()==null || (bo.getBookingCode()!=null && !bo.getBookingCode().equals(b.getBookingCode()))))) { 
                        if ((b.getDepartureFlight()!=null && !b.getDepartureFlight().getFactured()) || (b.getBackFlight() != null && !b.getBackFlight().getFactured())) { 
                            cont++;
            %>
            <div class="booking-check"><fmt:message key="Booking" />: <%=b.getBookingCode()%> | <fmt:message key="Date" />: <%=b.getBookingDate().toString()%></div>
            <% if (b.getDepartureFlight() != null) {%>
            <div class="checkin-flight">
                <ul>
                    <li><strong><fmt:message key="main.fly.label.from" /></strong> <%=b.getDepartureFlight().getConnection().getOriginAirport().getIATA()%> <strong><fmt:message key="main.fly.label.to" /></strong> <%=b.getDepartureFlight().getConnection().getDestinationAirport().getIATA()%></li>
                    <li><strong><fmt:message key="main.fly.label.departuredate" />:</strong> <%=b.getDepartureFlight().getDepartureDate()%> <%=b.getDepartureFlight().getDepartureTime()%></li>

                </ul>
                <button onclick="window.location = 'checkFlight?flight=D&booking=<%=b.getId()%>'" <% if (b.getDepartureFlight().getFactured()) {%>disabled class="check_but disabled"<%} else {%> class="check_but" <%}%>><fmt:message key="check.in" /></button>
            </div>
             <% } %>
            <% if (b.getBackFlight() != null) {%>
            <div class="checkin-flight">
                <ul>
                    <li><strong><fmt:message key="main.fly.label.from" /></strong> <%=b.getBackFlight().getConnection().getOriginAirport().getIATA()%> <strong><fmt:message key="main.fly.label.to" /></strong> <%=b.getBackFlight().getConnection().getDestinationAirport().getIATA()%></li>
                    <li><strong><fmt:message key="main.fly.label.departuredate" />:</strong> <%=b.getBackFlight().getDepartureDate()%> <%=b.getBackFlight().getDepartureTime()%></li>

                </ul>
                <button onclick="window.location = 'checkFlight?flight=B&booking=<%=b.getId()%>'" <% if (b.getBackFlight().getFactured()) {%>disabled class="check_but disabled"<%} else {%> class="check_but" <%}%>><fmt:message key="check.in" /></button>

            </div>
            <% } %>
            <div style="clear:left"></div>
            <%
                            }
                        }
                     } %> 
            <% if(cont==0){ %>
            <span style="color: red; font-weight: bold; background: white; display: block; text-align:center; padding: 20px; border-radius: 3px;" /><fmt:message key="you.have.not.pending.bookings.to.be.checked" /> </span>
            <% } %>
            <%    } else {
                    response.sendRedirect("index.jsp");
                }
            %>
        </div>
    </div>
</section >
<section class="sec">
</section>

