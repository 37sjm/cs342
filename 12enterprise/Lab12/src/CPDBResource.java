import models.Person;

import javax.ejb.PostActivate;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

import static jdk.nashorn.internal.runtime.PropertyDescriptor.GET;

/**
 * This stateless session bean serves as a RESTful resource handler for the CPDB.
 * It uses a container-managed entity manager.
 *
 * @author kvlinden
 * @version Spring, 2017
 */
@Stateless
@Path("cpdb")
public class CPDBResource {

    /**
     * JPA creates and maintains a managed entity manager with an integrated JTA that we can inject here.
     *     E.g., http://wiki.eclipse.org/EclipseLink/Examples/REST/GettingStarted
     */
    @PersistenceContext
    private EntityManager em;

    /**
     * GET a default message.
     *
     * @return a static hello-world message
     */
    @GET
    @Path("hello")
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello, JPA!";
    }

    /**
     * GET an individual person record.
     *
     * @param id the ID of the person to retrieve
     * @return a person record
     */
    @GET
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Person getPerson(@PathParam("id") long id) {
        return em.find(Person.class, id);
    }

    /**
     * GET all people using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all person records
     */
    @GET
    @Path("people")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Person> getPeople() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Person.class)).getResultList();
    }

    @PUT
    @Path("people/{x}")
    @Consumes("models/person")
    @Produces("text/plain")
    public String putPerson(@PathParam("x") long id, Person p) {
        if (em.find(Person.class, id) == null) {
            return "Person not found";
        } else {
            //find a way to get person from request
            em.merge(p);
            return "Successful update of person: " + p.getFirstname() + " " + p.getLastname();
        }
    }

    @POST
    @Path("people/")
    @Consumes("models/person")
    @Produces("text/plain")
    public String postPerson(Person p) {
        //figure out how to get person from request
        em.persist(p);
        return "Successfully posted person...";
    }

    @DELETE
    @Path("people/{x}")
    @Produces("text/plain")
    public String deletePerson(@PathParam("x") long id) {
        Person p = em.find(Person.class, id);
        if (p == null) {
            return "Person not found";
        } else {
            em.remove(p);
            return "Succesfully deleted person p";
        }
    }


}
