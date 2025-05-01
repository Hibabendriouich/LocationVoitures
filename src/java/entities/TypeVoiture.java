/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.util.List;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import org.hibernate.annotations.NamedNativeQuery;

/**
 *
 * @author hibaa
 */
@Entity
@NamedNativeQuery(
        name = "TypeVoiture.findByTypeId",
        query = "SELECT * FROM TypeVoiture WHERE id = ?",
        resultClass = TypeVoiture.class
    )
@Table(name = "types")
public class TypeVoiture {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String nom;
    private String description;

    @OneToMany(mappedBy = "typeVoiture")
private List<Voiture> voitures;


    public TypeVoiture() {
    }

    public TypeVoiture(String nom, String description) {
        this.nom = nom;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Voiture> getVoitures() {
        return voitures;
    }

    public void setVoitures(List<Voiture> voitures) {
        this.voitures = voitures;
    }

}
