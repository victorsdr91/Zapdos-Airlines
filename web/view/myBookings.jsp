<%-- 
    Document   : mybookings
    Created on : 26-feb-2016, 13:41:01
    Author     : victo
--%>
<%@page import="model.Booking"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.User"%>
<%
    HttpSession ses = request.getSession();
    User userL = (User) ses.getAttribute("user");
    Booking bo = null;
    if(ses.getAttribute("booking")!=null){
     bo = (Booking) ses.getAttribute("booking");
    }
    if(userL!=null){
%>
<section class="main" >
    <div id="login_cont" style="text-align:center" class="container_extended">
        <div id="userdata" >
            <h1 class="udata">My Profile: </h1>
             <div class="udlabel">
                <span class="udlheading">Name:</span>
                <span class="udlvalue"><%=userL.getName() %></span>
             </div>
            <div class="udlabel">
                <span class="udlheading">Surname:</span>
                <span class="udlvalue"><%=userL.getSurName() %></span>
            </div>
             <div class="udlabel">
                <span class="udlheading">NIF:</span>
                <span class="udlvalue"><%=userL.getNif() %></span>
            </div>
            <div class="udlabel">
                <span class="udlheading">Email:</span>
                <span class="udlvalue"><%=userL.getEmail() %></span>
            </div>
            <div style="clear:left"></div>
        </div>
        <% if(userL.getBookings()!=null){ %>
        <div id="current" class="bookings" >
            <h2> Current Bookings (<%=userL.getBookings().size()%>)</h2>
            <div class="books">
            <table class="bookinglist">
                <thead>
                    <th>ID</th>
                    <th>Booking Code</th>
                    <th>Register date</th>
                    <th>Checked </th>
                    <th>Type</th>
                    <th>View</th>
                </thead>
     
            <% int i=0; for(Booking b : userL.getBookings()){ 
                 if (bo == null || (bo!=null && (bo.getBookingCode()==null || (bo.getBookingCode()!=null && !bo.getBookingCode().equals(b.getBookingCode()))))) { 
                     String checked, type;
                     if(b.getDepartureFlight()!=null){
                        checked = b.getDepartureFlight().getFactured() ? b.getBackFlight()!=null ? b.getBackFlight().getFactured() ? "<img src='./img/checked.png' class='check-ico' />" : "<img src='./img/notchecked.png' class='check-ico' /> " : "<img src='./img/checked.png' class='check-ico' />": "<img src='./img/notchecked.png' class='check-ico' /> ";
                        type = b.getDepartureFlight()!=null ? b.getBackFlight()!=null ? "Round Trip" : "Departure" : " ";
                     }
                     else{
                        checked = b.getBackFlight()!=null ? b.getBackFlight().getFactured() ? "<img src='./img/checked.png' class='check-ico' />" : "<img src='./img/notchecked.png' class='check-ico' /> " : "<img src='./img/checked.png' class='check-ico' />";
                        type =    b.getBackFlight()!=null ? "Round Trip" : "Departure";
                     }
            %>
            <tr>
                <td><%=i%></td>
                <td><%=b.getBookingCode()%></td>
                <td><%=b.getBookingDate().getDayOfMonth()+" "+b.getBookingDate().getMonth()+" "+b.getBookingDate().getYear() %></td>
                <td><%=checked%></td>
                <td><%=type %></td>
                
                <td><img onclick="<% if(b.getDepartureFlight()!=null) {%>window.open('showSelectedBooking.html?booking=<%=i%>','Your Booking','menubar=0,toolbar=0')<% } %>" src="img/view.png" class="view-ico" /></td>
            </tr>
            <% i++;}
            } %>
            </table>
            </div>
            <span class="view-more">View more... </span>
        </div>
        <% } %>
        <% if(userL.getBackupBookings()!=null){ %>
        <div id="past" class="bookings">
            <h2> Past Bookings (<%=userL.getBackupBookings().size()%>)</h2>
            <div class="books">
            <table class="bookinglist">
                <thead>
                    <th>ID</th>
                    <th>Booking Code</th>
                    <th>Register date</th>
                    <th>Checked </th>
                    <th>Type</th>
                    <th>View</th>
                </thead>
     
             <% int j=0; for(Booking b : userL.getBackupBookings()){
                    String checked = b.getDepartureFlight().getFactured() ? b.getBackFlight()!=null ? b.getBackFlight().getFactured() ? "<img src='./img/checked.png' class='check-ico' />" : " " : "<img src='./img/checked.png' class='check-ico' />": " ";
                     String type = b.getDepartureFlight()!=null ? b.getBackFlight()!=null ? "Round Trip" : "Departure" : " ";
             %>
                 <tr>
                    <td><%=j%></td>
                    <td><%=b.getBookingCode()%></td>
                    <td><%=b.getBookingDate().getDayOfMonth()+" "+b.getBookingDate().getMonth()+" "+b.getBookingDate().getYear() %></td>
                    <td><%=checked%></td>
                    <td><%=type %></td>
                    <td><img onclick="window.open('showSelectedBooking.html?bbooking=<%=j%>','Your Booking','menubar=0,toolbar=0')" src="img/view.png" class="view-ico" /></td>
            </tr>
            
            <% j++; } %>
            </table>
            </div>
            <span class="view-more">View more... </span>
        </div>
        <% } %>
    </div>
    <div style="clear:left"></div>
    <script type="text/javascript" src="./js/myBookings.js" ></script>
</section>
<% } else {
        response.sendRedirect("login.html");
    }%>