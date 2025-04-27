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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import org.hibernate.annotations.NamedQueries;
import org.hibernate.annotations.NamedQuery;

/**
 *
 * @author hibaa
 */
@Entity
@NamedQueries({
    @NamedQuery(name = "findByMarque", query = "from Voiture where marque.id =:id"),
    @NamedQuery(name = "Voiture.findAll", query = "SELECT v FROM Voiture v"),
    @NamedQuery( name = "Voiture.countByType", query = "SELECT v.typeVoiture AS typeVoiture, COUNT(v) AS voitureCount " + "FROM Voiture v " +
            "GROUP BY v.typeVoiture " +
            "ORDER BY voitureCount DESC" )
    })

@Table(name = "voitures")
public class Voiture {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String marque;
    private String modele;
    private String annee;
    private boolean disponible;
    private String photo;
    private double prix;

    @OneToMany(mappedBy = "voiture")
    private List<Location> locations;

    @ManyToOne
    @JoinColumn(name = "typeId")
    private TypeVoiture typeVoiture;

    public Voiture(String marque, String modele, String annee, boolean disponible, TypeVoiture tv, String photo, double prix) {
        this.marque = marque;
        this.modele = modele;
        this.annee = annee;
        this.disponible = disponible;
        this.typeVoiture = tv;
        this.photo = photo;
        this.prix=prix;
    }

    public Voiture() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMarque() {
        return marque;
    }

    public void setMarque(String marque) {
        this.marque = marque;
    }

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }

    public String getAnnee() {
        return annee;
    }

    public void setAnnee(String annee) {
        this.annee = annee;
    }

    public boolean isDisponible() {
        return disponible;
    }

    public void setDisponible(boolean disponible) {
        this.disponible = disponible;
    }

    public TypeVoiture getTypeVoiture() {
        return typeVoiture;
    }

    public void setTypeVoiture(TypeVoiture typeVoiture) {
        this.typeVoiture = typeVoiture;
    }

    public List<Location> getLocations() {
        return locations;
    }

    public void setLocations(List<Location> locations) {
        this.locations = locations;
    }

    public void setType(String string) {
        throw new UnsupportedOperationException("Not supported yet."); 
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }
    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }
}
