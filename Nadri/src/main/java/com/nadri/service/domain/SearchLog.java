package com.nadri.service.domain;

import java.sql.Timestamp;

public class SearchLog {
   
   //field
   private int searchNo;                                 //검색 번호(시퀀스)
   private String searchKeyword;                     //검색어
   private Timestamp searchTime;                     //검색한 시간
   private int count;                                       //검색횟수
   
   //constructor method
   public SearchLog() {
   }


   //method
   public int getSearchNo() {
      return searchNo;
   }


   public void setSearchNo(int searchNo) {
      this.searchNo = searchNo;
   }


   public String getSearchKeyword() {
      return searchKeyword;
   }


   public void setSearchKeyword(String searchKeyword) {
      this.searchKeyword = searchKeyword;
   }


   public Timestamp getSearchTime() {
      return searchTime;
   }


   public void setSearchTime(Timestamp searchTime) {
      this.searchTime = searchTime;
   }

   public int getCount() {
      return count;
   }


   public void setCount(int count) {
      this.count = count;
   }


   @Override
   public String toString() {
      return "SearchLog [searchNo=" + searchNo + ", searchKeyword=" + searchKeyword + ", searchTime=" + searchTime
            + ", count=" + count + "]";
   }

}