package com.vam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vam.mapper.BoardMapper;
import com.vam.model.BoardVO;

@Service
public class BoardServiceImpl  implements BoardService {

	
	@Autowired
	private BoardMapper mapper;
	// 스프링이 관리하는 객체(빈)은 싱글톤패턴으로 관리되어 1개의 인스턴스가 유지된다.
	//autowird를 통해서 new 생성자로 호출없이 
	@Override
    public void enroll(BoardVO board) {
        
        mapper.enroll(board);
        
    }
	
	/* 게시판 목록 */
	@Override
    public List<BoardVO> getList() {
        
        return mapper.getList();
    }
 
	
	/* 게시판 조회 */
    @Override
    public BoardVO getPage(int bno) {
         
        return mapper.getPage(bno);
    }  
    
    /* 게시판 수정 */
    @Override
    public int modify(BoardVO board) {
        
        return mapper.modify(board);
    }

 
}
