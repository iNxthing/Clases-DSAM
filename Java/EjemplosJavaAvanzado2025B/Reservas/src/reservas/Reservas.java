
package reservas;

public class Reservas {

    private String documento;
    private String nombre;
    private String fechaReserva;

    public Reservas(String documento, String nombre, String fechaReserva) {
        this.documento = documento;
        this.nombre = nombre;
        this.fechaReserva = fechaReserva;
    }

    public String getDocumento() {
        return documento;
    }

    public String getNombre() {
        return nombre;
    }

    public String getFechaReserva() {
        return fechaReserva;
    }
    
    
}
