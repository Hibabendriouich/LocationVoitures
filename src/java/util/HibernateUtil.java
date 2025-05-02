package util;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.HibernateException;

public class HibernateUtil {

    private static SessionFactory sessionFactory;

    private HibernateUtil() {
    }

    public static SessionFactory getSessionFactory() {
        if (sessionFactory == null) {
            try {
                sessionFactory = new Configuration()
                        .configure("config/hibernate.cfg.xml")
                        .buildSessionFactory();
            } catch (HibernateException ex) {
                System.err.println("SessionFactory initialization failed.");
                ex.printStackTrace();
                System.err.println("Cause: " + ex.getCause());
                throw new RuntimeException("Failed to initialize Hibernate SessionFactory", ex);
            }
        }
        return sessionFactory;
    }

    public static void shutdown() {
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }
}
