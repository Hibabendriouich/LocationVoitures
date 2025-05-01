/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Location;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author hibaa
 */
public class LocationDao extends AbstractDao<Location> {

    public LocationDao() {
        super(Location.class);
    }

    public List<Location> findBetweenDate(Date d1, Date d2) {
        Session session = null;
        Transaction tx = null;
        List<Location> locations = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            locations = session.getNamedQuery("findBetweenDate").setParameter("d1", d1).setParameter("d2", d2).list();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return locations;
    }

    public List<Location> getLocationsByClient(int clientId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            return (List<Location>) session.createQuery(
                    "SELECT l FROM Location l "
                    + "JOIN FETCH l.voiture v "
                    + "JOIN FETCH v.type "
                    + "WHERE l.id.client = :clientId")
                    .setParameter("clientId", clientId)
                    .list();
        } finally {
            session.close();
        }
    }

    public boolean isCarAvailable(int voiture, Date dateDebut, Date dateFin) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Long count = (Long) session.createQuery(
                    "SELECT COUNT(l) FROM Location l WHERE "
                    + "l.id.voiture = :voiture AND "
                    + "NOT (l.dateFin < :dateDebut OR l.id.dateDebut > :dateFin)")
                    .setParameter("voiture", voiture)
                    .setParameter("dateDebut", dateDebut)
                    .setParameter("dateFin", dateFin)
                    .uniqueResult();
            return count == 0;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

}
