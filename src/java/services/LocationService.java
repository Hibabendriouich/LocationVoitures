/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import entities.Location;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author hibaa
 */

public class LocationService {

public List<Location> getLocationsByClient(int client) {
    Session session = null;
    Transaction tx = null;
    List<Location> locations = null;
    try {
        session = HibernateUtil.getSessionFactory().openSession();
        tx = session.beginTransaction();
        
        locations = session.createQuery("FROM Location l JOIN FETCH l.voiture WHERE l.client.id = :client")
                 .setParameter("client", client)
                 .list();
        
        tx.commit();
    } catch (HibernateException ex) {
        if (tx != null) tx.rollback();
        ex.printStackTrace();
    } finally {
        if (session != null) session.close();
    }
    return locations;
}}