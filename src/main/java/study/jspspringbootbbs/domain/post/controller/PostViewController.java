package study.jspspringbootbbs.domain.post.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/post")
public class PostViewController {

    @GetMapping("/list")
    public String getPostListForm(){
        return "/post/postListForm";
    }

    @GetMapping("/{postId}")
    public String getPostForm(@PathVariable("postId") Long postId, Model model){
        return "/post/postGetForm";
    }

    @GetMapping("/create")
    public String getPostCreateForm(){
        return "/post/postCreateForm";
    }

    @GetMapping("/{postId}/update")
    public String getPostUpdateForm(){
        return "/post/postUpdateForm";
    }
}
