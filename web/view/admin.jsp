<%-- 
    Document   : admin
    Created on : 25-feb-2016, 14:17:40
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
            if (us != null || (us!=null && !us.isAdmin())) {
        %>
        <div class="header"> <span class="inactive" onclick="window.location = 'index.html'" ><fmt:message key="main.fly.span.flight" /></span><% if (ses.getAttribute("user") != null) { %> <span class="inactive" onclick="window.location = 'checkin.html'"><fmt:message key="check.in" /></span> <% if(((User)ses.getAttribute("user")).isAdmin()){ %><span  onclick="window.location='admin.html'" >Admin Panel</span> <% } } %></div>
        <div  class="checkin">
            <h1 class="checkinh1">Completed flights</h1>
            <form method="post" action="deleteFlight" >
                <div class="label2">
                        <span>Flight Code</span>
                         <input type="text" name="fCode" class="input" id="fcode" autocomplete="off" value="" required />
                </div>
                <div class="label2">
                        <span>Departure Date</span>
                         <input type="text" name="fDate" class="input" id="fDate" autocomplete="off" value="" required />
                         <script>completedFlightDate()</script>
                </div>
                <button type="submit" class="continue_butt_small" >Delete Flight</button>
                <div style="clear:left"></div>
            </form>
             <h1 class="checkinh1">Incidents on a time period</h1>
            <form method="post" action="getIncidents" >
                <div class="label2">
                        <span>Min Date</span>
                         <input type="text" name="minDate" class="input" id="iminDate" autocomplete="off" value="" required />
                </div>
                <div class="label2">
                        <span>Max Date</span>
                         <input type="text" name="maxDate" class="input" id="imaxDate" autocomplete="off" value="" required />
                         <script>dateRange()</script>
                </div>
                <button type="submit" class="continue_butt_small" >Show Incidents</button>
                <div style="clear:left"></div>
                
            </form>
            <%  } else {
                    response.sendRedirect("index.jsp");
                }
            %>
        </div>
    </div>
</section >
<section class="sec">

</section>


