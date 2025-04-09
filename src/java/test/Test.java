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
import entities.User;
import entities.Voiture;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.util.Date;

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
