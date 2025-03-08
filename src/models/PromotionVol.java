package models;

import persistance.annotation.Colonne;
import persistance.annotation.Table;

@Table(nom = "promotion_vol")
public class PromotionVol {

    private String id;

    @Colonne("id_vol")
    private String idVol;

    @Colonne("id_type_siege")
    private String idTypeSiege;

    @Colonne("nbr_place")
    private int nbrPlace;

    @Colonne("taux_reduction")
    private int tauxReduction;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdVol() {
        return idVol;
    }

    public void setIdVol(String idVol) {
        this.idVol = idVol;
    }

    public String getIdTypeSiege() {
        return idTypeSiege;
    }

    public void setIdTypeSiege(String idTypeSiege) {
        this.idTypeSiege = idTypeSiege;
    }

    public int getNbrPlace() {
        return nbrPlace;
    }

    public void setNbrPlace(int nbrPlace) {
        this.nbrPlace = nbrPlace;
    }

    public int getTauxReduction() {
        return tauxReduction;
    }

    public void setTauxReduction(int tauxReduction) {
        this.tauxReduction = tauxReduction;
    }
}
