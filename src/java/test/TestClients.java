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
public class TestClients {

    public static void main(String[] args) {
        ClientDao cd = new ClientDao();
        for (Client c : cd.findClientsByMarqueVoiture("Bentley")) {
            System.out.println(" - " + c.getNom() + " " + c.getPrenom() + "\n - " + c.getCin());
        }
    }
}
