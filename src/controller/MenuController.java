package controller;

import itu.etu2779.annotation.Controller;
import itu.etu2779.annotation.Get;
import itu.etu2779.annotation.Url;
import itu.etu2779.servlet.ModelAndView;

@Controller
public class MenuController {

    @Get
    @Url(path = "promotion")
    public ModelAndView goPromotion(){
        ModelAndView mav = new ModelAndView("/WEB-INF/jsp/home.jsp?module=promotion.jsp");
        return mav;
    }

    @Get
    @Url(path = "reservation-settings")
    public ModelAndView goReservation(){
        ModelAndView mav = new ModelAndView("/WEB-INF/jsp/home.jsp?module=reserverVolSettings.jsp");
        return mav;
    }

}

