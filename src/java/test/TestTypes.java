/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import dao.TypeVoitureDao;
import entities.TypeVoiture;

/**
 *
 * @author hibaa
 */
public class TestTypes {

    public static void main(String[] args) {
        TypeVoitureDao vd = new TypeVoitureDao();
        for (TypeVoiture v : vd.findByTypeId(1)) {
            System.out.println(v.getNom());
        }
    }
}
