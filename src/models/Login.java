package models;

import itu.etu2779.annotation.validation.Email;
import itu.etu2779.annotation.validation.Required;

public class Login {

    @Required
    @Email
    private String email;

    @Required
    private String mdp;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMdp() {
        return mdp;
    }

    public void setMdp(String mdp) {
        this.mdp = mdp;
    }
}
