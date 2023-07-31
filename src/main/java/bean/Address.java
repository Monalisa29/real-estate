package bean;

public class Address {
	
	int addressId;
	String county;
	String city;
	String streetName;
	String streetNr;
			
	public Address() {
		super();
	}

	public Address(int addressId, String county, String city, String streetName, String streetNr) {
		super();
		this.addressId = addressId;
		this.county = county;
		this.city = city;
		this.streetName = streetName;
		this.streetNr = streetNr;
	}

	public int getAddressId() {
		return addressId;
	}

	public void setAddressId(int addressId) {
		this.addressId = addressId;
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

	public String getStreetName() {
		return streetName;
	}

	public void setStreetName(String streetName) {
		this.streetName = streetName;
	}

	public String getStreetNr() {
		return streetNr;
	}

	public void setStreetNr(String streetNr) {
		this.streetNr = streetNr;
	}

	@Override
	public String toString() {
		return "Address [addressId=" + addressId + ", county=" + county + ", city=" + city + ", streetName="
				+ streetName + ", streetNr=" + streetNr + "]";
	}
	
}
