package dao;

import entities.Voiture;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

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
            voitures = session.getNamedQuery("findByMarque")
                              .setParameter("id", id)
                              .list();
            tx.commit();
        } catch (HibernateException ex) {
            if (tx != null) tx.rollback();
            ex.printStackTrace(); 
        } finally {
            if (session != null) session.close();
        }
        return voitures;
    }

    public List<Voiture> getAllVoitures() {
        Session session = null;
        Transaction tx = null;
        List<Voiture> voitures = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            voitures = session.getNamedQuery("Voiture.findAll").list();
            tx.commit();
        } catch (HibernateException ex) {
            if (tx != null) tx.rollback();
            ex.printStackTrace(); 
        } finally {
            if (session != null) session.close();
        }
        return voitures;
    }
    public List<Object[]> countByType() {
    Session session = null;
    Transaction tx = null;
    List<Object[]> stats = null;
    try {
        session = HibernateUtil.getSessionFactory().openSession();
        tx = session.beginTransaction();
        stats = session.getNamedQuery("Voiture.countByType").list();
        tx.commit();
    } catch (HibernateException e) {
        if (tx != null) tx.rollback();
        throw e;
    } finally {
        if (session != null) session.close();
    }
    return stats;
}
}
