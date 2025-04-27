/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.hibernate.annotations.NamedQueries;
import org.hibernate.annotations.NamedQuery;

/**
 *
 * @author hibaa
 */
@Entity
@NamedQueries({
    @NamedQuery(name = "findBetweenDate", query = "from Location where dateDebut between :d1 and :d2"),
    @NamedQuery(name = "Location.findByClient", query = "SELECT l FROM Location l WHERE l.client.id = :idClient")
})
@Table(name = "locations")
public class Location {

    @EmbeddedId
    private LocationPK pK;

    
    @Temporal(TemporalType.DATE)
    @Column(insertable = false, updatable = false)
    private Date dateDebut;

    @Temporal(TemporalType.DATE)
    @Column(insertable = false, updatable = false)
    private Date dateFin;

    @ManyToOne
    @JoinColumn(name = "client", referencedColumnName = "id", insertable = false, updatable = false)
    private Client client;

    @ManyToOne
    @JoinColumn(name = "voiture", referencedColumnName = "id", insertable = false, updatable = false)
    private Voiture voiture;

    public Location() {
    }

    public Location(LocationPK pK, Date dateDebut, Date dateFin, Client client, Voiture voiture) {
        this.pK = pK;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.client = client;
        this.voiture = voiture;
    }

    public LocationPK getpK() {
        return pK;
    }

    public void setpK(LocationPK pK) {
        this.pK = pK;
    }

    public Date getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(Date dateDebut) {
        this.dateDebut = dateDebut;
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
