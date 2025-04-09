/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author hibaa
 */
@Embeddable
public class LocationPK implements Serializable {

    @Column(name = "clientId")
    private int client;

    @Column(name = "voitureId")
    private int voiture;

    @Column(name = "dateDebut")
    private Date dateDebut;

    @Column(name = "dateFin")
    private Date dateFin;
    public LocationPK() {
    }

    public LocationPK(Date dateDebut, Date dateFin, int client, int voiture) {
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.client = client;
        this.voiture = voiture;
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

    public int getClient() {
        return client;
    }

    public void setClient(int client) {
        this.client = client;
    }

    public int getVoiture() {
        return voiture;
    }

    public void setVoiture(int voiture) {
        this.voiture = voiture;
    }

}
