package com.vam.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vam.model.BoardVO;
import com.vam.model.Criteria;
import com.vam.model.PageMakerDTO;
import com.vam.service.BoardService;

@Controller
@RequestMapping("/board/*") // board 뒤에 어떤 요청이 들어와도 받겠다
public class BoardController {
	private static final Logger log = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardService bservice;

	/*  게시판 목록 페이지 접속 */
//	@GetMapping("/list") public void boardListGET(Model model) {
//	 * log.info("게시판 목록 페이지 진입"); model.addAttribute("list", bservice.getList()); }
//	public String boardListGET() { log.info("게시판 목록 페이지 진입");
//	return list; 와 같다
//  위에 쟤랑 /WEB-INF/view/list.jsp 이놈을 통해서 접근. 리턴을 받은거~
	 
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

	/* 게시판 조회 */
	@GetMapping("/get")
	public void boardGetPageGET(int bno, Model model) {

		model.addAttribute("pageInfo", bservice.getPage(bno));

	}

	/* 수정 페이지 이동 */
	/*
	 * 조회 페이지 이동 메소드와 동일. 수정하고자 하는 게시판의 내용을 출력해야 하기 때문. 따라서 int형 파라미터와 해당 게시판의 내용을
	 * 호출하는 Service메소드(getPage())를 호출.
	 */
	@GetMapping("/modify")
	public void boardModifyGET(int bno, Model model) {

		model.addAttribute("pageInfo", bservice.getPage(bno));

	}

	/* 글 수정 */
	/*
	 * 수정 기능 실행 후 리다이렉트 방식으로 리스트 페이지 이동시 데이터를 같이 전송하기 위해 RedircAttributes 객체 파라미터로
	 * 부여. 리스트페이지(list.jsp)이동시 수정이 완료되었음을 알리는 경고창 띄우기 위해 "mpdify success"스트링 데이터를
	 * "result"속성 값에 저장하는 addFlashAttrivute()메소드 호출 리턴타입 String. 리다이렉트(Redirect)방식으로
	 * 리스트 페이지 이동 하도록 작성.
	 */
	@PostMapping("/modify")
	public String boardModifyPOST(BoardVO board, RedirectAttributes rttr) {

		bservice.modify(board);

		rttr.addFlashAttribute("result", "modify success");

		return "redirect:/board/list";

	}

	/* 페이지 삭제 */
	@PostMapping("/delete")
	public String boardDeletePOST(int bno, RedirectAttributes rttr) {

		bservice.delete(bno);

		rttr.addFlashAttribute("result", "delete success");

		return "redirect:/board/list";
	}

	/*
	 * 게시판 목록 페이지 접속(페이징 적용)
	 * 
	 * @GetMapping("/list") public void boardListGET(Model model, Criteria cri) {
	 * 
	 * log.info("boardListGET");
	 * 
	 * model.addAttribute("list", bservice.getListPaging(cri));
	 * 
	 * }
	 */

	/* 게시판 목록 페이지 접속(페이징 적용) */
	@GetMapping("/list")
	public void boardListGET(Model model, Criteria cri) {
		log.info("게시판 목록 페이지 진입"); 
		model.addAttribute("list", bservice.getListPaging(cri));
		int total = bservice.getTotal();
		PageMakerDTO pageMake = new PageMakerDTO(cri, total);
		model.addAttribute("pageMaker", pageMake);
		// /WEB-INF/view/list.jsp 이놈을 통해서 접근. 리턴을 받은거~
	}

}
