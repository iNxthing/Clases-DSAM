/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sistemadegestionacademica;

/**
 *
 * @author nothing
 */
public class Notas {
    private String asignatura;
    private String periodo;
    private double valor;

    public Notas(String asignatura, String periodo, double valor) {
        this.asignatura = asignatura;
        this.periodo = periodo;
        this.valor = valor;
    }

    public String getAsignatura() {
        return asignatura;
    }

    public String getPeriodo() {
        return periodo;
    }

    public double getValor() {
        return valor;
    }
    
    
}
