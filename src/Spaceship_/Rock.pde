class Rock {
  int x, y, speed, diam;
  PImage rock;

  //Constructor
  Rock() {
    x = int(random(width));
    y = -50;
    speed = int(random(2, 8));
    diam = int(random(50,90));
    rock = loadImage("Rock.png");
  }

  void display() {
    imageMode(CENTER);
    rock.resize(diam, diam);
    image(rock, x, y);
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
}
