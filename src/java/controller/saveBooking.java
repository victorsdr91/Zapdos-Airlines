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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Booking;
import model.Payment;
import model.User;

/**
 *
 * @author victo
 */
public class saveBooking extends HttpServlet {
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
        User user = (User)ses.getAttribute("user");
        String cnumber = request.getParameter("cnumber");
        String cholder = request.getParameter("cholder");
        int cvv = Integer.parseInt(request.getParameter("cvv"));
        String cmonth = request.getParameter("cmonth");
        String cyear = request.getParameter("cyear");
        for(int i = 0; i< cnumber.length(); i++){
            if(cnumber.charAt(i) == '-'){
                cnumber = cnumber.substring(0, i) + cnumber.substring(i+1, cnumber.length());
            }
        }
        System.out.println(cnumber);
        Payment pay = new Payment("creditCard",(double)ses.getAttribute("totalPrice"),cnumber,cholder,cvv,cmonth,cyear);
        user.getBookings().get(0).setPayment(pay);
        
        Operations op = new Operations();
        boolean error = op.setBooking(con,user);
        if(error){
            response.sendRedirect("errorSavingBooking.html");
        }
        else{
            response.sendRedirect("confirmedBooking.html");
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
