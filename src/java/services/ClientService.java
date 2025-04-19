/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import dao.ClientDao;
import entities.Client;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author hibaa
 */
public class ClientService implements IService<Client> {

    private final ClientDao cd;

    public ClientService() {
        this.cd = new ClientDao();
    }

    public ClientService(ClientDao cd) {
        this.cd = cd;
    }

   public Client findClientByEmail(String email) {
       return cd.findClientByEmail(email);
    }
    @Override
    public boolean create(Client o) {
        return cd.create(o);
    }

    @Override
    public boolean delete(Client o) {
        return cd.delete(o);
    }

    @Override
    public boolean update(Client o) {
        return cd.update(o);
    }

    @Override
    public List<Client> findAll() {
        return cd.findAll();
    }

    @Override
    public Client findById(int id) {
        return cd.findById(id);
    }

}
