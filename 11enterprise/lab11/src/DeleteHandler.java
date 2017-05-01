/**
 * Created by mitch on 4/22/2017.
 */
import javax.ws.rs.*;

@Path("/{x}")
public class DeleteHandler {

    @DELETE
    @Produces("text/plain")
    public String getClichedMessage(@PathParam("x") int x) {
        return "Deleting - " + x;
    }
}


