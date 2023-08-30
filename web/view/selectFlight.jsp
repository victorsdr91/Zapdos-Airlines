<%-- 
    Document   : index
    Created on : 19-ene-2016, 10:51:30
    Author     : victo
--%>

<%@page import="model.Booking"%>
<%@page import="model.Flight"%>
<%@page import="java.util.ArrayList"%>
        <section class="main" >
            <div id="flights_cont" class="container"> 
                
                <%
                      HttpSession ses = request.getSession();
                     ArrayList<Flight> flights = (ArrayList<Flight>)ses.getAttribute("availableFlights");
                     %>
                     <% if(flights!=null && flights.size()>0){ %>
                         <script>departureFlight = false;</script>
                        <div class="flightPass"><span><fmt:message key="Adults" />: <% out.print(ses.getAttribute("adults")); %></span> 
                                                <span><fmt:message key="Children" />: <% out.print(ses.getAttribute("childs")); %></span>
                                                <span><fmt:message key="Infants" />: <% out.print(ses.getAttribute("infants")); %></span>
                         </div>
                         <h1 class="flightsTitle"><fmt:message key="Flights.from" /> <% out.print(flights.get(0).getConnection().getOriginAirport().getCity()); %> <fmt:message key="to" /> <% out.print(flights.get(0).getConnection().getDestinationAirport().getCity()); %> </h1>
                         <h2><fmt:message key="Departure" /></h2>
                        <%
                         int i = 0;
                        for(Flight flight : flights){
                            
                        %>
                            
                        <article class="flight dflight" id="df_<%=i%>"  onclick="addDepartureFlight(<% out.print(i); %>); checkContinue('departureFlight');">
                            <h3 class="flightCode"><% out.print(flight.getFlightCode()); %></h3>
                            <span id="dfd_<%=i%>" class="departureDate dflightdate"><% out.print(flight.getDepartureDate()); %></span>
                            <span class="departureDate"><fmt:message key="Duration" />: <% out.print(flight.getDuration()); %></span>
                            <br/>
                            <table>
                                <thead class="thead">
                                    <th><% out.print(flight.getConnection().getOriginAirport().getCity()); %> </th>
                                    <th></th>
                                    <th><% out.print(flight.getConnection().getDestinationAirport().getCity()); %></th>  
                                </th>
                                <tr>
                                    <td><% out.print(flight.getDepartureTime()); %></td>
                                    <td> ________________________________________ </td>
                                    <td><% out.print(flight.getDepartureTime().plusNanos(flight.getDuration().toNanoOfDay())); %></td>
                                </tr>
                                 <tr>
                                    <td><fmt:message key="Departure" /></td>
                                    <td>  </td>
                                    <td><fmt:message key="Arrival" /></td>
                                </tr>
                            </table>
                                    <div class="flightPrice"><h3><fmt:message key="Price" /> <br> <% out.print(flight.getPrice()); %> &euro; </h3></div>
                            <div style="clear:left"></div>  
                        </article> 
                       <%  i++; }
                     }else{
                         %>
                         <article class="flight"><span style="color:red"><fmt:message key="There.arent.available.flights" /></span></article>
                    <%  }
                %>
                 
                 <%
                     ArrayList<Flight> flightsTo = (ArrayList<Flight>)ses.getAttribute("availableFlightsTo");
                     %>
                      
                     <% if(flightsTo!=null){ %>
                        <h1><fmt:message key="Back" /></h1>
                           <%if(flightsTo.size()>0){ %>
                       <script>backFlight = false;</script>
                       <% int j = 0;
                        for(Flight flight : flightsTo){%>
                         <article class="flight bflight" id="bf_<%=j%>" onclick="addBackFlight(<% out.print(j); %>); checkContinue('backFlight');">
                            <h3 class="flightCode"><% out.print(flight.getFlightCode()); %></h3>
                            <span id="bfd_<%=j%>" class="departureDate bflightdate"><% out.print(flight.getDepartureDate()); %></span>
                            <span class="departureDate"><fmt:message key="Duration" />: <% out.print(flight.getDuration()); %></span>
                            <br/>
                            <table>
                                <thead class="thead">
                                    <th><% out.print(flight.getConnection().getOriginAirport().getCity()); %> </th>
                                    <th></th>
                                    <th><% out.print(flight.getConnection().getDestinationAirport().getCity()); %></th>  
                                </th>
                                <tr>
                                    <td><% out.print(flight.getDepartureTime()); %></td>
                                    <td> ________________________________________ </td>
                                    <td><% out.print(flight.getDepartureTime().plusNanos(flight.getDuration().toNanoOfDay())); %></td>
                                </tr>
                                 <tr>
                                    <td><fmt:message key="Departure" /></td>
                                    <td>  </td>
                                    <td><fmt:message key="Arrival" /></td>
                                </tr>
                            </table>
                                    <div class="flightPrice"><h3><fmt:message key="Price" /> <br> <% out.print(flight.getPrice()); %> &euro; </h3></div>
                            <div style="clear:left"></div>  
                        </article> 
                       <% j++; }
                        }else{
                         %>
                         <article class="flight"><span style="color:red"><fmt:message key="There.arent.available.flights" /></span></article>
                    <%  }
                     }
                %>
            </div>
            <section class="sessionBox"> 
                <h1 class="sessionBox_head"><fmt:message key="Shopping.cart" /></h1>
                <div class="sessionBox_content" id="cart"> Loading... </div>
                <script>refreshCart();</script>
                <% if(ses.getAttribute("booking")!=null){
                        %> <button onClick="window.location = './';" class="previous_butt_small">Previous Step</button> <%
                    } %>
                    <% if(ses.getAttribute("booking")!=null && ((Booking)ses.getAttribute("booking")).getDepartureFlight()!=null){
                        %> <button onClick="window.location = 'secondStep.html';" class="continue_butt_small">Next Step</button> <%
                    } %>
            </section>
             <div style="clear:left"></div>
        </section >
