package com.nadri.service.cart.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.nadri.common.Search;
import com.nadri.service.cart.CartDao;
import com.nadri.service.domain.Cart;

@Repository("cartDaoImpl")
public class CartDaoImpl implements CartDao{
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public CartDaoImpl() {
		System.out.println(this.getClass());
	}
	
	// 1. cart에 장소를 등록하는 메서드
	@Override
	public void addCartSpot(Cart cart) throws Exception {
		sqlSession.insert("CartMapper.addCartSpot", cart);
	}

	// 2. spot Cart를 가져오는 메서드
	@Override
	public List<Cart> getSpotCartList(Search search) throws Exception {
		return sqlSession.selectList("CartMapper.getSpotCartList", search);
	}

}
