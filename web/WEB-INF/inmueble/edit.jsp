<%@page import="java.util.ArrayList"%>
<%@page import="hibernate.Inmueble"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Inmueble inmueble = (Inmueble) request.getAttribute("inmueble");
    ArrayList<String> lista = new ArrayList();
    lista.add("Adosada");
    lista.add("Chalet");
    lista.add("Cortijo");
    lista.add("Local");
    lista.add("Otro");
    lista.add("Parcela");
    lista.add("Piso");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Inmueble</title>
        <link href="faces/resources/css/tabla.css" rel="stylesheet" type="text/css" />
        <link href="faces/resources/css/estilos.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div class="cabecera">
            <h1>Inmobiliaria AAD</h1>
            <h2>Editar Inmueble</h2>
        </div>
        <form action="control" method="POST">
            <div class="tabla">
                <table>
                    <tr>
                        <td colspan="2">Datos Inmueble</td>
                    </tr>
                    <tr>
                        <td><label for="id" required>Id: </label></td>
                        <td><input type="text" name="id" id="id" value="<%= inmueble.getId()%>" readonly /></td>
                    </tr>
                    <tr>
                        <td>Tipo</td>
                        <td>
                            <select name="tipo">
                                <% for (int i = 0; i < lista.size(); i++) {%>
                                <option value="<%= lista.get(i)%>" <% if (inmueble.getTipo().equals(lista.get(i))) {
                                                out.println("selected");
                                            }%>><%= lista.get(i)%></option>
                                <% }%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="calle">Calle: </label></td>
                        <td><input type="text" name="calle" id="calle" value="<%= inmueble.getCalle()%>" /></td>
                    </tr>
                    <tr>
                        <td><label for="numero">Número: </label></td>
                        <td><input type="text" name="numero" value="<%= inmueble.getNumero()%>" /></td>
                    </tr>
                    <tr>
                        <td><label for="localidad" required>Localidad: </label></td>
                        <td><input type="text" name="localidad" value="<%= inmueble.getLocalidad()%>" required/></td>
                    </tr>
                    <tr>
                        <td><label for="precio">Precio: </label></td>
                        <td><input type="number" name="precio" value="<%= inmueble.getPrecio()%>" /></td>
                    </tr>
                    <tr>
                        <td><label for="usuario" required>Usuario: </label></td>
                        <td><input type="text" name="usuario" value="<%= inmueble.getUsuario()%>" required /></td>
                    </tr>
                </table>
            </div>  
            <input type="hidden" name="target" value="inmueble" />
            <input type="hidden" name="op" value="edit" />
            <input type="hidden" name="action" value="op" />
            <div class="botones">
                <input type="submit" value="Editar" />
                <input type="reset" value="Valores Iniciales" />
                <a href="control?target=inmueble&op=select&action=view"><input type="button" value="Volver" name="volver" /></a>
            </div>
        </form>
    </body>
</html>