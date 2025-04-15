/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import dao.ClientDao;
import entities.Client;
import java.util.List;

/**
 *
 * @author hibaa
 */
public class ClientService implements IService<Client> {

    private final ClientDao fd;

    public ClientService(ClientDao fd) {
        this.fd = fd;
    }

    @Override
    public boolean create(Client o) {
        return fd.create(o);
    }

    @Override
    public boolean delete(Client o) {
        return fd.delete(o);
    }

    @Override
    public boolean update(Client o) {
        return fd.update(o);
    }

    @Override
    public List<Client> findAll() {
        return fd.findAll();
    }

    @Override
    public Client findById(int id) {
        return fd.findById(id);
    }

}
