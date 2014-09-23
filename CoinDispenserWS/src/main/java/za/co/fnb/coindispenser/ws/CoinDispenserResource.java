package za.co.fnb.coindispenser.ws;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import za.co.fnb.coindispenser.dto.DispenseCalculation;
import za.co.fnb.coindispenser.dto.DispenseCash;
import java.util.Arrays;

@Path("/dispenser/")
@Stateless
public class CoinDispenserResource {

    private static final List<BigDecimal> VALID_NOTES = new ArrayList<>(Arrays.asList(
            new BigDecimal[]{new BigDecimal("100"), new BigDecimal("50"), 
                new BigDecimal("20"), new BigDecimal("10")}
    ));
    
    private static final List<BigDecimal> VALID_COINS = new ArrayList<>(Arrays.asList(
            new BigDecimal[]{new BigDecimal("5"), new BigDecimal("2"), 
                new BigDecimal("1"), new BigDecimal("0.5"), new BigDecimal("0.25"), 
                new BigDecimal("0.1"), new BigDecimal("0.05")}
    ));

    @POST
    @Produces("application/json")
    @Consumes("application/json")
    public DispenseCalculation calculate(DispenseCalculation calc) {
        if (calc.getAmountDue().compareTo(calc.getNoteReceived()) > 0) {
            calc.setMessage("Insufficient amount received.");
            return calc;
        }

        if(!VALID_NOTES.contains(calc.getNoteReceived())) {
            calc.setMessage("Invalid denomination specified.");
            return calc;
        }
        
        BigDecimal change = calc.getNoteReceived().subtract(calc.getAmountDue());
        calc.setCashToDispense(new ArrayList<DispenseCash>());

        change = allocateChange(change, VALID_NOTES, calc.getCashToDispense());
        change = allocateChange(change, VALID_COINS, calc.getCashToDispense());
        
        if(change.compareTo(BigDecimal.ZERO) > 0) {
            calc.setMessage("Error occurred calculating cash to dispense.");
            return calc;
        }
        
        return calc;
    }

    @GET
    @Produces("application/json")
    @Path("/example/")
    public DispenseCalculation getExample() {
        DispenseCalculation c = new DispenseCalculation();
        c.setAmountDue(new BigDecimal("25.5"));
        c.setMessage("No message");
        c.setNoteReceived(new BigDecimal("50"));
        List<DispenseCash> l = new ArrayList<>();
        l.add(new DispenseCash("20", 1));
        l.add(new DispenseCash("2", 2));
        l.add(new DispenseCash("0.5", 1));
        c.setCashToDispense(l);

        return c;
    }

    @GET
    @Produces("text/plain")
    public String service() {
        return "This is a service";
    }
    
    /**
     * Figures out the best change to give given the current change amount
     * and a list of available denominations
     * Returns any change amount that is still to be accounted for
     * @param change Amount of change to allocate into denominations
     * @param denominations Available denominations
     * @param results List of the denominations used to allocate the change
     * @return Additional change not accounted for
     */
    private BigDecimal allocateChange(BigDecimal change, List<BigDecimal> denominations, List<DispenseCash> results) {
        for (BigDecimal den : denominations) {
            int quantity = 0;
            while(change.compareTo(den) >= 0) {
                change = change.subtract(den);
                quantity++;
            }
            if(quantity > 0)
                results.add(new DispenseCash(den, quantity));
        }
        return change;
    }
    
}
