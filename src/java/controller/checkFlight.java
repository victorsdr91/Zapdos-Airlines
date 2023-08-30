/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import com.mysql.jdbc.Connection;
import dao.DBConnection;
import dao.Operations;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.Base64;
import java.util.Hashtable;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Booking;
import model.Flight;
import model.Passenger;
import model.User;

/**
 *
 * @author victo
 */
public class checkFlight extends HttpServlet {

    private Connection con;
    @Override
    public void init() throws ServletException {
        try {
            DBConnection ConexBD = DBConnection.GetConexion();
            con = (Connection) ConexBD.GetCon();
        } catch (ClassNotFoundException | SQLException cnfe) {
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
        User user = (User) ses.getAttribute("user");
        int id = Integer.parseInt(request.getParameter("booking"));
        String type = request.getParameter("flight");
        Booking userb = null;
        for (Booking b : user.getBookings()) {
            if (b.getId() == id) {
                userb = b;
            }
        }
        Flight f = null;
        if (type.equals("D")) {
            f = userb.getDepartureFlight();
        } else {
            f = userb.getBackFlight();
        }

        for (Passenger p : f.getPassengers()) {
            String myCodeText = "Flight: " + f.getFlightCode() + "\nPassenger: " + p.getNif() + "\n" + p.getName() + " " + p.getSurName() + "\nDate: " + f.getDepartureDate() + " " + f.getDepartureTime();
            int size = 125;
            // change path as per your laptop/desktop location
            try {
                Hashtable<EncodeHintType, ErrorCorrectionLevel> hintMap = new Hashtable<>();
                hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
                QRCodeWriter qrCodeWriter = new QRCodeWriter();
                BitMatrix byteMatrix;

                byteMatrix = qrCodeWriter.encode(myCodeText, BarcodeFormat.QR_CODE, size, size, hintMap);

                int Width = byteMatrix.getWidth();

                BufferedImage image = new BufferedImage(Width, Width,
                        BufferedImage.TYPE_INT_RGB);
                image.createGraphics();

                Graphics2D graphics = (Graphics2D) image.getGraphics();
                graphics.setColor(Color.WHITE);
                graphics.fillRect(0, 0, Width, Width);
                graphics.setColor(Color.BLACK);

                for (int i = 0; i < Width; i++) {
                    for (int j = 0; j < Width; j++) {
                        if (byteMatrix.get(i, j)) {
                            graphics.fillRect(i, j, 1, 1);
                        }
                    }
                }
                ByteArrayOutputStream os = new ByteArrayOutputStream();
                ImageIO.write(image, "png", Base64.getEncoder().wrap(os));
                String qr = os.toString(StandardCharsets.ISO_8859_1.name());
                p.setQr(qr);

                if (p.getBaby() != null) {
                    myCodeText = "Flight: " + f.getFlightCode() + "\nPassenger: " + p.getNif() + "\n" + p.getName() + " " + p.getSurName() + "\nDate: " + f.getDepartureDate() + " " + f.getDepartureTime();
                    // change path as per your laptop/desktop location
                    try {
                        hintMap = new Hashtable<>();
                        hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
                        qrCodeWriter = new QRCodeWriter();
                        byteMatrix = qrCodeWriter.encode(myCodeText, BarcodeFormat.QR_CODE, size, size, hintMap);
                        Width = byteMatrix.getWidth();

                        image = new BufferedImage(Width, Width,
                                BufferedImage.TYPE_INT_RGB);
                        image.createGraphics();
                        graphics = (Graphics2D) image.getGraphics();
                        graphics.setColor(Color.WHITE);
                        graphics.fillRect(0, 0, Width, Width);
                        graphics.setColor(Color.BLACK);

                        for (int i = 0; i < Width; i++) {
                            for (int j = 0; j < Width; j++) {
                                if (byteMatrix.get(i, j)) {
                                    graphics.fillRect(i, j, 1, 1);
                                }
                            }
                        }
                        os = new ByteArrayOutputStream();
                        ImageIO.write(image, "png", Base64.getEncoder().wrap(os));
                        qr = os.toString(StandardCharsets.ISO_8859_1.name());
                        p.getBaby().setQr(qr);

                    } catch (WriterException ex) {
                        Logger.getLogger(checkFlight.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            } catch (WriterException ex) {
                Logger.getLogger(checkFlight.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        Operations op = new Operations();
        int error = op.checkFlight(con, userb, type);
        if (error >= 0) {
            ses.setAttribute("boardingCardsFor", userb);
            ses.setAttribute("boardingCardsForType", type);
        } else {
            ses.setAttribute("boardingCardsFor", null);
        }

        response.sendRedirect("showBoardingCards.html");
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
