/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package InformeEstudiantesPorGrado;

import java.util.List;
import java.util.ArrayList;

/**
 *
 * @author Usuario
 */
public class Grado {
    private String nombre;
    
    private static List<Estudiante> estudiantes = new ArrayList<>();

    public Grado(String nombre) {
        this.nombre = nombre;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public static void agregarEstudiante(Estudiante estudiante) {
        estudiantes.add(estudiante);
    }
 
    public static Estudiante crearEstudiante(String nombre, String grado) {
        Estudiante nuevo = new Estudiante(nombre, grado);
        agregarEstudiante(nuevo);
        return nuevo;
    }
 
    public static List<Estudiante> obtenerEstudiantes() {
        return estudiantes;
    }
    
    public static List<Estudiante> filtrarPorGrado(String nombreGrado) {
        List<Estudiante> resultado = new ArrayList<>();
        for (Estudiante e : obtenerEstudiantes()) {
            if (e.getGradoEstudiante().equalsIgnoreCase(nombreGrado)) {
                resultado.add(e);
            }
        }
        return resultado;
    }

   
    
    
    
    
}
