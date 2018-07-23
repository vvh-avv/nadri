package com.nadri.service.spot.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.common.Search;
import com.nadri.service.domain.Spot;
import com.nadri.service.spot.SpotDao;
import com.nadri.service.spot.SpotService;

@Service("spotServiceImpl")
public class SpotServiceImpl implements SpotService{

	///Field
	@Autowired
	@Qualifier("spotDaoImpl")

	private SpotDao spotDao;
	
	///Method
	public void setSpotDao(SpotDao spotDao) {
		this.spotDao=spotDao;
	}
	
	///Constructor
	public SpotServiceImpl() {
		System.out.println(this.getClass());
	}
	
	// 1. 장소 10개를 보여주는 메소드
	@Override
	public List<Spot> getSpotList(int spotCode) throws Exception {
		return spotDao.getSpotList(spotCode);
	}
	
	// 2. 장소 전체 보여주는 메소드
	@Override
	public List<Spot> getAllSpotList(int spotCode) throws Exception {
		return spotDao.getAllSpotList(spotCode);
	}

	// 3 스크롤을 내렸을때 무한 스크롤을 만들어 주는 메소드
	@Override
	public List<Spot> infiniteScrollDown(Spot spot) throws Exception {
		return spotDao.infiniteScrollDown(spot);
	}
	
	// 4. 장소 상세보기를 보여주는 메소드
	@Override
	   public Spot getSpot(int spotNo) throws Exception {
	      return spotDao.getSpot(spotNo);
	 }
	
	// 5. 주변 장소 정보를 가져오는 메소드
	@Override
	public List<Spot> searchAround(Spot spot) throws Exception {
		return spotDao.searchAround(spot);
	}
	
	/////////////////////////////////////////////////////////예지누나 추가!!(20180712)/////////////////////////////////////////////////////////////////
	@Override
	   public List<Spot> getSpotList() throws Exception {
	      // TODO Auto-generated method stub
	      return spotDao.getSpotList();
	   }

	   @Override
	   public void deleteSpot(String spotNo) {
	      // TODO Auto-generated method stub
	      spotDao.deleteSpot(spotNo);
	   }

	   @Override
	   public void addSpot(Spot spot) {
	      // TODO Auto-generated method stub
	      spotDao.addSpot(spot);
	   }
	   /////////////////////////////////////////////////////////예지누나 추가!!(20180712)/////////////////////////////////////////////////////////////////

	// 6. 게시판을 클릭했을때 조회수가 1씩 증가
	@Override
	public void updateSpotReadCnt(Spot spot) throws Exception {
		spotDao.updateSpotReadCnt(spot);
	}
	
	// 7. 전체 장소의 갯수를 가져옵니다.
	public int getTotalSpot() throws Exception {
		return spotDao.getTotalSpot();
	}
	
}
