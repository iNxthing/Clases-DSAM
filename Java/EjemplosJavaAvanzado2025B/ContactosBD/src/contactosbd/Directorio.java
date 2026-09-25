/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package contactosbd;

/**
 *
 * @author cymaniatico
 */
public class Directorio {
    
    private int id;
    private String nombre;
    private String telefono;
    private String tipoContacto;

    public Directorio(int id, String nombre, String telefono, String tipoContacto) {
        this.id = id;
        this.nombre = nombre;
        this.telefono = telefono;
        this.tipoContacto = tipoContacto;
    }

    public int getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public String getTelefono() {
        return telefono;
    }

    public String getTipoContacto() {
        return tipoContacto;
    }
    
    
    
}
