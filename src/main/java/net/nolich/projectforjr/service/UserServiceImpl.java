package net.nolich.projectforjr.service;


import net.nolich.projectforjr.dao.UserDao;
import net.nolich.projectforjr.model.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserServiceImpl implements UserService{
    private UserDao userDao;

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    @Transactional
    public void addUser(User user) {
        this.userDao.addUser(user);

    }

    @Override
    @Transactional
    public void removeUser(int id) {
        this.userDao.removeUser(id);

    }

    @Override
    @Transactional
    public User getUserById(int id) {
        return this.userDao.getUserById(id);
    }

    @Override
    @Transactional
    public List<User> getUsersByName(String name) {
        return this.userDao.getUsersByName(name);
    }

    @Override
    @Transactional
    public List<User> getUsers(Integer page) {
        return this.userDao.getUsers(page);
    }
}
