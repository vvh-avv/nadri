package com.nadri.web.schedule;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.nadri.common.Page;
import com.nadri.common.Search;
import com.nadri.service.cart.CartService;
import com.nadri.service.domain.Schedule;
import com.nadri.service.domain.User;
import com.nadri.service.domain.WayPoint;
import com.nadri.service.schedule.ScheduleService;

//==> 일정과 관련된 메서드 Controller
@Controller
@RequestMapping("/schedule/*")
public class ScheduleController {
		
	///Field
	@Autowired
	@Qualifier("scheduleServiceImpl")
	private ScheduleService scheduleService;
	
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;

	public ScheduleController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	int pageSize = 6;
	
	
	// addSchedule에 접근하기 위한 GET 메서드 입니다.
	@RequestMapping( value="addSchedule", method=RequestMethod.GET)
	public String addSchedule(Model model, HttpSession session, @ModelAttribute("user") User user, @ModelAttribute("search") Search search ) throws Exception{
		
		System.out.println( "/addSchedule : GET");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		
		// 세션에서 userId 를 가져옵니다!
		String userId=((User) session.getAttribute("user")).getUserId();
		
		// model에 담습니다!
		model.addAttribute("cart", cartService.getSpotCartList(userId));
		
		return "forward:/schedule/addSchedule.jsp";
	}
	
	// addSchedule을 실행하기 위한 POST 메서드 입니다.
	@RequestMapping( value="addSchedule",  method=RequestMethod.POST)
	public String addSchedule(Model model , @ModelAttribute WayPoint waypoint , @ModelAttribute Schedule schedule, @RequestParam("file") MultipartFile multipartFile, HttpSession session) throws Exception{
		
		System.out.println( "/addSchedule : POST");
		
		// 파일명 얻기
		String fileName = multipartFile.getOriginalFilename();
		System.out.println("=======================");
		System.out.println("======================="+waypoint.getWayPointImg());
		
		// 파일 객체 생성
		File file = new File("C:\\Users\\Bit\\git\\nadri\\Nadri\\WebContent\\images\\spot\\uploadFiles\\"+fileName);
		
		multipartFile.transferTo(file);
		
		//Business Logic
		schedule.setScheduleImg(fileName);
		
		// 일정 등록하는 부분
		scheduleService.addSchedule(schedule);
		
		
		// 경유지 등록하는 부분
		for(int i = 0; i < schedule.getWayPoints().size() ; i++) {
			System.out.println("시작되는중 번호 :"+i);
			schedule.getWayPoints().get(i).setWayPointNo(i);
			scheduleService.addWayPoint(schedule.getWayPoints().get(i));
			scheduleService.updateHashTag(schedule.getWayPoints().get(i).getWayPointTitle());
		}
		return "forward:/index.jsp";
	}
	
	// getSchedule을 실행하기 위한 GET 메서드 입니다.
	@RequestMapping( value="getSchedule",  method=RequestMethod.GET)
	public String getSchedule(@RequestParam("scheduleNo") int scheduleNo, Model model) throws Exception{
		
		System.out.println( "/getSchedule");

		// Model 과 View 연결
		model.addAttribute("schedule", scheduleService.getSchedule(scheduleNo));
		model.addAttribute("waypoint", scheduleService.getWayPoint(scheduleNo));
		
		return "forward:/schedule/getSchedule.jsp";
	}
	
	//마이페이지 내 일정을 보기 위한 메서드 입니다.
   @RequestMapping(value="getMyScheduleList")
   public String getMyScheduleList(Model model, HttpSession session, @ModelAttribute("search") Search search) throws Exception{
      System.out.println("/schedule/getMyScheduleList : GET / POST");
      
      User user = (User)session.getAttribute("user");
        	
      if(user==null) { //세션이 끊겼을 경우
         return "redirect:/";
      }
     
        //페이지네비게이션 해주는 logic..
	  	if(search.getCurruntPage() <= 1 ){
			search.setCurruntPage(0);
			search.setStartRowNum(0);
		}else {
			search.setStartRowNum((search.getCurruntPage()-1)*pageSize);
		}
		search.setPageSize(pageSize);
	     
		search.setUserId(user.getUserId());

	      // Business logic 수행
	      Map<String, Object> map = scheduleService.getMyScheduleList(search);
	      
		Page resultPage = new Page( search.getCurruntPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, 6);
		System.out.println(resultPage);

		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
				
      return "forward:/user/mypageScheduleList.jsp";
   }
   
   // updateSchedule을 실행하기 위한 GET 메서드 입니다.
	@RequestMapping( value="updateSchedule",  method=RequestMethod.GET)
	public String updateSchedule(@RequestParam("scheduleNo") int scheduleNo, Model model) throws Exception{
		
		System.out.println( "/updateSchedule : GET");

		// Model 과 View 연결
		model.addAttribute("schedule", scheduleService.getSchedule(scheduleNo));
		model.addAttribute("waypoint", scheduleService.getWayPoint(scheduleNo));
		
		return "forward:/schedule/updateSchedule.jsp";
	}
	
	// updateSchedule을 실행하기 위한 GET 메서드 입니다.
	@RequestMapping( value="updateSchedule",  method=RequestMethod.POST)
	public String updateSchedule(Model model , @ModelAttribute WayPoint waypoint , @ModelAttribute Schedule schedule, @RequestParam("file") MultipartFile multipartFile, HttpSession session) throws Exception{
		
		System.out.println( "/updateSchedule : POST");
		
		// 파일명 얻기
		String fileName = multipartFile.getOriginalFilename();
		
		// 파일 객체 생성
		File file = new File("C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\spot\\uploadFiles\\"+fileName);
		
		multipartFile.transferTo(file);
		
		//Business Logic
		schedule.setScheduleImg(fileName);
		
		// 일정 등록하는 부분
		scheduleService.addSchedule(schedule); //업데이트 schedule이들어갑니다.
		
		
		// 경유지 등록하는 부분
		for(int i = 0; i < schedule.getWayPoints().size() ; i++) {
			System.out.println("시작되는중 번호 :"+i);
			scheduleService.addWayPoint(schedule.getWayPoints().get(i)); // 업데이트 waypoint로 바꿉니다.
			scheduleService.updateHashTag(schedule.getWayPoints().get(i).getWayPointTitle());
		}
		return "forward:/index.jsp";
	}
}