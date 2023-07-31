package helper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ImmobileHelper {
	
	public String getSelectedCounty(String county)
	{
		if(Objects.isNull(county)) {
			return null;
		}
		else if(county.equals("Judet")) {
			return null;
		}
		else {
			return county;
		}
	}
	
	public String getSelectedCity(String city)
	{
		if(Objects.isNull(city)) {
			return null;
		}
		else if(city.equals("Oras")) {
			return null;
		}
		else {
			return city;
		}
	}
	
	public String getSelectedCategory(String category)
	{
		if(Objects.isNull(category)) {
			return null;
		}
		else if(category.equals("Categorie")) {
			return null;
		}
		else {
			return category;
		}
	}
	
	public String getSelectedType(String type)
	{
		if(Objects.isNull(type)) {
			return null;
		}
		else if(type.equals("Tip")) {
			return null;
		}
		else {
			return type;
		}
	}
	
	public int getSelectedRoomsNr(String roomsNr)
	{
		if(Objects.isNull(roomsNr)) {
			return 0;
		}
		else if(roomsNr.equals("Numardecamere")) {
			return 0;
		}
		else if(roomsNr.equals("4+")) {
			return 4;
		}
		else {
			return Integer.parseInt(roomsNr);
		}
	}
	
	public String getSelectedPartitioning(String partitioning)
	{
		if(Objects.isNull(partitioning)) {
			return null;
		}
		else if(partitioning.equals("compartimentare")) {
			return null;
		}
		else {
			return partitioning;
		}
	}
	
	public int getSelectedMinBuildYear(String buildYear)
	{
		if(Objects.isNull(buildYear)) {
			return 0;
		}
		else if(buildYear.equals("anConstructie")) {
			return 0;
		}
		else if(buildYear.equals("dupa2000")) {
			return 2000;
		}
		else if(buildYear.equals("1990-2000")) {
			return 1990;
		}
		else if(buildYear.equals("1977-2000")) {
			return 1997;
		}
		else if(buildYear.equals("inainte1977")) {
			return 1977;
		}
		
		return 0;
	}
	
	public int getSelectedMaxBuildYear(String buildYear)
	{
		if(Objects.isNull(buildYear)) {
			return 0;
		}
		else if(buildYear.equals("anConstructie")) {
			return 0;
		}
		else if(buildYear.equals("dupa2000")) {
			return 2000;
		}
		else if(buildYear.equals("1990-2000")) {
			return 2000;
		}
		else if(buildYear.equals("1977-2000")) {
			return 2000;
		}
		else if(buildYear.equals("inainte1977")) {
			return 1977;
		}
		
		return 0;
	}
	
	public int getSelectedUsableArea(String usableArea)
	{
		if(Objects.isNull(usableArea) || usableArea.equals("")) {
			return 0;
		}
		else if(usableArea.equals("0")){
			return 0;
		}		
		else {
			return tryParseInt(usableArea);
		}
	}
	
	public int getSelectedPrice(String price)
	{
		if(Objects.isNull(price)) {
			return 0;
		}
		else if(price.equals("0")){
			return 0;
		}
		else {
			return tryParseInt(price);
		}
	}
	
	public boolean checkIfContainsNr(String text)
	{
		char[] chars = text.toCharArray();
		for(char c : chars) {
			if(Character.isDigit(c)) {
				return true;
			}
		}
		return false;
	}
	
	public int getSelectedNr(String buildYear)
	{
		if(Objects.isNull(buildYear) || buildYear.equals("")) {
			return 0;
		}
		else if(tryParseInt(buildYear) != -1) {
			return tryParseInt(buildYear);
		}
		
		
		return -1;
	}
	
	public int tryParseInt(String stringNr) 
	{
	   try {
	      return Integer.parseInt(stringNr);
	   } catch (NumberFormatException ex) {
	      return -1;
	   }
	}
	
	public boolean checkIfContainsSpecialChars(String input) {
		String regex = "[!@#$%^&*(),.?\":{}|<>]";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(input);
		
		if(matcher.find()) {
			return true;
		}
		return false;
	}
	
	public Map<String, List<String>> getCountiesCities()
	{
		Map<String, List<String>> addresses = new HashMap<String, List<String>>();
		
		addresses.put("Alba", List.of("", "Alba Iulia", "Abrud", "Aiud", "Baia de Aries", "Blaj", "Campeni", "Cugir", "Ocna Mures", "Sebes", "Teius", "Zlatna"));
		addresses.put("Arad", List.of("", "Arad", "Chisineu Cris", "Curtici", "Ineu", "Lipova", "Nadlac", "Pancota", "Pecica", "Santana", "Seius"));
		addresses.put("Arges", List.of("", "Campulung", "Costesti", "Curtea de Arges", "Mioveni", "Pitesti", "Stefanesti", "Topoloveni"));
		addresses.put("Bacau", List.of("", "Bacau", "Buhusi", "Comanesti", "Darmanesti", "Moinesti", "Onesti", "Slanic-Moldova", "Targu Ocna"));
		addresses.put("Bihor", List.of("", "Alesd", "Beius", "Marghita", "Nucet", "Oradea", "Sacueni", "Salonta", "Stei", "Valea lui Mihai", "Vascau"));
		addresses.put("Bistrita-Nasaud", List.of("", "Bistrita", "Beclean", "Sangeorz-Bai", "Nasaud"));
		addresses.put("Botosani", List.of("", "Botosani", "Bucecea", "Dorohoi", "Darabani", "Flamanzi", "Saveni", "Stefanesti"));
		addresses.put("Brasov", List.of("", "Brasov", "Codlea", "Fagaras", "Ghimbav", "Predeal", "Rasnov", "Rasnov", "Rupea", "Sacele", "Victoria", "Zarnesti"));
		addresses.put("Braila", List.of("", "Braila", "Ianca", "Insuratei", "Faurei"));
		addresses.put("Bucuresti", List.of("", "Clinceni", "Tunari", "1 Decembrie", "Berceni", "Chiajna", "Chitila", "Gradistea", "Jilava", "Moara Vlasiei", "Peris", "Cornetu", "Ciolpani", "Corbeanca", "Gruiu", "Snagov", "Cernica", "Vidra", "Voluntari", "Balotesti", "Bragadiru", "Glina", "Otopeni", "Pantelimon", "Petrachioaia", "Popesti Leordeni", "Ciorogarla", "Crevedia", "Darasti-Ilfov", "Dascalu", "Dobroesti", "Domnesti", "Dragomiresti-Vale", "Dridu", "Fierbinti-Targ", "Fundeni", "Ganeasa", "Gradinari", "Magurele", "Mogosoaia", "Afumati", "Branesti", "Bucuresti", "Buftea", "Stefanestii De Jos", "Nuci"));
		addresses.put("Buzau", List.of("", "Buzau", "Ramnicu Sarat", "Nehoiu", "Patarlagele", "Pogoanele"));
		addresses.put("Caras-Severin", List.of("", "Resita", "Caransebes", "Bocsa", "Moldova Noua", "Oravita", "Otelu Rosu", "Anina", "Baile Herculane"));
		addresses.put("Calarasi", List.of("", "Calarasi", "Oltenita", "Budesti", "Fundulea", "Lehliu-Gara"));
		addresses.put("Cluj", List.of("", "Cluj-Napoca", "Campia Turzii", "Dej", "Gherla", "Huedin", "Turda"));
	    addresses.put("Constanta", List.of("", "Constanta", "Baneasa", "Cernavoda", "Eforie", "Harsova", "Mangalia", "Medgidia", "Murfatlar", "Navodari", "Negru Voda", "Ovidiu", "Techirghiol"));
	    addresses.put("Covasna", List.of("", "Baraolt", "Covasna", "Intorsura Buzaului", "Sfantu Gheorghe", "Tragu Secuiesc"));
	    addresses.put("Dambovita", List.of("", "Fleni", "Gaesti", "Moreni", "Pucioasa", "Racari", "Targoviste", "Titu"));
	    addresses.put("Dolj", List.of("", "Bailesti", "Bechet", "Calafat", "Craiova", "Dabulesti", "Filiasi", "Segarcea"));
	    addresses.put("Galati", List.of("", "Beresti", "Galati", "Targu Bujor", "Tecuci"));
	    addresses.put("Giurgiu", List.of("", "Bolintin-Vale", "Giurgiu", "Mihailesti"));
	    addresses.put("Gorj", List.of("", "Bumbesti-Jiu", "Calan", "Hateg", "Motru", "Novaci", "Petrila", "Rovinari", "Targu Carbunesti", "Targu Jiu", "Ticleni", "Turceni", "Tismana", "Uricani"));
	    addresses.put("Harghita", List.of("Balan", "Baile Tusnad", "Borsec", "Cristuru Secuiesc", "Gheorgheni", "Miercurea-Ciuc", "Odorheiu Secuiesc", "Toplita", "Vlahita"));
	    addresses.put("Hunedoara", List.of("", "Aninoasa", "Brad", "Calan", "Deva", "Geoagiu", "Hateg", "Lupeni", "Orastie", "Petrosani", "Simeria", "Targu Carbunesti", "Targu Jiu", "Turceni", "Uricani", "Vulcan"));
	    addresses.put("Ialomita", List.of("", "Amara", "Cazanesti", "Fetesti", "Fierbinti-Targ", "Slobozia", "Tandarei","Urziceni"));
	    addresses.put("Iasi", List.of("", "Iasi", "Pascani", "Harlau", "Podu Iloaiei", "Targu Frumos", "Hirlau"));
	    addresses.put("Ilfov", List.of("", "Buftea", "Pantelimon", "Popesti-Leordeni", "Voluntari", "Chitila", "Corbeanca", "Magurele", "Otopeni"));
	    addresses.put("Maramures", List.of("", "Baia Mare", "Sighetu Marmatiei", "Borsa", "Targu Lapus", "Somcuta Mare", "Dragomiresti", "Seini", "Cavnic"));
	    addresses.put("Mehedinti", List.of("", "Drobeta-Turnu Severin", "Orsova", "Strehaia", "Vanju Mare", "Baia de Arama"));
	    addresses.put("Mures", List.of("", "Targu Mures", "Reghin", "Sighisoara", "Sovata", "Tarnaveni", "Ungheni", "Iernut"));
	    addresses.put("Neamt", List.of("", "Piatra Neamt", "Roman", "Roznov", "Targu Neamt", "Bicaz", "Radauti-Prut", "Raucesti"));
	    addresses.put("Olt", List.of("", "Caracal", "Corabia", "Draganesti-Olt", "Piatra-Olt", "Potcoava", "Slatina", "Scornicesti"));
	    addresses.put("Prahova", List.of("", "Ploiesti", "Campina", "Breaza", "Baicoi", "Sinaia", "Slanic", "Valenii de Munte", "Urlati"));
	    addresses.put("Salaj", List.of("", "Zalau", "Jibou", "Simleu Silvaniei", "Cehu Silvaniei"));
	    addresses.put("Satu Mare", List.of("", "Satu Mare", "Carei", "Livada", "Tasnad"));
	    addresses.put("Sibiu", List.of("", "Sibiu", "Agnita", "Avrig", "Cisnadie", "Medias", "Miercurea Sibiului", "Saliste", "Talmaciu"));
	    addresses.put("Suceava", List.of("", "Suceava", "Falticeni", "Radauti", "Cajvana", "Dolhasca", "Vatra Dornei", "Gura Humorului", "Siret", "Campulung Moldovenesc"));
	    addresses.put("Teleorman", List.of("", "Rosiori de Vede", "Turnu Magurele", "Alexandria", "Zimnicea", "Videle"));
	    addresses.put("Timis", List.of("", "Timisoara", "Lugoj", "Sannicolau Mare", "Buzias", "Ciacova", "Deta", "Faget", "Jimbolia"));
	    addresses.put("Tulcea", List.of("", "Tulcea", "Babadag", "Isaccea", "Macin", "Sulina"));
	    addresses.put("Valcea", List.of("", "Ramnicu Valcea", "Dragasani", "Baile Govora", "Berbesti", "Calimanesti", "Horezu", "Brezoi", "Ocnele Mari"));
	    addresses.put("Vaslui", List.of("", "Vaslui", "Barlad", "Husi", "Negresti", "Murgeni", "Dranceni", "Padureni"));
	    addresses.put("Vrancea", List.of("", "Focsani", "Adjud", "Marasesti", "Odobesti", "Panciu"));
	
		return addresses;
	}
	
}
