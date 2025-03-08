package models;

import java.util.Date;

public class AjoutReservation {

    private String idVol, classe, idClient;
    private String fileNamepassport;
    private byte[] bytespassport;
    private Date dateResa;

    public String getIdVol() {
        return idVol;
    }

    public void setIdVol(String idVol) {
        this.idVol = idVol;
    }

    public String getClasse() {
        return classe;
    }

    public void setClasse(String classe) {
        this.classe = classe;
    }

    public String getIdClient() {
        return idClient;
    }

    public void setIdClient(String idClient) {
        this.idClient = idClient;
    }

    public String getFileNamepassport() {
        return fileNamepassport;
    }

    public void setFileNamepassport(String fileNamepassport) {
        this.fileNamepassport = fileNamepassport;
    }

    public byte[] getBytespassport() {
        return bytespassport;
    }

    public void setBytespassport(byte[] bytespassport) {
        this.bytespassport = bytespassport;
    }

    public Date getDateResa() {
        return dateResa;
    }

    public void setDateResa(Date dateResa) {
        this.dateResa = dateResa;
    }
}
