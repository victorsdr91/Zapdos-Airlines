/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.time.LocalDate;

/**
 * Class Incident
 * Contains information about non-checked bookings and flight data.
 * @author Víctor Sánchez del Río <victorsdr91@gmail.com
 */
public class Incident {
     private int id;
     private String bookingCode;
     private String nif;
     private String email;
     private LocalDate flightDate;
     private String flightCode;
     private String from;
     private String to;
     private int adults;
     private int children;
     private int infants;
     private double totalFlight;
     private double totalServices;
     
     /**
      * Incident Constructor
      * Incident main constructor
      * @param id from database
      * @param bookingCode booking code.
      * @param nif user nif.
      * @param email user email.
      * @param flightDate flight date.
      * @param flightCode flight code.
      * @param from from IATA.
      * @param to to IATA.
      * @param adults number of adults.
      * @param children number of children.
      * @param infants number of infants.
      * @param totalFlight total flight price.
      * @param totalServices total booked services price.
      */
    public Incident(int id, String bookingCode, String nif, String email, LocalDate flightDate, String flightCode, String from, String to, int adults, int children, int infants, double totalFlight, double totalServices) {
        this.id = id;
        this.bookingCode = bookingCode;
        this.nif = nif;
        this.email = email;
        this.flightDate = flightDate;
        this.flightCode = flightCode;
        this.from = from;
        this.to = to;
        this.adults = adults;
        this.children = children;
        this.infants = infants;
        this.totalFlight = totalFlight;
        this.totalServices = totalServices;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBookingCode() {
        return bookingCode;
    }

    public void setBookingCode(String bookingCode) {
        this.bookingCode = bookingCode;
    }

    public String getNif() {
        return nif;
    }

    public void setNif(String nif) {
        this.nif = nif;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LocalDate getFlightDate() {
        return flightDate;
    }

    public void setFlightDate(LocalDate flightDate) {
        this.flightDate = flightDate;
    }

    public String getFlightCode() {
        return flightCode;
    }

    public void setFlightCode(String flightCode) {
        this.flightCode = flightCode;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public int getAdults() {
        return adults;
    }

    public void setAdults(int adults) {
        this.adults = adults;
    }

    public int getChildren() {
        return children;
    }

    public void setChildren(int children) {
        this.children = children;
    }

    public int getInfants() {
        return infants;
    }

    public void setInfants(int infants) {
        this.infants = infants;
    }

    public double getTotalFlight() {
        return totalFlight;
    }

    public void setTotalFlight(double totalFlight) {
        this.totalFlight = totalFlight;
    }

    public double getTotalServices() {
        return totalServices;
    }

    public void setTotalServices(double totalServices) {
        this.totalServices = totalServices;
    }
     
     
     
           
}
