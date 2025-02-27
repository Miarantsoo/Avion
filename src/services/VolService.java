package services;

import models.RechercheVol;
import models.Vol;
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
}
