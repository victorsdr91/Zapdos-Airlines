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
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Airport;

/**
 *
 * @author victo
 */
public class loadTo extends HttpServlet {
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
        Operations op = new Operations();
        HttpSession ses = request.getSession();
        ArrayList<Airport> toAirports = op.getToAirports(con,request.getParameter("from"));
        try (final PrintWriter out = response.getWriter()) {
            for(Airport fromAirport: toAirports){
                if(ses.getAttribute("language")!= null){
                    if((ses.getAttribute("language")).toString().contains("es_ES") || ((String)ses.getAttribute("language")).contains("es-ES")){
                        out.print("<option value=" + fromAirport.getIATA() + ">" + fromAirport.getPais() + ": " + fromAirport.getCity() + "</option>");
                    }
                    else if((ses.getAttribute("language")).toString().contains("en_GB")){
                        out.print("<option value=" + fromAirport.getIATA() + ">" + fromAirport.getCountry() + ": " + fromAirport.getCity() + "</option>");
                    }
                }
                else{
                    out.print("<option value=" + fromAirport.getIATA() + ">" + fromAirport.getCountry() + ": " + fromAirport.getCity() + "</option>");
                }
            }
        } catch (IOException ex) {
                Logger.getLogger(loadFrom.class.getName()).log(Level.SEVERE, null, ex);
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
