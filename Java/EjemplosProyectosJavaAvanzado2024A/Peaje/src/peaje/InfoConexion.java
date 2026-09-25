/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package peaje;

/**
 *
 * @author cymaniatico
 */
public class InfoConexion {
    String url = "jdbc:mysql://localhost/peaje";
    String username="cbn";
    String password="cbn2016";

    public InfoConexion() {
    }
    

    public String getUrl() {
        return url;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }
    
}
