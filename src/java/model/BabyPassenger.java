package model;

import java.time.LocalDate;

/**
 *Class BabyPassenger
 * Class to create BabyPassenger objects with the default getter and setter methods.
 * Extends from Person.
 * @author victo
 */
public class BabyPassenger extends Person implements Cloneable {
    /**
     * BabyPassenger constructor
     * Default BabyPassenger constructor
     * @param id from database
     * @param nif BabyPassenger's official document
     * @param name BabyPassenger's name.
     * @param surName BabyPassenger's surname.
     * @param country BabyPassenger's country.
     * @param state BabyPassenger's state.
     * @param birthDate BabyPassenger's birthdate.
     */
    public BabyPassenger(int id, String nif, String name, String surName, String country, String state, LocalDate birthDate) {
        super(id, nif, birthDate, name, surName, country, state);
    }
    /**
     * BabyPassenger constructor
     * @param nif BabyPassenger's official document
     * @param name BabyPassenger's name.
     * @param surName BabyPassenger's surname.
     * @param country BabyPassenger's country.
     * @param state BabyPassenger's state.
     * @param birthDate BabyPassenger's birthdate.
     */
    public BabyPassenger(String nif, String name, String surName, String country, String state, LocalDate birthDate) {
        super(nif, birthDate, name, surName, country, state);
    }
    
    /**
     * BabyPassenger constructor
     * Creates an empty babypassenger object
     */
    public BabyPassenger() {
        super();
    }

    @Override
    public BabyPassenger clone() throws CloneNotSupportedException {
        return (BabyPassenger) super.clone();
    }

}
