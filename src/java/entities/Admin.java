/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 *
 * @author hibaa
 */
@Entity
@Table(name = "admins")
public class Admin extends User {

    String matricule;

    public Admin() {
    }

    public Admin(String matricule, String nom, String prenom, String email, String password) {
        super(nom, prenom, email, password);
        this.matricule = matricule;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

}
