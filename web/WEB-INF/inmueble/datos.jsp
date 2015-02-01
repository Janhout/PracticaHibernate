<%@page import="hibernate.Inmueble"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Datos Inmuebles</title>
        <link href="faces/resources/css/tabla.css" rel="stylesheet" type="text/css" />
        <link href="faces/resources/css/estilos.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div class="cabecera">
            <h1>Inmobiliaria AAD</h1>
            <h2>Datos Inmuebles</h2>
        </div>
        <div class="tabla" >
            <table >
                <tr>
                    <td><a href="control?target=inmueble&op=select&action=view&order=id">ID</a></td>
                    <td><a href="control?target=inmueble&op=select&action=view&order=calle">Calle</a></td>
                    <td><a href="control?target=inmueble&op=select&action=view&order=numero">Número</a></td>
                    <td><a href="control?target=inmueble&op=select&action=view&order=localidad">Localidad</a></td>
                    <td><a href="control?target=inmueble&op=select&action=view&order=tipo">Tipo</a></td>
                    <td><a href="control?target=inmueble&op=select&action=view&order=precio">Precio</a></td>
                    <td><a href="control?target=inmueble&op=select&action=view&order=usuario">Usuario</a></td>
                    <td colspan="3">Acciones</td>
                </tr>
                <%
                    List<Inmueble> lista = (List<Inmueble>) request.getAttribute("datos");
                    for (Inmueble i : lista) {
                %>
                <tr>
                    <td><%= i.getId()%></td>
                    <td><%= i.getCalle()%></td>
                    <td><%= i.getNumero()%></td>
                    <td><%= i.getLocalidad()%></td>
                    <td><%= i.getTipo()%></td>
                    <td><%= i.getPrecio()%></td>
                    <td><%= i.getUsuario()%></td>
                    <td><a href="control?target=inmueble&op=ver&action=view&id=<%= i.getId()%>">Ver Detalle</a></td>
                    <td><a href="control?target=inmueble&op=edit&action=view&id=<%= i.getId()%>">Editar</a></td>
                    <td><a href="control?target=inmueble&op=delete&action=view&id=<%= i.getId()%>">Borrar</a></td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
        <div class="botones">
<h2><a href="control?target=inmueble&op=insert&action=view"><input type="button" value="Insertar Inmueble" name="insertar" /></a></h2>
        </div>
    </body>
</html>
