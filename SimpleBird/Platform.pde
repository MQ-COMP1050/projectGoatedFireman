class Platform {
  float x;
  float y;
  float dx = 0;
  float dy = 0;
  float wide = 0;
  float high = 0;
  color myColor = color(150, 200, 100);

  Platform(float initX, float initY, float initWide, float initHigh) {
    x  = initX;
    y = initY;
    wide = initWide;
    high = initHigh;
  }

  void display() {
    noStroke();
    fill(myColor);
    rect(x, y, wide, high);
  }

  void animate() {

    dx = constrain(dx + random(-0.02, 0.02), -0.5, 0.5);
    dy = constrain(dy + random(-0.02, 0.02), -0.5, 0.5);

    x += dx;
    y += dy;
    
    if (x<0 && dx < 0) {
      dx = -dx;
    }
    if (y<0 && dy < 0) {
      dy = -dy;
    }
    if (x+wide>width && dx > 0) {
      dx = -dx;
    }
    if (y+high>height && dy > 0) {
      dy = -dy;
    }
  }


  boolean is_on_platform(float inX, float inY) {
    return (inX>=x && inX<=x+wide && inY>=y && inY <= y+high);
  }
}
