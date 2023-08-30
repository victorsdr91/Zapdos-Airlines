package model;

import java.util.ArrayList;

/**
 * Class User
 * Contains information about a system user.
 * @author Víctor Sánchez del Río &lt;victorsdr91@gmail.com&gt;
 */
public class User {
    private int id;
    private String email;
    private String name;
    private String surName;
    private String nif;
    private String password;
    private Payment lastPayment;
    private boolean admin;
    private ArrayList<Booking> bookings;
    private ArrayList<Booking> backupBookings;
    
    /**
     * User Constructor
     * User main constructor
     * @param id from database
     * @param email user e-mail.
     * @param name user name.
     * @param surName user surname.
     * @param nif user identification number.
     * @param password user password.
     */
    public User(int id, String email, String name, String surName, String nif, String password) {
        this.id = id;
        this.email = email;
        this.name = name;
        this.surName = surName;
        this.nif = nif;
        this.password = password;
        this.bookings = new ArrayList<>();
        this.backupBookings = new ArrayList<>();
    }    
    /**
     * User Constructor
     * @param email user e-mail.
     * @param name user name.
     * @param surName user surname.
     * @param nif user identification number.
     * @param password user password.
     */
    public User(String email, String name, String surName, String nif, String password) {
        this.name = name;
        this.surName = surName;
        this.nif = nif;
        this.email = email;
        this.password = password;
        this.id = -1;
        this.bookings = new ArrayList<>();
        this.backupBookings = new ArrayList<>();
    }
    /**
     * User Constructor
     * Constructer used when the user is trying to log in the system.
     * @param email user e-mail.
     * @param password user password.
     */
    public User(String email, String password){
        this.email = email;
        this.password = password;
        this.id = -1;
        this.bookings = new ArrayList<>();
        this.backupBookings = new ArrayList<>();
    }

    public ArrayList<Booking> getBookings() {
        return bookings;
    }

    public void setBookings(ArrayList<Booking> bookings) {
        this.bookings = bookings;
    }

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public ArrayList<Booking> getBackupBookings() {
        return backupBookings;
    }

    public void setBackupBookings(ArrayList<Booking> backupBookings) {
        this.backupBookings = backupBookings;
    }

    

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurName() {
        return surName;
    }

    public void setSurName(String surName) {
        this.surName = surName;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Payment getLastPayment() {
        return lastPayment;
    }

    public void setLastPayment(Payment lastPayment) {
        this.lastPayment = lastPayment;
    }

    public boolean isAdmin() {
        return admin;
    }

    public void setAdmin(boolean admin) {
        this.admin = admin;
    }
    
    
}
