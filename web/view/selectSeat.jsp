<%-- 
    Document   : selectSeat
    Created on : 10-feb-2016, 13:34:36
    Author     : victo
--%>
<%@page import="model.Service"%>
<%@page import="java.util.Iterator"%>
<%@page import="model.Flight"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Passenger"%>
<%@page import="model.Booking"%>
<% 
   HttpSession ses = request.getSession(true); 
   Booking booking = (Booking)ses.getAttribute("booking");
   ArrayList<Flight> flights = (ArrayList<Flight>)ses.getAttribute("availableFlights");

   Flight flight = null;
   
   for(Flight f : flights){
       if(booking.getDepartureFlight().getFlightCode().equals(f.getFlightCode()) && booking.getDepartureFlight().getDepartureDate().equals(f.getDepartureDate()) && booking.getDepartureFlight().getDepartureTime().equals(f.getDepartureTime())){
           flight = f;
       }
   }
   
   Flight flightB = null;
   if(booking.getBackFlight()!=null && ses.getAttribute("availableFlightsTo")!=null){
        ArrayList<Flight> flightsB = (ArrayList<Flight>)ses.getAttribute("availableFlightsTo");
        
        for(Flight f : flightsB){
            if(booking.getBackFlight().getFlightCode().equals(f.getFlightCode()) && booking.getBackFlight().getDepartureDate().equals(f.getDepartureDate()) && booking.getBackFlight().getDepartureTime().equals(f.getDepartureTime())){
                flightB = f;
            }
        }
   }
%>
<section class="main" >
            <div id="seat_cont" class="container"> 
                <script type="text/javascript" src ="./js/seats.js" ></script>
                <h1><fmt:message key='Seats.Selector' /></h1>
                <% Iterator it = flight.getPassengers().iterator();
                    while(it.hasNext()){
                        Passenger p = (Passenger)it.next();
                        if(p.getSeat()!=null){
                            %> <script> occupiedD[<% out.print(p.getSeat()); %>-1] = 1; </script> <%
                        }
                    }
                    Iterator it2 = booking.getDepartureFlight().getPassengers().iterator();
                    int i=0;
                    int contD = 0;
                    while(it2.hasNext()){
                        Passenger p2 = (Passenger)it2.next();
                        for(Service s : p2.getServices()){
                            if(s.getCode().equals("ES")){ 
                                contD++;
                                %><script>passengers[passengers.length]=<%=i%></script> <%
                                if(p2.getSeat()!=null){
                                    %><script>seatsPass[seatsPass.length]=<%=p2.getSeat()%></script> <%
                                }
                            }
                            
                           
                        }
                        
                        
                        i++;
                    }
                if(contD>0){%>
                <div id="d_seats" >
                <h1><fmt:message key='Departure' /></h1>
                <h2 id="passenger_name"></h2>
                <table id="flightselD" class="flightsel" width="151" height="172" cellpadding="0" cellspacing="0">
                        <tr>
                                <td colspan="9">
                                        <img src="./img/seats/seatsselect_01.png" width="151" height="53" alt=""></td>
                        </tr>
                        <tr>
                                <td rowspan="4">
                                        <img src="./img/seats/seatsselect_02.png" width="18" height="119" alt=""></td>
                                <td>
                                        <img id="seatD1" src="./img/seats/free.png" onclick="selectDS(this.id);" width="18" height="18" alt=""></td>
                                <td rowspan="4">
                                        <img src="./img/seats/seatsselect_04.png" width="8" height="119" alt=""></td>
                                <td>
                                        <img id="seatD2" src="./img/seats/free.png" onclick="selectDS(this.id);" width="18" height="18" alt=""></td>
                                <td rowspan="4">
                                        <img src="./img/seats/seatsselect_06.png" width="10" height="119" alt=""></td>
                                <td>
                                        <img id="seatD3" src="./img/seats/free.png" onclick="selectDS(this.id);" width="18" height="18" alt=""></td>
                                <td rowspan="4">
                                        <img src="./img/seats/seatsselect_08.png" width="11" height="119" alt=""></td>
                                <td>
                                        <img id="seatD4" src="./img/seats/free.png" onclick="selectDS(this.id);" width="18" height="18" alt=""></td>
                                <td rowspan="4">
                                        <img src="./img/seats/seatsselect_10.png" width="32" height="119" alt=""></td>
                        </tr>
                        <tr>
                                <td>
                                        <img src="./img/seats/seatsselect_11.png" width="18" height="38" alt=""></td>
                                <td>
                                        <img src="./img/seats/seatsselect_12.png" width="18" height="38" alt=""></td>
                                <td>
                                        <img src="./img/seats/seatsselect_13.png" width="18" height="38" alt=""></td>
                                <td>
                                        <img src="./img/seats/seatsselect_14.png" width="18" height="38" alt=""></td>
                        </tr>
                        <tr>
                                <td>
                                        <img id="seatD5" src="./img/seats/free.png" onclick="selectDS(this.id);" width="18" height="18" alt=""></td>
                                <td>
                                        <img id="seatD6" src="./img/seats/free.png" onclick="selectDS(this.id);" width="18" height="18" alt=""></td>
                                <td>
                                        <img id="seatD7" src="./img/seats/free.png" onclick="selectDS(this.id);" width="18" height="18" alt=""></td>
                                <td>
                                        <img id="seatD8" src="./img/seats/free.png" onclick="selectDS(this.id);" width="18" height="18" alt=""></td>
                        </tr>
                        <tr>
                                <td>
                                        <img src="./img/seats/seatsselect_19.png" width="18" height="45" alt=""></td>
                                <td>
                                        <img src="./img/seats/seatsselect_20.png" width="18" height="45" alt=""></td>
                                <td>
                                        <img src="./img/seats/seatsselect_21.png" width="18" height="45" alt=""></td>
                                <td>
                                        <img src="./img/seats/seatsselect_22.png" width="18" height="45" alt=""></td>
                        </tr>
                </table>
                <script>occupiedSeatsD();</script>
                </div>
                <% } int contB=0; if(booking.getBackFlight()!=null) { %>
                
                <% 
                    if(flightB!=null && flightB.getPassengers()!=null){
                        Iterator itf = flightB.getPassengers().iterator();
                        while(itf.hasNext()){
                            Passenger p = (Passenger)itf.next();
                            if(p.getSeat()!=null){
                                %> <script> occupiedB[<% out.print(p.getSeat()); %>-1] = 1; </script> <%
                            }
                        }
                    }
                     int j=0;
                    if(booking.getBackFlight().getPassengers()!=null){
                        Iterator itB = booking.getBackFlight().getPassengers().iterator();
                       
                        while(itB.hasNext()){
                            Passenger pB = (Passenger)itB.next();
                            for(Service sB : pB.getServices()){
                                if(sB.getCode().equals("ES")){
                                    contB++;
                                    %><script>passengersB[passengersB.length]=<%=j%></script> <%
                                    if(pB.getSeat()!=null){
                                        %><script>seatsPassB[seatsPassB.length]=<%=pB.getSeat()%></script> <%
                                    }   
                                }
                                
                                
                            }
                            
                            j++;
                        }
                    }
                if(contB>0){ %>
                <div id="B_seats" >
                <h1><fmt:message key='Back' /></h1>
                <h2 id="passenger_name_B"></h2>
                <table id="flightselB" class="flightsel" width="151" height="172" cellpadding="0" cellspacing="0">
                        <tr>
                                <td colspan="9">
                                        <img src="./img/seats/seatsselect_01.png" width="151" height="53" alt=""></td>
                        </tr>
                        <tr>
                                <td rowspan="4">
                                        <img src="./img/seats/seatsselect_02.png" width="18" height="119" alt=""></td>
                                <td>
                                        <img id="seatB1" src="./img/seats/free.png" onclick="selectBS(this.id);" width="18" height="18" alt=""></td>
                                <td rowspan="4">
                                        <img src="./img/seats/seatsselect_04.png" width="8" height="119" alt=""></td>
                                <td>
                                        <img id="seatB2" src="./img/seats/free.png" onclick="selectBS(this.id);" width="18" height="18" alt=""></td>
                                <td rowspan="4">
                                        <img src="./img/seats/seatsselect_06.png" width="10" height="119" alt=""></td>
                                <td>
                                        <img id="seatB3" src="./img/seats/free.png" onclick="selectBS(this.id);" width="18" height="18" alt=""></td>
                                <td rowspan="4">
                                        <img src="./img/seats/seatsselect_08.png" width="11" height="119" alt=""></td>
                                <td>
                                        <img id="seatB4" src="./img/seats/free.png" onclick="selectBS(this.id);" width="18" height="18" alt=""></td>
                                <td rowspan="4">
                                        <img src="./img/seats/seatsselect_10.png" width="32" height="119" alt=""></td>
                        </tr>
                        <tr>
                                <td>
                                        <img src="./img/seats/seatsselect_11.png" width="18" height="38" alt=""></td>
                                <td>
                                        <img src="./img/seats/seatsselect_12.png" width="18" height="38" alt=""></td>
                                <td>
                                        <img src="./img/seats/seatsselect_13.png" width="18" height="38" alt=""></td>
                                <td>
                                        <img src="./img/seats/seatsselect_14.png" width="18" height="38" alt=""></td>
                        </tr>
                        <tr>
                                <td>
                                        <img id="seatB5" src="./img/seats/free.png" onclick="selectBS(this.id);" width="18" height="18" alt=""></td>
                                <td>
                                        <img id="seatB6" src="./img/seats/free.png" onclick="selectBS(this.id);" width="18" height="18" alt=""></td>
                                <td>
                                        <img id="seatB7" src="./img/seats/free.png" onclick="selectBS(this.id);" width="18" height="18" alt=""></td>
                                <td>
                                        <img id="seatB8" src="./img/seats/free.png" onclick="selectBS(this.id);" width="18" height="18" alt=""></td>
                        </tr>
                        <tr>
                                <td>
                                        <img src="./img/seats/seatsselect_19.png" width="18" height="45" alt=""></td>
                                <td>
                                        <img src="./img/seats/seatsselect_20.png" width="18" height="45" alt=""></td>
                                <td>
                                        <img src="./img/seats/seatsselect_21.png" width="18" height="45" alt=""></td>
                                <td>
                                        <img src="./img/seats/seatsselect_22.png" width="18" height="45" alt=""></td>
                        </tr>
                </table>
                <script>occupiedSeatsB();</script>
                </div>
                <% }
                }
                if(contD==0 && contB==0){ 
                    ses.setAttribute("withoutSeatsService", true);
                    response.sendRedirect("seatSave"); }
                else{
                     ses.setAttribute("withoutSeatsService", false);
                }
                %>
                <div style="clear:left"></div>
                <button id="continue" onclick="window.location='seatSave'; " class="continue_butt" disabled style='color:grey;'><fmt:message key="main.fly.label.continue" /></button>
             </div>
                <script> checkSeats();</script>
            <section class="sessionBox"> 
            <h1 class="sessionBox_head"><fmt:message key='Shopping.cart' /></h1>
            <div class="sessionBox_content" id="cart"> Loading... </div>
            <script>refreshCart();</script>
            <% if(ses.getAttribute("booking")!=null && (((Booking)ses.getAttribute("booking")).getDepartureFlight().getPassengers()!= null) && (((Booking)ses.getAttribute("booking")).getDepartureFlight().getPassengers().get(0).getName()!= null)){
                    %> <button onClick="window.location = 'thirdStep.html';" class="previous_butt_small">Previous Step</button> <%
                } %>
            </section>
            <div style="clear:left"></div>
</section >