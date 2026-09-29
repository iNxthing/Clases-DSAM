/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sistemadegestionacademica;

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
    
    public static final List<String> asignaturas = new ArrayList<>();

    static {
        asignaturas.add("Matematicas");
        asignaturas.add("Ciencias");
        asignaturas.add("Ingles");
        asignaturas.add("Tecnologia");
    }
    public static Estudiante buscarPorNombre(String nombre) {
        for (Estudiante e : obtenerEstudiantes()) {
            if (e.getNombreEstudiante().equalsIgnoreCase(nombre)) {
                return e;
            }
        }
    return null;
}
    
    public static List<Estudiante> filtrarBajoRendimiento(double limite){
        List<Estudiante> resultado = new ArrayList<>();
        for (Estudiante e : obtenerEstudiantes()) {
            if (!e.getNotas().isEmpty() && e.calcularPromedio() < limite) {
                resultado.add(e);
            }
        }
        return resultado;
    }

   
    
    
    
    
}
