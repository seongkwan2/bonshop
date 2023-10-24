package com.bonshop.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bonshop.service.MemberService;
import com.bonshop.vo.MemberRole;
import com.bonshop.vo.MemberVO;
import com.bonshop.vo.ZipCodeVO;
import com.bonshop.vo.ZipcodeVO2;

@Controller
@RequestMapping(value="/member/*")
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired //비밀번호 암호화 의존성 추가
	private PasswordEncoder passwordEncoder;

	//회원가입 폼
	@RequestMapping(value="/sign", method=RequestMethod.GET)
	public ModelAndView sign() {
		System.out.println("sign() GET 동작");
		ModelAndView mv =new ModelAndView();

		mv.setViewName("member/sign");//뷰페이지 경로(뷰리졸브 경로)=> /WEB-INF/views/member/
		//member_Join.jsp
		return mv;
	}//sign()


	//중복아이디 검증
	@PostMapping("/member_idcheck")
	public void member_idcheck(@RequestParam String m_id, HttpServletResponse response)
			throws Exception{
		System.out.println("member_idcheck 메서드 동작");
		response.setContentType("text/html;charset=UTF-8");

		//DB에서 클라이언트가 입력한 ID가 존재하는지 검색
		MemberVO memberInfo = this.memberService.idCheck(m_id);

		int re=-1;
		if(memberInfo != null) { //검색한 아이디가 있으면 1을 반환(중복)
			re=1;
		}
	}//member_idcheck()


	//우편주소 검색 공지창
	@RequestMapping("/zip_find")
	public ModelAndView zip_find() {
		ModelAndView zm=new ModelAndView();
		zm.setViewName("member/zip_find");
		return zm;
	}//zip_find()


	//우편주소 검색 결과
	@RequestMapping("/zip_find_ok")
	public ModelAndView zip_find_ok(String dong) {
		List<ZipCodeVO> zlist=this.memberService.zipFind("%"+dong+"%");//%는 검색할 때 사용하는 와일드카드
		//sql 연산자로 하나이상의 임의의 모르는 문자와 매핑 대응한다.

		List<ZipcodeVO2> zlist2=new ArrayList<>();

		for(ZipCodeVO z:zlist) {
			ZipcodeVO2 z2=new ZipcodeVO2();

			z2.setZipcode(z.getZipcode());//우편번호 저장
			z2.setAddr(z.getSido()+" "+z.getGugun()+" "+z.getGil());//시도 구군 동을 저장

			zlist2.add(z2);//컬렉션에 우편번호와 주소를 추가
		}

		ModelAndView zm=new ModelAndView("member/zip_find");
		zm.addObject("zipcodelist",zlist2);
		zm.addObject("dong",dong);
		return zm;
	}//zip_find_ok()

	
	//회원저장
	@RequestMapping(value="/sign", method=RequestMethod.POST)
	@ResponseBody //JSON타입으로 다시 ajax에 접근하기 위한 방법
	public Map<String, Object> sign(@RequestBody MemberVO m) {
	    Map<String, Object> map = new HashMap<>();

	    System.out.println("sign(POST) 메서드 동작");
	    System.out.println("입력한 값들 출력 : "+ m);

	    try {
	        // 1. 기본 권한 설정
	        MemberRole defaultRole = new MemberRole();	//권한 테이블 소환
	        defaultRole.setRoleName("ROLE_USER");		//권한 테이블에 ROLE_USER이라는 권한 생성
	        List<MemberRole> roles = new ArrayList<>();
	        roles.add(defaultRole);
	        m.setRoles(roles);							//클라이언트의 아이디에 ROLE_USER권한 부여
	        System.out.println("권한 목록 :"+m.getRoles().toString());

	        m.setM_pwd(passwordEncoder.encode(m.getM_pwd())); //비번 암호화
	        this.memberService.insertMember(m); //회원저장

	        map.put("status", "success");
	        map.put("message", "가입 성공");
	        
	    } catch (Exception e) {
	    	e.printStackTrace();
	    	map.put("status", "error");
	    	map.put("message", "가입 실패: " + e.getMessage());
	    }
	    System.out.println("map의값 : " + map);
		return map;
	}





	/*마이 페이지*/
	@RequestMapping(value="/myPage")
	public void myPage() {}

}
