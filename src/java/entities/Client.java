/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.util.List;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import org.hibernate.annotations.NamedNativeQuery;
import org.hibernate.annotations.NamedQuery;

/**
 *
 * @author hibaa
 */
@Entity
@Table(name = "clients")

@NamedQuery(name = "findClientByEmail", query = "SELECT c FROM Client c WHERE c.email = :email")

@NamedNativeQuery(name = "findClientsByMarqueVoiture", query = "SELECT u.*, c.* FROM voitures v INNER JOIN locations l ON v.id = l.voiture INNER JOIN clients c ON c.id = l.client INNER JOIN users u ON u.id = c.id WHERE v.marque = :marque", resultClass = Client.class)
public class Client extends User {

    private String cin;

    @OneToMany(mappedBy = "client")
    private List<Location> locations;

    public Client() {
    }

    public Client(String cin, String nom, String prenom, String email, String password) {
        super(nom, prenom, email, password);
        this.cin = cin;
    }

    public String getCin() {
        return cin;
    }

    public void setCin(String cin) {
        this.cin = cin;
    }

    public List<Location> getLocations() {
        return locations;
    }

    public void setLocations(List<Location> locations) {
        this.locations = locations;
    }

}
