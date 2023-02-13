class PowerUp {
  int x, y, speed, diam;
  char type;

  //Constructor
  PowerUp() {
    x = int(random(width));
    y = -50;
    speed = int(random(2, 8));
    diam = int(random(50, 90));
    if (random(2)==0) {
      type = 'H';
    } else {
      type = 'A';
    }
  }
  void display() {
    fill(0, 0, 200);
    ellipse(x, y, diam, diam);
    fill(222);
    text(type, x, y);
  }
  void move() {
    y += speed;
  }
  boolean reachedBottom() {
    if (y>height+100) {
      return true;
    } else {
      return false;
    }
  }
  boolean intersect(SpaceShip1 ship) {
    float d = dist(x, y, ship.x, ship.y);
    if (d<30) {
      return true;
    } else {
      return false;
    }
  }
  }
