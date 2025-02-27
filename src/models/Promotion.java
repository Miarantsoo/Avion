package models;

public class Promotion {
    private String idVol;
    private int nbrEco;
    private int prEco;
    private int nbrBusi;
    private int prBusi;

    public String getIdVol() {
        return idVol;
    }

    public void setIdVol(String idVol) {
        this.idVol = idVol;
    }

    public int getNbrEco() {
        return nbrEco;
    }

    public void setNbrEco(int nbrEco) {
        this.nbrEco = nbrEco;
    }

    public int getPrEco() {
        return prEco;
    }

    public void setPrEco(int prEco) {
        this.prEco = prEco;
    }

    public int getNbrBusi() {
        return nbrBusi;
    }

    public void setNbrBusi(int nbrBusi) {
        this.nbrBusi = nbrBusi;
    }

    public int getPrBusi() {
        return prBusi;
    }

    public void setPrBusi(int prBusi) {
        this.prBusi = prBusi;
    }
}
