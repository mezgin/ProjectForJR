package net.nolich.projectforjr.dao;


import net.nolich.projectforjr.model.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDaoImpl implements UserDao {
    private static final int LIMIT_RESULT_USERS_PER_PAGE = 10;

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void addUser(User user) {
        Session session = this.sessionFactory.getCurrentSession();
        session.saveOrUpdate(user);
    }

    @Override
    public void removeUser(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        User user = (User) session.load(User.class, new Integer(id));
        if (user != null) {
            session.delete(user);
        }
    }

    @Override
    public User getUserById(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        User user = (User) session.load(User.class, new Integer(id));

        return user;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<User> getUsersByName(String name) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM User WHERE name = :name");
        query.setParameter("name", name);
        List<User> users = query.list();


        return users;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<User> getUsers(Integer page) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM User");
        query.setFirstResult((int)(page - 1) * LIMIT_RESULT_USERS_PER_PAGE);
        query.setMaxResults(LIMIT_RESULT_USERS_PER_PAGE);
        List<User> users = query.list();

        return users;
    }
}
