package com.nadri.web.cart;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nadri.service.cart.CartService;
import com.nadri.service.domain.Cart;
import com.nadri.service.domain.Spot;
import com.nadri.service.domain.User;

@Controller
@RequestMapping("/cart/*")
public class CartController {

	///Field
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	
	public CartController(){
		System.out.println(this.getClass());
	}

	//마이페이지 내 장소바구니를 보기 위한 메서드 입니다.
	@RequestMapping(value="getMyCartList")
	public String getMyCartList(Model model, HttpSession session) throws Exception{
		System.out.println("/schedule/getMyCartList : GET / POST");
		
		User user = (User)session.getAttribute("user");
		
		if(user==null) { //세션이 끊겼을 경우
			return "redirect:/";
		}
		List<Cart> list = cartService.getSpotCartList(user.getUserId());
		System.out.println("===넘어온 값===");
		System.out.println(list);
		System.out.println("===넘어온 값===");
		
		model.addAttribute("list", list);
		
		return "forward:/user/mypageCartList.jsp";
	}
}

