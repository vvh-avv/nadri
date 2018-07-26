package com.nadri.web.cart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nadri.service.cart.CartService;

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
	
}

