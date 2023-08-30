/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Booking;
import model.Flight;
import model.Passenger;
import model.Service;

/**
 *
 * @author victo
 */
public class refreshBooking extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession ses = request.getSession();
        Booking booking = (Booking) ses.getAttribute("booking");
        LocalDate now = LocalDate.now();
        
        if(booking==null){
            String cadenaAleatoria = "";
            long milis = new java.util.GregorianCalendar().getTimeInMillis();
            Random r = new Random(milis);
            int i = 0;
            while ( i < 8){
                char c = (char)r.nextInt(255);
                if ( (c >= '0' && c <='9') || (c >='A' && c <='Z') ){
                    cadenaAleatoria += c;
                    i ++;
                }
            }
            booking = new Booking(cadenaAleatoria);
            booking.setBookingDate(now);
            
        }
         ArrayList<Passenger> pass = null;
         ArrayList<Passenger> passD = null;
         ArrayList<Passenger> passB = null;
         int adults = 0;
         int children = 0;
         int infants = 0;
         int totalP = 0;
         int prevTotal = 0;
        if(ses.getAttribute("passengers")!= null){
            adults = (Integer)ses.getAttribute("adults");
            children = (Integer)ses.getAttribute("childs");
            infants = (Integer)ses.getAttribute("infants");
            totalP = (Integer)ses.getAttribute("totalP");
            if(ses.getAttribute("prevTotalP")!=null){
                prevTotal= (Integer)ses.getAttribute("prevTotalP");
            }
           if(totalP!=prevTotal){ 
             booking.deleteDepartureFlight();
             booking.deleteBackFlight();
           }
          
        }
        

        if(request.getParameter("departureFlight")!=null){
            if(request.getParameter("departureFlight").equals("true")){
                ArrayList flights = (ArrayList)ses.getAttribute("availableFlights");
                booking.setDepartureFlight((Flight)flights.get(Integer.parseInt(request.getParameter("id"))));
                if(ses.getAttribute("passengers")!= null){
                      pass= new ArrayList<>();
                        for(Passenger p : (ArrayList<Passenger>) ses.getAttribute("passengers")){
                           pass.add(new Passenger(p));
                        }
                        passD = new ArrayList<>();
                        for(Passenger p : pass){
                            passD.add(new Passenger(p));
                        }
                    booking.getDepartureFlight().setPassengers(passD);
                }
            }

        }
        if(request.getParameter("backFlight")!=null ){
            if(request.getParameter("backFlight").equals("true")){
                ArrayList flights = (ArrayList)ses.getAttribute("availableFlightsTo");
                booking.setBackFlight((Flight)flights.get(Integer.parseInt(request.getParameter("id"))));
                if(ses.getAttribute("passengers")!= null){
                      pass= new ArrayList<>();
                        for(Passenger p : (ArrayList<Passenger>) ses.getAttribute("passengers")){
                           pass.add(new Passenger(p));
                        }
                        passB = new ArrayList<>();
                        for(Passenger p : pass){
                            passB.add(new Passenger(p));
                        }
                     booking.getBackFlight().setPassengers(passB);
                }
            }

        }
        if(request.getParameter("addservice")!=null){
            if(request.getParameter("flight").equals("d")){
                Service service = ((ArrayList<Service>)ses.getAttribute("services")).get(Integer.parseInt(request.getParameter("addservice")));
                booking.getDepartureFlight().getPassengers().get(Integer.parseInt(request.getParameter("pid"))).addService(service);
            } else if(request.getParameter("flight").equals("b")){
                Service service = ((ArrayList<Service>)ses.getAttribute("services")).get(Integer.parseInt(request.getParameter("addservice")));
                booking.getBackFlight().getPassengers().get(Integer.parseInt(request.getParameter("pid"))).addService(service);
            }
            
        }
        if(request.getParameter("deleteservice")!=null){
            if(request.getParameter("flight").equals("d")){
                for(int i=0; i<booking.getDepartureFlight().getPassengers().get(Integer.parseInt(request.getParameter("pid"))).getServices().size();i++){
                    Service service = booking.getDepartureFlight().getPassengers().get(Integer.parseInt(request.getParameter("pid"))).getServices().get(i);
                    if(service.getCode().equals(request.getParameter("deleteservice")))booking.getDepartureFlight().getPassengers().get(Integer.parseInt(request.getParameter("pid"))).getServices().remove(service);
                }
            } else if(request.getParameter("flight").equals("b")){
                for(int i=0; i<booking.getDepartureFlight().getPassengers().get(Integer.parseInt(request.getParameter("pid"))).getServices().size();i++){
                    Service service = booking.getBackFlight().getPassengers().get(Integer.parseInt(request.getParameter("pid"))).getServices().get(i);
                    if(service.getCode().equals(request.getParameter("deleteservice")))booking.getBackFlight().getPassengers().get(Integer.parseInt(request.getParameter("pid"))).getServices().remove(service);
                }
            }
        }

        if(request.getParameter("deleteItem")!=null){
            switch(request.getParameter("deleteItem")){
                case "departureFlight": booking.deleteDepartureFlight();
                                        booking.deleteBackFlight();
                    break;
                case "backFlight": booking.deleteBackFlight();
                    break;
            }
        }
        ses.setAttribute("prevTotalP",totalP);
        ses.setAttribute("booking", booking);
        double total = 0;
        double totalPass = 0;
        DecimalFormat df  = new DecimalFormat("##.##");
        ArrayList<Service> passServices;
        try (PrintWriter out = response.getWriter()) {
           if(booking.getDepartureFlight()!=null){
               out.println("<span style='float:left;' >Departure from <b>"
                       + booking.getDepartureFlight().getConnection().getOriginAirport().getCity() 
                       + "</b> to <b>"
                       + booking.getDepartureFlight().getConnection().getDestinationAirport().getCity() 
                       + "</b> </span> <span class='ui-icon ui-icon-circle-close' style='float:left;' onclick='deleteBookingItem(\"departureFlight\"); checkContinue(\"departureRemoved\")'></span>"
                       + "<br /><span>"+ booking.getDepartureFlight().getDepartureDate()+" "+  booking.getDepartureFlight().getDepartureTime() +"</span><hr style='clear:left' />");
               for(Passenger p : booking.getDepartureFlight().getPassengers()){
                   passServices = p.getServices();
                   if(passServices.size()>0){
                       for(Service ser : passServices){
                           if(!ser.getCode().equals("B"))totalPass+= ser.getPrice();
                       }
                   }
                   totalPass+=  booking.getDepartureFlight().getPrice();
                   if(p.getType().equals("adult")){
                        out.println("<div> - Adult seat "+totalPass+"&euro; </div>");
                   }
                   else out.println("<div> - Child seat "+totalPass+"&euro; </div>");
                   total += totalPass;
                   totalPass=0;
               }
               for(int i = 0;i<infants;i++){
                   out.println("<div> - Baby seat "+booking.getDepartureFlight().getPassengers().get(i).getServices().get(0).getPrice()+"&euro; </div>");
                   total += booking.getDepartureFlight().getPassengers().get(i).getServices().get(0).getPrice();
               }
               out.print("<br/>");
              
           }
           if(booking.getBackFlight()!= null){
               out.println("<span style='float:left;' >Back from <b>"+ booking.getBackFlight().getConnection().getOriginAirport().getCity() +"</b> to <b>"+ booking.getBackFlight().getConnection().getDestinationAirport().getCity() +"</b></span> <span class='ui-icon ui-icon-circle-close' style='float:left;' onclick='deleteBookingItem(\"backFlight\"); checkContinue(\"backRemoved\")'></span> <br/><span>"+ booking.getBackFlight().getDepartureDate()+" "+  booking.getBackFlight().getDepartureTime() +"</span><hr style='clear:left' />");
               for(Passenger p : booking.getBackFlight().getPassengers()){
                   passServices = p.getServices();
                   if(passServices.size()>0){
                       for(Service ser : passServices){
                           if(!ser.getCode().equals("B"))totalPass+= ser.getPrice();
                       }
                   }
                   totalPass+=  booking.getBackFlight().getPrice();
                   if(p.getType().equals("adult")){
                        out.println("<div> - Adult seat "+totalPass+"&euro; </div>");
                   }
                   else out.println("<div> - Child seat "+totalPass+"&euro; </div>");
                   total += totalPass;
                   totalPass=0;
               }
               for(int i = 0;i<infants;i++){
                   out.println("<div> - Baby seat "+booking.getBackFlight().getPassengers().get(i).getServices().get(0).getPrice()+"&euro; </div>");
                   total += booking.getBackFlight().getPassengers().get(i).getServices().get(0).getPrice();
               }
               out.print("<br/>");
           }
           out.println("<hr /><div>Total: "+ df.format(total) +" &euro;</div>");
           ses.setAttribute("totalPrice", total);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
