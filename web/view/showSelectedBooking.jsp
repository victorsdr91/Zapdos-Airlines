<%-- 
    Document   : showBooking
    Created on : 17-feb-2016, 21:54:08
    Author     : victo
--%>

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
        int book =0;
        Booking booking = null;
        if(request.getParameter("booking")!=null){
            book = Integer.parseInt(request.getParameter("booking"));
            booking = userl.getBookings().get(book);
        }
        else if(request.getParameter("bbooking")!=null){
            book = Integer.parseInt(request.getParameter("bbooking"));
            booking = userl.getBackupBookings().get(book);
        }
        
        if (booking == null || booking.getDepartureFlight() == null) {
            response.sendRedirect("index.html");
        }else{
        double subtotalP = 0;
        double total = 0;
        DecimalFormat df = new DecimalFormat("##.##");
         String creditcard = "****-****-****-"+ booking.getPayment().getCreditCard().substring(booking.getPayment().getCreditCard().length()-4,booking.getPayment().getCreditCard().length());
%>
<section class="main" >
    <div id="login_cont" class="container_extended">
        <script type="text/javascript" src="./js/booking.js"></script>
        <button id="continue" onclick="printE(document.getElementById('content'));" class="continue_butt" style="margin-left: 5%;">Print</button>
        <div id="content">
            <table id="booking" style="color:#121f52;width:90%;margin:auto;border-collapse: collapse;border: 1px #121f52 solid;">
                <tr style="background: #263D5A;
                    color: yellow;border: 1px #121f52 solid;">
                    <td style="padding:4px;"><h3 style="margin:3px;">Booking: <%=booking.getBookingCode()%></h3></td>
                    <th>Client: <%=userl.getNif()%> - <%=userl.getEmail()%> </th>
                    <th><%=booking.getBookingDate()%></th>
                    <th>Zapdos Airlines</th>
                </tr>
                <tr style="border: 1px #121f52 solid;">
                    <td colspan="4" style="padding:4px;background:#121f52;color:yellow;padding:4px;"><strong>DEPARTURE </strong></td>
                </tr>
                <tr style="border: 1px #121f52 solid;">
                    <td style="padding:4px;width:8%;"><strong>from: </strong></td>
                    <td style="padding:4px;width:15%;"><%=booking.getDepartureFlight().getConnection().getOriginAirport().getIATA()%> <%=booking.getDepartureFlight().getConnection().getOriginAirport().getName()%> <%=booking.getDepartureFlight().getConnection().getOriginAirport().getTerminals().get(0).getLocation() + booking.getDepartureFlight().getConnection().getOriginAirport().getTerminals().get(0).getNumber()%> (<%=booking.getDepartureFlight().getConnection().getOriginAirport().getCountry()%>)</td>
                    <td style="padding:4px;width:8%;"><strong>to: </strong></td>
                    <td style="padding:4px;width:15%;"><%=booking.getDepartureFlight().getConnection().getDestinationAirport().getIATA()%> <%=booking.getDepartureFlight().getConnection().getDestinationAirport().getName()%> <%=booking.getDepartureFlight().getConnection().getDestinationAirport().getTerminals().get(0).getLocation() + booking.getDepartureFlight().getConnection().getDestinationAirport().getTerminals().get(0).getNumber()%> (<%=booking.getDepartureFlight().getConnection().getDestinationAirport().getCountry()%>)</td>
                </tr>
                <tr style="border: 1px #121f52 solid;">
                    <td style="padding:4px;width:8%;"><strong>Date: </strong></td>
                    <td style="padding:4px;width:15%;"><%=booking.getDepartureFlight().getDepartureDate() + " " + booking.getDepartureFlight().getDepartureTime()%> (GMT+1)</td>
                    <td style="padding:4px;width:8%;"><strong>Duration:  </strong></td>
                    <td style="padding:4px;width:15%;"><%=booking.getDepartureFlight().getDuration()%>h</td>
                </tr>
                <% if (booking.getBackFlight() != null) {%>
                <tr style="border: 1px #121f52 solid;">
                    <td colspan="4" style="background:#121f52;color:yellow;"><strong>BACK</strong></td>
                </tr>
                <tr style="border: 1px #121f52 solid;">
                    <td style="padding:4px;width:8%;"><strong>from: </strong></td>
                    <td style="padding:4px;width:15%;"><%=booking.getBackFlight().getConnection().getOriginAirport().getIATA()%> <%=booking.getBackFlight().getConnection().getOriginAirport().getName()%> <%=booking.getBackFlight().getConnection().getOriginAirport().getTerminals().get(0).getLocation() + booking.getBackFlight().getConnection().getOriginAirport().getTerminals().get(0).getNumber()%> (<%=booking.getBackFlight().getConnection().getOriginAirport().getCountry()%>)</td>
                    <td style="padding:4px;width:8%;"><strong>to: </strong></td>
                    <td style="padding:4px;width:15%;"><%=booking.getBackFlight().getConnection().getDestinationAirport().getIATA()%> <%=booking.getBackFlight().getConnection().getDestinationAirport().getName()%> <%=booking.getBackFlight().getConnection().getDestinationAirport().getTerminals().get(0).getLocation() + booking.getBackFlight().getConnection().getDestinationAirport().getTerminals().get(0).getNumber()%> (<%=booking.getBackFlight().getConnection().getDestinationAirport().getCountry()%>)</td>
                </tr>
                <tr style="border: 1px #121f52 solid;">
                    <td style="padding:4px;width:8%;"><strong>Date: </strong></td>
                    <td style="padding:4px;width:15%;"><%=booking.getBackFlight().getDepartureDate() + " " + booking.getBackFlight().getDepartureTime()%> (GMT+1)</td>
                    <td style="padding:4px;width:8%;"><strong>Duration:  </strong></td>
                    <td style="padding:4px;width:15%;"><%=booking.getBackFlight().getDuration()%>h</td>
                </tr>
                <% }%>
                <tr style="border: 1px #121f52 solid;">
                    <td colspan="4" style="padding:4px;background:#121f52;color:yellow;"><strong>PASSENGERS</strong></td>
                </tr>
                <tr style="border: 1px #121f52 solid;text-align:center;font-weight:bold;" class="data head">
                    <td style="padding:4px;">NIF</td>
                    <td style="padding:4px;">NAME</td>
                    <td style="padding:4px;">SURNAME</td>
                    <td style="padding:4px;">BIRTHDATE</td>
                </tr>
                <% for (Passenger p : booking.getDepartureFlight().getPassengers()) {%>
                <tr style="border: 1px #121f52 solid;text-align:center" class="data">
                    <td style="padding:4px;"><%=p.getNif()%></td>
                    <td style="padding:4px;"><%=p.getName()%></td>
                    <td style="padding:4px;"><%=p.getSurName()%></td>
                    <td style="padding:4px;"><%=p.getBirthDate()%></td>
                </tr>
                <%  if (p.getBaby() != null) {%>
                <tr style="border: 1px #121f52 solid;text-align:center" class="data">
                    <td style="padding:4px;"><%=p.getBaby().getNif()%></td>
                    <td style="padding:4px;"><%=p.getBaby().getName()%></td>
                    <td style="padding:4px;"><%=p.getBaby().getSurName()%></td>
                    <td style="padding:4px;"><%=p.getBaby().getBirthDate()%></td>
                </tr>
                <% }
                    } %>
                <tr style="border: 1px #121f52 solid;">
                    <td colspan="4" style="border: 1px #121f52 solid;padding:4px;background:#121f52;color:yellow;"><strong>BREAKDOWN</strong></td>
                </tr>
                <tr style="border: 1px #121f52 solid;">
                    <td colspan="4" style="border: 1px #121f52 solid;padding:4px;background:#121f52;color:yellow;"><strong>SEATS</strong></td>
                </tr>
                <tr style="border: 1px #121f52 solid;border-bottom:#121f52 1px solid;">
                    <td colspan="3" style="padding:4px; border-right: 1px #001735 solid;
                        width:90%;"class="item"><strong>ITEM</strong></td>
                    <td style="padding:4px;text-align:center;"><strong>PRICE</strong></td>
                </tr>
                <% for (Passenger p : booking.getDepartureFlight().getPassengers()) {
                        subtotalP += booking.getDepartureFlight().getPrice();
                %>
                <tr style="border: 1px #121f52 solid;">
                    <td colspan="3" style="padding:4px; border-right: 1px #001735 solid;
                        width:90%;" class="item">- Departure <%=p.getType()%> seat</td>
                    <td style="padding:4px;text-align:center;"><%=booking.getDepartureFlight().getPrice()%> &euro;</td>
                </tr>
                <% if (p.getBaby() != null) {
                        subtotalP += p.getServices().get(0).getPrice();
                %>
                <tr style="border: 1px #121f52 solid;">
                    <td colspan="3" style="padding:4px; border-right: 1px #001735 solid;
                        width:90%;" class="item">- Departure baby seat</td>
                    <td style="padding:4px;text-align:center;"><%=p.getServices().get(0).getPrice()%> &euro;</td>
                </tr>
                <% }
                    }
                    if (booking.getBackFlight() != null) {
                        for (Passenger p : booking.getBackFlight().getPassengers()) {
                            subtotalP += booking.getBackFlight().getPrice();
                %>
                <tr style="border: 1px #121f52 solid;">
                    <td colspan="3" style="padding:4px; border-right: 1px #001735 solid;
                        width:90%;" class="item">- Back <%=p.getType()%> seat</td>
                    <td style="padding:4px;text-align:center;"><%=booking.getBackFlight().getPrice()%> &euro;</td>
                </tr>
                <% if (p.getBaby() != null) {
                        subtotalP += p.getServices().get(0).getPrice();
                %>
                <tr style="border: 1px #121f52 solid;">
                    <td colspan="3" style="padding:4px;  border-right: 1px #001735 solid;
                        width:90%;" class="item">- Back baby seat</td>
                    <td style="padding:4px;text-align:center;"><%=p.getServices().get(0).getPrice()%> &euro;</td>
                </tr>
                <% }
                        }
                    }%>
                <tr style="border: 1px #121f52 solid;background:lightgrey">
                    <td colspan="3" style="padding:4px;  border-right: 1px #001735 solid;
                        width:90%;" class="item">SUBTOTAL</td>
                    <td style="padding:4px;text-align:center;"><%=df.format(subtotalP)%> &euro;</td>
                </tr>
                <% total += subtotalP; %>
                <tr style="border: 1px #121f52 solid;">
                    <td colspan="4" style="padding:4px;background:#121f52;color:yellow;"><strong>DEPARTURE SERVICES</strong></td>
                </tr>
                <% for (Passenger p : booking.getDepartureFlight().getPassengers()) {
                        subtotalP = 0;%>
                <tr style="border: 1px #121f52 solid;background:#006c87;color:white;">
                    <td style="padding:4px;" colspan="3"><strong>Passenger: </strong><%=p.getNif()%></td>
                    <td style="padding:4px;"></td>
                </tr>
                <tr style="border: 1px #121f52 solid;border-bottom:#121f52 1px solid;">
                    <td colspan="3" style="padding:4px;" class="item"><strong>ITEM</strong></td>
                    <td style="padding:4px;text-align:center;"><strong>PRICE</strong></td>
                </tr>
                <% for (Service s : p.getServices()) {
                        if (!s.getCode().equals("B")) {
                            subtotalP += s.getPrice();
                %>
                <tr style="border: 1px #121f52 solid;">
                    <td colspan="3" style="padding:4px; border-right: 1px #001735 solid;
                        width:90%;" class="item">- <%=s.getDescription()%></td>
                    <td style="padding:4px;text-align:center;"><%=s.getPrice()%> &euro;</td>
                </tr>
                <% }
                    }%>
                <tr style="border: 1px #121f52 solid; background:lightgrey">
                    <td colspan="3" style="padding:4px;" class="item">SUBTOTAL</td>
                    <td style="padding:4px;text-align:center;"><%=df.format(subtotalP)%> &euro;</td>
                </tr>
                <% total += subtotalP; %>
                <% }%>
                <% if (booking.getBackFlight() != null) { %>
                <tr style="border: 1px #121f52 solid;">
                    <td colspan="4" style="padding:4px;background:#121f52;color:yellow;"><strong>BACK SERVICES</strong></td>
                </tr>
                <% for (Passenger p : booking.getBackFlight().getPassengers()) {
                        subtotalP = 0;%>
                <tr style="border: 1px #121f52 solid;background:#006c87;color:white;">
                    <td style="padding:4px;" colspan="3"><strong>Passenger: </strong><%=p.getNif()%></td>
                    <td style="padding:4px;"></td>
                </tr>
                <tr style="border: 1px #121f52 solid;border-bottom:#121f52 1px solid;">
                    <td colspan="3" style="padding:4px; border-right: 1px #001735 solid;
                        width:90%;" class="item"><strong>ITEM</strong></td>
                    <td style="padding:4px;text-align:center;"><strong>PRICE</strong></td>
                </tr>
                <% for (Service s : p.getServices()) {
                        if (!s.getCode().equals("B")) {
                            subtotalP += s.getPrice();
                %>
                <tr style="border: 1px #121f52 solid;border: 1px #121f52 solid;">
                    <td colspan="3"  style="padding:4px; border-right: 1px #001735 solid;
                        width:90%;"class="item">- <%=s.getDescription()%></td>
                    <td style="padding:4px;text-align:center;"><%=s.getPrice()%> &euro;</td>
                </tr>
                <% }
                    }%>
                <tr style="border: 1px #121f52 solid;background:lightgrey">
                    <td colspan="3" style="padding:4px; border-right: 1px #001735 solid;
                        width:90%;" class="item">SUBTOTAL</td>
                    <td style="padding:4px;text-align:center;"><%=df.format(subtotalP)%> &euro;</td>
                </tr>
                <% total += subtotalP; %>
                <% }%>
                <% }%>
                <tr style="border: 1px #121f52 solid;background:#121f52;color:yellow;">
                    <td style="padding:4px; border-right: 1px #001735 solid;
                        width:25%;">CARD HOLDER</td>
                    <td style="padding:4px;text-align:center;width:25%;border-right: 1px #001735 solid;"><%=booking.getPayment().getCreditUser() %></td>
                    <td style="padding:4px; border-right: 1px #001735 solid;
                        width:25%;" >CREDIT CARD</td>
                    <td style="padding:4px;text-align:center;width:25%;"><%=creditcard %></td>
                </tr>
                <tr style="border: 1px #121f52 solid;background:#121f52;color:yellow;">
                    <td colspan="3" style="padding:4px; border-right: 1px #001735 solid;
                        width:90%;" class="item">TOTAL</td>
                    <td style="padding:4px;text-align:center;"><%=df.format(total)%> &euro;</td>
                </tr>
            </table>
        </div>
        <button id="continue" onclick="printE(document.getElementById('content'));" class="continue_butt" style="display:inline-block;margin-left: 75%;">Print</button>
        <button id="continue" onclick="window.close()" class="continue_butt" style="display:inline-block;margin-left:1%;">Close</button>
    </div>
    <div style="clear:left"></div>
</section >
<% } }%>