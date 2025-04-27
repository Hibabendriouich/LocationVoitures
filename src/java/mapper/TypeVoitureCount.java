/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mapper;

/**
 *
 * @author hibaa
 */
public class TypeVoitureCount {
    private String typeVoiture;
    private long voitureCount;

    public TypeVoitureCount(String typeVoiture, long voitureCount) {
        this.typeVoiture = typeVoiture;
        this.voitureCount = voitureCount;
    }

    public String getTypeVoiture() {
        return typeVoiture;
    }

    public long getVoitureCount() {
        return voitureCount;
    }
}
