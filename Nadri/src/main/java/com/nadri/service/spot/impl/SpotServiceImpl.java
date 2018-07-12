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
	
	///Constructor
	private SpotDao spotDao;
	
	///Method
	public void setmapDao(SpotDao spotDao) {
		this.spotDao=spotDao;
	}
	
	///Constructor
	public SpotServiceImpl() {
		System.out.println(this.getClass());
	}
	
	// 1. 장소 전체를 보여주는 메소드
	@Override
	public List<Spot> getSpotList(int spotCode) throws Exception {
		return spotDao.getSpotList(spotCode);
	}
	
	// 2. 한강리스트를 보여주는 메소드
	@Override
	public List<Spot> getRiverList(int spotCode) throws Exception {
		return spotDao.getRiverList(spotCode);
	}

	// 3. 맛집 리스트를 보여주는 메소드
	@Override
	public List<Spot> getRestaurantList(int spotCode) throws Exception {
		return spotDao.getRestaurantList(spotCode);
	}
	
	// 4. 스크롤을 내렸을때 무한 스크롤을 만들어 주는 메소드
	@Override
	public List<Spot> infiniteScrollDown(int bnoToStart) throws Exception {
		return spotDao.infiniteScrollDown(bnoToStart);
	}
	
	// 5. 장소 상세보기를 보여주는 메소드
	@Override
	   public Spot getSpot(int spotNo) throws Exception {
	      return spotDao.getSpot(spotNo);
	 }
	
	// 6. 주변 장소 정보를 가져오는 메소드
	@Override
	public List<Spot> searchAround(Spot spot) throws Exception {
		return spotDao.searchAround(spot);
	}
	
}
