package models;

import persistance.annotation.Colonne;
import persistance.annotation.Table;

@Table(nom = "prix_vol")
public class PrixVol {
    private String id;
    @Colonne("id_vol")
    private String idVol;
    @Colonne("id_type_siege")
    private String idTypeSiege;
    private double prix;

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

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }

    @Override
    public String toString() {
        return "PrixVol{" +
                "id='" + id + '\'' +
                ", idVol='" + idVol + '\'' +
                ", idTypeSiege='" + idTypeSiege + '\'' +
                ", prix=" + prix +
                '}';
    }
}
