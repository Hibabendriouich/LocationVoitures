package test;

import dao.AdminDao;
import dao.ClientDao;
import dao.TypeVoitureDao;
import dao.VoitureDao;
import dao.LocationDao;
import dao.UserDao;
import entities.Admin;
import entities.Client;
import entities.Location;
import entities.LocationPK;
import entities.TypeVoiture;
import entities.User;
import entities.Voiture;
import java.util.Date;
import util.HibernateUtil;

/**
 *
 * @author hibaa
 */
public class Test {

    public static void main(String[] args) {
        //  HibernateUtil.getSessionFactory();
        ClientDao clientDao = new ClientDao();
        TypeVoitureDao type = new TypeVoitureDao();
        VoitureDao voitureDao = new VoitureDao();
        LocationDao locationDao = new LocationDao();
        AdminDao ad = new AdminDao();
        UserDao ud = new UserDao();
        ClientDao client = new ClientDao();

        /*
        
         clientDao.create(new Client("EE123456", "Ben Driouich", "Hiba", "hiba@gmail.com", "hiba123"));

         
         type.create(new TypeVoiture("luxe", "haut de gamme"));

         voitureDao.create(new Voiture("bmw", "serie 5", "2019", true, type.findById(1)));
         */
        Date dateDebut = new Date();
        Date dateFin = new Date();

        Client c = clientDao.findById(1);
        Voiture v = voitureDao.findById(1);

        LocationPK pk = new LocationPK(dateDebut, c.getId(), v.getId());
        Location loc = new Location(pk, dateDebut, dateFin, c, v);
        locationDao.create(loc);
        System.out.println("Location enregistrée avec succès !"); 

        /*
         ad.create(new Admin("abc123", "safi", "amal", "amal@gmail.com", "ama123"));
         ad.create(new Admin("hds456", "rami", "ali", "ali@gmail.com", "ali123")); */
        /*         Admin a = ad.findById(3);
         a.setEmail("amal23@gmail.com");
         ad.update(a);
         ad.delete(ad.findById(4));
         */
        ud.create(new User("berrada", "khalid", "khalid@gmail.com", "khalid123"));
        ud.create(new User("alami", "fatiha", "fatiha@gmail.com", "fatiha123"));
        /*       User u = ud.findById(1);
         u.setPassword("fatiha123@");
         ud.update(u);
         ud.delete(ud.findById(10));
         */

    }
}
