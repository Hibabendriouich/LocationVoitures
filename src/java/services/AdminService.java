/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import dao.AdminDao;
import entities.Admin;
import java.util.List;

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
