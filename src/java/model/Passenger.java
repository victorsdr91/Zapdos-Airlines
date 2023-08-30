package model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Class Passenger
 * Contains the passenger information and its services
 * @author Víctor Sánchez del Río <victorsdr91@gmail.com>
 */
public class Passenger extends Person implements Cloneable {

    private ArrayList<Service> services;
    private BabyPassenger baby;
    private String type;
    private String seat;

    /**
     * Passenger Constructor
     * Passenger main constructor
     * @param id from database
     * @param nif passenger identification number
     * @param birthDate passenger birthdate
     * @param name passenger name
     * @param surName passenger surname
     * @param country passenger country
     * @param state passenger state
     * @param type passenger type (adult/child)
     * @param seat passenger flight seat
     */
    public Passenger(int id, String nif, LocalDate birthDate, String name, String surName, String country, String state, String type, String seat) {
        super(id, nif, birthDate, name, surName, country, state);
        this.services = new ArrayList<>();
        this.type = type;
        this.seat = seat;
    }
    /**
     * Passenger Constructor
     * @param nif passenger identification number
     * @param birthDate passenger birthdate
     * @param name passenger name
     * @param surName passenger surname
     * @param country passenger country
     * @param state passenger state
     * @param type passenger type (adult/child)
     * @param seat passenger flight seat
     */
    public Passenger(String nif, LocalDate birthDate, String name, String surName, String country, String state, String type, String seat) {
        super(nif, birthDate, name, surName, country, state);
        this.services = new ArrayList<>();
        this.type = type;
        this.seat = seat;
    }

    /**
     * Passenger Constructor
     * Constructor that creates an empty passenger just with the nif and seat setted.
     * @param NIF passenger nif
     * @param seat passenger seat
     */
    public Passenger(String NIF, String seat) {
        super(NIF);
        this.seat = seat;
    }
    
    /**
     * Passenger Constructor
     * Empty passenger constructor
     */
    public Passenger() {
        super();
        this.services = new ArrayList<>();
    }

    /**
     * Passenger Constructor
     * Constructor that creates and empty passenger object just with the type setted.
     * @param type passenger type
     */
    public Passenger(String type) {
        super();
        this.type = type;
        this.services = new ArrayList<>();
    }
    
    /**
     * Passenger Constructor
     * Constructor that copies a Passenger object over this
     * @param p Passenger object to be copied.
     */
    public Passenger(Passenger p) {
        super(p.getId(), p.getNif(), p.getBirthDate(), p.getName(), p.getSurName(), p.getCountry(), p.getState());
        this.services = new ArrayList<>();
        if (p.getBaby() != null) {
            try {
                this.baby = (BabyPassenger) p.getBaby().clone();
            } catch (CloneNotSupportedException ex) {
                Logger.getLogger(Passenger.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        this.type = p.type;
        this.seat = p.seat;
        for (Service ser : p.getServices()) {
            try {
                this.services.add(ser.clone());
            } catch (CloneNotSupportedException ex) {
                Logger.getLogger(Passenger.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }

    public BabyPassenger getBaby() {
        return baby;
    }

    public void setBaby(BabyPassenger baby) {
        this.baby = baby;
    }

    public ArrayList<Service> getServices() {
        return services;
    }

    public void setServices(ArrayList<Service> services) {
        this.services = services;
    }

    public boolean addService(Service s) {
        try {
            this.services.add((Service) s.clone());
            return true;
        } catch (CloneNotSupportedException ex) {
            Logger.getLogger(Service.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSeat() {
        return seat;
    }

    public void setSeat(String seat) {
        this.seat = seat;
    }

    @Override
    public Passenger clone() throws CloneNotSupportedException {
        return (Passenger) super.clone();
    }

    @Override
    public String toString() {
        String str = super.toString();
        return "\n\t" + str + "Passenger{" + ", baby=" + baby + ", type=" + type + ", seat=" + seat + "\n services: " + services + '}';
    }

}
