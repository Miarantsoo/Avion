package models;

import itu.etu2779.annotation.auth.RoleType;
import persistance.annotation.Colonne;
import persistance.annotation.NoMap;
import persistance.annotation.Table;

@Table(nom = "utilisateur")
public class User {

    private String id;
    private String nom;
    private String prenom;
    private String email;
    private String password;
    @Colonne("role")
    private int roleBase;

    @NoMap
    private RoleType role;

    public RoleType getRole() {
        return role;
    }

    public void setRole(RoleType role) {
        this.role = role;
    }

    public int getRoleBase() {
        return roleBase;
    }

    public void setRoleBase(int roleBase) {
        this.roleBase = roleBase;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRoleType() {
        for(RoleType roleType : RoleType.values()) {
            if(roleType.level == roleBase) {
                setRole(roleType);
            }
        }
    }

    @Override
    public String toString() {
        return "User{" +
                "id='" + id + '\'' +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", role=" + role +
                '}';
    }
}
