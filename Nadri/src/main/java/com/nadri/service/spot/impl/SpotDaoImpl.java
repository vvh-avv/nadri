package com.nadri.service.spot.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.nadri.common.Search;
import com.nadri.service.domain.Spot;
import com.nadri.service.spot.SpotDao;

@Repository("spotDaoImpl")
public class SpotDaoImpl implements SpotDao{
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public SpotDaoImpl() {
		System.out.println(this.getClass());
	}

	/// 1. 장소리스트를 불러오는 메소드(10개만)
	@Override
	public List<Spot> getSpotList(int spotCode) throws Exception {
		return sqlSession.selectList("SpotMapper.getSpotList", spotCode);
	}
	
	// 2. 장소리스트를 보여주는 메소드(전체)
	@Override
	public List<Spot> getAllSpotList(int spotCode) throws Exception {
		return sqlSession.selectList("SpotMapper.getAllSpotList",spotCode);
	}
	
	// 3. 스크롤을 내렸을때 무한 스크롤을 만들어 주는 메소드
	@Override
	public List<Spot> infiniteScrollDown(Spot spot) throws Exception {
		return sqlSession.selectList("SpotMapper.infiniteScrollDown", spot);
	}	
	
	// 4. 장소 상세보기를 보여주는 메소드
	@Override
	public Spot getSpot(int spotNo) throws Exception {
	      return sqlSession.selectOne("SpotMapper.getSpot", spotNo);
	   }
	
	// 5. 주변 장소 정보를 가져오는 메소드
	@Override
	public List<Spot> searchAround(Spot spot) throws Exception {
		return sqlSession.selectList("SpotMapper.searchAround", spot);
	}
	
	/////////////////////////////////////////////////////////예지누나 추가!!(20180712)/////////////////////////////////////////////////////////////////
	@Override
	   public List<Spot> getSpotList() throws Exception {
	      // TODO Auto-generated method stub
	      return sqlSession.selectList("SpotMapper.listSpot");
	   }

	   @Override
	   public void deleteSpot(String spotNo) {
	      // TODO Auto-generated method stub
	      sqlSession.delete("SpotMapper.deleteSpot", Integer.parseInt(spotNo));
	   }

	   @Override
	   public void addSpot(Spot spot) {
	      // TODO Auto-generated method stub
	      sqlSession.insert("SpotMapper.addSpot", spot);
	   }
	   /////////////////////////////////////////////////////////예지누나 추가!!(20180712)/////////////////////////////////////////////////////////////////
	  
	// 6. 게시판을 클릭했을때 조회수가 1씩 증가
	@Override
	public void updateSpotReadCnt(Spot spot) throws Exception {
		sqlSession.update("SpotMapper.updateSpotReadCnt", spot);
	}
	
	// 7. 전체 장소의 갯수를 가져옵니다.
	public int getTotalSpot() throws Exception {
		return sqlSession.selectOne("SpotMapper.getTotalSpot");
	}
	
	// 8. 검색한 장소를 가져옵니다.
	public List<Spot> getSearchSpotList(Search search) throws Exception {
		return sqlSession.selectList("SpotMapper.getSearchSpotList", search);
	}
	
}