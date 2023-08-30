package model;

import java.time.LocalDate;

/**
 * Class Person
 * Abstract class that is never invoqued.
 * Used to create Passenger and BabyPassenger objects.
 * @author Víctor Sánchez del Río <victorsdr91@gmail.com>
 */
public abstract class Person {

    private int id;
    private String nif;
    private LocalDate birthDate;
    private String name;
    private String surName;
    private String country;
    private String state;
    private String qr;

    /**
     * Person Constructor
     * Person main contructor
     * @param id from database
     * @param nif person identification number.
     * @param birthDate person birthdate.
     * @param name person name.
     * @param surName person surname.
     * @param country person country.
     * @param state person state.
     */
    public Person(int id, String nif, LocalDate birthDate, String name, String surName, String country, String state) {
        this.nif = nif;
        this.birthDate = birthDate;
        this.name = name;
        this.surName = surName;
        this.country = country;
        this.state = state;
        this.id = id;
    }
    /**
     * Person Constructor
     * @param nif person identification number.
     * @param birthDate person birthdate.
     * @param name person name.
     * @param surName person surname.
     * @param country person country.
     * @param state person state.
     */
    public Person(String nif, LocalDate birthDate, String name, String surName, String country, String state) {
        this.nif = nif;
        this.birthDate = birthDate;
        this.name = name;
        this.surName = surName;
        this.country = country;
        this.state = state;
        this.id = -1;
    }
    /**
     * Person Constructor
     * Person empty constructor.
     */
    public Person() {

    }
    
    public String getQr() {
        return qr;
    }

    public void setQr(String qr) {
        this.qr = qr;
    }
    
    public Person(String NIF) {
        this.nif = NIF;
    }

    public String getNif() {
        return nif;
    }

    public void setNif(String nif) {
        this.nif = nif;
    }

    public int getId() {
        return id;
    }
   
    
    public void setId(int id) {
        this.id = id;
    }

    public LocalDate getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(LocalDate birthDate) {
        this.birthDate = birthDate;
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

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return "Person{" + "id=" + id + ", nif=" + nif + ", birthDate=" + birthDate + ", name=" + name + ", surName=" + surName + ", country=" + country + ", state=" + state + '}';
    }

}
