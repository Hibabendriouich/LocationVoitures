/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import entities.Location;
import java.util.List;
import javax.persistence.EntityManager;

/**
 *
 * @author hibaa
 */

public class LocationService {

    private EntityManager em;
    
    public List<Location> getLocationsByClient(Long clientId) {
        try {
            return em.createQuery("SELECT l FROM Location l WHERE l.client.id = :clientId", Location.class)
                    .setParameter("clientId", clientId)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}