package models;

import persistance.annotation.Colonne;
import persistance.annotation.Table;

import java.util.Arrays;
import java.util.Date;

@Table(nom = "reservation", prefixe = "RESA")
public class Reservation {
    private String id;

    @Colonne("id_vol")
    private String idVol;

    @Colonne("id_utilisateur")
    private String idUtilisateur;

    @Colonne("id_type_siege")
    private String idTypeSiege;
    private double prix;

    @Colonne("date_reservation")
    private Date dateResa;

    @Colonne("passport_name")
    private String passportName;
    private byte[] passport;
    private int etat;

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

    public String getIdUtilisateur() {
        return idUtilisateur;
    }

    public void setIdUtilisateur(String idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
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

    public Date getDateResa() {
        return dateResa;
    }

    public void setDateResa(Date dateResa) {
        this.dateResa = dateResa;
    }

    public String getPassportName() {
        return passportName;
    }

    public void setPassportName(String passportName) {
        this.passportName = passportName;
    }

    public byte[] getPassport() {
        return passport;
    }

    public void setPassport(byte[] passport) {
        this.passport = passport;
    }

    public int getEtat() {
        return etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }

    @Override
    public String toString() {
        return "Reservation{" +
                "id='" + id + '\'' +
                ", idVol='" + idVol + '\'' +
                ", idUtilisateur='" + idUtilisateur + '\'' +
                ", idTypeSiege='" + idTypeSiege + '\'' +
                ", prix=" + prix +
                ", dateResa=" + dateResa +
                ", passportName='" + passportName + '\'' +
                ", passport=" + Arrays.toString(passport) +
                ", etat=" + etat +
                '}';
    }
}
