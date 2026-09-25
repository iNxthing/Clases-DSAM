/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package contactosbd;

/**
 *
 * @author cymaniatico
 */
public class TipoContacto {
    
    private int id;
    private String descripcion;

    public TipoContacto(int id, String descripcion) {
        this.id = id;
        this.descripcion = descripcion;
    }

    public int getId() {
        return id;
    }

    public String getDescripcion() {
        return descripcion;
    }
    
    
    
}
