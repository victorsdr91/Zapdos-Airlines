package model;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Class Flight
 * Object that has the entire data from an flight
 * @author Víctor Sánchez del Río <victorsdr91@gmail.com>
 */
public class Flight implements Cloneable {

    private int id;
    private Connection connection;
    private String flightCode;
    private LocalDate departureDate;
    private LocalTime departureTime;
    private LocalTime duration;
    private String airplane;
    private double price;
    private int nPlacement;
    private ArrayList<Passenger> passengers;
    private Boolean factured = false;
    
    /**
     * Flight Constructor
     * @param connection Connection object that have the origin and 
     * the destination information about the flight.
     * @param flightCode flight code unique/day obtained from database
     * @param departureDate Departure date
     * @param departureTime Departure time
     * @param duration Flight duration
     * @param airplane Airplane plate
     * @param price Flight price
     * @param nPlacement number of places on the airport.
     */
    public Flight(Connection connection, String flightCode, LocalDate departureDate, LocalTime departureTime, LocalTime duration, String airplane, double price, int nPlacement) {
        this.connection = connection;
        this.flightCode = flightCode;
        this.departureDate = departureDate;
        this.departureTime = departureTime;
        this.duration = duration;
        this.airplane = airplane;
        this.price = price;
        this.nPlacement = nPlacement;
        this.passengers = new ArrayList<>();

    }
    
    /**
     * Flight Constructor
     * @param id from database
     * @param connection Connection object that have the origin and 
     * the destination information about the flight.
     * @param flightCode flight code unique/day obtained from database
     * @param departureDate Departure date
     * @param departureTime Departure time
     * @param duration Flight duration
     * @param airplane Airplane plate
     * @param price Flight price
     * @param nPlacement number of places on the airport.
     */
    public Flight(int id, Connection connection, String flightCode, LocalDate departureDate, LocalTime departureTime, LocalTime duration, String airplane, double price, int nPlacement) {
        this.id = id;
        this.connection = connection;
        this.flightCode = flightCode;
        this.departureDate = departureDate;
        this.departureTime = departureTime;
        this.duration = duration;
        this.airplane = airplane;
        this.price = price;
        this.nPlacement = nPlacement;
        this.passengers = new ArrayList<>();
    }

    public Boolean getFactured() {
        return factured;
    }

    public void setFactured(Boolean factured) {
        this.factured = factured;
    }
    

    public Flight() {
        this.passengers = new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Connection getConnection() {
        return connection;
    }

    public void setConnection(Connection connection) {
        this.connection = connection;
    }

    public String getFlightCode() {
        return flightCode;
    }

    public void setFlightCode(String flightCode) {
        this.flightCode = flightCode;
    }

    public LocalDate getDepartureDate() {
        return departureDate;
    }

    public void setDepartureDate(LocalDate departureDate) {
        this.departureDate = departureDate;
    }

    public LocalTime getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(LocalTime departureTime) {
        this.departureTime = departureTime;
    }

    public LocalTime getDuration() {
        return duration;
    }

    public void setDuration(LocalTime duration) {
        this.duration = duration;
    }

    public String getAirplane() {
        return airplane;
    }

    public void setAirplane(String airplane) {
        this.airplane = airplane;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getnPlacement() {
        return nPlacement;
    }

    public void setnPlacement(int nPlacement) {
        this.nPlacement = nPlacement;
    }

    public ArrayList<Passenger> getPassengers() {
        return passengers;
    }

    public void setPassengers(ArrayList<Passenger> passengers) {
        this.passengers = passengers;
    }

    public boolean addPassenger(Passenger p) {
        try {
            this.passengers.add((Passenger) p.clone());
            return true;
        } catch (CloneNotSupportedException ex) {
            Logger.getLogger(Flight.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public Flight clone() throws CloneNotSupportedException {
        Flight aux = (Flight) super.clone();
        ArrayList<Passenger> passaux = new ArrayList<>();
        for (Passenger pass : this.getPassengers()) {
            passaux.add(new Passenger(pass));
        }
        aux.setPassengers(passaux);
        return aux;
    }

    @Override
    public String toString() {
        return "\nFlight{" + "id=" + id + ", connection=" + connection + ", flightCode=" + flightCode + ", departureDate=" + departureDate + ", departureTime=" + departureTime + ", duration=" + duration + ", airplane=" + airplane + ", price=" + price + ", nPlacement=" + nPlacement + ", \npassengers:" + passengers + '}';
    }

}
