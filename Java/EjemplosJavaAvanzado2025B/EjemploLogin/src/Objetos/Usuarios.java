/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Objetos;

/**
 *
 * @author cymaniatico
 */
public class Usuarios {
    private int idUser;
    private String user;
    private String pass;
    private int idRole;

    public Usuarios(int idUser, String user, String pass, int idRole) {
        this.idUser = idUser;
        this.user = user;
        this.pass = pass;
        this.idRole = idRole;
    }

    public int getIdUser() {
        return idUser;
    }

    public String getUser() {
        return user;
    }

    public String getPass() {
        return pass;
    }

    public int getIdRole() {
        return idRole;
    }
    
    
    
    
}
