package controller;

import itu.etu2779.annotation.*;
import itu.etu2779.annotation.auth.Auth;
import itu.etu2779.annotation.auth.Public;
import itu.etu2779.annotation.auth.RoleType;
import itu.etu2779.servlet.CustomSession;
import itu.etu2779.servlet.ModelAndView;
import models.*;
import persistance.database.GenericRepo;
import persistance.exception.MismatchException;
import services.VolService;

import java.sql.SQLException;
import java.util.List;

@Controller
//@Auth(RoleType.Admin)
public class VolController {

    @Get
    @Url(path = "add-vol")
    public ModelAndView addVol() throws SQLException, MismatchException {
        ModelAndView mav = new ModelAndView("/WEB-INF/jsp/home.jsp?module=insererVol.jsp");
        List<Avion> avion = GenericRepo.findAll(Avion.class);
        List<VilleDesservie> ville = GenericRepo.findAll(VilleDesservie.class);
        mav.addObject("avion", avion);
        mav.addObject("ville", ville);
        return mav;
    }

    @Post
    @Url(path = "add-vol")
    public ModelAndView addVol(@Param(name = "add") AjoutVol add) throws SQLException, MismatchException {
        System.out.println(add);
        ModelAndView mav = new ModelAndView("/WEB-INF/jsp/home.jsp?module=insererVol.jsp");
        return mav;
    }

    @Get
    @Url(path = "update-vol")
    public ModelAndView goUpdateVol(@Param(name = "id") String id) throws SQLException, MismatchException {
        ModelAndView mav = new ModelAndView("/WEB-INF/jsp/home.jsp?module=insererVol.jsp");
        Vol vol = GenericRepo.findById(id, Vol.class);
        List<Avion> avion = GenericRepo.findAll(Avion.class);
        List<VilleDesservie> ville = GenericRepo.findAll(VilleDesservie.class);
        mav.addObject("vol", vol);
        mav.addObject("avion", avion);
        mav.addObject("ville", ville);
        return mav;
    }

    @Public
    @Get
    @Url(path = "liste-vol")
    public ModelAndView goListVol(CustomSession session) throws SQLException, MismatchException {
        ModelAndView mav = new ModelAndView("/WEB-INF/jsp/home.jsp?module=listeVol.jsp");
        List<Vol> vol = GenericRepo.findAll(Vol.class);
        List<Avion> avion = GenericRepo.findAll(Avion.class);
        List<VilleDesservie> ville = GenericRepo.findAll(VilleDesservie.class);
        List<Configuration> conf = GenericRepo.findAll(Configuration.class);
        mav.addObject("vol", vol);
        mav.addObject("avion", avion);
        mav.addObject("ville", ville);
        mav.addObject("conf", conf);
        return mav;
    }

    @Post
    @Url(path = "recherche-vol")
    public ModelAndView rechercheVol(@Param(name = "rech")RechercheVol recherche) throws SQLException, MismatchException {
        ModelAndView mav = new ModelAndView("/WEB-INF/jsp/home.jsp?module=listeVol.jsp");
        List<Vol> vol = VolService.findVolByRecherche(recherche);
        List<Avion> avion = GenericRepo.findAll(Avion.class);
        List<VilleDesservie> ville = GenericRepo.findAll(VilleDesservie.class);
        mav.addObject("vol", vol);
        mav.addObject("avion", avion);
        mav.addObject("ville", ville);
        return mav;
    }

    @Get
    @Url(path = "promotion-vol")
    public ModelAndView promotion() throws SQLException, MismatchException {
        ModelAndView mav = new ModelAndView("/WEB-INF/jsp/home.jsp?module=promotion.jsp");
        List<Vol> vol = GenericRepo.findAll(Vol.class);
        List<Avion> avion = GenericRepo.findAll(Avion.class);
        List<VilleDesservie> ville = GenericRepo.findAll(VilleDesservie.class);
        mav.addObject("vol", vol);
        mav.addObject("avion", avion);
        mav.addObject("ville", ville);
        return mav;
    }
}
