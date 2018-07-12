package com.nadri.service.spot;

import java.util.List;

import com.nadri.common.Search;
import com.nadri.service.domain.Spot;

public interface SpotDao {
	
	// 1. 장소 전체를 보여주는 메소드
	public List<Spot> getSpotList(int spotCode) throws Exception;
	
	// 2. 한강 리스트를 보여주는 메소드
	public List<Spot> getRiverList(int spotCode) throws Exception;
	
	// 3. 맛집 리스트를 전체 보여주는 메소드
	public List<Spot> getRestaurantList(int spotCode) throws Exception;
	
	// 4. 스크롤 다운했을때
	public List<Spot> infiniteScrollDown(int bnoToStart) throws Exception;
	
	// 5. 장소 상세보기를 보여주는 메소드
	public Spot getSpot(int spotNo) throws Exception;
	
	// 6. 주변 장소 정보를 가져오는 메소드
	public List<Spot> searchAround(Spot spot) throws Exception;
	
	/////////////////////////////////////////////////////////예지누나 추가!!(20180712)/////////////////////////////////////////////////////////////////
	 // 3. 장소삭제 (admin only)
	 public void deleteSpot(String spotNo);
	 
	 // 0. 코드없이 전체 장소 조회(admin only)
	 public List<Spot> getSpotList() throws Exception;
	   
	 // 4. 장소추가 (admin only)
	 public void addSpot(Spot spot);
	 /////////////////////////////////////////////////////////예지누나 추가!!(20180712)/////////////////////////////////////////////////////////////////
} 
