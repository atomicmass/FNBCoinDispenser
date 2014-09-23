package za.co.fnb.coindispenser.ws;

import javax.ejb.Stateless;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import za.co.fnb.coindispenser.dto.User;

@Stateless
@Path("/user/")
public class UserResource {
    @Path("login")
    @POST
    @Consumes("application/json")
    @Produces("application/json")
    public boolean login(User user) {
        if(user.getUserName().equalsIgnoreCase("admin"))
            return true;
        return false;
    }
    
    @GET
    @Produces("text/plain")
    public String service() {
        return "This is a service";
    }
    
    @GET
    @Produces("application/json")
    @Path("/example/")
    public User getExample() {
        return new User("admin", "password");
    }
}
