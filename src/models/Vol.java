package models;

import persistance.annotation.Table;

import java.sql.Timestamp;

@Table(nom = "v_vol")
public class Vol {

    private String id;
    private String modele;
    private String capacite;
    private String villeDepart;
    private String villeArrivee;
    private Timestamp dateDepart;
    private Timestamp dateArrivee;
    private int economique;
    private int business;
    private int nbrEco;
    private int promEco;
    private int nbrBusi;
    private int promBusi;

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

    public String getCapacite() {
        return capacite;
    }

    public void setCapacite(String capacite) {
        this.capacite = capacite;
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

    public Timestamp getDateDepart() {
        return dateDepart;
    }

    public void setDateDepart(Timestamp dateDepart) {
        this.dateDepart = dateDepart;
    }

    public Timestamp getDateArrivee() {
        return dateArrivee;
    }

    public void setDateArrivee(Timestamp dateArrivee) {
        this.dateArrivee = dateArrivee;
    }

    public int getEconomique() {
        return economique;
    }

    public void setEconomique(int economique) {
        this.economique = economique;
    }

    public int getBusiness() {
        return business;
    }

    public void setBusiness(int business) {
        this.business = business;
    }

    public int getNbrEco() {
        return nbrEco;
    }

    public void setNbrEco(int nbrEco) {
        this.nbrEco = nbrEco;
    }

    public int getPromEco() {
        return promEco;
    }

    public void setPromEco(int promEco) {
        this.promEco = promEco;
    }

    public int getNbrBusi() {
        return nbrBusi;
    }

    public void setNbrBusi(int nbrBusi) {
        this.nbrBusi = nbrBusi;
    }

    public int getPromBusi() {
        return promBusi;
    }

    public void setPromBusi(int promBusi) {
        this.promBusi = promBusi;
    }
}
