package com.nadri.service.spot;

import java.util.List;
import java.util.Map;

import com.nadri.common.Search;
import com.nadri.service.domain.Spot;

public interface SpotService {
	
	// 1. 장소 10개를 보여주는 메소드
	public List<Spot> getSpotList(int spotCode) throws Exception;
	
	// 1-1. 장소를 보여주는 메소드 
	public List<Spot> getRiverList(int spotCode) throws Exception;
	
	// 2. 장소 전체를 보여주는 메소드
	public List<Spot> getAllSpotList(int spotCode) throws Exception;
	
	// 3. 스크롤을 내렸을때 무한 스크롤을 만들어 주는 메소드
	public List<Spot> infiniteScrollDown(Spot spot) throws Exception;
	
	// 4. 장소 상세보기를 보여주는 메소드
	public Spot getSpot(int spotNo) throws Exception;
	
	// 5. 주변 장소 정보를 가져오는 메소드
	public List<Spot> searchAround(Spot spot) throws Exception;
	
	/////////////////////////////////////////////////////////예지누나 추가!!(20180712)/////////////////////////////////////////////////////////////////
	// 3. 장소삭제 (admin only)
	public void deleteSpot(String spotNo);
	
	// 0. 코드없이 전체 장소 조회(admin only)
	public List<Spot> getSpotList() throws Exception;
	
	// 4. 장소추가 (admin only)
	public void addSpot(Spot spot);
	/////////////////////////////////////////////////////////예지누나 추가!!(20180712)/////////////////////////////////////////////////////////////////
	
	// 7. 게시판을 클릭했을때 조회수가 1씩 증가
	public void updateSpotReadCnt(Spot spot) throws Exception;
	
	// 8. 전체 장소의 갯수를 가져옵니다.
	public int getTotalSpot() throws Exception;
	
	// 9. 검색한 장소를 가져옵니다.
	public List<Spot> getSearchSpotList(Search search) throws Exception;
	
	// 10. getRecommandSpotList 가져오는 메서드
	public List<Spot> getRecommandSpotList() throws Exception;
}
