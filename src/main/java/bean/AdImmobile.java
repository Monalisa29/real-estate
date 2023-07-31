package bean;

import java.util.Date;

public class AdImmobile {
	
	int adId;
	int immobileId;
	int userId;
	int realtorId;
	int categoryId;
	int usableArea;
	int priceImmobile;
	int yearImmobile;
	int roomsNrImmobile;
	int addressId;
	int addressNr;
	int floorAp;
	int floorsNrHouse;
	int adPostingPeriod;
	Date adPostDate;
	String adStatus;
	String descImmobile;
	String categoryName;
	String immobileType;
	String adTitle;
	String county;
	String city;
	String streedName;
	String ownerFName;
	String ownerLName;
	String partitioningAp;
	String picture;
	
	public AdImmobile() {
		super();
	}
	
	public AdImmobile(int adId, int immobileId, int userId, int realtorId, int categoryId, int usableArea,
			int priceImmobile, int yearImmobile, int roomsNrImmobile, int addressId, int addressNr, int floorAp,
			int floorsNrHouse, int adPostingPeriod, Date adPostDate, String adStatus, String descImmobile,
			String categoryName, String immobileType, String adTitle, String county, String city, String streedName,
			String ownerFName, String ownerLName, String partitioningAp, String picture) {
		super();
		this.adId = adId;
		this.immobileId = immobileId;
		this.userId = userId;
		this.realtorId = realtorId;
		this.categoryId = categoryId;
		this.usableArea = usableArea;
		this.priceImmobile = priceImmobile;
		this.yearImmobile = yearImmobile;
		this.roomsNrImmobile = roomsNrImmobile;
		this.addressId = addressId;
		this.addressNr = addressNr;
		this.floorAp = floorAp;
		this.floorsNrHouse = floorsNrHouse;
		this.adPostingPeriod = adPostingPeriod;
		this.adPostDate = adPostDate;
		this.adStatus = adStatus;
		this.descImmobile = descImmobile;
		this.categoryName = categoryName;
		this.immobileType = immobileType;
		this.adTitle = adTitle;
		this.county = county;
		this.city = city;
		this.streedName = streedName;
		this.ownerFName = ownerFName;
		this.ownerLName = ownerLName;
		this.partitioningAp = partitioningAp;
		this.picture = picture;
	}

	public int getAdId() {
		return adId;
	}

	public void setAdId(int adId) {
		this.adId = adId;
	}

	public Date getAdPostDate() {
		return adPostDate;
	}

	public void setAdPostDate(Date adPostDate) {
		this.adPostDate = adPostDate;
	}

	public String getAdStatus() {
		return adStatus;
	}

	public void setAdStatus(String adStatus) {
		this.adStatus = adStatus;
	}

	public int getImmobileId() {
		return immobileId;
	}

	public void setImmobileId(int immobileId) {
		this.immobileId = immobileId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getRealtorId() {
		return realtorId;
	}

	public void setRealtorId(int realtorId) {
		this.realtorId = realtorId;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public int getUsableArea() {
		return usableArea;
	}

	public void setUsableArea(int usableArea) {
		this.usableArea = usableArea;
	}

	public String getDescImmobile() {
		return descImmobile;
	}

	public void setDescImmobile(String descImmobile) {
		this.descImmobile = descImmobile;
	}

	public int getPriceImmobile() {
		return priceImmobile;
	}

	public void setPriceImmobile(int priceImmobile) {
		this.priceImmobile = priceImmobile;
	}

	public int getYearImmobile() {
		return yearImmobile;
	}

	public void setYearImmobile(int yearImmobile) {
		this.yearImmobile = yearImmobile;
	}

	public int getRoomsNrImmobile() {
		return roomsNrImmobile;
	}

	public void setRoomsNrImmobile(int roomsNrImmobile) {
		this.roomsNrImmobile = roomsNrImmobile;
	}

	public int getAddressId() {
		return addressId;
	}

	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getImmobileType() {
		return immobileType;
	}

	public void setImmobileType(String immobileType) {
		this.immobileType = immobileType;
	}

	public String getAdTitle() {
		return adTitle;
	}

	public void setAdTitle(String title) {
		this.adTitle = title;
	}

	public String getCounty() {
		return county;
	}

	public void setCounty(String county) {
		this.county = county;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getStreedName() {
		return streedName;
	}

	public void setStreedName(String streedName) {
		this.streedName = streedName;
	}

	public int getAddressNr() {
		return addressNr;
	}

	public void setAddressNr(int addressNr) {
		this.addressNr = addressNr;
	}

	public String getOwnerFName() {
		return ownerFName;
	}

	public void setOwnerFName(String ownerFName) {
		this.ownerFName = ownerFName;
	}

	public String getOwnerLName() {
		return ownerLName;
	}

	public void setOwnerLName(String ownerLName) {
		this.ownerLName = ownerLName;
	}

	public int getFloorAp() {
		return floorAp;
	}

	public void setFloorAp(int floorAp) {
		this.floorAp = floorAp;
	}

	public int getFloorsNrHouse() {
		return floorsNrHouse;
	}

	public void setFloorsNrHouse(int floorsNrHouse) {
		this.floorsNrHouse = floorsNrHouse;
	}

	public String getPartitioningAp() {
		return partitioningAp;
	}

	public void setPartitioningAp(String partitioningAp) {
		this.partitioningAp = partitioningAp;
	}

	public int getAdPostingPeriod() {
		return adPostingPeriod;
	}

	public void setAdPostingPeriod(int adPostingPeriod) {
		this.adPostingPeriod = adPostingPeriod;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	@Override
	public String toString() {
		return "AdImmobile [adId=" + adId + ", immobileId=" + immobileId + ", userId=" + userId + ", realtorId="
				+ realtorId + ", categoryId=" + categoryId + ", usableArea=" + usableArea + ", priceImmobile="
				+ priceImmobile + ", yearImmobile=" + yearImmobile + ", roomsNrImmobile=" + roomsNrImmobile
				+ ", addressId=" + addressId + ", addressNr=" + addressNr + ", floorAp=" + floorAp + ", floorsNrHouse="
				+ floorsNrHouse + ", adPostingPeriod=" + adPostingPeriod + ", adPostDate=" + adPostDate + ", adStatus="
				+ adStatus + ", descImmobile=" + descImmobile + ", categoryName=" + categoryName + ", immobileType="
				+ immobileType + ", adTitle=" + adTitle + ", county=" + county + ", city=" + city + ", streedName="
				+ streedName + ", ownerFName=" + ownerFName + ", ownerLName=" + ownerLName + ", partitioningAp="
				+ partitioningAp + ", picture=" + picture + "]";
	}

}
