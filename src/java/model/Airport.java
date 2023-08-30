package model;

import java.util.ArrayList;

/**
 * Class Airport 
 * This class just has default. getter and setter methods from its properties.
 *
 * @author Victor Sánchez del Río (victorsdr91@gmail.com)
 */
public class Airport implements Cloneable {

    private int ID;
    private String IATA;
    private String name;
    private String city;
    private String country;
    private String pais;
    private ArrayList<Terminal> terminals;

    /**
     * Airport main constructor
     *
     * @param IATA code from the airport Ex: MAD,DUB...
     * @param name from the airport Ex: Barajas
     * @param city where is the airport Ex: Madrid, London..
     * @param country where is the city Ex: Ireland, Spain...
     * @param pais where is the city (Spanish name) Ex: Irlanda, España...
     * @param terminals Terminals arrayList that contains Terminal Objects.
     */
    public Airport(int id, String IATA, String name, String city, String country, String pais, ArrayList<Terminal> terminals) {
        this.ID = id;
        this.IATA = IATA;
        this.name = name;
        this.city = city;
        this.country = country;
        this.pais = pais;
        this.terminals = new ArrayList<>();
        terminals.stream().forEach((terminal) -> {
            this.terminals.add(terminal);
        });
    }
    
    /**
     * Airport constructor
     * Constructor that generates an empty Airport.
     */
    public Airport() {
        this.terminals = new ArrayList<>();
    }

    /**
     * Airport constructor
     * @param IATA
     * @param name from the airport Ex: Barajas
     * @param city where is the airport Ex: Madrid, London..
     * @param country where is the city Ex: Ireland, Spain...
     * @param pais where is the city (Spanish name) Ex: Irlanda, España...
     */
    public Airport(String IATA, String name, String city, String country, String pais) {
        this.IATA = IATA;
        this.name = name;
        this.city = city;
        this.country = country;
        this.pais = pais;
        this.terminals = new ArrayList<>();

    }

    public int getId() {
        return ID;
    }

    public void setId(int ID) {
        this.ID = ID;
    }

    public String getIATA() {
        return IATA;
    }

    public void setIATA(String IATA) {
        this.IATA = IATA;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public void addTerminal(Terminal t) {
        this.terminals.add(t);
    }

    public ArrayList<Terminal> getTerminals() {
        return terminals;
    }

    public void setTerminals(ArrayList<Terminal> terminals) {
        this.terminals = terminals;
    }

    @Override
    public Airport clone() throws CloneNotSupportedException {
        Airport aux = (Airport) super.clone();
        ArrayList<Terminal> aux2 = new ArrayList<>();
        for (Terminal terminal : this.terminals) {
            aux2.add(terminal.clone());
        }
        aux.setTerminals(aux2);
        return aux;
    }

    @Override
    public String toString() {
        return "Airport{" + "IATA=" + IATA + ", name=" + name + ", city=" + city + ", country=" + country + ", pais=" + pais + ", terminals=" + terminals + '}';
    }

}
