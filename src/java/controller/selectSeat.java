/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Booking;

/**
 *
 * @author victo
 */
public class selectSeat extends HttpServlet {

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
        HttpSession ses = request.getSession(true); 
        Booking booking = (Booking)ses.getAttribute("booking");
        if(request.getParameter("passenger")!=null){
            int ind = Integer.parseInt(request.getParameter("passenger"));
            try (PrintWriter out = response.getWriter()) {
                /* TODO output your page here. You may use following sample code. */
               out.print(booking.getDepartureFlight().getPassengers().get(ind).getName()+ " "+ booking.getDepartureFlight().getPassengers().get(ind).getSurName());
            }
        }
        if(request.getParameter("passengerB")!=null){
            int ind = Integer.parseInt(request.getParameter("passengerB"));
            try (PrintWriter out = response.getWriter()) {
                /* TODO output your page here. You may use following sample code. */
               out.print(booking.getBackFlight().getPassengers().get(ind).getName()+ " "+ booking.getBackFlight().getPassengers().get(ind).getSurName());
            }
        }
        if(request.getParameter("type")!=null && request.getParameter("pass")!=null && request.getParameter("seat")!=null){
            int inp = Integer.parseInt(request.getParameter("pass"));
            String seat = request.getParameter("seat");
            String type = request.getParameter("type");
            if(type.equals("D")){
                booking.getDepartureFlight().getPassengers().get(inp).setSeat(seat);
                System.out.println("Añadido asiento a: "+booking.getDepartureFlight().getPassengers().get(inp).getName() );
                System.out.println("Asiento: "+booking.getDepartureFlight().getPassengers().get(inp).getSeat() );
            }
            else if(type.equals("B")){
                booking.getBackFlight().getPassengers().get(inp).setSeat(seat);
                System.out.println("B Añadido asiento a: "+booking.getBackFlight().getPassengers().get(inp).getName() );
                System.out.println("B Asiento: "+booking.getBackFlight().getPassengers().get(inp).getSeat() );
            }
        }
    }

    // <editor-fold defaultstate='collapsed' desc='HttpServlet methods. Click on the + sign on the left to edit the code.'>
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
