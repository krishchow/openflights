String[] details;
float lati;
float longi;
String name;
class Attract {
  Attract(String input) {
    details=split(input, ',');
    lati=float(details[3]);
    longi=float(details[4]);
    name=details[18];
  }
  String Name() {
   return name; 
  }
  float latitude() {
    return lati;
  }
  float longitude() {
   return longi; 
  }
}