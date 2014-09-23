package za.co.fnb.coindispenser.dto;

import java.io.Serializable;
import java.math.BigDecimal;

public class DispenseCash implements Serializable {
    private BigDecimal denomination;
    private int quantity;
    
    public DispenseCash() {}
    
    public DispenseCash(BigDecimal denomination, int quantity) {
        this();
        this.denomination = denomination;
        this.quantity = quantity;
    }
    
    public DispenseCash(String denomination, int quantity) {
        this(new BigDecimal(denomination), quantity);
    }

    public BigDecimal getDenomination() {
        return denomination;
    }

    public void setDenomination(BigDecimal denomination) {
        this.denomination = denomination;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
