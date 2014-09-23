package za.co.fnb.coindispenser.ws;

import javax.ejb.Stateless;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import za.co.fnb.coindispenser.dto.LoginResult;

@Stateless
@Path("/user/")
public class UserResource {
    @GET
    @Produces("application/xml")
    @Path("{user}/{password}")
    public LoginResult login(@PathParam("user") String user, @PathParam("password") String password) {
        if(user.equalsIgnoreCase("admin")) 
            return new LoginResult("", true);
        return new LoginResult("Login failed", false);
    }
    
    @GET
    @Produces("text/plain")
    public String service() {
        return "This is a service";
    }
    
    @GET
    @Produces("application/xml")
    @Path("/example/")
    public LoginResult getExample() {
        return new LoginResult("Message", true);
    }
}
