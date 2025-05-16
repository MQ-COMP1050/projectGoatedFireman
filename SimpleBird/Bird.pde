class Bird {
  //position and speed. The movement is smooqther if you manipulate speed, instead of position.
  float x;
  float y;
  float xSpeed;
  float ySpeed;

  //the colors
  color birdColor;
  color beakColor;

  Eye leftEye;
  Eye rightEye;


  Bird(float initX, float initY, int initRadius) {
    //use provided arguments to initialise attributes
    x = initX;
    y = initY;
    xSpeed = 0;
    ySpeed = 0;
    birdColor = color(230, 220, 50);
    beakColor = color(150, 140, 145);
    leftEye = new Eye(-60, -60);
    rightEye = new Eye(-40, -60);
  }

  void display() {
    pushMatrix();
    translate(x, y);//Everything is now relative to x and y, the position of the bird.
    stroke(50, 50);
    noStroke();
    fill(birdColor);
    ellipse(0, 0, 100, 100);  //body
    ellipse(-50, -50, 50, 50); //head

    //eyes
    leftEye.display();
    rightEye.display();

    //beak
    noStroke();
    fill(beakColor);
    triangle(-70, -60, -70, -40, -100, -45);

    popMatrix();//Now everything is normal again
  }


  void animate(Platform obstacle) {

    //Update speed
    if (obstacle.is_on_platform(x, y)||obstacle.is_on_platform(x, y+50)) {
      waddle();
    } else {
      swim();
    }
    
    boundaryCheck();
    
    leftEye.animate();
    rightEye.animate();

    if (mousePressed) {
      poke(mouseX, mouseY);
    }
  }


  void swim() {

    xSpeed = constrain(xSpeed + random(-0.2, 0.2), -2, 0);
    //The speed in horizontal direction can be evenly random

    x += xSpeed;
    y += ySpeed;
  }


  void waddle() {
    //After the the bird wins it proceeds to the exit
    xSpeed = constrain(xSpeed + random(-0.6, 0.6), -4, -1);
    ySpeed = constrain(ySpeed + random(-0.05, 0.05), -0.5, 0.5);
    if (random(0, 1)<0.10 ) {
      leftEye.close(10);
    }
    if (random(0, 1)<0.10 ) {
      rightEye.close(10);
    }
    //Update position
    x += xSpeed;
    y += ySpeed;
  }

  void boundaryCheck() {
    //Check the borders
    if (x < -100) { //reset to the right border
      x = width + 100;
      xSpeed = -3;
    }
    if (y < 75 && ySpeed < 0) {
      ySpeed = 1;
    }
    if (x > width + 100) {
      xSpeed = -1;
    } else {
    }
    if (y > height - 50 && ySpeed > 0) {
      ySpeed = -1;
    } else {
      ySpeed = ySpeed;
    }
  }

  void poke(float mx, float my) {
    if (dist(mx, my, x, y) <= 50) {
      leftEye.close(100);
      rightEye.close(100);
    }
  }
}
