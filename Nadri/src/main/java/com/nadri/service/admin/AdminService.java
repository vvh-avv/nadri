package com.nadri.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.nadri.service.domain.Inquire;
import com.nadri.service.domain.Spot;

public interface AdminService {
	
	public void addInquire(Inquire inquire);
	
	public List<Inquire> getInquireList();

	public void updateInquire(Inquire inquire);
	
	public Inquire getInquire(int inquireNo);
	
	public void updateSpot(Spot spot);
	
	public Map<String,Object> getGraphLog(HashMap<String, Object> map);
	
	public int blockUser(String userId);
	
}
