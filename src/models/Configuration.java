package models;

import persistance.annotation.Table;

@Table(nom = "configuration")
public class Configuration {

    private String id;
    private String desce;
    private int val;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDesce() {
        return desce;
    }

    public void setDesce(String desce) {
        this.desce = desce;
    }

    public int getVal() {
        return val;
    }

    public void setVal(int val) {
        this.val = val;
    }
}
