package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Airport;
import model.BabyPassenger;
import model.Booking;
import model.Flight;
import model.Incident;
import model.Passenger;
import model.Payment;
import model.Service;
import model.Terminal;
import model.User;

/**
 * Class Operations
 * Contains methods to operate over database and system.
 * @author Víctor Sánchez del Río <victorsdr91@gmail.com>
 */
public class Operations {

    /**
     * getFromAirports
     * Method to obtain the airports data on the first screen.
     * @param con Connection object
     * @return List of the airports hosted on the system.
     */
    public ArrayList getFromAirports(Connection con) {
        ArrayList<Airport> Airports = new ArrayList<>();
        String select = "SELECT a.id, a.iata, a.name, a.city, a.country, a.pais, t.Location, t.number "
                + "FROM connections c "
                + "JOIN airports a ON a.id =c.originAirport "
                + "JOIN terminals t ON t.id = c.originTerminal AND t.idAirport = a.id "
                + "ORDER BY iata, number asc;";
        try {
            Statement s = con.createStatement();
            ResultSet result = s.executeQuery(select);
            String actualIata = "";
            Airport airport = null;
            String aux;
            Terminal t;
            while (result.next()) {
                aux = result.getString("iata");
                if (actualIata.equals(aux)) {
                    t = new Terminal(result.getString("Location"), result.getInt("number"));
                    airport.addTerminal(t.clone());
                } else {
                    actualIata = aux;
                    if (airport != null) {
                        Airports.add(airport.clone());
                    } else {
                        airport = new Airport();
                    }
                    airport.setId(result.getInt("id"));
                    airport.setIATA(actualIata);
                    airport.setName(result.getString("name"));
                    airport.setCity(result.getString("city"));
                    airport.setCountry(result.getString("country"));
                    airport.setPais(result.getString("pais"));
                    t = new Terminal(result.getString("Location"), result.getInt("number"));
                    airport.addTerminal(t.clone());
                }
            }
            if (airport != null) {
                Airports.add(airport.clone());
            }
        } catch (SQLException | CloneNotSupportedException ex) {
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return Airports;
    }
    
    /**
     * getToAirports
     * Method that obtains the Airport list connected with the origin.
     * @param con Connection object
     * @param from iata from the origin Airport.
     * @return Airport List connected with the origin Airport.
     */
    public ArrayList<Airport> getToAirports(Connection con, String from) {
        ArrayList<Airport> Airports = new ArrayList<>();
        String selectid = "SELECT DISTINCT id FROM airports WHERE iata='" + from + "' ";
        try {
            Statement s = con.createStatement();
            ResultSet resultid = s.executeQuery(selectid);
            resultid.first();
            String select = "SELECT a.id, a.iata, a.name, a.city, a.country, a.pais, t.Location, t.number "
                    + "FROM connections c "
                    + "JOIN airports a ON a.id =c.destinationAirport "
                    + "JOIN terminals t ON t.id = c.destinationTerminal AND t.idAirport = a.id "
                    + "WHERE c.originAirport = " + resultid.getInt("id") + " "
                    + "ORDER BY iata, number asc;";
            ResultSet result = s.executeQuery(select);
            String actualIata = "";
            Airport airport = null;
            String aux;
            Terminal t;
            while (result.next()) {
                aux = result.getString("iata");
                if (actualIata.equals(aux)) {
                    t = new Terminal(result.getString("Location"), result.getInt("number"));
                    airport.addTerminal(t.clone());
                } else {
                    actualIata = aux;
                    if (airport != null) {
                        Airports.add(airport.clone());
                    } else {
                        airport = new Airport();
                    }
                    airport.setId(result.getInt("id"));
                    airport.setIATA(actualIata);
                    airport.setName(result.getString("name"));
                    airport.setCity(result.getString("city"));
                    airport.setCountry(result.getString("country"));
                    airport.setPais(result.getString("pais"));
                    t = new Terminal(result.getString("Location"), result.getInt("number"));
                    airport.addTerminal(t.clone());
                }
            }
            if (airport != null) {
                Airports.add(airport.clone());
            }
        } catch (SQLException | CloneNotSupportedException ex) {
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return Airports;
    }

    /**
     * method getFlights
     * @param con Connection object
     * @param from Origin IATA
     * @param to Destination IATA
     * @param dateMin Min departure date to search on the database.
     * @param dateMax Max departure date to search on the database.
     * @param placements Placements to be occuped on the flight.
     * @return Available flights list.
     */
    public ArrayList<Flight> getFlights(Connection con, String from, String to, LocalDate dateMin, LocalDate dateMax, int placements) {
        ArrayList<Flight> flights = new ArrayList<>();
        try {
            System.out.println(dateMin);
            System.out.println(dateMax);
            String select = "SELECT f.id 'flightId', flightCode, departureDate, duration, dt.departuretime, airplane, price, "
                    + "		(nPlacement-(SELECT (count(*)) FROM flightoccupation fo WHERE fo.idFlight = f.id)) 'freePlacement', "
                    + "		fr.iata 'fromIata', fr.name 'fromName', fr.city 'fromCity', fr.country 'fromCountry', fr.pais 'fromPais', "
                    + "		frt.Location 'fromTerminalLocation', frt.number 'fromTerminalNumber', "
                    + "		t.iata 'toIata', t.name 'toName', t.city 'toCity', t.country 'toCountry', t.pais 'toPais', "
                    + "		tt.Location 'toTerminalLocation', tt.number 'toTerminalNumber' "
                    + "FROM flights f "
                    + "JOIN connections c ON  c.id = f.idConnection "
                    + "JOIN departuretimes dt ON f.idTime = dt.id "
                    + "JOIN airports fr ON fr.id = c.originAirport "
                    + "JOIN airports t ON t.id = c.destinationAirport "
                    + "JOIN terminals frt ON frt.id = c.originTerminal "
                    + "JOIN terminals tt ON tt.id = c.destinationTerminal "
                    + "WHERE fr.iata = '" + from + "' AND t.iata = '" + to + "' AND (departureDate BETWEEN '" + dateMin.toString() + "' AND '" + dateMax.toString() + "' AND (nPlacement-(SELECT (count(*)) FROM flightoccupation fo WHERE fo.idFlight = f.id)) >= " + placements + " ) ORDER BY departureDate asc;";
            Statement s = con.createStatement();
            ResultSet result = s.executeQuery(select);
            while (result.next()) {
                Terminal tFrom = new Terminal(result.getString("fromTerminalLocation"), result.getInt("fromTerminalNumber"));
                Airport AirFrom = new Airport(result.getString("fromIata"), result.getString("fromName"), result.getString("fromCity"), result.getString("fromCountry"), result.getString("fromPais"));
                AirFrom.addTerminal(tFrom);
                Terminal tTo = new Terminal(result.getString("toTerminalLocation"), result.getInt("toTerminalNumber"));
                Airport AirTo = new Airport(result.getString("toIata"), result.getString("toName"), result.getString("toCity"), result.getString("toCountry"), result.getString("toPais"));
                AirTo.addTerminal(tTo);
                model.Connection c = new model.Connection(AirFrom, tFrom, AirTo, tTo);

                String selectP = "SELECT p.*, fo.seat FROM flightoccupation fo "
                        + "JOIN passengers p ON fo.idPassenger = p.id "
                        + "WHERE fo.idFlight = " + result.getString("flightId") + " ;";
                Statement s2 = con.createStatement();
                ResultSet result2 = s2.executeQuery(selectP);

                Flight f = new Flight(result.getInt("flightId"), c, result.getString("flightCode"), result.getDate("departureDate").toLocalDate(), result.getTime("departuretime").toLocalTime(), result.getTime("duration").toLocalTime(), result.getString("airplane"), result.getDouble("price"), result.getInt("freePlacement"));
                while (result2.next()) {
                    Passenger p = new Passenger(result2.getString("NIF"), LocalDate.parse(result2.getString("Birthdate")), result2.getString("Name"), result2.getString("Surname"), result2.getString("country"), result2.getString("state"), result2.getString("type"), result2.getString("seat"));
                    f.addPassenger(p);
                }

                flights.add(f);
                System.out.println(result.getDate("departureDate"));
                System.out.println(result.getTime("duration"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return flights;
    }
    
    /**
     * getFlight
     * Method that obtain a complete booking flight complete object.
     * @param con Connection object
     * @param f Flight object
     * @param b Booking object
     * @return Complete Flight object.
     */
    public Flight getFlight(Connection con, Flight f, Booking b) {
        try {
            String select = "SELECT f.id 'flightId', flightCode, departureDate, duration, dt.departuretime, airplane, price, "
                    + "		(nPlacement-(SELECT (count(*)) FROM flightoccupation fo WHERE fo.idFlight = f.id)) 'freePlacement', "
                    + "		fr.iata 'fromIata', fr.name 'fromName', fr.city 'fromCity', fr.country 'fromCountry', fr.pais 'fromPais', "
                    + "		frt.Location 'fromTerminalLocation', frt.number 'fromTerminalNumber', "
                    + "		t.iata 'toIata', t.name 'toName', t.city 'toCity', t.country 'toCountry', t.pais 'toPais', "
                    + "		tt.Location 'toTerminalLocation', tt.number 'toTerminalNumber' "
                    + "FROM flights f "
                    + "JOIN connections c ON  c.id = f.idConnection "
                    + "JOIN departuretimes dt ON f.idTime = dt.id "
                    + "JOIN airports fr ON fr.id = c.originAirport "
                    + "JOIN airports t ON t.id = c.destinationAirport "
                    + "JOIN terminals frt ON frt.id = c.originTerminal "
                    + "JOIN terminals tt ON tt.id = c.destinationTerminal "
                    + "WHERE f.id=" + f.getId() + "  ;";
            Statement s = con.createStatement();
            ResultSet result = s.executeQuery(select);
            while (result.next()) {
                Terminal tFrom = new Terminal(result.getString("fromTerminalLocation"), result.getInt("fromTerminalNumber"));
                Airport AirFrom = new Airport(result.getString("fromIata"), result.getString("fromName"), result.getString("fromCity"), result.getString("fromCountry"), result.getString("fromPais"));
                AirFrom.addTerminal(tFrom);
                Terminal tTo = new Terminal(result.getString("toTerminalLocation"), result.getInt("toTerminalNumber"));
                Airport AirTo = new Airport(result.getString("toIata"), result.getString("toName"), result.getString("toCity"), result.getString("toCountry"), result.getString("toPais"));
                AirTo.addTerminal(tTo);
                model.Connection c = new model.Connection(AirFrom, tFrom, AirTo, tTo);

                String selectP = "SELECT p.*,fo.id 'foId', fo.seat, fo.factured FROM flightoccupation fo "
                        + "JOIN passengers p ON fo.idPassenger = p.id "
                        + "WHERE fo.idFlight = " + result.getString("flightId") + " AND fo.idBook=" + b.getId() + " ;";
                Statement s2 = con.createStatement();
                ResultSet result2 = s2.executeQuery(selectP);

                f = new Flight(result.getInt("flightId"), c, result.getString("flightCode"), result.getDate("departureDate").toLocalDate(), result.getTime("departuretime").toLocalTime(), result.getTime("duration").toLocalTime(), result.getString("airplane"), result.getDouble("price"), result.getInt("freePlacement"));
                while (result2.next()) {
                    f.setFactured(result2.getBoolean("factured"));
                    Passenger p = new Passenger(result2.getString("NIF"), LocalDate.parse(result2.getString("Birthdate")), result2.getString("Name"), result2.getString("Surname"), result2.getString("country"), result2.getString("state"), result2.getString("type"), result2.getString("seat"));
                    p.setId(result2.getInt("foId"));
                    p.setServices(this.getBookedServices(con, p));
                    String selectB = "SELECT * FROM babypassenger WHERE idPassenger = " + result2.getInt("id");
                    Statement s3 = con.createStatement();
                    ResultSet result3 = s3.executeQuery(selectB);
                    while (result3.next()) {
                        BabyPassenger baby = new BabyPassenger(result3.getInt("id"), result3.getString("NIF"), result2.getString("Name"), result2.getString("Surname"), result2.getString("country"), result2.getString("state"), LocalDate.parse(result2.getString("Birthdate")));
                        p.setBaby(baby);
                    }
                    f.addPassenger(p);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return f;
    }
    /**
     * getBackupFlight
     * Method that obtain a complete backup booking flight complete object.
     * @param con Connection object
     * @param f Flight object
     * @param b Booking object
     * @return Complete Flight object from the backup table.
     */
    public Flight getBackupFlight(Connection con, Flight f, Booking b) {
        try {
            String select = "SELECT f.id 'flightId', flightCode, departureDate, duration, time, airplane, price, "
                    + "		(nPlacement-(SELECT (count(*)) FROM flightoccupation fo WHERE fo.idFlight = f.id)) 'freePlacement', "
                    + "		fr.iata 'fromIata', fr.name 'fromName', fr.city 'fromCity', fr.country 'fromCountry', fr.pais 'fromPais', "
                    + "		frt.Location 'fromTerminalLocation', frt.number 'fromTerminalNumber', "
                    + "		t.iata 'toIata', t.name 'toName', t.city 'toCity', t.country 'toCountry', t.pais 'toPais', "
                    + "		tt.Location 'toTerminalLocation', tt.number 'toTerminalNumber' "
                    + "FROM flights_backup f "
                    + "JOIN connections c ON  c.id = f.idConnection "
                    + "JOIN airports fr ON fr.id = c.originAirport "
                    + "JOIN airports t ON t.id = c.destinationAirport "
                    + "JOIN terminals frt ON frt.id = c.originTerminal "
                    + "JOIN terminals tt ON tt.id = c.destinationTerminal "
                    + "WHERE f.id=" + f.getId() + "  ;";
            Statement s = con.createStatement();
            ResultSet result = s.executeQuery(select);
            while (result.next()) {
                Terminal tFrom = new Terminal(result.getString("fromTerminalLocation"), result.getInt("fromTerminalNumber"));
                Airport AirFrom = new Airport(result.getString("fromIata"), result.getString("fromName"), result.getString("fromCity"), result.getString("fromCountry"), result.getString("fromPais"));
                AirFrom.addTerminal(tFrom);
                Terminal tTo = new Terminal(result.getString("toTerminalLocation"), result.getInt("toTerminalNumber"));
                Airport AirTo = new Airport(result.getString("toIata"), result.getString("toName"), result.getString("toCity"), result.getString("toCountry"), result.getString("toPais"));
                AirTo.addTerminal(tTo);
                model.Connection c = new model.Connection(AirFrom, tFrom, AirTo, tTo);

                String selectP = "SELECT p.*,fo.id 'foId', fo.seat, fo.factured FROM flightoccupation_backup fo "
                        + "JOIN passengers_backup p ON fo.idPassenger = p.id "
                        + "WHERE fo.idFlight = " + result.getString("flightId") + " AND fo.idBook=" + b.getId() + " ;";
                Statement s2 = con.createStatement();
                ResultSet result2 = s2.executeQuery(selectP);

                f = new Flight(result.getInt("flightId"), c, result.getString("flightCode"), result.getDate("departureDate").toLocalDate(), result.getTime("time").toLocalTime(), result.getTime("duration").toLocalTime(), result.getString("airplane"), result.getDouble("price"), result.getInt("freePlacement"));
                while (result2.next()) {
                    f.setFactured(result2.getBoolean("factured"));
                    Passenger p = new Passenger(result2.getString("NIF"), LocalDate.parse(result2.getString("Birthdate")), result2.getString("Name"), result2.getString("Surname"), result2.getString("country"), result2.getString("state"), result2.getString("type"), result2.getString("seat"));
                    p.setId(result2.getInt("foId"));
                    p.setServices(this.getBackupBookedServices(con, p));
                    String selectB = "SELECT * FROM babypassenger_backup WHERE idPassenger = " + result2.getInt("id");
                    Statement s3 = con.createStatement();
                    ResultSet result3 = s3.executeQuery(selectB);
                    while (result3.next()) {
                        BabyPassenger baby = new BabyPassenger(result3.getInt("id"), result3.getString("NIF"), result2.getString("Name"), result2.getString("Surname"), result2.getString("country"), result2.getString("state"), LocalDate.parse(result2.getString("Birthdate")));
                        p.setBaby(baby);
                    }
                    f.addPassenger(p);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return f;
    }
    /**
     * getServices
     * Obtain all the services from database
     * @param con Connection object
     * @return Available service list.
     */
    public ArrayList<Service> getServices(Connection con) {
        ArrayList<Service> services = new ArrayList<>();

        String select = "SELECT * FROM services";
        try {
            Statement s = con.createStatement();
            ResultSet result = s.executeQuery(select);
            while (result.next()) {
                Service aux = new Service(result.getInt("id"), result.getString("code"), result.getString("description"), result.getString("descripcion"), result.getDouble("price"));
                services.add(aux);
            }

        } catch (SQLException ex) {
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return services;
    }
    
    /**
     * getBookedServices
     * Obtain the passenger booked services.
     * @param con Connection Object.
     * @param p Passenger object.
     * @return Passenger booked services list.
     */
    public ArrayList<Service> getBookedServices(Connection con, Passenger p) {
        ArrayList<Service> services = new ArrayList<>();

        String select = "SELECT s.* FROM bookedservices b "
                + "JOIN services s ON b.idService = s.id  "
                + "WHERE b.idFo=" + p.getId();
        try {
            Statement s = con.createStatement();
            ResultSet result = s.executeQuery(select);
            while (result.next()) {
                Service aux = new Service(result.getInt("id"), result.getString("code"), result.getString("description"), result.getString("descripcion"), result.getDouble("price"));
                services.add(aux);
            }

        } catch (SQLException ex) {
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return services;
    }

    /**
     * getBackupBookedServices
     * Obtain the passenger booked services from backup tables.
     * @param con Connection Object.
     * @param p Passenger object.
     * @return Passenger backup booked services list.
     */
    public ArrayList<Service> getBackupBookedServices(Connection con, Passenger p) {
        ArrayList<Service> services = new ArrayList<>();

        String select = "SELECT b.* FROM bookedservices_backup b "
                + "WHERE b.idFo=" + p.getId();
        try {
            Statement s = con.createStatement();
            ResultSet result = s.executeQuery(select);
            while (result.next()) {
                Service aux = new Service(result.getInt("id"), result.getString("code"), result.getString("description"), result.getString("descripcion"), result.getDouble("price"));
                services.add(aux);
            }

        } catch (SQLException ex) {
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return services;
    }
    
    /**
     * checkEmailAvailability
     * Check if the email introduced on the form has been used or not
     * @param con Connection object
     * @param email email to be checked.
     * @return true if the email is available, false if not.
     */
    public boolean checkEmailAvailability(Connection con, String email) {
        boolean available = true;
        String select = "SELECT * FROM users WHERE email = ?";
        try {
            PreparedStatement s = con.prepareStatement(select);
            s.setString(1, email);
            ResultSet result = s.executeQuery();
            if (result.next()) {
                available = false;
            }

        } catch (SQLException ex) {
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
        }

        return available;
    }
    
    /**
     * registerUser
     * Register a new user on the database.
     * @param con Connection object.
     * @param user User object to be registered (must be completed)
     * @return the registered user.
     */
    public User registerUser(Connection con, User user) {
        try {
            PreparedStatement s = con.prepareStatement("INSERT INTO users (email,name,surName,NIF,password) VALUES(?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
            s.setString(1, user.getEmail());
            s.setString(2, user.getName());
            s.setString(3, user.getSurName());
            s.setString(4, user.getNif());
            s.setString(5, BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
            int rs = s.executeUpdate();
            ResultSet id = s.getGeneratedKeys();
            while (id.next()) {
                user.setId(id.getInt(1));
            }

        } catch (SQLException ex) {
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);

        }
        return user;
    }
    
    /**
     * login
     * Method that obtains user information and his bookings
     * @param con Connection object.
     * @param user User email and password.
     * @return Complete User object.
     */
    public User login(Connection con, User user) {

        User userL = null;
        try {
            String select = "SELECT * FROM users WHERE email='" + user.getEmail() + "' ";
            Statement s = con.createStatement();
            ResultSet rs = s.executeQuery(select);

            while (rs.next()) {
                if (BCrypt.checkpw(user.getPassword(), rs.getString("password"))) {
                    userL = new User(rs.getInt("id"), rs.getString("email"), rs.getString("name"), rs.getString("surname"), rs.getString("nif"), rs.getString("password"));
                    userL.setAdmin(rs.getBoolean("admin"));
                               
                    Statement p = con.createStatement();
                    String paysel = "SELECT p.id, Price, AES_DECRYPT(UNHEX(creditCard),'joseesnoob') 'creditCard', creditHolder, creditYear, creditMonth FROM payments p" 
                                 + " JOIN BOOKINGS b ON b.id = p.idBooking " 
                                 + " WHERE idUser = "+ userL.getId() +" ORDER BY p.id desc LIMIT 1 ;";
                         ResultSet rsp = p.executeQuery(paysel);
                    while (rsp.next()) {
                        Payment pay = new Payment(rsp.getInt("id"), rsp.getDouble("Price"), rsp.getString("creditCard"), rsp.getString("creditHolder"), rsp.getString("creditYear"), rsp.getString("creditMonth"));
                        userL.setLastPayment(pay);
                    }
                    userL = this.getBookings(userL, con);
                    userL = this.getBackupBookings(userL, con);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userL;
    }
    /**
     * setBooking
     * Insert a new paid booking on the database
     * @param con Connection object
     * @param user User object
     * @return true if there are errors during the process, false if not.
     */
    public boolean setBooking(com.mysql.jdbc.Connection con, User user) {
        boolean error = false;
        try {
            Booking booking = user.getBookings().get(0);
            con.setAutoCommit(false);
            PreparedStatement bs = con.prepareStatement("INSERT INTO bookings (bookingCode,bookingDate, idUser) VALUES (?,?,?)", Statement.RETURN_GENERATED_KEYS);
            bs.setString(1, booking.getBookingCode());
            bs.setString(2, booking.getBookingDate().toString());
            bs.setInt(3, user.getId());
            bs.executeUpdate();
            ResultSet idb = bs.getGeneratedKeys();
            while (idb.next()) {
                booking.setId(idb.getInt(1));
            }

            for (Passenger p : booking.getDepartureFlight().getPassengers()) {
                PreparedStatement pds = con.prepareStatement("INSERT INTO passengers (NIF, Birthdate, Name, Surname, country, type, state) VALUES (?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
                pds.setString(1, p.getNif());
                pds.setString(2, p.getBirthDate().toString());
                pds.setString(3, p.getName());
                pds.setString(4, p.getSurName());
                pds.setString(5, p.getCountry());
                pds.setString(6, p.getType());
                pds.setString(7, p.getState());
                pds.executeUpdate();
                ResultSet idr = pds.getGeneratedKeys();
                while (idr.next()) {
                    p.setId(idr.getInt(1));
                }

            }

            for (Passenger p : booking.getDepartureFlight().getPassengers()) {
                if (p.getBaby() != null) {
                    PreparedStatement pdbs = con.prepareStatement("INSERT INTO babypassenger (idPassenger, name, surName, nif, birthdate, country, state) VALUES (?,?,?,?,?,?,?)");
                    pdbs.setInt(1, p.getId());
                    pdbs.setString(2, p.getBaby().getName());
                    pdbs.setString(3, p.getBaby().getSurName());
                    pdbs.setString(4, p.getBaby().getNif());
                    pdbs.setString(5, p.getBaby().getBirthDate().toString());
                    pdbs.setString(6, p.getBaby().getCountry());
                    pdbs.setString(7, p.getBaby().getState());
                    pdbs.executeUpdate();

                }

                PreparedStatement pfos = con.prepareStatement("INSERT INTO flightoccupation (idBook, idFlight, idPassenger, type, seat) VALUES (?,?,?,'D',?)", Statement.RETURN_GENERATED_KEYS);
                pfos.setInt(1, booking.getId());
                pfos.setInt(2, booking.getDepartureFlight().getId());
                pfos.setInt(3, p.getId());
                pfos.setString(4, p.getSeat());
                pfos.executeUpdate();
                ResultSet idfor = pfos.getGeneratedKeys();
                int idfo = 0;
                while (idfor.next()) {
                    idfo = idfor.getInt(1);
                }

                for (Service s : p.getServices()) {
                    PreparedStatement pss = con.prepareStatement("INSERT INTO bookedservices (idFo, idService) VALUES (?,?)", Statement.RETURN_GENERATED_KEYS);
                    pss.setInt(1, idfo);
                    pss.setInt(2, s.getId());
                    pss.executeUpdate();

                }
                if (booking.getBackFlight() != null) {
                    String seat = "-1";
                    Passenger bpass = new Passenger();
                    for (Passenger p2 : booking.getBackFlight().getPassengers()) {
                        if (p.getNif().equals(p2.getNif())) {
                            seat = p2.getSeat();
                            bpass = p2;
                        }
                    }

                    PreparedStatement pbfos = con.prepareStatement("INSERT INTO flightoccupation (idBook, idFlight, idPassenger, type, seat) VALUES (?,?,?,'B',?)", Statement.RETURN_GENERATED_KEYS);
                    pbfos.setInt(1, booking.getId());
                    pbfos.setInt(2, booking.getBackFlight().getId());
                    pbfos.setInt(3, p.getId());
                    pbfos.setString(4, seat);
                    pbfos.executeUpdate();

                    ResultSet idbfor = pbfos.getGeneratedKeys();
                    int idbfo = 0;
                    while (idbfor.next()) {
                        idbfo = idbfor.getInt(1);
                    }

                    for (Service s : bpass.getServices()) {
                        PreparedStatement ps2s = con.prepareStatement("INSERT INTO bookedservices (idFo, idService) VALUES (?,?)", Statement.RETURN_GENERATED_KEYS);
                        ps2s.setInt(1, idbfo);
                        ps2s.setInt(2, s.getId());
                        ps2s.executeUpdate();

                    }

                }

            }

            PreparedStatement pays = con.prepareStatement("INSERT INTO payments (idBooking, Price, creditCard, creditHolder, creditYear, creditMonth) VALUES (?,?,HEX(AES_ENCRYPT(?,'joseesnoob')),?,?,?)");
            pays.setInt(1, booking.getId());
            pays.setDouble(2, booking.getPayment().getPrice());
            pays.setString(3, booking.getPayment().getCreditCard());
            pays.setString(4, booking.getPayment().getCreditUser());
            pays.setString(5, booking.getPayment().getCyear());
            pays.setString(6, booking.getPayment().getCmonth());
            pays.executeUpdate();
            
            
            con.commit();
            error = false;

        } catch (SQLException ex) {
            try {
                error = true;
                con.rollback();
            } catch (SQLException ex1) {
                error = true;
                Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex1);
            }
        } finally {
            try {
                con.setAutoCommit(true);

            } catch (SQLException ex) {
                error = true;
                Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return error;

    }
    /**
     * getBookings
     * Get the booking list from an user.
     * @param u User object
     * @param con Connection object
     * @return User with the Booking List setted.
     */
    public User getBookings(User u, Connection con) {
        try {
            Statement s = con.createStatement();
            String select = "SELECT * FROM bookings WHERE idUser = " + u.getId() + " ORDER BY bookingDate desc";
            ResultSet rs = s.executeQuery(select);
            while (rs.next()) {
                Booking aux = new Booking(rs.getString("bookingCode"));
                aux.setId(rs.getInt("id"));
                aux.setBookingDate(rs.getDate("bookingDate").toLocalDate());
                this.getBooking(aux, con);
                u.getBookings().add(aux);

            }

        } catch (SQLException ex) {
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return u;
    }
    /**
     * getBooking
     * Obtain a booking object by its id.
     * @param b booking object with just the id setted.
     * @param con Connection object
     * @return Booking complete object.
     */
    public Booking getBooking(Booking b, Connection con) {
        try {
            Statement s = con.createStatement();
            String select = "SELECT * FROM flightoccupation WHERE idBook=" + b.getId() + " AND type='D' ";
            ResultSet rs = s.executeQuery(select);
            int idf;
            if (rs.next()) {
                idf = rs.getInt("idFlight");
                Flight f = new Flight();
                f.setId(idf);
                Flight flight = this.getFlight(con, f, b);
                b.setDepartureFlight(flight);
            }
            Statement sb = con.createStatement();
            String selectb = "SELECT * FROM flightoccupation WHERE idBook=" + b.getId() + " AND type='B' ";
            ResultSet rsb = sb.executeQuery(selectb);
            if (rsb.next()) {
                idf = rsb.getInt("idFlight");
                Flight f = new Flight();
                f.setId(idf);
                Flight flight = this.getFlight(con, f, b);
                b.setBackFlight(flight);

            }
            Statement p = con.createStatement();
            String paysel = "SELECT id, Price, AES_DECRYPT(UNHEX(creditCard),'joseesnoob') 'creditCard', creditHolder, creditYear, creditMonth FROM payments WHERE idBooking=" + b.getId();
            ResultSet rsp = p.executeQuery(paysel);
            while (rsp.next()) {
                Payment pay = new Payment(rsp.getInt("id"), rsp.getDouble("Price"), rsp.getString("creditCard"), rsp.getString("creditHolder"), rsp.getString("creditYear"), rsp.getString("creditMonth"));
                b.setPayment(pay);
            }

        } catch (SQLException ex) {
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return b;
    }
    
    /**
     * getBackupBookings
     * Get the backup booking list from an user.
     * @param u User object
     * @param con Connection object
     * @return User with the Backup Booking List setted.
     */
    public User getBackupBookings(User u, Connection con) {
        try {
            Statement s = con.createStatement();
            String select = "SELECT * FROM bookings_backup WHERE idUser = " + u.getId() + " ORDER BY bookingDate desc";
            ResultSet rs = s.executeQuery(select);
            while (rs.next()) {
                Booking aux = new Booking(rs.getString("bookingCode"));
                aux.setId(rs.getInt("id"));
                aux.setBookingDate(rs.getDate("bookingDate").toLocalDate());
                this.getBackupBooking(aux, con);
                u.getBackupBookings().add(aux);

            }

        } catch (SQLException ex) {
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return u;
    }
    
    /**
     * getBackupBooking
     * Obtain a backup booking object by its id.
     * @param b booking object with just the id setted.
     * @param con Connection object
     * @return Backup Booking complete object.
     */
    public Booking getBackupBooking(Booking b, Connection con) {
        try {
            Statement s = con.createStatement();
            String select = "SELECT * FROM flightoccupation_backup WHERE idBook=" + b.getId() + " AND type='D' ";
            ResultSet rs = s.executeQuery(select);
            int idf;
            if (rs.next()) {
                idf = rs.getInt("idFlight");
                Flight f = new Flight();
                f.setId(idf);
                Flight flight = this.getBackupFlight(con, f, b);
                b.setDepartureFlight(flight);
                Statement p = con.createStatement();
                String paysel = "SELECT id, Price, AES_DECRYPT(UNHEX(creditCard),'joseesnoob') 'creditCard', creditHolder, creditYear, creditMonth FROM payments_backup WHERE idBooking=" + b.getId();
                ResultSet rsp = p.executeQuery(paysel);
                while (rsp.next()) {
                    Payment pay = new Payment(rsp.getInt("id"), rsp.getDouble("Price"), rsp.getString("creditCard"), rsp.getString("creditHolder"), rsp.getString("creditYear"), rsp.getString("creditMonth"));
                    b.setPayment(pay);
                }
            }
            Statement sb = con.createStatement();
            String selectb = "SELECT * FROM flightoccupation_backup WHERE idBook=" + b.getId() + " AND type='B' ";
            ResultSet rsb = sb.executeQuery(selectb);
            if (rsb.next()) {
                idf = rsb.getInt("idFlight");
                Flight f = new Flight();
                f.setId(idf);
                Flight flight = this.getBackupFlight(con, f, b);
                b.setBackFlight(flight);
                Statement p = con.createStatement();
                String paysel = "SELECT id, Price, AES_DECRYPT(UNHEX(creditCard),'joseesnoob') 'creditCard', creditHolder, creditYear, creditMonth FROM payments_backup WHERE idBooking=" + b.getId();
                ResultSet rsp = p.executeQuery(paysel);
                while (rsp.next()) {
                    Payment pay = new Payment(rsp.getInt("id"), rsp.getDouble("Price"), rsp.getString("creditCard"), rsp.getString("creditHolder"), rsp.getString("creditYear"), rsp.getString("creditMonth"));
                    b.setPayment(pay);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return b;
    }
    
    /**
     * checkFlight
     * Check the flight determined by type ("D" Departure, "B" Back).
     * @param con Connection Object
     * @param b Booking where is the flight to be checked
     * @param type Flight type (Departure or Back)
     * @return -1 if error, >0 if not.
     */
    public int checkFlight(com.mysql.jdbc.Connection con, Booking b, String type) {
        String update = "UPDATE flightoccupation SET factured = 1 WHERE idBook = ? AND type = ? ";
        try {
            PreparedStatement s = con.prepareStatement(update);
            s.setInt(1, b.getId());
            s.setString(2, type);
            int result = s.executeUpdate();
            switch (type) {
                case "D":
                    b.getDepartureFlight().setFactured(true);
                    break;
                case "B":
                    b.getBackFlight().setFactured(true);
                    break;
            }
            return result;
        } catch (SQLException ex) {
            return -1;
        }
    }
    /**
     * deleteFlight
     * Deletes a flight from database on a determinated date.
     * @param con Connection Object
     * @param fcode Flight Code
     * @param fdate Flight Date
     * @return true if there are errors, false if not.
     */
    public boolean deleteFlight(com.mysql.jdbc.Connection con, String fcode, LocalDate fdate) {
        boolean error = false;
        try {
            PreparedStatement s = con.prepareStatement("DELETE FROM flights WHERE flightCode = ? AND departureDate = ? ");
            s.setString(1, fcode);
            s.setString(2, fdate.toString());
            int t = s.executeUpdate();
            if (t == 0) {
                error = true;
            }
        } catch (SQLException ex) {
            error = true;
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return error;
    }
    /**
     * getIncididentsArray
     * Return an Incidents list between two dates
     * @param con Connection object
     * @param minDate min date 
     * @param maxDate max date
     * @return Incidents list
     */
    public ArrayList<Incident> getIncidentsArray(com.mysql.jdbc.Connection con, LocalDate minDate, LocalDate maxDate) {
       ArrayList<Incident> incidents = new ArrayList<>();
       
        try {
            String select = "SELECT * FROM incidents WHERE flightDate BETWEEN '"+minDate.toString()+"' AND '"+maxDate.toString()+"' ";
            Statement s = con.createStatement();
            ResultSet rs = s.executeQuery(select);
            while(rs.next()){
                incidents.add(new Incident(rs.getInt("id"),rs.getString("bookingCode"),rs.getString("userNIF"),rs.getString("userEmail"),rs.getDate("flightDate").toLocalDate(),rs.getString("flightCode"),rs.getString("from"),rs.getString("to"),rs.getInt("adults"),rs.getInt("children"),rs.getInt("infants"),rs.getDouble("totalFlight"),rs.getDouble("totalServices")));
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
        }
       
       
       return incidents;
    }

}
