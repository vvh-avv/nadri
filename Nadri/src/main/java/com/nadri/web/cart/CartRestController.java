package com.nadri.web.cart;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.imageio.ImageIO;
import javax.xml.bind.DatatypeConverter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.nadri.service.cart.CartService;
import com.nadri.service.domain.Cart;
import com.nadri.service.domain.Comment;

//==> 장바구니 RestController
@RestController
@RequestMapping("/restcart/*")
public class CartRestController{

	///Field
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	
	public CartRestController(){
		System.out.println(this.getClass());
	}
	
	// addCartSpot을 실행하기 위한 POST 메서드 입니다.
	@RequestMapping(value="addCartSpot", method=RequestMethod.POST)
	public void addCartSpot( @RequestBody Cart cart ) throws Exception{		
		System.out.println("/restcart/addCartSpot : POST");

		System.out.println("cart : " + cart);
		
		//Business Logic
		cartService.addCartSpot(cart);
	}
	
	@RequestMapping(value="updateCart/{cartNo}/{cartDetail}", method=RequestMethod.POST)
	public void updateCart( @PathVariable int cartNo, @PathVariable String cartDetail ) throws Exception{
		System.out.println("/restcart/updateCart : POST");
		
		//한글깨져 넘어와서 추가
		cartDetail = new String(URLDecoder.decode(cartDetail,"UTF-8"));
		
		Cart cart = cartService.getCart(cartNo);
		cart.setCartDetail(cartDetail);
		
		cartService.updateCart(cart);
	}
	
	@RequestMapping(value="updateCartImg/{cartNo}", method=RequestMethod.POST)
	public String updateCartImg( @PathVariable int cartNo, @RequestBody Cart newCart) throws Exception{
		System.out.println("/restcart/updateCartImg : POST");
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyMMdd_HHmmss");
		Calendar now = Calendar.getInstance();
		String fileName = formatter.format(now.getTime())+".jpg";
		System.out.println("변경된 파일명 : "+fileName);
		
		
		//새로운 파일 생성
		String imgdata = newCart.getCartImg();
		String base64Image = imgdata.split(",")[1];
		byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(base64Image);
		BufferedImage bufImg = ImageIO.read(new ByteArrayInputStream(imageBytes));
		ImageIO.write(bufImg, "jpg", new File("C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\spot\\"+fileName));

		Cart cart = cartService.getCart(cartNo);
		
		//기존 파일 삭제
		new File("C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\spot\\"+cart.getCartImg()).delete();

		cart.setCartImg(fileName);
		cartService.updateCart(cart);
		
		System.out.println("===="+fileName);
		return fileName;
	}
	
	@RequestMapping(value="deleteCart/{cartNo}", method=RequestMethod.POST)
	public void deleteCart( @PathVariable int cartNo ) throws Exception{
		System.out.println("/restcart/deleteCart : POST");
		
		cartService.deleteCart(cartNo);
	}

   @RequestMapping(value="getCart/{cartNo}", method=RequestMethod.POST)
   public Cart getCart(@PathVariable int cartNo) throws Exception{
      System.out.println("/restcart/getCart : POST");
      
      return cartService.getCart(cartNo);
   }
}







