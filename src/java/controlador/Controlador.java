package controlador;

import hibernate.Inmueble;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import modelo.ModeloInmueble;

@WebServlet(name = "Controlador", urlPatterns = {"/control"})
@MultipartConfig
public class Controlador extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String destino = "index.html";
        boolean forward = false;
        String target, op, action;

        target = request.getParameter("target");
        op = request.getParameter("op");
        action = request.getParameter("action");

        if (target != null && op != null && action != null) {
            if (target.equals("inmueble") && op.equals("select") && action.equals("view")) {
                forward = true;
                destino = "WEB-INF/inmueble/datos.jsp";
                String orden = request.getParameter("order");
                if(orden!=null){
                    request.setAttribute("datos", ModeloInmueble.get(new String[]{orden}));
                } else{
                    request.setAttribute("datos", ModeloInmueble.get());   
                }
            } else if (target.equals("inmueble") && op.equals("delete") && action.equals("view")) {
                forward = true;
                destino = "WEB-INF/inmueble/delete.jsp";
                request.getParameter("id");
                request.setAttribute("inmueble", ModeloInmueble.get(request.getParameter("id")));
            } else if (target.equals("inmueble") && op.equals("delete") && action.equals("op")) {
                forward = false;
                destino = "control?target=inmueble&op=select&action=view";
                ModeloInmueble.delete(request.getParameter("id"));
                borrarFotos(request.getParameter("id"));
            } else if (target.equals("inmueble") && op.equals("insert") && action.equals("view")) {
                forward = true;
                destino = "WEB-INF/inmueble/insert.jsp";
            } else if (target.equals("inmueble") && op.equals("insert") && action.equals("op")) {
                forward = false;
                destino = "control?target=inmueble&op=select&action=view";
                ModeloInmueble.insert(devolverInmueble(request));
            } else if (target.equals("inmueble") && op.equals("edit") && action.equals("view")) {
                forward = true;
                destino = "WEB-INF/inmueble/edit.jsp";
                request.getParameter("id");
                request.setAttribute("inmueble", ModeloInmueble.get(request.getParameter("id")));
            } else if (target.equals("inmueble") && op.equals("edit") && action.equals("op")) {
                forward = false;
                destino = "control?target=inmueble&op=select&action=view";
                ModeloInmueble.update(devolverInmueble(request));
            } else if (target.equals("inmueble") && op.equals("foto") && action.equals("view")) {
                forward = true;
                destino = "WEB-INF/inmueble/nueva_foto.jsp";
                request.setAttribute("id", request.getParameter("id"));
            } else if (target.equals("inmueble") && op.equals("foto") && action.equals("op")) {
                forward = false;
                destino = "control?target=inmueble&op=ver&action=view&id=" + request.getParameter("id");
                subirFoto(request);
            } else if (target.equals("inmueble") && op.equals("ver") && action.equals("view")) {
                forward = true;
                destino = "WEB-INF/inmueble/ver_fotos.jsp";
                request.setAttribute("inmueble", ModeloInmueble.get(request.getParameter("id")));
            }
        }

        if (forward) {
            request.getRequestDispatcher(destino).forward(request, response);
        } else {
            response.sendRedirect(destino);
        }
    }

    private void subirFoto(HttpServletRequest request) {
        boolean error = false;
        String id = request.getParameter("id");
        InputStream fileContent = null;
        try {
            Part filePart = request.getPart("archivo");
            fileContent = filePart.getInputStream();
            String nombre = conseguirNombre(id);
            if(filePart.getContentType().contains("png")){
                nombre = nombre + ".png";
            } else if(filePart.getContentType().contains("jpeg")){
                nombre = nombre + ".jpg";
            } else if(filePart.getContentType().contains("gif")){
                nombre = nombre + ".gif";
            }
            String destino = getServletContext().getRealPath("") + File.separator + "subido" + File.separator + id + File.separator;
            File carpeta = new File(destino);
            if(!carpeta.exists()){
                carpeta.mkdirs();
            }
            byte[] array = new byte[1000];
            FileOutputStream fos = new FileOutputStream(destino + nombre);
            try {
                int leido = fileContent.read(array);
                while (leido > 0) {
                    fos.write(array, 0, leido);
                    leido = fileContent.read(array);
                }
            } catch (Exception e) {
                error = true;
            } finally {
                fos.close();
            }
        } catch (Exception e) {
            error = true;
        } finally {
            try {
                fileContent.close();
            } catch (Exception e) {
                error = true;
            }
        }
    }

    private void borrarFotos(String id) {
        //String directorio = getServletContext().getRealPath("/") + "subido/" + id + "/";
        String directorio = getServletContext().getRealPath("")+File.separator+ "subido"+File.separator+ id + File.separator;
       
        File f = new File(directorio);
        System.out.println(f.exists()+"********************************************"+f.getAbsolutePath());
        if (f.exists()) {
    
            File[] ficheros = f.listFiles();
            for (int i = 0; i < ficheros.length; i++) {
                ficheros[i].delete();
            }
        }
        f.delete();
    }

    private String conseguirNombre(String id) {
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy_MM_dd_hh_mm_ss");
        String fecha = formatoFecha.format(new Date());
        return "inmueble_" + id + "_" + fecha;
    }

    private Inmueble devolverInmueble(HttpServletRequest request) {
        Inmueble inmueble = new Inmueble();
        inmueble.setLocalidad(request.getParameter("localidad"));
        inmueble.setCalle(request.getParameter("calle"));
        inmueble.setNumero(request.getParameter("numero"));
        inmueble.setUsuario(request.getParameter("usuario"));
        String p = request.getParameter("precio");
        int precio;
        try {
            precio = Integer.parseInt(p);
        } catch (NumberFormatException e) {
            precio = 0;
        }
        inmueble.setPrecio(precio);
        inmueble.setTipo(request.getParameter("tipo"));
        String i = request.getParameter("id");
        int id;
        try {
            id = Integer.parseInt(i);
        } catch (NumberFormatException e) {
            id = 0;
        }
        inmueble.setId(id);
        return inmueble;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
