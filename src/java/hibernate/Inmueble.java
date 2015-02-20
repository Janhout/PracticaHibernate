package hibernate;
// Generated 28-ene-2015 17:06:17 by Hibernate Tools 4.3.1

import org.json.JSONObject;

public class Inmueble  implements java.io.Serializable {

     private Integer id;
     private String calle;
     private String numero;
     private String localidad;
     private String tipo;
     private int precio;
     private String usuario;

    public Inmueble() {
    }

    public Inmueble(JSONObject json){
        
        this.calle = json.getString("calle");
        this.numero = json.getString("numero");
        this.localidad = json.getString("localidad");
        this.tipo = json.getString("tipo");
        try{
            this.precio = Integer.parseInt(json.getString("precio"));
        } catch(NumberFormatException e){
            precio = 0;
        }
        this.usuario = json.getString("usuario");
    }
    
    public Inmueble(String calle, String numero, String localidad, String tipo, int precio, String usuario) {
       this.calle = calle;
       this.numero = numero;
       this.localidad = localidad;
       this.tipo = tipo;
       this.precio = precio;
       this.usuario = usuario;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public String getCalle() {
        return this.calle;
    }
    
    public void setCalle(String calle) {
        this.calle = calle;
    }
    public String getNumero() {
        return this.numero;
    }
    
    public void setNumero(String numero) {
        this.numero = numero;
    }
    public String getLocalidad() {
        return this.localidad;
    }
    
    public void setLocalidad(String localidad) {
        this.localidad = localidad;
    }
    public String getTipo() {
        return this.tipo;
    }
    
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    public int getPrecio() {
        return this.precio;
    }
    
    public void setPrecio(int precio) {
        this.precio = precio;
    }
    public String getUsuario() {
        return this.usuario;
    }
    
    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }




}


