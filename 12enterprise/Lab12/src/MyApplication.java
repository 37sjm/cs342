import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by elc3 on 4/29/2017.
 */

@ApplicationPath("/")
public class MyApplication extends Application {

    @Override
    public Set<Class<?>> getClasses() {
        HashSet h = new HashSet<Class<?>>();
        h.add(CPDBResource.class);
        return h;
    }
}
