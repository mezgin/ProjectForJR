package net.nolich.projectforjr.controller;

import net.nolich.projectforjr.model.User;
import net.nolich.projectforjr.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class UserController {

    private UserService userService;

    @Autowired(required = true)
    @Qualifier(value = "userService")
    public void setUserService(UserService userService) {
        this.userService = userService;
    }


    @RequestMapping(value = "users", method = RequestMethod.GET)
    public ModelAndView listOfUsers(@RequestParam(value="page", required = false) Integer page) {
        ModelAndView modelAndView = new ModelAndView("users");

        if (page == null)
            page = 1;

        List<User> users = userService.getUsers(page);
        PagedListHolder<User> pagedListHolder = new PagedListHolder<>(users);
        pagedListHolder.setPageSize(5);
        modelAndView.addObject("maxPages", pagedListHolder.getPageCount());

        if(page==null || page < 1 || page > pagedListHolder.getPageCount())page=1;

        modelAndView.addObject("user", new User());
        modelAndView.addObject("searchuser", new User());
        modelAndView.addObject("listUsers",  this.userService.getUsers(page));
        modelAndView.addObject("page", page);

        if(page == null || page < 1 || page > pagedListHolder.getPageCount()){
            pagedListHolder.setPage(0);
            modelAndView.addObject("users", pagedListHolder.getPageList());
        }
        else if(page <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(page-1);
            modelAndView.addObject("users", pagedListHolder.getPageList());
        }

        return modelAndView;
    }


    @RequestMapping(value = "/users/adduser", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("user") User user){
            this.userService.addUser(user);

        return "redirect:/users";
    }

    @RequestMapping("/remove/{id}")
    public String removeUser(@PathVariable("id") int id){
        this.userService.removeUser(id);

        return "redirect:/users";
    }

    @RequestMapping("edit/{id}")
    public String editUser(@PathVariable("id") int id, @RequestParam(value="page", required = false) Integer page, Model model){
        if (page == null)
            page = 1;
        model.addAttribute("user", this.userService.getUserById(id));
        model.addAttribute("searchuser", new User());
        model.addAttribute("listUsers", this.userService.getUsers(page));
        model.addAttribute("page", page);

        return "users";
    }

    @RequestMapping("userdata/{id}")
    public String userData(@PathVariable("id") int id, Model model) {
        model.addAttribute("user", this.userService.getUserById(id));

        return "userdata";
    }

    @RequestMapping(value="searchresults", method = RequestMethod.POST)
    public String searchResults(@ModelAttribute("searchuser") User user, Model model ) {
        List<User> searchResult;
        searchResult = userService.getUsersByName(user.getName());
        model.addAttribute("listUsers", searchResult);

        return "searchresults";
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        simpleDateFormat.setLenient(true);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(simpleDateFormat, true));
    }
}
