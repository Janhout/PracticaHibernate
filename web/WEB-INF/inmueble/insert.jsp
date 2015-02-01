<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% ArrayList<String> lista = new ArrayList();
    lista.add("Adosada");
    lista.add("Chalet");
    lista.add("Cortijo");
    lista.add("Local");
    lista.add("Otro");
    lista.add("Parcela");
    lista.add("Tipo");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insertar Inmueble</title>
        <link href="faces/resources/css/tabla.css" rel="stylesheet" type="text/css" />
        <link href="faces/resources/css/estilos.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div class="cabecera">
            <h1>Inmobiliaria AAD</h1>
            <h2>Insertar Inmueble</h2>
        </div>
        <form action="control" method="POST">
            <div class="tabla">
                <table>
                    <tr>
                        <td colspan="2">Datos Inmueble</td>
                    </tr>
                    <tr>
                        <td>Tipo</td>
                        <td>
                            <select name="tipo">
                                <% for (int i = 0; i < lista.size(); i++) {%>
                                <option value="<%= lista.get(i)%>"><%= lista.get(i)%></option>
                                <% }%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="calle">Calle: </label></td>
                        <td><input type="text" name="calle" id="calle" value=""/></td>
                    </tr>
                    <tr>
                        <td><label for="numero">Número: </label></td>
                        <td><input type="text" name="numero" value="" /></td>
                    </tr>
                    <tr>
                        <td><label for="localidad" required>Localidad: </label></td>
                        <td><input type="text" name="localidad" value="" required/></td>
                    </tr>
                    <tr>
                        <td><label for="precio">Precio: </label></td>
                        <td><input type="number" name="precio" value="" /></td>
                    </tr>
                    <tr>
                        <td><label for="usuario" required>Usuario: </label></td>
                        <td><input type="text" name="usuario" value="" required /></td>
                    </tr>
                </table>
            </div>      

            <input type="hidden" name="id" value="0" />
            <input type="hidden" name="target" value="inmueble" />
            <input type="hidden" name="op" value="insert" />
            <input type="hidden" name="action" value="op" />
            <div class="botones">
                <input type="submit" value="Insertar" />
                <a href="control?target=inmueble&op=select&action=view"><input type="button" value="Volver" name="volver" /></a>
            </div>
        </form>
    </body>
</html>
