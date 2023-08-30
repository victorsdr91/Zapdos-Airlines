package model;

/**
 * Class connection
 * Intermediate class used to get the from and the to on a flight
 * @author Víctor Sánchez del Río <victorsdr91@gmail.com>
 */
public class Connection {

    private int id;
    private Airport originAirport;
    private Terminal originTerminal;
    private Airport destinationAirport;
    private Terminal destinationTerminal;
    /**
     * Connection Constructor
     * @param originAirport Origin Airport object
     * @param originTerminal Origin Terminal object
     * @param destinationAirport Destination Airport object
     * @param destinationTerminal Destination Terminal object
     */
    public Connection(Airport originAirport, Terminal originTerminal, Airport destinationAirport, Terminal destinationTerminal) {
        this.originAirport = originAirport;
        this.originTerminal = originTerminal;
        this.destinationAirport = destinationAirport;
        this.destinationTerminal = destinationTerminal;
    }
    
    /**
     * Connection Constructor
     * Connection main constructor
     * @param id from database
     * @param originAirport Origin Airport object
     * @param originTerminal Origin Terminal object
     * @param destinationAirport Destination Airport object
     * @param destinationTerminal Destination Terminal object
     */
    public Connection(int id, Airport originAirport, Terminal originTerminal, Airport destinationAirport, Terminal destinationTerminal) {
        this.id = id;
        this.originAirport = originAirport;
        this.originTerminal = originTerminal;
        this.destinationAirport = destinationAirport;
        this.destinationTerminal = destinationTerminal;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Airport getOriginAirport() {
        return originAirport;
    }

    public void setOriginAirport(Airport originAirport) {
        this.originAirport = originAirport;
    }

    public Terminal getOriginTerminal() {
        return originTerminal;
    }

    public void setOriginTerminal(Terminal originTerminal) {
        this.originTerminal = originTerminal;
    }

    public Airport getDestinationAirport() {
        return destinationAirport;
    }

    public void setDestinationAirport(Airport destinationAirport) {
        this.destinationAirport = destinationAirport;
    }

    public Terminal getDestinationTerminal() {
        return destinationTerminal;
    }

    public void setDestinationTerminal(Terminal destinationTerminal) {
        this.destinationTerminal = destinationTerminal;
    }

}
