package model;

/**
 * Class Service
 * Intermediate class used to get the from and the to on a flight
 * @author Víctor Sánchez del Río <victorsdr91@gmail.com>
 */
public class Service implements Cloneable {
    private int id;
    private String Code;
    private String description;
    private String descripcion;
    private double price;
    
    /**
     * Service Constructor
     * @param Code service unique code.
     * @param description service english description.
     * @param descripcion service spanish description.
     * @param price service price.
     */
    public Service(String Code, String description, String descripcion, double price) {
        this.Code = Code;
        this.description = description;
        this.descripcion = descripcion;
        this.price = price;
    }
    /**
     * Service Constructor
     * Service main constructor.
     * @param id from database
     * @param Code service unique code.
     * @param description service english description.
     * @param descripcion service spanish description.
     * @param price service price.
     */
    public Service(int id, String Code, String description, String descripcion, double price) {
        this.id = id;
        this.Code = Code;
        this.description = description;
        this.descripcion = descripcion;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return Code;
    }

    public void setCode(String Code) {
        this.Code = Code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
    @Override
    public Service clone() throws CloneNotSupportedException{
        return (Service)super.clone();
    }

    @Override
    public String toString() {
        return "\n\t\tService{" + "id=" + id + ", Code=" + Code + ", description=" + description + ", descripcion=" + descripcion + ", price=" + price + '}';
    }
    
}
