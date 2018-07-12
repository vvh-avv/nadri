package com.nadri.service.admin;

import java.util.List;

import com.nadri.service.domain.Inquire;

public interface AdminService {
	
	public void addInquire(Inquire inquire);
	
	public List<Inquire> getInquireList();

	public void updateInquire(Inquire inquire);
	
	public Inquire getInquire(int inquireNo);

}
