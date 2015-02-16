package modelo;

import hibernate.HibernateUtil;
import hibernate.Inmueble;
import java.math.BigInteger;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

public class ModeloInmueble {
    
    public ModeloInmueble(){
    }
    
    public static List<Inmueble> get() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        String hql = "from Inmueble";
        Query q = session.createQuery(hql);
        List<Inmueble> inmuebles = q.list();
        session.getTransaction().commit();
        session.close();
        return inmuebles;
    }
    
    public static List<Inmueble> get(String[] orden) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        String ord = "";
        for(int i = 0; i<orden.length;i++){
            ord = ord + " inm."+orden[i];
            if(i!=orden.length -1){
                ord = ord + ",";
            }
        }
        String hql = "from Inmueble inm order by" + ord;
        Query q = session.createQuery(hql);
        List<Inmueble> inmuebles = q.list();
        session.getTransaction().commit();
        session.close();
        return inmuebles;
    }

    public static Inmueble get(String id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Inmueble i = (Inmueble) session.get(Inmueble.class, Integer.parseInt(id));
        session.getTransaction().commit();
        session.close();
        return i;
    }
    
    public static void delete(String id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Inmueble i = (Inmueble) session.load(Inmueble.class, Integer.parseInt(id));
        session.delete(i);
        session.getTransaction().commit();
        session.flush();
        session.close();
    }
    
    public static long insert(Inmueble inmueble){   
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        session.save(inmueble); 
        Long lastId = ((BigInteger) session.createSQLQuery("SELECT LAST_INSERT_ID()").uniqueResult()).longValue();
        session.close();
        return lastId;
    }
    
    public static void update(Inmueble inmueble){
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        session.update(inmueble);
        session.getTransaction().commit();
        session.flush();
        session.close();
    }
}
