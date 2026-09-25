package contactosbd;

public class InfoConexion {

    String url = "jdbc:mysql://localhost/directorio";
    String username="root";
    String password="drakhuntress1210";

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
