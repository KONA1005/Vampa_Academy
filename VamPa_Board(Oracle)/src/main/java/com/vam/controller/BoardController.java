package com.vam.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board/*") // board 뒤에 어떤 요청이 들어와도 받겠다 
public class BoardController {
	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
	
	@GetMapping("/list")
	public void boardListGET() {
		log.info("게시판 목록 페이지 진입");
		
	}
	/*public String boardListGET() {
		log.info("게시판 목록 페이지 진입");
		return list;  와 같다 위에 쟤랑 */ 
		/* /WEB-INF/view/list.jsp 이놈을 통해서 접근. 리턴을 받은거~
	}  */ 
	
	
	@GetMapping("/enroll")
	public void boardEnrollGET() {
        
        log.info("게시판 등록 페이지 진입");
        
    }
	
	@GetMapping("/custom")
	public void boardCustomGET() {
		log.info("커스텀페이지 진입");
	}
	 
}
