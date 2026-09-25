/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package colegio;

/**
 *
 * @author cymaniatico
 */
public class Estudiante {
    
    private String documento;
    private String nombre;
    private String edad;
    private String programa;
    
    public Estudiante(String documento, String nombre, 
            String edad, String programa){
        this.documento=documento;
        this.nombre=nombre;
        this.edad=edad;
        this.programa=programa;
    }
    
    public String getDocumento(){
        return documento;
    }
    
    public String getNombre(){
        return nombre;
    }
    
    public String getEdad(){
        return edad;
    }
    
    public String getPrograma(){
        return programa;
    }
    
    
}
