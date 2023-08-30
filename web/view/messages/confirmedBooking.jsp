<%-- 
    Document   : confirmBooking
    Created on : 18-feb-2016, 21:07:30
    Author     : Victor
--%>
<%
    HttpSession ses = request.getSession();
    ses.setAttribute("booking", null );
 %>
<section class="main" >
            <div id="login_cont" style="text-align:center" class="container">
                <h1 class="h1center">Booking confirmed!</h1>  
                <img src="./img/tick.png" style="width:100px; margin:auto" /><br/>
                <span style="text-align:center;">Your booking is correctly processed and it's on our database now.</span>
                <br/><br/>
                <button style="text-align:center;" class="previous_butt_small" onclick="window.location='showBooking.html'">View my Booking</button> 
                <button style="text-align:center;" class="previous_butt_small" onclick="window.location='index.html'">Home</button> 
                <button style="text-align:center;" class="previous_butt_small" onclick="window.location='myBookings.html'" >My Bookings</button>
            </div>
            <div style="clear:left"></div>
</section>
