package controller;

import itu.etu2779.annotation.Controller;
import itu.etu2779.annotation.Get;
import itu.etu2779.annotation.Url;
import itu.etu2779.servlet.ModelAndView;

@Controller
public class HomeController {

    @Get
    @Url(path = "home")
    public ModelAndView goHome(){
        ModelAndView mav = new ModelAndView("/WEB-INF/jsp/home.jsp?module=insererVol.jsp");
        return mav;
    }

}
