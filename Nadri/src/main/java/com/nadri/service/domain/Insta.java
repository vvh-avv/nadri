package com.nadri.service.domain;

public class Insta {
	
	private String searchKeyword;
	private String img;
	private String shortLink;
	private String likes;
	private String date;
	
	@Override
	public String toString() {
		return "Insta [searchKeyword=" + searchKeyword + ", img=" + img + ", shortLink=" + shortLink + ", likes="
				+ likes + ", date=" + date + "]";
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}
	
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	public String getImg() {
		return img;
	}
	
	public void setImg(String img) {
		this.img = img;
	}
	
	public String getShortLink() {
		return shortLink;
	}
	
	public void setShortLink(String shortLink) {
		this.shortLink = shortLink;
	}
	
	public String getLikes() {
		return likes;
	}
	
	public void setLikes(String likes) {
		this.likes = likes;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	
	
	

}
