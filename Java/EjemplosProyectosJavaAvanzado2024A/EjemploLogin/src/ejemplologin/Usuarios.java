/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ejemplologin;

/**
 *
 * @author cymaniatico
 */
public class Usuarios {
    
    private int id;
    private String user;
    private String pass;
    private int idProfile;

    public Usuarios(int id, String user, String pass, int idProfile) {
        this.id = id;
        this.user = user;
        this.pass = pass;
        this.idProfile = idProfile;
    }

    public int getId() {
        return id;
    }

    public String getUser() {
        return user;
    }

    public String getPass() {
        return pass;
    }

    public int getIdProfile() {
        return idProfile;
    }
    
    
    
}
