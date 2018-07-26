package com.nadri.web.schedule;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
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
		
		// 파일 객체 생성
		File file = new File("C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\spot\\uploadFiles\\"+fileName);
		
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
   public String getMyScheduleList(Model model, HttpSession session) throws Exception{
      System.out.println("/schedule/getMyScheduleList : GET / POST");
      
      User user = (User)session.getAttribute("user");
      
      if(user==null) { //세션이 끊겼을 경우
         return "redirect:/";
      }
      List<Schedule> list = scheduleService.getMyScheduleList(user.getUserId());
      
      model.addAttribute("list", list);
      
      return "forward:/user/mypageScheduleList.jsp";
   }
	
}