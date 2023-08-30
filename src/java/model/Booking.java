package model;

import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Class Booking
 * Class that creates booking objects.
 * Requires from Flights and Payments objects to be completed.
 * @author Víctor Sánchez del Río
 */
public class Booking {

    private int id;
    private String bookingCode;
    private LocalDate bookingDate;
    private Flight departureFlight;
    private Flight backFlight;
    private Payment payment;
    
    /**
     * Booking Constructor
     * Booking class main constructor
     * @param id from database
     * @param bookingCode unique number (8 alphanumeric digits)
     * @param bookingDate when the booking has been done
     * @param departureFlight Flight object
     * @param backFlight Flight object
     * @param payment Payment object
     */
    public Booking(int id, String bookingCode, LocalDate bookingDate, Flight departureFlight, Flight backFlight, Payment payment) {
        this.id = id;
        this.bookingCode = bookingCode;
        this.departureFlight = departureFlight;
        this.backFlight = backFlight;
        this.payment = payment;
        this.bookingDate = bookingDate;
    }
    /**
     * Booking Constructor
     * Booking constructor that generates an empty booking only with the id setted
     * @param id from database
     */
    public Booking(int id){
        this.id = id;
    }
    
    /**
     *Booking Constructor
     * Constructor that copies a Booking object over this.
     * @param b 
     */
    public Booking(Booking b) {
        this.id = b.id;
        this.bookingCode = b.bookingCode;
        try {
            if (b.getBackFlight() != null) {
                this.backFlight = b.getBackFlight().clone();
            }
            this.departureFlight = b.getDepartureFlight().clone();
        } catch (CloneNotSupportedException ex) {
            Logger.getLogger(Booking.class.getName()).log(Level.SEVERE, null, ex);
        }
        this.bookingDate = b.bookingDate;
        this.payment = b.payment;
    }
    /**
     * Booking Constructor
     * Constructor that generates an empty booking just with the booking code setted.
     * @param bookingCode 
     */
    public Booking(String bookingCode) {
        this.bookingCode = bookingCode;
    }

    public LocalDate getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(LocalDate bookingDate) {
        this.bookingDate = bookingDate;
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

    public Flight getDepartureFlight() {
        return departureFlight;
    }

    public void setDepartureFlight(Flight departure) {
        try {
            if (departure != null) {
                this.departureFlight = departure.clone();
            } else {
                this.departureFlight = null;
            }
        } catch (CloneNotSupportedException ex) {
            Logger.getLogger(Booking.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Flight getBackFlight() {
        return backFlight;
    }

    public void setBackFlight(Flight backFlight) {
        try {
            if (backFlight != null) {
                this.backFlight = backFlight.clone();
            } else {
                this.backFlight = null;
            }
        } catch (CloneNotSupportedException ex) {
            Logger.getLogger(Booking.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteDepartureFlight() {
        this.departureFlight = null;
    }

    public void deleteBackFlight() {
        this.backFlight = null;
    }

    public Payment getPayment() {
        return payment;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }

    @Override
    public String toString() {
        return "Booking{" + "id=" + id + ", bookingCode=" + bookingCode + ", \ndepartureFlight:" + departureFlight + ", \nbackFlight=" + backFlight + ",\n payment=" + payment + '}';
    }

}
