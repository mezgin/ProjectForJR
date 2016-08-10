package net.nolich.projectforjr.service;

import net.nolich.projectforjr.model.User;

import java.util.List;

public interface UserService {
    void addUser(User user);

    void removeUser(int id);

    User getUserById(int id);

    List<User> getUsersByName(String name);

    List<User> getUsers(Integer page);
}
