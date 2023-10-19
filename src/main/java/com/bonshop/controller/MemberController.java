package com.bonshop.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bonshop.service.MemberService;
import com.bonshop.vo.MemberVO;

import pwdchange.pwdChange;

@Controller
@RequestMapping(value="/member/*")
public class MemberController {
	
	@Autowired
	private MemberService memberService;

	
	/*로그인 기능*/
	
	//로그인 페이지 입력 받기 전
	@RequestMapping(value="/login", method=RequestMethod.GET)
	   public String login() {
		System.out.println("login (GET) 메서드 동작");
			
	      return "member/login";
	   }
	
	//로그인 기능 구현
		@RequestMapping(value="/login",method=RequestMethod.POST)
		public ModelAndView login(@RequestParam("m_id") String m_id, @RequestParam("m_pwd") String m_pwd, 
				HttpSession session, RedirectAttributes rttr) {
			System.out.println("login (POST) 메서드 동작");
			ModelAndView model = new ModelAndView();
			
			// 데이터베이스에서 해당 사용자 정보 조회
	        MemberVO memberInfo = memberService.getMemberInfo(m_id);
	        System.out.println("회원정보 : "+ memberInfo);
	        
	        
	        //로그인을 할때 
	        
	        //관리자 계정일 경우
	        if(m_id.equals("admin01") && 
	        		memberInfo != null && 
	        		memberInfo.getM_pwd().equals(pwdChange.getPassWordToXEMD5String(m_pwd))) {
	        	
	        	System.out.println("관리자 계정 로그인 시도");
	        	
	        	model.setViewName("redirect:/admin");
	        	return model;
	        
	        //테스트용 계정 개발완료후 코드삭제예정
	        }else if (
	        		m_id.equals("z") &&
	        		memberInfo != null && 
	        		memberInfo.getM_pwd().equals(memberInfo.getM_pwd())) {	//아이디 정보의 비밀번호를 비교
	            // 로그인 성공
	        	System.out.println("로그인 성공");
	        	session.setAttribute("logined", memberInfo);	//사용자의 정보를 세션에 저장
	        	rttr.addFlashAttribute("message", "안녕하세요! " + memberInfo.getM_name() + "님 환영합니다.");
	        	model.setViewName("redirect:/");
	            return model; // 로그인 후 메인 페이지로 이동
	            
	        //일반 계정일 경우
	        }else if (memberInfo != null && 
	        		memberInfo.getM_pwd().equals(pwdChange.getPassWordToXEMD5String(m_pwd))) {	//아이디 정보의 비밀번호를 비교
	            // 로그인 성공
	        	System.out.println("로그인 성공");
	        	session.setAttribute("logined", memberInfo);	//사용자의 정보를 세션에 저장
	        	rttr.addFlashAttribute("message", "안녕하세요! " + memberInfo.getM_name() + "님 환영합니다.");
	        	model.setViewName("redirect:/");
	            return model; // 로그인 후 메인 페이지로 이동
	        } else {
	            // 로그인 실패
	        	System.out.println("로그인 실패");
	        	model.addObject("message", "아이디 또는 비밀번호를 다시 확인해주세요.");
	        	model.setViewName("/member/login");
	            return model; // 로그인 페이지로 돌아감
	        }
		}
		
		
		/* 로그아웃 */
	    @PostMapping("/logout")
	    public String logout(HttpSession session) {
	        session.invalidate(); // 세션 제거
	        return "redirect:/";  // 홈 페이지로 리다이렉트
	    }
	
		
		
		
		/*회원가입 코드*/
		
		//회원가입 페이지
		@RequestMapping(value="/sign", method=RequestMethod.GET)
		public void sign() {
			System.out.println("sign(GET) 메서드 동작");
		}
		
		
		//회원가입 페이지 (클라이언트에게 입력 받은 후)
		@ResponseBody
		@RequestMapping(value="/sign", method=RequestMethod.POST)
		public Map<String, Object> sign(@RequestBody MemberVO memberInfo) {
		    System.out.println("sign(POST) 메서드 동작");
		    Map<String, Object> map = new HashMap<>();
		    System.out.println("클라이언트가 입력한 정보:" +memberInfo);
		    
		    
		    //데이터베이스에 추가 10-18일 여기까지 작업 데이터베이스에 정보 들어가면 그때 true가 반환되게 수정해야함
		    memberInfo.setM_pwd(pwdChange.getPassWordToXEMD5String(memberInfo.getM_pwd()));	//비번 암호화
		    this.memberService.addMember(memberInfo);

		    // 회원가입 로직 처리 (예: 서비스 또는 DAO를 통해 DB에 저장)
		    boolean isSuccessful = true; // 여기서는 예로 true를 사용. 실제 로직에 따라 변경해야 함.

		    if (isSuccessful) {
		    	map.put("status", "true");
		    	map.put("message", "안녕하세요! "+memberInfo.getM_name()+"님 반갑습니다 !");
		        System.out.println("가입성공");
		    } else {
		    	map.put("status", "false");
		    	map.put("message", "오류로 인해 가입에 실패했습니다. 다시 시도해주세요");
		        System.out.println("가입실패");
		    }
		    return map;
		}

		
		//중복아이디 검증
		@PostMapping("/member_idcheck")
	    public void member_idcheck(@RequestParam String m_id, HttpServletResponse response)
	    throws Exception{
			System.out.println("member_idcheck 메서드 동작");
	    	response.setContentType("text/html;charset=UTF-8");
	    	
	    	//DB에서 클라이언트가 입력한 ID가 존재하는지 검색
	    	MemberVO memberInfo = this.memberService.getMemberInfo(m_id);
	    	
	    	int re=-1;
	    	if(memberInfo != null) { //검색한 아이디가 있으면 1을 반환(중복)
	    		re=1;
	    	}
	    	
	    }//member_idcheck()
		
		
		
		
		/*마이 페이지*/
		@RequestMapping(value="/myPage")
		public void myPage() {}
		
		
		
		
		
		
		
		
		
		
		
		
}
