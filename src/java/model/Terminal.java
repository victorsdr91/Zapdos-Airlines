package model;

/**
 * Class Terminal
 * Contains information about an specific terminal from an airport.
 * @author Víctor Sánchez del Río <victorsdr91@gmail.com>
 */
public class Terminal implements Cloneable {

    private int id;
    private String Location;
    private int number;

    /**
     * Terminal Constructor
     * Terminal main constructor
     * @param id from database.
     * @param Location Terminal location.
     * @param number terminal number.
     */
    public Terminal(int id, String Location, int number) {
        this.id = id;
        this.Location = Location;
        this.number = number;
    }
    
    /**
     * Terminal Constructor
     * @param Location Terminal location.
     * @param number terminal number.
     */
    public Terminal(String Location, int number) {
        this.Location = Location;
        this.number = number;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLocation() {
        return Location;
    }

    public void setLocation(String Location) {
        this.Location = Location;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    @Override
    public Terminal clone() throws CloneNotSupportedException {
        return (Terminal) super.clone();
    }

    @Override
    public String toString() {
        return "Terminal{" + "Location=" + Location + ", number=" + number + '}';
    }

}
