/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Voiture;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author hibaa
 */
public class VoitureDao extends AbstractDao<Voiture> {

    public VoitureDao() {
        super(Voiture.class);
    }
    public List<Voiture> findByMarque(int id) {
        Session session = null;
        Transaction tx = null;
        List<Voiture> voitures = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            voitures = session.getNamedQuery("findByMarque").setParameter("id", id).list();
            tx.commit();
        } catch (HibernateException ex) {
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return voitures;
    }

}
