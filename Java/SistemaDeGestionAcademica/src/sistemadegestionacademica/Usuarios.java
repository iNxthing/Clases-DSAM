/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package sistemadegestionacademica;

/**
 *
 * @author Usuario
 */
public class Usuarios {
    private int id;
    private String user;
    private String pass;
    private int idprofile;

    public Usuarios(int id, String user, String pass, int idprofile) {
        this.id = id;
        this.user = user;
        this.pass = pass;
        this.idprofile = idprofile;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public int getIdprofile() {
        return idprofile;
    }

    public void setIdprofile(int idprofile) {
        this.idprofile = idprofile;
    }

    
}
