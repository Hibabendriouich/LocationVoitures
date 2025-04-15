/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import dao.VoitureDao;
import entities.Voiture;

/**
 *
 * @author hibaa
 */
public class TestMarque {

    public static void main(String[] args) {
        VoitureDao vd = new VoitureDao();
        for (Voiture v : vd.findByMarque(1)) {
            System.out.println(v.getMarque());
        }
    }
}
