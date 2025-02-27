package models;

import itu.etu2779.annotation.validation.Required;

import java.util.Date;

public class AjoutVol {
    private String id;

    @Required
    private String modele;

    @Required
    private String villeDepart;

    @Required
    private String villeArrivee;

    @Required
    private Date dateDepart;

    @Required
    private Date dateArrivee;

    @Required
    private double prixEco;

    @Required
    private double prixBusi;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }

    public String getVilleDepart() {
        return villeDepart;
    }

    public void setVilleDepart(String villeDepart) {
        this.villeDepart = villeDepart;
    }

    public String getVilleArrivee() {
        return villeArrivee;
    }

    public void setVilleArrivee(String villeArrivee) {
        this.villeArrivee = villeArrivee;
    }

    public Date getDateDepart() {
        return dateDepart;
    }

    public void setDateDepart(Date dateDepart) {
        this.dateDepart = dateDepart;
    }

    public Date getDateArrivee() {
        return dateArrivee;
    }

    public void setDateArrivee(Date dateArrivee) {
        this.dateArrivee = dateArrivee;
    }

    public double getPrixEco() {
        return prixEco;
    }

    public void setPrixEco(double prixEco) {
        this.prixEco = prixEco;
    }

    public double getPrixBusi() {
        return prixBusi;
    }

    public void setPrixBusi(double prixBusi) {
        this.prixBusi = prixBusi;
    }

    @Override
    public String toString() {
        return "AjoutVol{" +
                "id='" + id + '\'' +
                ", modele='" + modele + '\'' +
                ", villeDepart='" + villeDepart + '\'' +
                ", villeArrivee='" + villeArrivee + '\'' +
                ", dateDepart=" + dateDepart +
                ", dateArrivee=" + dateArrivee +
                ", prixEco=" + prixEco +
                ", prixBusi=" + prixBusi +
                '}';
    }
}
