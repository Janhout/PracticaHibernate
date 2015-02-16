<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="hibernate.Inmueble"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Inmueble inmueble = (Inmueble) request.getAttribute("inmueble");
    ArrayList<String> fotos = new ArrayList();
    String directorio = getServletContext().getRealPath("/") + "subido/" + inmueble.getId() + "/";
    File carpeta = new File(directorio);
    if (carpeta.exists()) {
        File[] ficheros = carpeta.listFiles();
        for (int i = 0; i < ficheros.length; i++) {
            if(ficheros[i].getName().contains(("inmueble_"+inmueble.getId()+"_"))){
                fotos.add("subido/"+inmueble.getId()+"/"+ficheros[i].getName());
            }
        }
    }
    if(fotos.size()==0){
        fotos.add("resources/images/nohay.jpg");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Fotos Inmueble</title>
        <link rel="stylesheet" href="faces/resources/css/flexslider.css">
        <link rel="stylesheet" href="faces/resources/css/estilos.css">
        <script src="faces/resources/javascript/jquery-2.1.3.js"></script>
        <script src="faces/resources/javascript/jquery.flexslider.js"></script>
        <script src="faces/resources/javascript/varios.js"></script>
        <link href="faces/resources/css/tabla.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div class="cabecera">
            <h1>Inmobiliaria AAD</h1>
            <h2>Detalles Inmueble</h2>
        </div>
        <div class="flexslider">
            <ul class="slides">
                <% for(int i=0; i<fotos.size(); i++){ %>
                <li>
                    <img src="<%= fotos.get(i) %>" />
                </li>
                <% } %>
            </ul>
        </div>
        <div id ="mostrar">
            <div class="tabla">
                <table>
                    <tr>
                        <td colspan="2">Datos Inmueble</td>
                    </tr>
                    <tr>
                        <td>ID</td>
                        <td><%= inmueble.getId()%></td>
                    </tr>
                    <tr>
                        <td>Tipo</td>
                        <td><%= inmueble.getTipo()%></td>
                    </tr>
                    <tr>
                        <td>Dirección</td>
                        <td><%= inmueble.getCalle() + " " + inmueble.getNumero()%></td>
                    </tr>
                    <tr>
                        <td>Localidad</td>
                        <td><%= inmueble.getLocalidad()%></td>
                    </tr>
                    <tr>
                        <td>Precio</td>
                        <td><%= inmueble.getPrecio()%></td>
                    </tr>
                    <tr>
                        <td>Usuario</td>
                        <td><%= inmueble.getUsuario()%></td>
                    </tr>
                </table>
            </div>
            <div class="botones">
                <a href="control?target=inmueble&op=foto&action=view&id=<%= inmueble.getId()%>"><input type="button" value="Agregar Foto" name="nueva_foto" /></a>
                <a href="control?target=inmueble&op=select&action=view"><input type="button" value="Volver" name="volver" /></a>
            </div>
        </div>
    </body>
</html>
