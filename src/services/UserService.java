package services;

import itu.etu2779.annotation.auth.RoleType;
import itu.etu2779.servlet.CustomSession;
import models.User;
import org.apache.commons.codec.digest.DigestUtils;
import persistance.database.GenericRepo;
import persistance.exception.MismatchException;

import java.sql.SQLException;
import java.util.List;

public class UserService {

    public static boolean verifLogin(String email, String mdp, CustomSession session) throws SQLException, MismatchException {
        String mdpHashed = DigestUtils.sha256Hex(mdp);
        String aWhere = "email = '" + email + "' AND password = '" + mdpHashed + "'";
        List<User> verif = GenericRepo.findWCond(User.class, aWhere);
        if (verif.size() > 0) {
            verif.get(0).setRoleType();
            session.add("AUTH", true);
            session.add("ROLE_USER", verif.get(0).getRole());
            session.add("user", verif.get(0));
        }
        return verif.size() > 0 ? true : false;
    }

}
