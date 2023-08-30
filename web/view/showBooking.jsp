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
   Booking booking = (Booking)ses.getAttribute("booking");
   if(booking==null || booking.getDepartureFlight()==null) response.sendRedirect("index.jsp");
   User userl = (User)ses.getAttribute("user");
   if(userl.getBookings().size()>0){
       if(!userl.getBookings().get(0).getBookingCode().equals(booking.getBookingCode()))
            userl.getBookings().add(0, new Booking(booking));
   }
   else userl.getBookings().add(new Booking(booking));
   booking = userl.getBookings().get(0);
   double subtotalP=0;
   double total = 0;
   DecimalFormat df  = new DecimalFormat("##.##");

%>
<section class="main" >
            <div id="login_cont" class="container">
               
                <h1 class="h1center">Your Booking</h1>
                <table id="booking" class="bookingtb">
                    <tr class="theader">
                        <td ><h3>Booking: <%=booking.getBookingCode()%></h3></td>
                        <th>Client: <%=userl.getNif()%> - <%=userl.getEmail()%> </th>
                        <th><%=booking.getBookingDate() %></th>
                        <th>Zapdos Airlines</th>
                    </tr>
                    <tr>
                        <td colspan="4" style="background:#121f52;color:yellow;"><strong>DEPARTURE </strong></td>
                    </tr>
                    <tr>
                        <td class="finfo"><strong>from: </strong></td>
                        <td class="finfod"><%=booking.getDepartureFlight().getConnection().getOriginAirport().getIATA() %> <%=booking.getDepartureFlight().getConnection().getOriginAirport().getName()%> <%=booking.getDepartureFlight().getConnection().getOriginAirport().getTerminals().get(0).getLocation()+booking.getDepartureFlight().getConnection().getOriginAirport().getTerminals().get(0).getNumber()%> (<%=booking.getDepartureFlight().getConnection().getOriginAirport().getCountry()%>)</td>
                        <td class="finfo"><strong>to: </strong></td>
                        <td class="finfod"><%=booking.getDepartureFlight().getConnection().getDestinationAirport().getIATA()%> <%=booking.getDepartureFlight().getConnection().getDestinationAirport().getName()%> <%=booking.getDepartureFlight().getConnection().getDestinationAirport().getTerminals().get(0).getLocation()+booking.getDepartureFlight().getConnection().getDestinationAirport().getTerminals().get(0).getNumber()%> (<%=booking.getDepartureFlight().getConnection().getDestinationAirport().getCountry()%>)</td>
                    </tr>
                    <tr>
                        <td class="finfo"><strong>Date: </strong></td>
                        <td class="finfod"><%=booking.getDepartureFlight().getDepartureDate()+" "+booking.getDepartureFlight().getDepartureTime() %> (GMT+1)</td>
                        <td class="finfo"><strong>Duration:  </strong></td>
                        <td class="finfod"><%=booking.getDepartureFlight().getDuration()%>h</td>
                    </tr>
                    <% if(booking.getBackFlight()!=null){ %>
                    <tr>
                        <td colspan="4" style="background:#121f52;color:yellow;"><strong>BACK</strong></td>
                    </tr>
                    <tr>
                        <td class="finfo"><strong>from: </strong></td>
                        <td class="finfod"><%=booking.getBackFlight().getConnection().getOriginAirport().getIATA()%> <%=booking.getBackFlight().getConnection().getOriginAirport().getName()%> <%=booking.getBackFlight().getConnection().getOriginAirport().getTerminals().get(0).getLocation()+booking.getBackFlight().getConnection().getOriginAirport().getTerminals().get(0).getNumber()%> (<%=booking.getBackFlight().getConnection().getOriginAirport().getCountry()%>)</td>
                        <td class="finfo"><strong>to: </strong></td>
                        <td class="finfod"><%=booking.getBackFlight().getConnection().getDestinationAirport().getIATA()%> <%=booking.getBackFlight().getConnection().getDestinationAirport().getName()%> <%=booking.getBackFlight().getConnection().getDestinationAirport().getTerminals().get(0).getLocation()+booking.getBackFlight().getConnection().getDestinationAirport().getTerminals().get(0).getNumber()%> (<%=booking.getBackFlight().getConnection().getDestinationAirport().getCountry()%>)</td>
                    </tr>
                    <tr>
                        <td class="finfo"><strong>Date: </strong></td>
                        <td class="finfod"><%=booking.getBackFlight().getDepartureDate()+" "+booking.getBackFlight().getDepartureTime() %> (GMT+1)</td>
                        <td class="finfo"><strong>Duration:  </strong></td>
                        <td class="finfod"><%=booking.getBackFlight().getDuration()%>h</td>
                    </tr>
                    <% }%>
                     <tr>
                        <td colspan="4" style="background:#121f52;color:yellow;"><strong>PASSENGERS</strong></td>
                    </tr>
                    <tr class="data head">
                        <td>NIF</td>
                        <td>NAME</td>
                        <td>SURNAME</td>
                        <td>BIRTHDATE</td>
                    </tr>
                    <% for(Passenger p : booking.getDepartureFlight().getPassengers()){ %>
                     <tr class="data">
                        <td><%=p.getNif()%></td>
                        <td><%=p.getName()%></td>
                        <td><%=p.getSurName() %></td>
                        <td><%=p.getBirthDate() %></td>
                    </tr>
                    <%  if(p.getBaby()!=null){ %>
                        <tr class="data">
                            <td><%=p.getBaby().getNif()%></td>
                            <td><%=p.getBaby().getName()%></td>
                            <td><%=p.getBaby().getSurName() %></td>
                            <td><%=p.getBaby().getBirthDate() %></td>
                        </tr>
                    <% }
                    } %>
                    <tr>
                        <td colspan="4" style="background:#121f52;color:yellow;"><strong>BREAKDOWN</strong></td>
                    </tr
                    <tr>
                        <td colspan="4" style="background:#121f52;color:yellow;"><strong>SEATS</strong></td>
                    </tr>
                    <tr style="border-bottom:#121f52 1px solid;">
                        <td colspan="3" class="item"><strong>ITEM</strong></td>
                        <td style="text-align:center;"><strong>PRICE</strong></td>
                    </tr>
                    <% for(Passenger p : booking.getDepartureFlight().getPassengers()){ 
                         subtotalP += booking.getDepartureFlight().getPrice();
                    %>
                        <tr>
                            <td colspan="3" class="item">- Departure <%=p.getType()%> seat</td>
                            <td style="text-align:center;"><%=booking.getDepartureFlight().getPrice() %> &euro;</td>
                        </tr>
                    <% if(p.getBaby()!=null){ 
                         subtotalP += p.getServices().get(0).getPrice();
                    %>
                        <tr>
                            <td colspan="3" class="item">- Departure baby seat</td>
                            <td style="text-align:center;"><%=p.getServices().get(0).getPrice() %> &euro;</td>
                        </tr>
                       <% }
                    }
                    if(booking.getBackFlight()!=null){ 
                        for(Passenger p : booking.getBackFlight().getPassengers()){ 
                         subtotalP += booking.getBackFlight().getPrice();
                    %>
                        <tr>
                            <td colspan="3" class="item">- Back <%=p.getType()%> seat</td>
                            <td style="text-align:center;"><%=booking.getBackFlight().getPrice() %> &euro;</td>
                        </tr>
                        <% if(p.getBaby()!=null){
                            subtotalP += p.getServices().get(0).getPrice();
                        %>
                        <tr>
                            <td colspan="3" class="item">- Back baby seat</td>
                            <td style="text-align:center;"><%=p.getServices().get(0).getPrice() %> &euro;</td>
                        </tr>
                       <% }
                        }
                    }%>
                    <tr style="background:lightgrey">
                            <td colspan="3" class="item">SUBTOTAL</td>
                            <td style="text-align:center;"><%=df.format(subtotalP) %> &euro;</td>
                    </tr>
                    <% total+=subtotalP; %>
                    <tr>
                        <td colspan="4" style="background:#121f52;color:yellow;"><strong>DEPARTURE SERVICES</strong></td>
                    </tr>
                    <% for(Passenger p : booking.getDepartureFlight().getPassengers()){ 
                        subtotalP=0;%>
                    <tr style="background:#006c87;color:white;">
                        <td colspan="3"><strong>Passenger: </strong><%=p.getNif()%></td>
                        <td></td>
                    </tr>
                    <tr style="border-bottom:#121f52 1px solid;">
                        <td colspan="3" class="item"><strong>ITEM</strong></td>
                        <td style="text-align:center;"><strong>PRICE</strong></td>
                    </tr>
                        <% for(Service s : p.getServices()){ 
                            if(!s.getCode().equals("B")){
                                subtotalP += s.getPrice();
                        %>
                        <tr>
                            <td colspan="3" class="item">- <%=s.getDescription()%></td>
                            <td style="text-align:center;"><%=s.getPrice() %> &euro;</td>
                        </tr>
                            <% }
                            } %>
                        <tr style="background:lightgrey">
                            <td colspan="3" class="item">SUBTOTAL</td>
                            <td style="text-align:center;"><%=df.format(subtotalP) %> &euro;</td>
                        </tr>
                        <% total+=subtotalP; %>
                    <% }%>
                    <% if(booking.getBackFlight()!=null){ %>
                         <tr>
                            <td colspan="4" style="background:#121f52;color:yellow;"><strong>BACK SERVICES</strong></td>
                        </tr>
                        <% for(Passenger p : booking.getBackFlight().getPassengers()){ 
                            subtotalP=0;%>
                        <tr style="background:#006c87;color:white;">
                            <td colspan="3"><strong>Passenger: </strong><%=p.getNif()%></td>
                            <td></td>
                        </tr>
                        <tr style="border-bottom:#121f52 1px solid;">
                            <td colspan="3" class="item"><strong>ITEM</strong></td>
                            <td style="text-align:center;"><strong>PRICE</strong></td>
                        </tr>
                            <% for(Service s : p.getServices()){ 
                                if(!s.getCode().equals("B")){
                                    subtotalP += s.getPrice();
                            %>
                            <tr>
                                <td colspan="3" class="item">- <%=s.getDescription()%></td>
                                <td style="text-align:center;"><%=s.getPrice() %> &euro;</td>
                            </tr>
                                <% }
                                } %>
                            <tr style="background:lightgrey">
                                <td colspan="3" class="item">SUBTOTAL</td>
                                <td style="text-align:center;"><%=df.format(subtotalP) %> &euro;</td>
                            </tr>
                            <% total+=subtotalP; %>
                        <% }%>
                    <% } %>
                    <tr style="background:#121f52;color:yellow;">
                            <td colspan="3" class="item">TOTAL</td>
                            <td style="text-align:center;"><%=df.format(total) %> &euro;</td>
                    </tr>
                </table>
                <button id="continue" onclick="window.location='seventhStep.html'; " class="continue_butt"><fmt:message key="main.fly.label.continue" /></button>
            </div>
            <section class="sessionBox"> 
            <h1 class="sessionBox_head">Shopping cart</h1>
            <div class="sessionBox_content" id="cart"> Loading... </div>
            <script>refreshCart();</script>
            <% if(ses.getAttribute("withoutSeatsService")!=null && ((Boolean)ses.getAttribute("withoutSeatsService"))){ %>
                <button onClick="window.location = 'thirdStep.html';" class="previous_butt_small">Previous Step</button>
            <% }else{ %>
                 <button onClick="window.location = 'fourthStep.html';" class="previous_butt_small">Previous Step</button> 
            <% } %>
            </section>
            <div style="clear:left"></div>
           
</section >
