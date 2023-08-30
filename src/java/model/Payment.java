package model;

/**
 * Class Payment
 * Contains information about the payment done on a booking
 * @author Víctor Sánchez del Río <victorsdr91@gmail.com>
 */
public class Payment {

    private int id;
    private String method;
    private double price;
    private String creditCard;
    private String creditUser;
    private int creditCVV;
    private String cmonth;
    private String cyear;
    
    /**
     * Payment Constructor
     * Payment main constructor
     * @param id from database.
     * @param method unsused.
     * @param price booking total price.
     * @param creditCard credit card number.
     * @param creditUser credit card holder.
     * @param creditCVV crecit card cvv.
     * @param cmonth credit card expiration month.
     * @param cyear credit card expiration year.
     */
    public Payment(int id, String method, double price, String creditCard, String creditUser, int creditCVV, String cmonth, String cyear) {
        this.id = id;
        this.method = method;
        this.price = price;
        this.creditCard = creditCard;
        this.creditUser = creditUser;
        this.creditCVV = creditCVV;
        this.cmonth = cmonth;
        this.cyear = cyear;
    }
    
    /**
     * Payment Constructor
     * @param id from database.
     * @param price booking total price.
     * @param creditCard credit card number.
     * @param creditUser credit card holder.
     * @param cmonth credit card expiration month.
     * @param cyear credit card expiration year.
     */
    public Payment(int id, double price, String creditCard, String creditUser, String cmonth, String cyear) {
        this.id = id;
        this.price = price;
        this.creditCard = creditCard;
        this.creditUser = creditUser;
        this.cmonth = cmonth;
        this.cyear = cyear;
    }
    /**
     * Payment Constructor
     * @param method unused.
     * @param price booking total price.
     * @param creditCard credit card number.
     * @param creditUser credit card holder.
     * @param creditCVV crecit card cvv.
     * @param cmonth credit card expiration month.
     * @param cyear credit card expiration year.
     */
    public Payment(String method, double price, String creditCard, String creditUser, int creditCVV, String cmonth, String cyear) {
        this.method = method;
        this.price = price;
        this.creditCard = creditCard;
        this.creditUser = creditUser;
        this.creditCVV = creditCVV;
        this.cmonth = cmonth;
        this.cyear = cyear;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getCreditCard() {
        return creditCard;
    }

    public void setCreditCard(String creditCard) {
        this.creditCard = creditCard;
    }

    public String getCreditUser() {
        return creditUser;
    }

    public void setCreditUser(String creditUser) {
        this.creditUser = creditUser;
    }

    public int getCreditCVV() {
        return creditCVV;
    }

    public void setCreditCVV(int creditCVV) {
        this.creditCVV = creditCVV;
    }

    public String getCmonth() {
        return cmonth;
    }

    public void setCmonth(String cmonth) {
        this.cmonth = cmonth;
    }

    public String getCyear() {
        return cyear;
    }

    public void setCyear(String cyear) {
        this.cyear = cyear;
    }

    @Override
    public String toString() {
        return "Payment{" + "id=" + id + ", method=" + method + ", price=" + price + ", creditCard=" + creditCard + ", creditUser=" + creditUser + ", creditCVV=" + creditCVV + ", cmonth=" + cmonth + ", cyear=" + cyear + '}';
    }

}
