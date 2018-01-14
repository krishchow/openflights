/* //<>//
 One City to another random city in least amount of clicks
 Points UI -  add link to route info which would link to Airline info, which would show all routes of a certain airline
 attractions from a click - show closest attraction from clicking on a point - same logic as find an airport just more math
 Game states - loading screen?
 Optimize data (lower the size and load times?)
 Optimize point display - new class of Points (Idk) draw bg once draw each point once dont refresh each time 
 */
PImage map;
PImage sky;
PImage Plane;
String Airports;
String[] components;
String[] airlinesComponents;
String[] routes;
String[] attractions;
int[] idArray= new int[59637];
int[] idArray2= new int[59637];
int[] airlineIdArray = new int[5995];
float[] AirportIdArray = new float[7733];
FloatList latitude;
FloatList longitude;
FloatList airportX;
FloatList airportY;
boolean menu=false;
boolean points=false;
boolean sourceTyped;
boolean destinationTyped;
boolean sourceComplete;
boolean destinationComplete;
boolean radiusCheck;
boolean displayRoute;
boolean displayNames=true;
ArrayList<airports> Airport = new ArrayList<airports>();
ArrayList<Trip> Routes = new ArrayList<Trip>();
String sourceID="";
String destinationID="";
ArrayList<Plane> route = new ArrayList<Plane>();
ArrayList<Airline> airline = new ArrayList<Airline>();
ArrayList<Attract> att = new ArrayList<Attract>();
float codeAirline; 
int id;
int destination;
int source;
boolean menu2;
boolean routeComplete=false;
String routeID="";
String sourceName;
String destinationName;
boolean startFlight;
boolean highlightCheck=false;
float mouseToPointX;
float mouseToPointY;
PVector mouseRationalize;
float RNumber = 4.444444444444444444444445;
float[] distList = new float[7733];
int minimumValue;
float LongiFinder;
float LatiFinder;
boolean portFinder;
boolean portUI;
int c=0;
float[] w;
int P;
float destCounter;
ArrayList<String> destinationNameList= new ArrayList<String>();
float heightCalc;
float portID;
boolean airlineUI;
/**
 * This is the mainfile and it serves to organize and visualize all the classes while allowing user
 * input. It also loads the bulk of the data.
 * 
 * @author Krish Chowdhary
 * @version 1.5
 * @since Processing 3.0b6
 * @since December 2015
 */
void setup() {
  size(1600, 800);
  map=loadImage("assets/map3.jpg");
  sky=loadImage("assets/sky.jpg");
  Plane=loadImage("assets/airplane.png");
  imageMode(CENTER);
  image(map, width/2, height/2);
  String[] airports = loadStrings("data/airports.dat");
  routes = loadStrings("data/routes.dat");
  String[] airlines = loadStrings("data/airlines.dat");
  String[] attractions = loadStrings("data/spots2.txt");
  String[] attractions2 = loadStrings("data/spots.txt");
  for (int i=0; i < airports.length; i++) {
    String tempAirport = airports[i];
    Airport.add(new airports(tempAirport));
  }
  for (int i=0; i < 5995; i++) {
    String tempAirline = airlines[i];
    airline.add(new Airline(tempAirline));
  }

  for (int i=0; i < routes.length; i++) {
    String tempRoute = routes[i];
    Routes.add(new Trip(tempRoute));
  }
  for (int i=0; i < Routes.size(); i++) {
    idArray[i]=Routes.get(i).id();
    idArray2[i]=Routes.get(i).id();
  }
  BubbleSort(idArray);
  for (int i=0; i <airline.size(); i++) {
    airlineIdArray[i]=int(airline.get(i).airlineID);
  }
  for (int i=1; i<attractions.length; i++) {
    att.add(new Attract(attractions[i]));
  }
  for (int i=0; i<attractions2.length; i++) {
    att.add(new Attract(attractions2[i]));
  }
  println("loaded");
}
/**
 * This function visualizes all the elements in the program and allows for smooth animations.
 */
void draw() {
  if (menu) {
    background(sky);
    textSize(50);
    fill(0);
    text("Flight Finder", 10, 50);
    fill(255);
    rectMode(CORNERS);
    rect(10, 60, 500, 110);
    if (sourceComplete) {
      fill(255, 0, 0);
    } else fill(0);
    textSize(30);
    text(sourceID, 15, 95);
    fill(255);
    if (sourceComplete) {
      rect(10, 120, 500, 170);
      if (destinationComplete) {
        fill(255, 0, 0);
      } else fill(0);
      text(destinationID, 15, 155);
    }
  }
  if (menu2) {
    background(sky);
    textSize(50);
    fill(0);
    text("Route Finder", 10, 50);
    text("Maximum of " + (routes.length-1), 0, height-25);
    fill(255);
    rectMode(CORNERS);
    rect(10, 60, 500, 110);
    if (routeComplete) {
      fill(255, 0, 0);
    } else fill(0);
    textSize(30);
    text(routeID, 15, 95);
  }
  if (!menu && !menu2) {
    image(map, width/2, height/2);
    if (points) {
      for (int i=0; i < Airport.size(); i++) {
        Airport.get(i).display();
      }
    }
    if (displayNames && points==false && (route.size() >0)) {
      destination=route.get(0).DestinationID();
      source=route.get(0).SourceID();
      for (int i=0; i < Airport.size(); i++) {
        if (Airport.get(i).id() == destination) {
          destinationName=Airport.get(i).IDToName(int(destination));
        }
      }
      for (int i=0; i < Airport.size(); i++) {
        if (Airport.get(i).id() == source) {
          sourceName=Airport.get(i).IDToName(int(source));
        }
      }
      fill(255);
      textSize(30);
      text(RQuote(sourceName), 0, 30);
      text(RQuote(destinationName), 0, 65);
    }
  }

  if (displayRoute) {
    route.get(0).points();
    route.get(0).startFlight();
  }
  if (startFlight) {
    route.get(0).update();
    if (dist(route.get(0).x, route.get(0).y, route.get(0).destinationX, route.get(0).destinationY) <= 10) {
      route.remove(0);
      displayRoute=false;
      startFlight=false;
    }
  }

  if (sourceID.length() > 0) {
    sourceTyped=true;
  }
  if (destinationID.length() > 0) {
    destinationTyped=true;
  }
  if (!sourceTyped) {
    if (menu) {
      textSize(30);
      fill(0, 255, 0);
      text("Source Airport ID", 15, 95);
    }
  }
  if (!destinationTyped && sourceComplete) {
    if (menu) {
      textSize(30);
      fill(0, 255, 0);
      text("Destination Airport ID", 15, 155);
    }
  }
  if (destinationComplete) {
    if (radiusCheck) {
      fill(0, 255, 0);
    } else fill(255);
    ellipseMode(CENTER);
    ellipse(620, 115, 100, 100);
    if (dist(mouseX, mouseY, 620, 115) < 50) {
      if (mousePressed) {
        radiusCheck=true;
      }
    }
  }
  if (radiusCheck) {
    sourceID=Routes.get(int(routeID)).source();
    destinationID=Routes.get(int(routeID)).destination();
    route.add(new Plane(float(sourceID), float(destinationID)));
    displayRoute=true;
    menu=false;
    menu2=false;
    reset();
  }
  if (routeComplete) {
    if (highlightCheck) {
      fill(0, 255, 0);
    } else fill(255);
    ellipseMode(CENTER);
    ellipse(620, 115, 100, 100);
    if (dist(mouseX, mouseY, 620, 115) < 50) {
      highlightCheck=true;
      if (mousePressed) {
        radiusCheck=true;
      }
    } else { 
      highlightCheck=false;
    }
  }
  if (portUI) {
    background(255);
    textSize(30);
    fill(0);
    text("Closest Airport: " + RQuote(Airport.get(minimumValue).Name()), 2, 30);
    if (RQuote(Airport.get(minimumValue).Code()) == "") {
      text("Airport Code: " + RQuote(Airport.get(minimumValue).OtherCode()), 2, 65);
    } else {           
      text("Closest Airport Code: " + RQuote(Airport.get(minimumValue).Code()), 2, 65);
    }
    text("City: " + RQuote(Airport.get(minimumValue).City()), 2, 100);
    text("Country: " + RQuote(Airport.get(minimumValue).Country()), 2, 135);
    if (highlightCheck) {
      fill(0, 255, 0);
    } else fill(255);
    ellipseMode(CENTER);
    ellipse(width-50, height-50, 90, 90);
    if (dist(mouseX, mouseY, width-50, height-50) < 45) {
      highlightCheck=true;
    } else { 
      highlightCheck=false;
    }    
    heightCalc=(textAscent() + textDescent());
    rectMode(CENTER);

    if (destinationNameList.size()>0) {
      if (mouseX > 2 && mouseX < (2+textWidth(destinationNameList.get(int((destinationNameList.size()-1)-destCounter)))) && mouseY < (200+(0*39.5)) && mouseY > ((200+(0*39.5))-30)) {
        fill(0, 255, 0);
      } else noFill();
      rect(2+(textWidth(destinationNameList.get(int((destinationNameList.size()-1)-destCounter)))/2), ((200+(0*39.5))-15), textWidth(destinationNameList.get(int((destinationNameList.size()-1)-destCounter))), heightCalc);
      fill(0);
      text(destinationNameList.get(int((destinationNameList.size()-1)-destCounter)), 2, (200+(0*39.5)));
      ////
      ////
      ////
      if (mouseX > 2 && mouseX < (2+textWidth(destinationNameList.get(int((destinationNameList.size()-1)-destCounter)))) && mouseY < (200+(0*39.5)) && mouseY > ((200+(0*39.5))-30)) {
        if (mousePressed) {
          reset();
          airlineUI=true;
          portUI=false;
        }
      }
    }
    if (destinationNameList.size()>1) {
      if (mouseX > 2 && mouseX < (2+textWidth(destinationNameList.get(int((destinationNameList.size()-2)-destCounter)))) && mouseY < (200+(1*39.5)) && mouseY > ((200+(1*39.5))-30)) {
        fill(0, 255, 0);
      } else noFill();      
      rect(2+(textWidth(destinationNameList.get(int((destinationNameList.size()-2)-destCounter)))/2), ((200+(1*39.5))-15), textWidth(destinationNameList.get(int((destinationNameList.size()-2)-destCounter))), heightCalc);
      fill(0);
      text(destinationNameList.get(int((destinationNameList.size()-2)-destCounter)), 2, (200+(1*39.5)));
    }      
    if (destinationNameList.size()>2) {
      if (mouseX > 2 && mouseX < (2+textWidth(destinationNameList.get(int((destinationNameList.size()-3)-destCounter)))) && mouseY < (200+(2*39.5)) && mouseY > ((200+(2*39.5))-30)) {
        fill(0, 255, 0);
      } else noFill();
      rect(2+(textWidth(destinationNameList.get(int((destinationNameList.size()-3)-destCounter)))/2), ((200+(2*39.5))-15), textWidth(destinationNameList.get(int((destinationNameList.size()-3)-destCounter))), heightCalc);
      fill(0);
      text(destinationNameList.get(int((destinationNameList.size()-3)-destCounter)), 2, (200+(2*39.5)));
    } 
    if (destinationNameList.size()>3) {
      if (mouseX > 2 && mouseX < (2+textWidth(destinationNameList.get(int((destinationNameList.size()-4)-destCounter)))) && mouseY < (200+(3*39.5)) && mouseY > ((200+(3*39.5))-30)) {
        fill(0, 255, 0);
      } else noFill();
      rect(2+(textWidth(destinationNameList.get(int((destinationNameList.size()-4)-destCounter)))/2), ((200+(3*39.5))-15), textWidth(destinationNameList.get(int((destinationNameList.size()-4)-destCounter))), heightCalc);
      fill(0);
      text(destinationNameList.get(int((destinationNameList.size()-4)-destCounter)), 2, (200+(3*39.5)));
    } 
    if (destinationNameList.size()>4) {
      if (mouseX > 2 && mouseX < (2+textWidth(destinationNameList.get(int((destinationNameList.size()-5)-destCounter)))) && mouseY < (200+(4*39.5)) && mouseY > ((200+(4*39.5))-30)) {
        fill(0, 255, 0);
      } else noFill();      
      rect(2+(textWidth(destinationNameList.get(int((destinationNameList.size()-5)-destCounter)))/2), ((200+(4*39.5))-15), textWidth(destinationNameList.get(int((destinationNameList.size()-5)-destCounter))), heightCalc);
      fill(0);
      text(destinationNameList.get(int((destinationNameList.size()-5)-destCounter)), 2, (200+(4*39.5)));
    } 
    if (destinationNameList.size()>5) {
      if (mouseX > 2 && mouseX < (2+textWidth(destinationNameList.get(int((destinationNameList.size()-6)-destCounter)))) && mouseY < (200+(5*39.5)) && mouseY > ((200+(5*39.5))-30)) {
        fill(0, 255, 0);
      } else noFill();      
      rect(2+(textWidth(destinationNameList.get(int((destinationNameList.size()-6)-destCounter)))/2), ((200+(5*39.5))-15), textWidth(destinationNameList.get(int((destinationNameList.size()-6)-destCounter))), heightCalc);
      fill(0);
      text(destinationNameList.get(int((destinationNameList.size()-6)-destCounter)), 2, (200+(5*39.5)));
    } 
    if (destinationNameList.size()>6) {
      if (mouseX > 2 && mouseX < (2+textWidth(destinationNameList.get(int((destinationNameList.size()-7)-destCounter)))) && mouseY < (200+(6*39.5)) && mouseY > ((200+(6*39.5))-30)) {
        fill(0, 255, 0);
      } else noFill();      
      rect(2+(textWidth(destinationNameList.get(int((destinationNameList.size()-7)-destCounter)))/2), ((200+(6*39.5))-15), textWidth(destinationNameList.get(int((destinationNameList.size()-7)-destCounter))), heightCalc);
      fill(0);
      text(destinationNameList.get(int((destinationNameList.size()-7)-destCounter)), 2, (200+(6*39.5)));
    } 
    if (destinationNameList.size()>7) {
      if (mouseX > 2 && mouseX < (2+textWidth(destinationNameList.get(int((destinationNameList.size()-8)-destCounter)))) && mouseY < (200+(7*39.5)) && mouseY > ((200+(7*39.5))-30)) {
        fill(0, 255, 0);
      } else noFill();      
      rect(2+(textWidth(destinationNameList.get(int((destinationNameList.size()-8)-destCounter)))/2), ((200+(7*39.5))-15), textWidth(destinationNameList.get(int((destinationNameList.size()-8)-destCounter))), heightCalc);
      fill(0);
      text(destinationNameList.get(int((destinationNameList.size()-8)-destCounter)), 2, (200+(7*39.5)));
    } 
    if (destinationNameList.size()>8) {
      if (mouseX > 2 && mouseX < (2+textWidth(destinationNameList.get(int((destinationNameList.size()-9)-destCounter)))) && mouseY < (200+(8*39.5)) && mouseY > ((200+(8*39.5))-30)) {
        fill(0, 255, 0);
      } else noFill();      
      rect(2+(textWidth(destinationNameList.get(int((destinationNameList.size()-9)-destCounter)))/2), ((200+(8*39.5))-15), textWidth(destinationNameList.get(int((destinationNameList.size()-9)-destCounter))), heightCalc);
      fill(0);
      text(destinationNameList.get(int((destinationNameList.size()-9)-destCounter)), 2, (200+(8*39.5)));
    } 
    if (destinationNameList.size()>9) {
      if (mouseX > 2 && mouseX < (2+textWidth(destinationNameList.get(int((destinationNameList.size()-10)-destCounter)))) && mouseY < (200+(9*39.5)) && mouseY > ((200+(9*39.5))-30)) {
        fill(0, 255, 0);
      } else noFill();      
      rect(2+(textWidth(destinationNameList.get(int((destinationNameList.size()-10)-destCounter)))/2), ((200+(9*39.5))-15), textWidth(destinationNameList.get(int((destinationNameList.size()-10)-destCounter))), heightCalc);
      fill(0);
      text(destinationNameList.get(int((destinationNameList.size()-10)-destCounter)), 2, (200+(9*39.5)));
    } 
    if (destinationNameList.size()>10) {
      if (mouseX > 2 && mouseX < (2+textWidth(destinationNameList.get(int((destinationNameList.size()-11)-destCounter)))) && mouseY < (200+(10*39.5)) && mouseY > ((200+(10*39.5))-30)) {
        fill(0, 255, 0);
      } else noFill();      
      rect(2+(textWidth(destinationNameList.get(int((destinationNameList.size()-11)-destCounter)))/2), ((200+(10*39.5))-15), textWidth(destinationNameList.get(int((destinationNameList.size()-11)-destCounter))), heightCalc);
      fill(0);
      text(destinationNameList.get(int((destinationNameList.size()-11)-destCounter)), 2, (200+(10*39.5)));
    } 
    if (destinationNameList.size()>11) {
      if (mouseX > 2 && mouseX < (2+textWidth(destinationNameList.get(int((destinationNameList.size()-12)-destCounter)))) && mouseY < (200+(11*39.5)) && mouseY > ((200+(11*39.5))-30)) {
        fill(0, 255, 0);
      } else noFill();      
      rect(2+(textWidth(destinationNameList.get(int((destinationNameList.size()-12)-destCounter)))/2), ((200+(11*39.5))-15), textWidth(destinationNameList.get(int((destinationNameList.size()-12)-destCounter))), heightCalc);
      fill(0);
      text(destinationNameList.get(int((destinationNameList.size()-12)-destCounter)), 2, (200+(11*39.5)));
    } 
    if (destinationNameList.size()>12) {
      if (mouseX > 2 && mouseX < (2+textWidth(destinationNameList.get(int((destinationNameList.size()-13)-destCounter)))) && mouseY < (200+(12*39.5)) && mouseY > ((200+(12*39.5))-30)) {
        fill(0, 255, 0);
      } else noFill();      
      rect(2+(textWidth(destinationNameList.get(int((destinationNameList.size()-13)-destCounter)))/2), ((200+(12*39.5))-15), textWidth(destinationNameList.get(int((destinationNameList.size()-13)-destCounter))), heightCalc);
      fill(0);
      text(destinationNameList.get(int((destinationNameList.size()-13)-destCounter)), 2, (200+(12*39.5)));
    } 
    if (destinationNameList.size()>13) {
      if (mouseX > 2 && mouseX < (2+textWidth(destinationNameList.get(int((destinationNameList.size()-14)-destCounter)))) && mouseY < (200+(13*39.5)) && mouseY > ((200+(13*39.5))-30)) {
        fill(0, 255, 0);
      } else noFill();      
      rect(2+(textWidth(destinationNameList.get(int((destinationNameList.size()-14)-destCounter)))/2), ((200+(13*39.5))-15), textWidth(destinationNameList.get(int((destinationNameList.size()-14)-destCounter))), heightCalc);
      fill(0);
      text(destinationNameList.get(int((destinationNameList.size()-14)-destCounter)), 2, (200+(13*39.5)));
    } 
    if (destinationNameList.size()>14) {
      if (mouseX > 2 && mouseX < (2+textWidth(destinationNameList.get(int((destinationNameList.size()-15)-destCounter)))) && mouseY < (200+(14*39.5)) && mouseY > ((200+(14*39.5))-30)) {
        fill(0, 255, 0);
      } else noFill();      
      rect(2+(textWidth(destinationNameList.get(int((destinationNameList.size()-15)-destCounter)))/2), ((200+(14*39.5))-15), textWidth(destinationNameList.get(int((destinationNameList.size()-15)-destCounter))), heightCalc);
      fill(0);
      text(destinationNameList.get(int((destinationNameList.size()-15)-destCounter)), 2, (200+(14*39.5)));
    } 
    if (destinationNameList.size()>15) {
      if (mouseX > 2 && mouseX < (2+textWidth(destinationNameList.get(int((destinationNameList.size()-16)-destCounter)))) && mouseY < (200+(15*39.5)) && mouseY > ((200+(15*39.5))-30)) {
        fill(0, 255, 0);
      } else noFill();      
      rect(2+(textWidth(destinationNameList.get(int((destinationNameList.size()-16)-destCounter)))/2), ((200+(15*39.5))-15), textWidth(destinationNameList.get(int((destinationNameList.size()-16)-destCounter))), heightCalc);
      fill(0);
      text(destinationNameList.get(int((destinationNameList.size()-16)-destCounter)), 2, (200+(15*39.5)));
    }
  }
  if (portFinder && !portUI && !menu && !menu2) {
    image(Plane, width-35, 25, 60, 50);
  }
  if (airlineUI) {
    background(255);
    text(airline.get(int(Routes.get(int(w[w.length-1])).airlineID())).Name(), 2, 200);
    println(Routes.get(int(w[w.length-1])).destinationAirportIdentifier);
    //if (mousePressed && mouseX < width-100) {
    //  airlineUI=false;
    //}
  }
  fill(255,0,0);
  noStroke();
  ellipse(585,164,1,1);
  stroke(0);
  fill(0);
}
/**
 * This function allowas for keys to be pressed enabling the bulk of input and transtions from the 
 * menu screen and blank map screen. 
 */
void keyPressed() {
  if (!displayRoute && !menu2) {
    if (key == '`') {
      if (menu == true) {
        menu = false;
      } else if (menu == false) {
        menu = true;
      }
    }
  }
  if (key == 'p') {
    if (!menu && !menu2) {
      if (points == true) {
        points = false;
      } else if (points == false) {
        points = true;
      }
    }
  }
  if (!displayRoute & !menu) {
    if (key == 'r') {
      if (menu2 == true) {
        menu2 = false;
      } else if (menu2 == false) {
        menu2 = true;
      }
    }
  }
  if (key == 'a') {
    if (!menu && !menu2 && !portUI && !airlineUI) {
      if (portFinder == true) {
        portFinder = false;
      } else if (portFinder == false) {
        portFinder = true;
      }
    }
  }
  if (menu && !sourceComplete) {
    if (sourceID.length() <= 3) {
      if (key != '`') {
        if (key >= 48 && key <= 57) {
          sourceID=sourceID + key;
        }
      }
    }
    if (sourceID.length() > 0 && sourceComplete ==false) {
      if (key == ENTER) {
        for (int i = 0; i < Airport.size(); i++) {
          if (Airport.get(i).id == float(sourceID)) {
            sourceComplete=true;
          }
        }
      }
    }
    if (sourceID.length() > 0) {
      if (key == BACKSPACE) {
        sourceID=sourceID.substring(0, sourceID.length()-1);
      }
    }
  }
  if (menu && !destinationComplete && sourceComplete) {
    if (destinationID.length() <= 3) {
      if (key != '`') {
        if (key >= 48 && key <= 57) {
          destinationID=destinationID + key;
        }
      }
    }
    if (destinationID.length() > 0 && destinationComplete ==false) {
      if (key == ENTER) {
        for (int i = 0; i < Airport.size(); i++) {
          if (Airport.get(i).id == float(destinationID)) {
            destinationComplete=true;
          }
        }
      }
    }
    if (destinationID.length() > 0) {
      if (key == BACKSPACE) {
        destinationID=destinationID.substring(0, destinationID.length()-1);
      }
    }
  }
  if (menu2 && routeComplete==false) {
    if (routeID.length() <= 4) {
      if (key != '`') {
        if (key >= 48 && key <= 57) {
          routeID=routeID + key;
        }
      }
    }
    if (routeID.length() > 0 && routeComplete ==false) {
      if (int(routeID) <= 59636) {
        if (key == ENTER) {
          routeComplete=true;
        }
      }
      if (key == BACKSPACE) {
        routeID=routeID.substring(0, routeID.length()-1);
      }
    }
  }
  if (portUI) {
    if (keyCode == UP) {
      if (destCounter > 0) {
        destCounter=destCounter-1;
      }
    }
    if (keyCode == DOWN) {
      if (destCounter < (destinationNameList.size()-16)) {
        destCounter=destCounter+1;
      }
    }
  }
}
void mousePressed() {
  println("x " + mouseX);
  println("y " + mouseY);
  if (!displayRoute && !menu && !menu2 && portFinder && !portUI) {
    mouseToPointX=mouseX;
    mouseToPointY=mouseY;
    for (int i=0; i < Airport.size(); i++) {
      distList[i]=(dist(mouseToPointX, mouseToPointY, Airport.get(i).Longitude(), Airport.get(i).Latitude()));
    }
    minimumValue = FlinearSearch(distList, min(distList));    
    LongiFinder=Airport.get(minimumValue).Longitude();
    LatiFinder=Airport.get(minimumValue).Latitude();
    w = new float[countSearch(idArray2, Airport.get(minimumValue).id()).size()];
    if (countSearch(idArray2, Airport.get(minimumValue).id()).size() > 0) {
      for (int i=0; i < countSearch(idArray2, Airport.get(minimumValue).id()).size(); i++) {
        w[i]=countSearch(idArray2, Airport.get(minimumValue).id()).get(i);
      }
    }
    for (int i=0; i < w.length; i++) {
      for (int e=0; e < Airport.size(); e++) {
        if (Airport.get(e).id() == Routes.get(int(w[i])).destinationN()) {
          destinationNameList.add(RQuote(Airport.get(e).Name()));
        }
      }
    }
    portUI=true;
    portFinder=false;
  }
  if (portUI) {
    if (dist(mouseX, mouseY, width-50, height-50) < 45) {
      portUI=false;
      c=0;
      reset();
    }
  }
}
/**
 * This function essentially converts the Airports ID to a longitude value
 */
float idToLongitude(float id) {
  for (int i=0; i < Airport.size(); i++) {
    if (i == id) {
      return Airport.get(i).longitude;
    }
  }
  return -1;
}
/**
 * This function essentially converts the Airports ID to a latitude value
 */
float idToLatitude(float id) {
  for (int i=0; i < Airport.size(); i++) {
    if (i == id) {
      return Airport.get(i).latitude;
    }
  }
  return -1;
}
/**
 * This function resets all the key values involved in choose two points
 */
void reset() {
  destinationID="";
  sourceID="";
  routeID="";
  sourceName="";
  destinationName="";
  sourceComplete=false;
  destinationComplete=false;
  routeComplete=false;
  sourceTyped=false;
  destinationTyped=false;
  radiusCheck=false;
  highlightCheck=false;
  destinationNameList.clear();
}
/**
 * This function takes an integer array and sorts it using the bubble sort method
 * 
 * @Param num - integer array which is to be sorted
 */
void BubbleSort(int[] num) {
  int temp;
  boolean sortFlag=true;
  while (sortFlag) {
    sortFlag=false;
    for (int i=0; i < num.length-1; i++) {
      if (num[i] < num[i+1]) {
        temp=num[i];
        num[i]=num[i+1];
        num[i+1] = temp;
        sortFlag=true;
      }
    }
  }
}
/**
 * This function does a linear search to see if a route is does actually exist, if it does 
 * then it allows for the travel from the source to the destination
 */
void checkIfExistant() {
  for (int i=0; i < Routes.size(); i++) {
    if (route.get(0).DestinationID()==int(Routes.get(i).sourceToDestination(int(route.get(0).sourceID)))) {
      route.get(0).counter++;
      startFlight=true;
    }
  }
}
/**
 * This function does a linear search to retreieve the airline ID, using the destination and source IDs
 * once retrieved it ends the loop. After retrieving the airline ID it uses a function in the Airline
 * class to call upon the Airlines named
 */
void GetID() {
  for (int i=0; i < Routes.size(); i++) {
    if (int(Routes.get(i).getCode(route.get(0).sourceID, route.get(0).destinationID)) != -1) {
      id=int(Routes.get(i).getCode(route.get(0).sourceID, route.get(0).destinationID));
      break;
    }
  }
  for (int i=0; i < airline.size(); i++) {
    if (airline.get(i).IDToName(id) != "") {
      airline.get(i).AirlineNameFinal=airline.get(i).IDToName(id);
      break;
    }
  }
}
/**
 * This function takes an integer array and a key then uses linear sort to find the amount of times
 * it can be found in the array
 * 
 * @Param data - integer array which is to be searched
 * @Param Key - the integer which is being searched for in the array
 */
int Search(int[] data, int Key) {
  int i, count=0; 
  for ( i = 0; i< data.length; i++) {
    if (data[i]==Key) {
      count++;
    }
  }
  return count;
}
FloatList countSearch(int[] data, float Key) {
  int i;
  FloatList dataSet = new FloatList();
  for ( i = 0; i< data.length; i++) {
    if (data[i] == Key) {
      dataSet.append(i);
    }
  }
  return dataSet;
}
int FlinearSearch(float[] data, float Key) {
  for (int i=0; i < data.length; i++) {
    if (data[i] == Key) {
      return i;
    }
  }
  return -1;
}
/**
 * This function takes an integer array and a key then uses linear sort to find the Key in the array
 * 
 * @Param data - integer array which is to be searched
 * @Param Key - the integer which is being searched for in the array
 */
int linearSearch(int[] data, int Key) {
  for (int i=0; i < data.length; i++) {
    if (data[i] == Key) {
      return i;
    }
  }
  return -1;
}
float UNrationalizeLongitude(float coordsX) {
  float x=coordsX;
  return ((x-800)/4.4445);
}
float UNrationalizeLatitude(float coordsY) {
  float y=coordsY;
  if (y < 400) {
    y=-y;
    return ((400+y)/RNumber);
  }
  if (y > 400) {
    return ((400-y)/RNumber);
  } else
    return 0;
}
String RQuote(String input) {
  String sourceName1=input.substring(0, 1);
  if (sourceName1.equals(str(key=34))) {
    return input.substring(1, input.length()-1);
  } else {
    return input;
  }
}