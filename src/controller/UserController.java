package controller;

import itu.etu2779.annotation.*;
import itu.etu2779.servlet.CustomSession;
import itu.etu2779.servlet.ModelAndView;
import models.Login;
import models.User;
import org.apache.commons.codec.digest.DigestUtils;
import persistance.database.GenericRepo;
import persistance.exception.MismatchException;
import services.UserService;

import java.sql.SQLException;
import java.util.List;

@Controller
public class UserController {

    @Get
    @Url(path = "login")
    public ModelAndView login() throws SQLException, MismatchException {
        ModelAndView mav = new ModelAndView("/WEB-INF/jsp/login.jsp");
        return mav;
    }

    @Post
    @Url(path = "login")
    public ModelAndView login(@Param(name = "log") Login log, CustomSession session) throws SQLException, MismatchException {
        boolean verif = UserService.verifLogin(log.getEmail(), log.getMdp(), session);
        String path = "";
        ModelAndView mav = null;
        if(!verif){
            path += "login";
            mav = new ModelAndView(path);
            mav.setDispatch(true);
            mav.setError("/login");
            mav.addObject("erreur", "Veuillez verifier vos identifiants");
        } else {
            path += "liste-vol";
            mav = new ModelAndView(path);
            mav.setRedirect(true);
        }
        return mav;
    }

    @Get
    @Url(path = "logout")
    public ModelAndView logout(CustomSession session){
        ModelAndView mav = new ModelAndView("login");
        mav.setRedirect(true);
        session.delete("AUTH");
        session.delete("ROLE_USER");
        session.delete("user");
        return mav;
    }
}
