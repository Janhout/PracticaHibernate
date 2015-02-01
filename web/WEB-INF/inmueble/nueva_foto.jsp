<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Subir foto</title>
        <link href="faces/resources/css/tabla.css" rel="stylesheet" type="text/css" />
        <link href="faces/resources/css/estilos.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div class="cabecera">
            <h1>Inmobiliaria AAD</h1>
            <h2>Agregar Foto</h2>
        </div>
        <div class="cuerpo">
            <form action="control" method="post" enctype="multipart/form-data">
                <input type="file" name="archivo" required accept="image/*"/>
                <input type="hidden" name="target" value="inmueble" />
                <input type="hidden" name="op" value="foto" />
                <input type="hidden" name="action" value="op" /><br />
                <input type="hidden" name="id" value="<%= request.getParameter("id") %>" />
                <div class ="botones">
                    <input type="submit" value="Subir foto" />
                    <a href="control?target=inmueble&op=ver&action=view&id=<%= request.getParameter("id") %>"><input type="button" value="Volver" name="volver" /></a>
                </div>
            </form>
        </div>
    </body>
</html>