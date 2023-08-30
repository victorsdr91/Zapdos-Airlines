/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.mysql.jdbc.Connection;
import dao.DBConnection;
import dao.Operations;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.BabyPassenger;
import model.Flight;
import model.Passenger;
import model.Service;

/**
 *
 * @author victo
 */
public class loadFlights extends HttpServlet {
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
        Operations op = new Operations();
        
        int adults = Integer.parseInt(request.getParameter("adults"));
        int childs = Integer.parseInt(request.getParameter("childs"));
        int infants = Integer.parseInt(request.getParameter("infants"));
        int placements = adults+childs;
        ses.setAttribute("totalP",(adults+childs+infants));
        
        ArrayList<Passenger> passengers = new ArrayList<>();
        ArrayList<Service> services = op.getServices(con);
        ses.setAttribute("services", services);
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        
        LocalDate fromDate = LocalDate.parse(request.getParameter("fromDate"));
        LocalDate toDate = null;
        
        if(!request.getParameter("toDate").equals("")){
            toDate =  LocalDate.parse(request.getParameter("toDate"));
            
        }
       
        ses.setAttribute("childs", childs);
        ses.setAttribute("adults", adults);
        ses.setAttribute("infants", infants);
        int previousinfants = 0;
        if(ses.getAttribute("pinfants")!=null) previousinfants = (Integer)ses.getAttribute("pinfants");
        if(previousinfants!=infants){
            passengers = new ArrayList<>();
        }
        if(ses.getAttribute("passengers")!=null) ses.setAttribute("passengers",null);
        
        for(int i=0; i<(adults);i++){
            passengers.add(new Passenger("adult"));
        }
        for(int t=0; t<(childs);t++){
            passengers.add(new Passenger("child"));
        }
        Service baby = null;
        for(Service service : services){
            if(service.getCode().equals("B")) baby = service;
        }
        
        for(int j=0; j<infants;j++){
            passengers.get(j).setBaby(new BabyPassenger());
            passengers.get(j).addService(baby);
        }
        
        LocalDate dateMin = LocalDate.now();
        LocalDate dateMax = fromDate.plusWeeks(1);
        if(fromDate.minusWeeks(1).compareTo(dateMin)>0) dateMin = fromDate.minusWeeks(1);
        
        ArrayList<Flight> flights = op.getFlights(con, from, to, dateMin,dateMax, placements);
        if(ses.getAttribute("availableFlights")!=null){
            ses.setAttribute("availableFlights", null);
        }
         if(ses.getAttribute("availableFlightsTo")!=null){
            ses.setAttribute("availableFlightsTo", null);
        }
        if(toDate!=null){
            LocalDate dateMinTo = LocalDate.now().plusDays(1);
            if(toDate.minusWeeks(1).compareTo(dateMinTo)>0) dateMinTo = toDate.minusWeeks(1);
            LocalDate dateMaxTo = toDate.plusWeeks(1);
            ArrayList<Flight> flightsTo = op.getFlights(con, to, from, dateMinTo, dateMaxTo, placements);
            ses.setAttribute("availableFlightsTo", flightsTo);
        }
        ses.setAttribute("pinfants",infants);
        ses.setAttribute("availableFlights", flights);
        ses.setAttribute("passengers",passengers);
        request.setAttribute("section", "firstStep");
        response.sendRedirect("firstStep.html");
        
        
        
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
