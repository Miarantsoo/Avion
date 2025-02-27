package models;

public class RechercheVol {
    private String modele;
    private String villeDepart;
    private String villeArrivee;
    private String dateDepart;
    private String dateArrivee;

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

    public String getDateDepart() {
        return dateDepart;
    }

    public void setDateDepart(String dateDepart) {
        this.dateDepart = dateDepart;
    }

    public String getDateArrivee() {
        return dateArrivee;
    }

    public void setDateArrivee(String dateArrivee) {
        this.dateArrivee = dateArrivee;
    }

    @Override
    public String toString() {
        return "RechercheVol{" +
                "modele='" + modele + '\'' +
                ", villeDepart='" + villeDepart + '\'' +
                ", villeArrivee='" + villeArrivee + '\'' +
                ", dateDepart='" + dateDepart + '\'' +
                ", dateArrivee='" + dateArrivee + '\'' +
                '}';
    }
}
