/**
 * This Class serves to visualize the flight path of the Plane from the Source Airport
 * to the Destination Airport. It also controls updating and creating the key points
 * 
 * @author Krish Chowdhary
 * @version 1.5
 * @since Processing 3.0b6
 * @since December 2015
 */
class Plane {
  PImage plane;
  float sourceX;
  float sourceY;
  float destinationX;
  float destinationY;
  float x;
  float y;
  int sourceID;
  int destinationID;
  int counter;
  int firstAppearance;
  int amountOfAppearances;
  float checkIfRoute;
  ArrayList rangeOfAppearances;
  boolean scale;
  boolean routeExists;
  boolean moveDirect;
  float degreeAngle;
  float velocityX, velocityY;
  /**
   * This constructor takes in the indentification of both the destination and source airports and 
   * effectivly converts them to longitude and latitude values (x and y values)
   *
   * @Param source - this is the ID of the source Airport
   * @Param destination - this is the ID of the destination Airport
   */
  Plane(float source, float destination) {
    plane = Plane;
    for (int i=0; i < Airport.size(); i++) {
      if (Airport.get(i).id == source) {
        sourceX = Airport.get(i).Longitude();
        sourceY = Airport.get(i).Latitude();
        continue;
      }
    }
    for (int i=0; i < Airport.size(); i++) {
      if (Airport.get(i).id == destination) {
        destinationX = Airport.get(i).Longitude();
        destinationY = Airport.get(i).Latitude();
        continue;
      }
    }
    x=sourceX;
    y=sourceY;
    sourceID=int(source);
    destinationID=int(destination);
  }
  /**
   * This function visualizes the two points, being source and destination and draws the plane
   */
  void points() {
    fill(0, 255, 0);
    ellipse(sourceX, sourceY, 15, 15);
    fill(255, 0, 0);
    ellipse(destinationX, destinationY, 15, 15);
    if (counter > 0) {
      if (scale) {
        scale(-1, 1);
        image(plane, -x, y, 70, 70);
      } 
      if (!scale) {
        image(plane, x, y, 70, 70);
      }
    }
    if (sourceX > width/2) {
      if (dist(sourceX, sourceY, destinationX, destinationY) < (dist(sourceX, sourceY, width, destinationY) + dist(0, destinationY, destinationX, destinationY))) {
        moveDirect=true;
      }
    }
    if (sourceX < width/2) {
      if (dist(sourceX, sourceY, destinationX, destinationY) < (dist(sourceX, sourceY, 0, sourceY) + dist(width, destinationY, destinationX, destinationY))) {
        moveDirect=true;
      }
    }
  }
  /**
   * This function updates the plane while also restricting its movement to be going 
   * towards the destination
   */
  void update() {
    if (!points) {
      if (moveDirect) {
        float xD=dist(sourceX, 0, destinationX, 0);
        float yD=dist(0, sourceY, 0, destinationY);
        if (xD > yD) {
          velocityY=yD/xD;
          velocityX=1;
        } else {
          velocityX=xD/yD;
          velocityY=1;
        }
        if (mousePressed) {
          if (x >= destinationX) {
            x=x-(5*velocityX);
            scale=true;
          }
          if (x <= destinationX) {
            x=x+(5*velocityX);
            scale=false;
          }
          if (y >= destinationY) {
            y=y-(5*velocityY);
          }
          if (y <= destinationY) {
            y=y+(5*velocityY);
          }
        } else {
          if (x >= destinationX) {
            x=x-velocityX;
            scale=true;
          }
          if (x <= destinationX) {
            x=x+velocityX;
            scale=false;
          }
          if (y >= destinationY) {
            y=y-velocityY;
          }
          if (y <= destinationY) {
            y=y+velocityY;
          }
        }
      }
      if (!moveDirect) {
        if (x > width) {
          x=0;
        }
        if (x < 0) {
          x=width;
        }
        if (sourceX > width/2) {
          float xD=dist(sourceX, sourceY, width, sourceY);
          float yD=dist(0, sourceY, 0, destinationY);
          float xD2=dist(0, destinationY, destinationX, destinationY);
          if ((xD+xD2) > yD) {
            velocityY=yD/(xD+xD2);
            velocityX=1;
          } else {
            velocityX=(xD+xD2)/yD;
            velocityY=1;
          }
          if (mousePressed) {
            if (x >= destinationX && x>=width/2) {
              x=x+(5*velocityX);
              scale=false;
            }
            if (x <= destinationX && x<=width/2) {
              x=x+(5*velocityX);
              scale=false;
            }
            if (y >= destinationY) {
              y=y-(5*velocityY);
            }
            if (y <= destinationY) {
              y=y+(5*velocityY);
            }
          } else {
            if (x >= destinationX && x>=width/2) {
              x=x+velocityX;
              scale=false;
            }
            if (x <= destinationX && x<=width/2) {
              x=x+velocityX;
              scale=false;
            }

            if (y >= destinationY) {
              y=y-velocityY;
            }
            if (y <= destinationY) {
              y=y+velocityY;
            }
          }
        }
        if (sourceX < width/2) {
          float xD=dist(sourceX, sourceY, 0, sourceY);
          float yD=dist(0, sourceY, 0, destinationY);
          float xD2=dist(width, destinationY, destinationX, destinationY);
          if ((xD+xD2) > yD) {
            velocityY=yD/(xD+xD2);
            velocityX=1;
          } else {
            velocityX=(xD+xD2)/yD;
            velocityY=1;
          }
          if (mousePressed) {
            if (x >= destinationX && x>=width/2) {
              x=x-(5*velocityX);
              scale=true;
            }
            if (x <= destinationX && x<=width/2) {
              x=x-(5*velocityX);
              scale=true;
            }
            if (y >= destinationY) {
              y=y-(5*velocityY);
            }
            if (y <= destinationY) {
              y=y+(5*velocityY);
            }
          } else {
            if (x >= destinationX && x >=width/2) {
              x=x-velocityX;
              scale=true;
            }
            if (x <= destinationX && x <=width/2) {
              x=x-velocityX;
              scale=true;
            }
            if (y >= destinationY) {
              y=y-velocityY;
            }
            if (y <= destinationY) {
              y=y+velocityY;
            }
          }
        }
      }
    }
  }


  /**
   * This function checks the mouse position and then begins another function which will verify the
   * the routes existance
   */
  void startFlight() {
    if (mousePressed && dist(mouseX, mouseY, sourceX, sourceY) < 20) {
      checkIfExistant();
    }
  }
  /**
   * This function returns the ID of the destination Airport
   */
  int DestinationID() {
    return destinationID;
  }
  int SourceID() {
    return sourceID;
  }
}