/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.mysql.jdbc.Connection;
import dao.DBConnection;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Booking;
import model.Passenger;

/**
 *
 * @author victo
 */
public class savePassengers extends HttpServlet {
    private Connection con;
    @Override
    public void init() throws ServletException {
          try{
                DBConnection ConexBD=DBConnection.GetConexion();  
                con = (Connection) ConexBD.GetCon();
            }catch(ClassNotFoundException | SQLException cnfe){  
                }
    }
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
        Booking booking = (Booking)ses.getAttribute("booking");
        ArrayList<Passenger> pass = booking.getDepartureFlight().getPassengers();
        int i = 1;
        for(Passenger passenger : pass) {
            passenger.setId(-1);
            passenger.setName(request.getParameter("name_passenger_"+i));
            passenger.setNif(request.getParameter("nif_passenger_"+i));
            passenger.setSurName(request.getParameter("surname_passenger_"+i));
            System.out.println(passenger.getSurName());
            passenger.setBirthDate(LocalDate.parse(request.getParameter("birthdate_passenger_"+i)));
            passenger.setCountry(request.getParameter("country_passenger_"+i));
            passenger.setState(request.getParameter("state_passenger_"+i));
            if(passenger.getBaby()!=null){
                passenger.getBaby().setName(request.getParameter("name_babypassenger_"+i));
                passenger.getBaby().setNif(request.getParameter("nif_babypassenger_"+i));
                passenger.getBaby().setSurName(request.getParameter("surname_babypassenger_"+i));
                passenger.getBaby().setBirthDate(LocalDate.parse(request.getParameter("birthdate_babypassenger_"+i)));
                passenger.getBaby().setCountry(request.getParameter("country_babypassenger_"+i));
                passenger.getBaby().setState(request.getParameter("state_babypassenger_"+i));
            }
            i++;
        }
        if(booking.getBackFlight()!=null){
            ArrayList<Passenger> passB = booking.getBackFlight().getPassengers();
            i = 1;
            for(Passenger passenger : passB) {
                passenger.setId(-1);
                passenger.setName(request.getParameter("name_passenger_"+i));
                passenger.setNif(request.getParameter("nif_passenger_"+i));
                passenger.setSurName(request.getParameter("surname_passenger_"+i));
                System.out.println(passenger.getSurName());
                passenger.setBirthDate(LocalDate.parse(request.getParameter("birthdate_passenger_"+i)));
                passenger.setCountry(request.getParameter("country_passenger_"+i));
                passenger.setState(request.getParameter("state_passenger_"+i));
                if(passenger.getBaby()!=null){
                    passenger.getBaby().setName(request.getParameter("name_babypassenger_"+i));
                    passenger.getBaby().setNif(request.getParameter("nif_babypassenger_"+i));
                    passenger.getBaby().setSurName(request.getParameter("surname_babypassenger_"+i));
                    passenger.getBaby().setBirthDate(LocalDate.parse(request.getParameter("birthdate_babypassenger_"+i)));
                    passenger.getBaby().setCountry(request.getParameter("country_babypassenger_"+i));
                    passenger.getBaby().setState(request.getParameter("state_babypassenger_"+i));
                }
                i++;
            }
        }
        response.sendRedirect("thirdStep.html");
        
        
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
