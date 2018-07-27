package com.nadri.service.cart;

import java.util.List;

import com.nadri.common.Search;
import com.nadri.service.domain.Cart;

public interface CartService {
	
	// 1. cart에 장소를 등록하는 메서드
	public void addCartSpot(Cart cart) throws Exception; 
	
	// 2. spot Cart를 가져오는 메서드
	public List<Cart> getSpotCartList(String userId) throws Exception;

	public void deleteCart(int cartNo) throws Exception;

	public void updateCart(Cart cart) throws Exception;

	public Cart getCart(int cartNo) throws Exception;

}
