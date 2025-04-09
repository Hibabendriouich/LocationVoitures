/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import entities.Client;
import entities.Location;
import entities.LocationPK;
import entities.TypeVoiture;
import org.hibernate.Query;
import entities.Voiture;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.util.Date;
import java.util.List;

/**
 *
 * @author hibaa
 */
public class Test {

    public static void main(String[] args) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();

            Client client = new Client("EE123456", "Hiba", "Ben Driouich", "hiba@gmail.com", "hiba123");
            session.save(client);

            TypeVoiture type = new TypeVoiture("Luxe", "Voiture haut de gamme");
            session.save(type);

            Voiture voiture = new Voiture();
            voiture.setMarque("Bentley");
            voiture.setModele("Continental GT");
            voiture.setAnnee("2022");
            voiture.setDisponible(true);
            voiture.setTypeVoiture(type);
            session.save(voiture);

            Date dateDebut = new Date();
            Date dateFin = new Date(dateDebut.getTime() + 3 * 24 * 60 * 60 * 1000);
            LocationPK pk = new LocationPK(dateDebut, dateFin, client.getId(), voiture.getId());

            Location location = new Location();
            location.setpK(pk);
            location.setDateDebut(dateDebut);
            location.setDateFin(dateFin);
            location.setClient(client);
            location.setVoiture(voiture);

            session.save(location);

            tx.commit();
            System.out.println("Location enregistrée avec succès !");
            String marqueCible = "Bentley";
            String hql = "SELECT DISTINCT l.client FROM Location l WHERE l.voiture.marque = :marque";

            Query query = session.createQuery(hql);
            query.setParameter("marque", marqueCible);

            List<Client> clients = query.list();

            System.out.println("Clients ayant loué une voiture de marque " + marqueCible + " :");
            for (Client c : clients) {
                System.out.println(c.getNom() + " " + c.getPrenom() + " (" + c.getEmail() + ")");
            }
            String cinCible = "EE123456";
            String hql2 = "SELECT DISTINCT l.voiture FROM Location l WHERE l.client.cin = :cin";
            Query query2 = session.createQuery(hql2);
            query2.setParameter("cin", cinCible);

            List<Voiture> voitures = query2.list();

            System.out.println("Voitures louées par le client avec CIN " + cinCible + " :");
            for (Voiture v : voitures) {
                System.out.println(v.getMarque() + " " + v.getModele() + " (" + v.getAnnee() + ")");
            }

        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }

        HibernateUtil.getSessionFactory().close();
    }
}
