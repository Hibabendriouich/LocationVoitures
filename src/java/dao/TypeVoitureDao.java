/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.TypeVoiture;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author hibaa
 */
public class TypeVoitureDao extends AbstractDao<TypeVoiture> {

    public TypeVoitureDao() {
        super(TypeVoiture.class);
    }

    public List<TypeVoiture> findByTypeId(int id) {
        Session session = null;
        Transaction tx = null;
        List<TypeVoiture> types = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            types = session.getNamedQuery("findByTypeId").setParameter("id", id).list();
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
        return types;
    }

}
