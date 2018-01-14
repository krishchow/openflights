/**
 * This class will be used catagorize the routes file and control where the Plane class travels
 * 
 * @author Krish Chowdhary
 * @version 1.5
 * @since Processing 3.0b6
 * @since December 2015
 */
class Trip {
  String[] details;  
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
  /**
   * This constructor splits the input (string) into the different details and also uses the idToLongitude/
   * idToLatitude functions seen on the main file. Lastly it creates two PVectors to store this data.
   *
   * @Param info - a string which is from the array of data (routes.dat)
   */
  Trip(String info) {
    details = split(info, ',');
    airlineCode=details[0];
    airlineIdentifier=details[1];
    sourceAirportCode=details[2];
    sourceAirportIdentifier=float(details[3]);
    destinationAirportCode=details[4];
    destinationAirportIdentifier=float(details[5]);
    codeshare=details[6];
    stops=float(details[7]);
    equipment=details[8];
    float x1;
    float y1;
    float x2;
    float y2;
    x1=idToLongitude(sourceAirportIdentifier);
    x2=idToLongitude(destinationAirportIdentifier);
    y1=idToLatitude(sourceAirportIdentifier);
    y2=idToLatitude(destinationAirportIdentifier);
    coordSource=new PVector(0, 0);
    coordDestination=new PVector(0, 0);
    coordSource.set(x1, y1);
    coordDestination.set(x2, y2);
  }

  /**
   * This function returns the ID as an integer
   */
  int id() {
    return int(sourceAirportIdentifier);
  }
  /**
   * This function checks if the input ID is equal to the source airports ID, if it isnt it returns -1
   *
   * @Param indentification - this variable is the ID beings searched for
   */
  float sourceToDestination(int identification) {
    if (identification == sourceAirportIdentifier) {
      return destinationAirportIdentifier;
    } else return -1;
  }
  /**
   * This function takes in two inputs, those two being the ID's of source and destination airports
   * and returns the Airline ID if they are a pair
   *
   * @Param inputSource -  the Source Airport ID
   * @Param inputDestination - the Destination Airport ID
   */
  float getCode(int inputSource, int inputDestination) {
    if (inputSource == sourceAirportIdentifier) {
      if (inputDestination == destinationAirportIdentifier) {
        return float(airlineIdentifier);
      }
    }
    return -1;
  }
  /**
   * This function takes in three inputs, those three being the ID's of source airport, destination airport and Airline Code
   * and returns true if they all match
   *
   * @Param SID -  the Source Airport ID
   * @Param DID - the Destination Airport ID
   * @Param code - the Airline ID
   */
  boolean AirlineCodeConfirmation(float code, int SID, int DID) {
    if (SID == sourceAirportIdentifier) {
      if (DID == destinationAirportIdentifier) {
        if (code == float(airlineIdentifier)) {
          return true;
        }
      }
    }
    return false;
  }
  String source() {
    return details[3];
  }
  String destination() {
    return details[5];
  }
  Float destinationN() {
    return destinationAirportIdentifier;
  }
  float airlineID() {
    return float(airlineIdentifier);
  }
}