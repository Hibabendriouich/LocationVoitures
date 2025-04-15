package test;

import dao.ClientDao;
import dao.TypeVoitureDao;
import dao.VoitureDao;
import dao.LocationDao;
import entities.Client;
import entities.Location;
import entities.LocationPK;
import entities.TypeVoiture;
import entities.Voiture;
import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import util.HibernateUtil;

/**
 *
 * @author hibaa
 */
public class Test {

    public static void main(String[] args) {
        ClientDao clientDao = new ClientDao();
        TypeVoitureDao typeDao = new TypeVoitureDao();
        VoitureDao voitureDao = new VoitureDao();
        LocationDao locationDao = new LocationDao();

        Client client = new Client("EE123456", "Hiba", "Ben Driouich", "hiba@gmail.com", "hiba123");
        clientDao.create(client);

        TypeVoiture type = new TypeVoiture("Luxe", "Voiture haut de gamme");
        typeDao.create(type);

        Voiture voiture = new Voiture();
        voiture.setMarque("Bentley");
        voiture.setModele("Continental GT");
        voiture.setAnnee("2022");
        voiture.setDisponible(true);
        voiture.setTypeVoiture(type);
        voitureDao.create(voiture);

        Date dateDebut = new Date();
        LocationPK pk = new LocationPK(dateDebut, client.getId(), voiture.getId());

        Location location = new Location();
        location.setpK(pk);
        location.setDateDebut(dateDebut);
        location.setClient(client);
        location.setVoiture(voiture);

        locationDao.create(location);
        System.out.println("Location enregistrée avec succès !");

        Session session = HibernateUtil.getSessionFactory().openSession();

        String marqueCible = "Bentley";
        String hql1 = "SELECT DISTINCT l.client FROM Location l WHERE l.voiture.marque = :marque";
        Query query1 = session.createQuery(hql1);
        query1.setParameter("marque", marqueCible);
        List<Client> clients = query1.list();
        System.out.println("\nClients ayant loué une voiture de marque " + marqueCible + " :");
        for (Client c : clients) {
            System.out.println("- " + c.getNom() + " " + c.getPrenom());
        }

        String cinCible = "EE123456";
        String hql2 = "SELECT DISTINCT l.voiture FROM Location l WHERE l.client.cin = :cin";
        Query query2 = session.createQuery(hql2);
        query2.setParameter("cin", cinCible);
        List<Voiture> voitures = query2.list();
        System.out.println("\nVoitures louées par le client avec CIN " + cinCible + " :");
        for (Voiture v : voitures) {
            System.out.println("- " + v.getMarque() + " " + v.getModele() + " (" + v.getAnnee() + ")");
        }

        session.close();
        HibernateUtil.getSessionFactory().close();
    }
}
