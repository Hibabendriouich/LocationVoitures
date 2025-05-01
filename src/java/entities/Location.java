/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import javax.persistence.Entity;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.hibernate.annotations.NamedQueries;
import org.hibernate.annotations.NamedQuery;
import javax.persistence.FetchType;

/**
 *
 * @author hibaa
 */
@Entity
@NamedQueries({
    @NamedQuery(name = "findBetweenDate", 
               query = "SELECT l FROM Location l WHERE l.id.dateDebut BETWEEN :d1 AND :d2"),
    @NamedQuery(name = "Location.findByClient",
               query = "SELECT l FROM Location l JOIN FETCH l.voiture WHERE l.id.client = :idClient")
})
public class Location {
    @EmbeddedId
    private LocationPK id;

    @Temporal(TemporalType.DATE)  
    @Column(name = "dateFin")     
    private Date dateFin;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "client", referencedColumnName = "id", insertable = false, updatable = false)
    private Client client;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "voiture", referencedColumnName = "id", insertable = false, updatable = false)
    private Voiture voiture;

    public Location() {}

    public Location(LocationPK id, Date dateFin) {
        this.id = id;
        this.dateFin = dateFin;
    }

    public Date getDateDebut() {
    return this.id.getDateDebut();
}
    public LocationPK getId() {
        return id;
    }

    public void setId(LocationPK id) {
        this.id = id;
    }

    public Date getDateFin() {
        return dateFin;
    }

    public void setDateFin(Date dateFin) {
        this.dateFin = dateFin;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public Voiture getVoiture() {
        return voiture;
    }

    public void setVoiture(Voiture voiture) {
        this.voiture = voiture;
    }
}