package com.vam.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vam.model.BoardVO;
import com.vam.service.BoardService;

@Controller
@RequestMapping("/board/*") // board 뒤에 어떤 요청이 들어와도 받겠다 
public class BoardController {
	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
	
	  @Autowired
	    private BoardService bservice;
	
	/* 게시판 목록 페이지 접속 */
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
	// 커스텀페이지 만들기
	@GetMapping("/custom")
	public void boardCustomGET() {
		log.info("커스텀페이지 진입");
	}
	
	/* 게시판 등록처리 */
	  @PostMapping("/enroll")
	    public String boardEnrollPOST(BoardVO board, RedirectAttributes rttr) {
	        /* RedirectAttributes 에 addFlashAttribute함수는, 일회성으로만 데이터를 전달하기 위함 */
	        log.info("BoardVO : " + board);
	        
	        bservice.enroll(board);
	        rttr.addFlashAttribute("result", "enrol success");
	        return "redirect:/board/list"; // redirect = 지금 가지고 있는 데이터를 다 없애는거
	        
	    }
	 
}
