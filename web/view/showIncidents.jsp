<%-- 
    Document   : showBooking
    Created on : 17-feb-2016, 21:54:08
    Author     : victo
--%>

<%@page import="model.Incident"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Service"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="model.Passenger"%>
<%@page import="model.User"%>
<%@page import="model.Booking"%>
<%
    HttpSession ses = request.getSession(true);
    User userl = (User) ses.getAttribute("user");
    if (userl == null)
        response.sendRedirect("index.html");
    else {
        ArrayList<Incident> incidents = (ArrayList<Incident>) ses.getAttribute("incidents");
%>
<section class="main" >
    <div id="login_cont" class="container_extended">
        <script type="text/javascript" src="./js/booking.js"></script>
        <h1 class="h1center">Incidents</h1>  
        <div id="content">
            <% if(incidents.size()>0){ %>
            <table class="bookinglist" style='text-align:center;'>
                <tr>
                    <th>bookingCode</th>
                    <th>User NIF</th>
                    <th>User Email</th>
                    <th>Flight Date</th>
                    <th>Flight Code</th>
                    <th>Itinerary</th>
                    <th>Adults</th>
                    <th>Children</th>
                    <th>Infants</th>
                    <th>Flight Price</th>
                    <th>Services Price</th>
                </tr>
                <% for(Incident i : incidents){ %>
                <tr>
                    <td><%=i.getBookingCode()%></td>
                    <td><%=i.getNif() %></td>
                    <td><%=i.getEmail() %></td>
                    <td><%=i.getFlightDate() %></td>
                    <td><%=i.getFlightCode() %></td>
                    <td><%=i.getFrom() %> to <%=i.getTo() %></td>
                    <td><%=i.getAdults() %></td>
                    <td><%=i.getChildren() %></td>
                    <td><%=i.getInfants() %></td>
                    <td><%=i.getTotalFlight() %> &euro;</td>
                    <td><%=i.getTotalServices() %> &euro;</td>
                </tr>
                <% } %>
            </table>
            <% }else{ %>
                <span style="text-align:center;">There are'nt incidents on this period.</span>
            <% } %>
        </div>
    </div>
</section>
<%
    }%>
