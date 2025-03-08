package services;

import models.*;
import persistance.database.GenericRepo;
import persistance.exception.MismatchException;

import java.sql.SQLException;
import java.util.List;

public class VolService {

    public static List<Vol> findVolByRecherche(RechercheVol recherche) throws SQLException, MismatchException {
        String condition = "";
        if (!recherche.getModele().equals("null") && !recherche.getModele().isEmpty()) {
            if (!condition.equals("")) condition += " AND ";
            condition += " modele = '" + recherche.getModele() + "'";
        }
        if (!recherche.getVilleDepart().equals("null") && !recherche.getVilleDepart().isEmpty()) {
            if (!condition.equals("")) condition += " AND ";
            condition += " villeDepart = '" + recherche.getVilleDepart() + "'";
        }
        if (!recherche.getVilleArrivee().equals("null") && !recherche.getVilleArrivee().isEmpty()) {
            if (!condition.equals("")) condition += " AND ";
            condition += " villeArrivee = '" + recherche.getVilleArrivee() + "'";
        }
        if (!recherche.getDateDepart().equals("null")) {
            if (!condition.equals("")) condition += " AND ";
            condition += " dateDepart >= '" + recherche.getDateDepart() + "'";
        }
        if (!recherche.getDateArrivee().equals("null")) {
            if (!condition.equals("")) condition += " AND ";
            condition += " dateArrivee <= '" + recherche.getDateArrivee() + "'";
        }
        List<Vol> vol = GenericRepo.findWCond(Vol.class, condition);
        return vol;
    }

    public static void book(AjoutReservation res) throws MismatchException, SQLException {
        Reservation resa = new Reservation();
        resa.setIdVol(res.getIdVol());
        resa.setIdUtilisateur(res.getIdClient());
        resa.setIdTypeSiege(res.getClasse());
        resa.setPassportName(res.getFileNamepassport());
        resa.setPassport(res.getBytespassport());
        resa.setDateResa(res.getDateResa());

        Vol v = GenericRepo.findById(res.getIdVol(), Vol.class);
        List<PrixVol> prix = GenericRepo.findWCond(PrixVol.class, "id_vol = '"+ v.getId() + "'");

        PromotionVol prom = null;
        if (res.getClasse().equals("TSIEGE001")) {
            if(v.getNbrEco() != 0 && v.getPromEco() != 0) {
                resa.setPrix(prix.get(0).getPrix() - (prix.get(0).getPrix() * v.getPromEco() / 100));
                prom = GenericRepo.findWCond(PromotionVol.class, "id_vol = '"+ v.getId() + "' AND id_type_siege = 'TSIEGE001'").get(0);
                prom.setNbrPlace(prom.getNbrPlace()-1);
            } else {
                resa.setPrix(prix.get(0).getPrix());
            }
        } else {
            if(v.getNbrEco() != 0 && v.getPromEco() != 0) {
                resa.setPrix(prix.get(1).getPrix() - (prix.get(1).getPrix() * v.getPromBusi() / 100));
                prom = GenericRepo.findWCond(PromotionVol.class, "id_vol = '"+ v.getId() + "' AND id_type_siege = 'TSIEGE002'").get(0);
                prom.setNbrPlace(prom.getNbrPlace()-1);
            } else {
                resa.setPrix(prix.get(1).getPrix());
            }
        }
        resa.setEtat(1);
        GenericRepo.save(prom);
        System.out.println(resa);
        GenericRepo.save(resa);
    }
}
