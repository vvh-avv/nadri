package com.nadri.service.admin.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.nadri.service.admin.AdminDao;
import com.nadri.service.domain.Inquire;
import com.nadri.service.domain.Spot;

@Repository("adminDaoImpl")
public class AdminDaoImpl implements AdminDao{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public AdminDaoImpl() {
		
	}

	@Override
	public void addInquire(Inquire inquire) {
		// TODO Auto-generated method stub
		sqlSession.insert("AdminMapper.insertInquire", inquire);
	}

	@Override
	public List<Inquire> getInquireList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("AdminMapper.getInquireList");
	}

	@Override
	public void updateInquire(Inquire inquire) {
		// TODO Auto-generated method stub
		System.out.println("get in updateInquire Dao");
		sqlSession.update("AdminMapper.updateInquire", inquire);
	}

	@Override
	public Inquire getInquire(int inquireNo) {
		// TODO Auto-generated method stub
		System.out.println("get in getInquire Dao");
		return sqlSession.selectOne("AdminMapper.getInquire", inquireNo);
	}

	@Override
	public void updateSpot(Spot spot) {
		// TODO Auto-generated method stub
		sqlSession.update("SpotMapper.updateSpot", spot);
	}

}
