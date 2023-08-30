<%-- 
    Document   : showBooking
    Created on : 17-feb-2016, 21:54:08
    Author     : victo
--%>


<%@page import="model.Terminal"%>
<%@page import="model.Airport"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.util.Base64"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="com.google.zxing.WriterException"%>
<%@page import="java.awt.Color"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="com.google.zxing.common.BitMatrix"%>
<%@page import="com.google.zxing.BarcodeFormat"%>
<%@page import="com.google.zxing.qrcode.QRCodeWriter"%>
<%@page import="com.google.zxing.qrcode.decoder.ErrorCorrectionLevel"%>
<%@page import="com.google.zxing.EncodeHintType"%>
<%@page import="java.util.Hashtable"%>
<%@page import="model.Flight"%>
<%@page import="model.Service"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="model.Passenger"%>
<%@page import="model.User"%>
<%@page import="model.Booking"%>

<%
    HttpSession ses = request.getSession();
    User userl = (User) ses.getAttribute("user");
    if (userl == null)
        response.sendRedirect("index.html");
    else {

        Booking booking = (Booking) ses.getAttribute("boardingCardsFor");
        String type = (String) ses.getAttribute("boardingCardsForType");
        if (booking == null || booking.getDepartureFlight() == null) {
            response.sendRedirect("index.html");
        }
        DecimalFormat df = new DecimalFormat("##.##");
        Flight f = null;
        if (type.equals("D")) {
            f = booking.getDepartureFlight();
        } else {
            f = booking.getBackFlight();
        }
        Airport ori = f.getConnection().getOriginAirport();
        Airport dest = f.getConnection().getDestinationAirport();
        Terminal orit = f.getConnection().getOriginTerminal();
        Terminal destt = f.getConnection().getDestinationTerminal();
%>      

<section class="main" >
    <div id="login_cont" class="container">
        <h1 class="h1center">Your Boarding Cards</h1>
        <script type="text/javascript" src="./js/booking.js"></script>
        <div id="boardingcards">
            <style>
                @media print {
                    .boardingcard{
                        font-family: sans-serif;
                        padding: 10px;
                        width: 100%;
                        background: #001735;
                        margin: 10px;
                        border-radius: 7px;
                    }
                    #flightdata{
                        float:left;
                        width:52%;
                        font-size: 10px;
                    }
                    #flightdata .static{
                        padding: 3px;
                        color:white;
                        font-weight: bold;
                    }
                    #flightdata .dynamic{
                        padding: 3px;
                        background: white;
                        border-radius: 2px;
                    }
                    #flightdatamin{
                        float:left;
                        width:28%;
                        font-size: 8px;
                        padding-left: 5px;
                        padding-bottom: 5px;
                        border-left: 1px dashed #fff000;
                    }
                    #flightdatamin .static{
                        display:inline-block;
                        padding: 1px;
                        color:white;
                        font-weight: bold;
                    }
                    #flightdatamin .dynamic{
                        display:inline-block;
                        padding: 3px;
                        background: white;
                        border-radius: 2px;
                    }
                    .qr{
                        float:left;
                        border-radius: 5px;
                    }
                    .qr .title{
                        margin: 3px;
                        color: yellow;
                        font-weight: bold;
                        font-size: 16px;
                    }
                }
            </style>
            <%     for (Passenger p : f.getPassengers()) {%>
            <div class="boardingcard">
                <div id="flightdata">
                    <div>
                        <span class="static">FLIGHT: </span>
                        <span class="dynamic"><%=f.getFlightCode()%></span>
                        <span class="static" style="margin-left: 120px; color:yellow"> COMPANY </span>
                    </div>
                    <div style="margin-top:15px;">
                        <span class="static"> FROM </span>
                        <span class="dynamic"><%=ori.getName()%> <%=orit.getLocation()%><%=orit.getNumber()%> <%=ori.getCity()%> (<%=ori.getCountry()%>)</span>
                        <span class="static"> TO </span>
                        <span class="dynamic"><%=dest.getName()%> <%=destt.getLocation()%><%=destt.getNumber()%> <%=dest.getCity()%> (<%=dest.getCountry()%>)</span>
                    </div>
                    <div style="margin-top:15px;">
                        <span class="static"> DEPARTURE: </span>
                        <span class="dynamic"><%=f.getDepartureDate().getDayOfMonth()%> <%=f.getDepartureDate().getMonth()%> <%=f.getDepartureDate().getYear()%> <%=f.getDepartureTime().toString()%>h</span>
                        <span class="static"> ARRIVAL: </span>
                        <span class="dynamic"> <%=f.getDepartureTime().plusNanos(f.getDuration().toNanoOfDay()).toString()%>h </span>
                    </div>
                    <div style="margin-top:15px;">
                        <span class="static">PASSENGER: </span>
                        <span class="static"> NIF </span>
                        <span class="dynamic"><%=p.getNif()%></span>
                        <span class="static"> NAME </span>
                        <span class="dynamic"><%=p.getName()%> <%=p.getSurName()%></span>
                    </div>
                    <div style="margin-top:15px;">
                        <span class="static"> SEAT: </span>
                        <span class="dynamic" style="font-weight:bold;"><%=p.getSeat()%></span>
                    </div>
                </div>
                <div id="flightdatamin">
                    <div>
                        <span class="static">FLIGHT: </span>
                        <span class="dynamic"><%=f.getFlightCode()%></span>
                         <span class="static" style="margin-left: 40px; color:yellow"> CLIENT </span>
                    </div>
                    <div style="margin-top:15px;">
                        <span class="static"> FROM </span>
                        <span class="dynamic"><%=ori.getIATA()%></span>
                        <span class="static"> TO </span>
                        <span class="dynamic"><%=dest.getIATA()%></span>
                    </div>
                    <div style="margin-top:15px;">
                        <span class="static"> DEPARTURE: </span>
                        <span class="dynamic"><%=f.getDepartureDate().getDayOfMonth()%> <%=f.getDepartureDate().getMonth()%> <%=f.getDepartureDate().getYear()%> <%=f.getDepartureTime().toString()%> </span>
                    </div>
                    <div style="margin-top:15px;">
                        <span class="static">PASSENGER: </span>
                        <br/><br/>
                        <span class="static"> NAME </span>
                        <span class="dynamic"><%=p.getName()%> <%=p.getSurName()%></span>
                        <span class="static"> SEAT </span>
                        <span class="dynamic" style="font-weight:bold;"><%=p.getSeat()%></span>
                    </div>
                </div>
                <div class="qr">
                    <h1 class="title">Zapdos Airlines</h1>
                    <img style="border-radius:4px" src="data:image/png;base64,<%=p.getQr()%>" />
                </div>
                <div style="clear:left" ></div>
            </div>
            <%
                if(p.getBaby()!=null){ %>
                <div class="boardingcard">
                    <div id="flightdata">
                        <div>
                            <span class="static">FLIGHT: </span>
                            <span class="dynamic"><%=f.getFlightCode()%></span>
                             <span class="static" style="margin-left: 120px; color:yellow"> COMPANY </span>
                        </div>
                        <div style="margin-top:15px;">
                            <span class="static"> FROM </span>
                            <span class="dynamic"><%=ori.getName()%> <%=orit.getLocation()%><%=orit.getNumber()%> <%=ori.getCity()%> (<%=ori.getCountry()%>)</span>
                            <span class="static"> TO </span>
                            <span class="dynamic"><%=dest.getName()%> <%=destt.getLocation()%><%=destt.getNumber()%> <%=dest.getCity()%> (<%=dest.getCountry()%>)</span>
                        </div>
                        <div style="margin-top:15px;">
                            <span class="static"> DEPARTURE: </span>
                            <span class="dynamic"><%=f.getDepartureDate().getDayOfMonth()%> <%=f.getDepartureDate().getMonth()%> <%=f.getDepartureDate().getYear()%> <%=f.getDepartureTime().toString()%>h</span>
                            <span class="static"> ARRIVAL: </span>
                            <span class="dynamic"> <%=f.getDepartureTime().plusNanos(f.getDuration().toNanoOfDay()).toString()%>h </span>
                        </div>
                        <div style="margin-top:15px;">
                            <span class="static">PASSENGER: </span>
                            <span class="static"> NIF </span>
                            <span class="dynamic"><%=p.getBaby().getNif()%></span>
                            <span class="static"> NAME </span>
                            <span class="dynamic"><%=p.getBaby().getName()%> <%=p.getBaby().getSurName()%></span>
                        </div>
                        <div style="margin-top:15px;">
                            <span class="static"> SEAT: </span>
                            <span class="dynamic" style="font-weight:bold;"><%=p.getSeat()%></span>
                        </div>
                    </div>
                    <div id="flightdatamin">
                        <div>
                            <span class="static">FLIGHT: </span>
                            <span class="dynamic"><%=f.getFlightCode()%></span>
                            <span class="static" style="margin-left: 40px; color:yellow"> CLIENT </span>
                        </div>
                        <div style="margin-top:15px;">
                            <span class="static"> FROM </span>
                            <span class="dynamic"><%=ori.getIATA()%></span>
                            <span class="static"> TO </span>
                            <span class="dynamic"><%=dest.getIATA()%></span>
                        </div>
                        <div style="margin-top:15px;">
                            <span class="static"> DEPARTURE: </span>
                            <span class="dynamic"><%=f.getDepartureDate().getDayOfMonth()%> <%=f.getDepartureDate().getMonth()%> <%=f.getDepartureDate().getYear()%> <%=f.getDepartureTime().toString()%> </span>
                        </div>
                        <div style="margin-top:15px;">
                            <span class="static">PASSENGER: </span>
                            <br/><br/>
                            <span class="static"> NAME </span>
                            <span class="dynamic"><%=p.getBaby().getName()%> <%=p.getBaby().getSurName()%></span>
                            <span class="static"> SEAT </span>
                            <span class="dynamic" style="font-weight:bold;"><%=p.getSeat()%></span>
                        </div>
                    </div>
                    <div class="qr">
                        <h1 class="title">Zapdos Airlines</h1>
                        <img style="border-radius:4px" src="data:image/png;base64,<%=p.getBaby().getQr()%>" />
                    </div>
                    <div style="clear:left" ></div>
                </div>
                <% } %>
            <% } %>
        </div>
        <button id="continue" onclick="printE(document.getElementById('boardingcards'));" class="continue_butt" style="display:inline-block;margin-left: 75%;">Print</button>
        <button id="continue" onclick="window.location = 'index.html'" class="continue_butt" style="display:inline-block;margin-left:1%;">Home</button>

    </div>
    <div style="clear:left" ></div>
</section>
<% }%>
