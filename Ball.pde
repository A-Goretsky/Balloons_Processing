class Ball {
  
  final static int MOVING = 0;
  final static int GROWING = 1;
  final static int SHRINKING = 2;
  final static int DEAD = 3;
      
  boolean crashed;
  float x, y, dx, dy, rad;
  color c;
  int state;

  Ball() {
    crashed = false;
    float r = random(256);
    float g = random(256);
    float b = random(256);
    c = color( r, g, b );
    
    rad = 10;

    //coordinates
    x = random( (width - r) + r/2 );
    y = random( (height - r) + r/2 );

    //direction / speed
    dx = random(10) - 5;
    dy = random(10) - 5;
    
    state = MOVING;
  }
  

  void move() {
    x = x + dx;
    y = y + dy;
    bounce();
  }
 
 void bounce() {
   if( x < rad || x >= width - rad ) {
      x = x + dx;
    }
    if( y < rad || y >= height - rad ) {
      y = y + dy;  
    }
 }
 
 void grow() {
   if( rad < 50 && crashed == false ) {
     rad += 0.5;
   } else {
     state = SHRINKING;
   }
 }
 
 void shrink() {
   if( rad > 0.5 ) {
     state = SHRINKING;
     rad -= 0.5;     
   } else {
     state = DEAD;
   }
 }
 
 void display() {
   fill( c );
   ellipse( x, y, 2*rad, 2*rad );
 }
 
 boolean isTouching( Ball other ) {
   return other.rad + rad > dist( other.x, other.y, x, y );
 }
 
 void checkCollision(ArrayList<Ball> balls) {
    for (int i = 0; i < balls.size (); i++) {
       Ball temp = balls.get(i);
       if (state == MOVING && isTouching(temp) && (temp.state == GROWING || temp.state == SHRINKING)) {
         state = GROWING;
         temp.crashed = true;
       }
     }
  }
  
  void process() {
    if (state == MOVING || 
        state == GROWING || 
        state == SHRINKING) {
      display();
    }
    if (state == MOVING) {
      move();
    }
    if (state == GROWING) {
      grow();
    } else if (state == SHRINKING) {
      shrink();
    }
  }
  
}//end class Ball
