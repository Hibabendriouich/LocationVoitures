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
    Session session = null;
    try {
        session = HibernateUtil.getSessionFactory().openSession();
        return session.createQuery("SELECT l FROM Location l " +"JOIN FETCH l.voiture " +"WHERE l.id.client = :clientId").setParameter("clientId", clientId).list();  
    } catch (Exception e) {
        e.printStackTrace();
        return Collections.emptyList();
    } finally {
        if (session != null) {
            session.close();
        }
    }
}

}
