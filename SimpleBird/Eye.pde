class Eye {
    float x;
    float y;
    boolean isSquinting;
    int squintCounter = 0;

    Eye(float initX, float initY) {
        x = initX;
        y = initY;
        isSquinting = false;
    }

    void display() {
        if (isSquinting) {
            noStroke();
            fill(255);
            ellipse(x, y, 16, 16);
            strokeWeight(1);
            stroke(0);
            line(x - 8, y, x + 8, y);
        } else {
            noStroke();
            fill(255);
            ellipse(x, y, 16, 16);
            fill(0);
            ellipse(x - 1, y - 1, 5, 5);
        }
    }

    void animate() {
        //Open the eyes again
        if (squintCounter == 0) {
            open();
        }

        if (squintCounter > 0) {
            squintCounter--;
        }
    }

    void open() {
        isSquinting = false;
    }

    void close(int duration) {
        isSquinting = true;
        squintCounter = duration;
    }
}
