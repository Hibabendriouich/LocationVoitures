/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import dao.LocationDao;
import entities.Location;
import java.util.Date;

/**
 *
 * @author hibaa
 */
public class TestDate {

    public static void main(String[] args) {
        LocationDao ld = new LocationDao();
        for (Location l : ld.findBetweenDate(new Date("2025/04/01"), new Date("2025/04/31"))) {
            System.out.println(l.getDateFin() + ", " + l.getVoiture().getMarque() + " ," + l.getClient().getNom());
        }
    }
}
