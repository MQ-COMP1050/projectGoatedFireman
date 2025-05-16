/*
A simple Bird. 

This program contains a few less and more serious issues.

Your task is to address them.

*/

// This is a new comment
Bird tweety;
Bird raven;
Platform Deck;


void setup() {
    size(1000, 600);

    tweety   = new Bird(random(700, 900), random( 80, 180),50);
    raven    = new Bird(random(700, 900), random(180, 280),50);
    Deck = new Platform(100,200,300,250);
   
}

void draw() {
    //background water and endzone
    background(0, 0, 200);
    

Deck.display();
    tweety.display();
    raven.display();
    Deck.animate();
    tweety.animate(Deck);
    raven.animate(Deck);    
    
}

void mousePressed() {
    //Move here the code that pokes the bird if the mouse if pressed.
}
