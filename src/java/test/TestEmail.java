/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import dao.ClientDao;
import entities.Client;

/**
 *
 * @author hibaa
 */
public class TestEmail {
    public static void main(String[] args) {
        ClientDao clientDao = new ClientDao();
        Client client = clientDao.findClientByEmail("hiba@gmail.com");
        
        if (client != null) {
            System.out.println("Client trouvé : " + client.getNom() + " " + client.getPrenom());
        } else {
            System.out.println("Aucun client trouvé avec cet email.");
        }
    }
}
