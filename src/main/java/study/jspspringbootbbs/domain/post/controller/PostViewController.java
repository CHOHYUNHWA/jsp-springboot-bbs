package study.jspspringbootbbs.domain.post.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/post")
public class PostViewController {

    @GetMapping("/list")
    public String getPostListForm(){
        return "/post/postListForm";
    }

    @GetMapping
    public String getPostForm(){
        return "/post/postListForm";
    }

    @GetMapping("/create")
    public String getPostCreateForm(){
        return "/post/postCreateForm";
    }

    @GetMapping("/update")
    public String getPostUpdateForm(){
        return "/post/postUpdateForm";
    }

}
