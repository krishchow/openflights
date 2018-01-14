/**
 * This class serves to visualize all the points of the map without much more detail.
 * Furthermore rationalizing the x and y coordinates occurs here.
 * 
 * @author Krish Chowdhary
 * @version 1.5
 * @since Processing 3.0b6
 * @since December 2015
 */
class airports {
  String[] details;
  String[] temp;
  String[] tempCatagory;
  String tempString;
  float x;
  float y;
  float id;
  String name;
  String city;
  String country;
  String FAA;
  String ICAO;
  float latitude;
  float longitude;
  float altitude;
  float timezone;
  String DST;
  /**
   * This constructor splits the input (string) into the different details
   *
   * @Param input - a string which is from the array of data
   */
  airports(String input) {
    details = split(input, ',');
    id = float(details[0]);
    name = details[1];
    city = details[2];
    if (details.length > 12) { 
      temp[0] = details[3];
      temp[1] = details[4];
      country = join(temp, "");
      FAA = details[5];
      ICAO = details[6];
      latitude = float(details[7]);
      longitude = float(details[8]);
      altitude = float(details[9]);
      timezone = float(details[10]);
      DST = details[11];
    } else {
      country = details[3]; 
      FAA = details[4]; 
      ICAO = details[5]; 
      latitude = float(details[6]); 
      longitude = float(details[7]); 
      altitude = float(details[8]); 
      timezone = float(details[9]); 
      DST = details[10];
    }
  }
  /**
   * This function visualizes all the airports
   */
  void display() {
    fill(255);
    ellipse(rationalizeLongitude(longitude), rationalizeLatitude(latitude), 5, 5);
  }
  /**
   * This function does some math which leads to the point recieving an 'x' postion on the map
   *
   * @Param latitude - the direct input of latitude from the data
   */
  float rationalizeLatitude(float latitude) {
    float y=latitude;
    boolean north=false;
    float absy=0;
    if (y >= 0) {
      absy=y;
      north=true;
    }
    if (y < 0) {
      absy=-y;
      north=false;
    }
    if (north) {
      return 400-(absy * RNumber);
    } else return 400+(absy * RNumber);
  }
  /**
   * This function does some math which leads to the point recieving a 'y' postion on the map
   *
   * @Param longitude - the direct input of longitude from the data
   */
  float rationalizeLongitude(float longitude) {
    float x=longitude;
    boolean west=false;
    float absx=0;
    if (x >= 0) {
      absx=x;
      west=false;
    }
    if (x < 0) {
      absx=-x;
      west=true;
    }
    if (west) {
      return 800-(absx * RNumber);
    } else return 800+(absx * RNumber);
  }
  /**
   * This function calls upon the rationalizeLatitude to return a float value on the Y Axis
   */
  float Latitude() {
    return rationalizeLatitude(latitude);
  }
  /**
   * This function calls upon the rationalizeLongitude to return a float value on the X Axis
   */
  float Longitude() {
    return rationalizeLongitude(longitude);
  }
  String IDToName(int ID) {
    if (ID==id) {
      return name;
    }
    return "";
  }
  float id() {
    return id;
  }
  String Name() {
    return name;
  }
  String City() {
    return city;
  }
  String Country() {
    return country;
  }
  String Code() {
    return FAA;
  }
  String OtherCode() {
    return ICAO;
  }
}