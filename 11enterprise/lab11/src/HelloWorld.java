/**
 * Created by mitch on 4/22/2017.
 */
import javax.ws.rs.*;

@Path("/hello")
public class HelloWorld {
    @GET
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello World";
    }

    @Path("/api/{x}")
    @PUT
    @Produces("text/plain")
    public String putRequest(@PathParam("x") int x) { return "Putting - " + x; }

    @Path("/api")
    @GET
    @Produces("text/plain")
    public String getRequest() { return "Getting..."; }


    @Path("/api/{s}")
    @POST
    @Produces("text/plain")
    public String postRequest(@PathParam("s") String s) { return "Posting - " + s; }

}


