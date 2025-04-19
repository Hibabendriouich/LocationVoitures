/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import dao.AdminDao;
import entities.Admin;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author hibaa
 */
public class AdminService implements IService<Admin> {

    private final AdminDao ad;

    public AdminService() {
        this.ad = new AdminDao();
    }

    public AdminService(AdminDao ad) {
        this.ad = ad;
    }

    public Admin findAdminByEmail(String email) {
        Session session = null;
        Transaction tx = null;
        Admin admin = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            admin = (Admin) session.getNamedQuery("findAdminByEmail").setParameter("email", email).uniqueResult();
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
        return admin;
    }

    @Override
    public boolean create(Admin o) {
        return ad.create(o);
    }

    @Override
    public boolean delete(Admin o) {
        return ad.delete(o);
    }

    @Override
    public boolean update(Admin o) {
        return ad.update(o);
    }

    @Override
    public List<Admin> findAll() {
        return ad.findAll();
    }

    @Override
    public Admin findById(int id) {
        return ad.findById(id);
    }
}
