/**
 * This class will be used to extend the Trip class and add 
 * additional functionality to calculate the Airline's name and ID
 * 
 * @author Krish Chowdhary
 * @version 1.5
 * @since Processing 3.0b6
 * @since December 2015
 */
class Airline {
  String[] details;  
  String[] airlineDetails;  
  String airlineCode;
  String airlineIdentifier;
  String sourceAirportCode;
  float sourceAirportIdentifier;
  String destinationAirportCode;
  float destinationAirportIdentifier;
  String codeshare;
  float stops;
  String equipment;
  PVector coordSource;
  PVector coordDestination;
  float airlineID;
  String airlineName;
  String alias;
  String IATACode;
  String ICAOCode;
  String Callsign;
  String Country;
  String Active;
  String AirlineNameFinal="";
 /**
 * This constructor takes two strings, one which is superceeded by the 'Trips' class and the other which
 * contains the information about the Airline 
 *
 * @Param info - information about the route being taken
 * @Param airlineInfo - information about the Airline
 */
  Airline(String airlineInfo) {
    airlineDetails=split(airlineInfo, ',');
    airlineID=float(airlineDetails[0]);
    airlineName=airlineDetails[1];
    alias=airlineDetails[2];
    IATACode=airlineDetails[3];
    ICAOCode=airlineDetails[4];
    Callsign=airlineDetails[5];
    Country=airlineDetails[6];
    Active=airlineDetails[7];
  }
  /**
 * This function does essentially converts the Identification number to the Airline's name
 *
 * @Param ID - integer which is the identification number of the Airline
 */
  String IDToName(int ID) {
    if (ID==airlineID) {
      return airlineName;
    }
    return "";
  }
  String Name() {
  return airlineName;
  }
}