/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
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
public class seatSave extends HttpServlet {

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
         HttpSession ses = request.getSession(true); 
        Booking booking = (Booking)ses.getAttribute("booking");
        ArrayList<Flight> flights = (ArrayList<Flight>)ses.getAttribute("availableFlights");

        Flight flight = null;

        for(Flight f : flights){
            if(booking.getDepartureFlight().getFlightCode().equals(f.getFlightCode()) && booking.getDepartureFlight().getDepartureDate().equals(f.getDepartureDate()) && booking.getDepartureFlight().getDepartureTime().equals(f.getDepartureTime())){
                try {
                    flight = f.clone();
                } catch (CloneNotSupportedException ex) {
                    Logger.getLogger(seatSave.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if(flight!=null){
            for (Passenger p : booking.getDepartureFlight().getPassengers()) {
                for (Service s : p.getServices()) {
                    if(s.getCode().equals("ES")){
                        flight.addPassenger(p);
                    }
                }
            }
            boolean []placement = new boolean[8];
            for(int i=0;i<placement.length;i++){
                placement[i]=false;
            }
            for(Passenger pf : flight.getPassengers()){
                placement[Integer.parseInt(pf.getSeat())-1]=true;
            }
            boolean alea = true;
            for(Passenger ps : booking.getDepartureFlight().getPassengers()){
                for(Service ss : ps.getServices()){
                   if(ss.getCode().equals("ES")) alea = false;
                }
                if(alea){
                    for(int i=0;i<placement.length;i++){
                        if(!placement[i]) {
                            ps.setSeat(""+(i+1));
                            placement[i]=true;
                            System.out.println(ps.getName()+" tiene el asiento "+ps.getSeat());
                            i=placement.length;
                        }
                    }

                }
                alea=true;
            }
        }
        
        
        Flight flightB = null;
        if(booking.getBackFlight()!=null && ses.getAttribute("availableFlightsTo")!=null){
                ArrayList<Flight> flightsB = (ArrayList<Flight>)ses.getAttribute("availableFlightsTo");

                for(Flight f : flightsB){
                    if(booking.getBackFlight().getFlightCode().equals(f.getFlightCode()) && booking.getBackFlight().getDepartureDate().equals(f.getDepartureDate()) && booking.getBackFlight().getDepartureTime().equals(f.getDepartureTime())){
                        try {
                            flightB = f.clone();
                        } catch (CloneNotSupportedException ex) {
                            Logger.getLogger(seatSave.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
                if(flightB!=null){
                    for (Passenger p : booking.getBackFlight().getPassengers()) {
                        for (Service s : p.getServices()) {
                            if(s.getCode().equals("ES")){
                                flightB.addPassenger(p);
                            }
                        }
                    }
                   boolean[] placement = new boolean[8];
                    for(int i=0;i<placement.length;i++){
                        placement[i]=false;
                    }
                
                    for(Passenger pf : flightB.getPassengers()){
                        placement[Integer.parseInt(pf.getSeat())-1]=true;
                    }
                    boolean alea = true;
                    for(Passenger ps : booking.getBackFlight().getPassengers()){
                        for(Service ss : ps.getServices()){
                           if(ss.getCode().equals("ES")) alea = false;
                        }
                        if(alea){
                            for(int i=0;i<placement.length;i++){
                                if(!placement[i]) {
                                    ps.setSeat(""+(i+1));
                                    placement[i]=true;
                                    System.out.println(ps.getName()+" tiene el asiento de vuelta "+ps.getSeat());
                                    i=placement.length;
                                }
                            }

                        }
                        alea=true;
                    }
                }
        }
        response.sendRedirect("fifthStep.html");
       
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
