package za.co.fnb.coindispenser.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class DispenseCalculation implements Serializable {
    private BigDecimal amountDue;
    private BigDecimal noteReceived;
    private List<DispenseCash> cashToDispense;
    private String message;

    public BigDecimal getAmountDue() {
        return amountDue;
    }

    public void setAmountDue(BigDecimal amountDue) {
        this.amountDue = amountDue;
    }

    public BigDecimal getNoteReceived() {
        return noteReceived;
    }

    public void setNoteReceived(BigDecimal noteReceived) {
        this.noteReceived = noteReceived;
    }

    public List<DispenseCash> getCashToDispense() {
        return cashToDispense;
    }

    public void setCashToDispense(List<DispenseCash> cashToDispense) {
        this.cashToDispense = cashToDispense;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
