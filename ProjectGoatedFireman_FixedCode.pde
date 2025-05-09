// Goat's position and speed
float goatX, goatY;
float goatSpeedX = 3;
float goatSpeedY = 2;

// Game state
boolean gameOver = false;

// Building data
int numBuildings;
float[] buildingHeights;
boolean[][][] windowStates;

void setup() {
  size(900, 700);
  resetGame();

  // Initialize buildings
  numBuildings = width / 100;
  buildingHeights = new float[numBuildings];
  windowStates = new boolean[numBuildings][][];

  for (int i = 0; i < numBuildings; i++) {
    buildingHeights[i] = random(150, 400);
    int rows = int(buildingHeights[i] / 40);
    int cols = 3;
    windowStates[i] = new boolean[rows][cols];
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        windowStates[i][row][col] = random(1) > 0.4; // 60% chance light is on
      }
    }
  }
}

void draw() {
  if (gameOver) {
    background(0, 200, 0); // green background on success
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(24);
    text("You caught the goat!\nPress 'r' to restart", width / 2, height / 2);
    return;
  }

  drawBuildings();

  // Update goat position
  goatX += goatSpeedX;
  goatY += goatSpeedY;

  // Bounce off walls
  if (goatX < 0 || goatX > width) {
    goatSpeedX *= -1;
  }
  if (goatY < 0 || goatY > height) {
    goatSpeedY *= -1;
  }

  // Draw fireman at mouse position
  drawFireman(mouseX, mouseY);

  // Draw goat
  drawGoat(goatX, goatY);

  // Check for collision
  float d = dist(mouseX, mouseY, goatX, goatY);
  if (d < 50) {
    gameOver = true;
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    resetGame();
  }
}

void resetGame() {
  gameOver = false;
  goatX = random(100, width - 100);
  goatY = random(100, height - 100);
  goatSpeedX = random(2, 4) * (random(1) > 0.5 ? 1 : -1);
  goatSpeedY = random(2, 4) * (random(1) > 0.5 ? 1 : -1);
}

// Draw buildings behind the action
void drawBuildings() {
  // Sky
  background(135, 206, 235); // light blue sky

  // Draw buildings
  for (int i = 0; i < numBuildings; i++) {
    float x = i * 100;
    float h = buildingHeights[i];

    // Building body (brown brick)
    fill(139, 69, 19);
    noStroke();
    rect(x, height - h, 80, h);

    // Windows (squared and persistent)
    int rows = windowStates[i].length;
    int cols = windowStates[i][0].length;

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        float wx = x + 10 + col * 20;
        float wy = height - h + 10 + row * 40;

        if (windowStates[i][row][col]) {
          fill(255, 255, 100); // lit
        } else {
          fill(30); // unlit
        }

        rect(wx, wy, 18, 18, 4); // squarish window
      }
    }
  }
}

// Drawing functions

void drawFireman(float x, float y) {
  // Body
  fill(255, 0, 0);
  rect(x - 25, y, 50, 80);

  // Arms
  fill(255, 0, 0);
  rect(x - 45, y, 20, 60);
  rect(x + 25, y, 20, 60);

  // Legs
  fill(0, 0, 255);
  rect(x - 20, y + 80, 15, 40);
  rect(x + 5, y + 80, 15, 40);

  // Boots
  fill(0); 
  rect(x - 20, y + 120, 15, 10);
  rect(x + 5, y + 120, 15, 10);

  // Head
  fill(255, 220, 180);
  ellipse(x, y - 30, 50, 50);

  // Eyes
  fill(0);
  ellipse(x - 10, y - 35, 5, 5);
  ellipse(x + 10, y - 35, 5, 5);

  // Smile
  noFill();
  stroke(0);
  arc(x, y - 20, 20, 10, 0, PI);

  // Helmet
  fill(255, 0, 0);
  arc(x, y - 50, 60, 40, PI, TWO_PI);
  rect(x - 15, y - 65, 30, 10);

  // Badge
  fill(255, 255, 0);
  ellipse(x, y - 50, 10, 10);
}

void drawGoat(float x, float y) {
  // Body
  fill(180);
  ellipse(x, y, 80, 50);

  // Legs
  stroke(0);
  strokeWeight(2);
  line(x - 20, y + 25, x - 20, y + 40);
  line(x + 20, y + 25, x + 20, y + 40);

  // Head
  noStroke();
  fill(200);
  ellipse(x + 40, y - 10, 40, 40);

  // Horns
  stroke(150, 100, 50);
  strokeWeight(3);
  noFill();
  arc(x + 35, y - 30, 20, 20, PI, TWO_PI);
  arc(x + 45, y - 30, 20, 20, PI, TWO_PI);

  // Eyes
  fill(0);
  ellipse(x + 35, y - 10, 4, 4);
  ellipse(x + 45, y - 10, 4, 4);

  // Nose
  fill(100);
  ellipse(x + 38, y + 5, 3, 3);
  ellipse(x + 42, y + 5, 3, 3);

  // Beard
  stroke(150);
  line(x + 40, y + 10, x + 40, y + 20);
}
