class SpaceShip1 {
  int x, y, w, ammo, turretCount, health;
  PImage SpaceShip1;

  SpaceShip1() {
    x = 0;
    y=0;
    w= 100;
    ammo= 500;
    turretCount = 1;
    health = 1000;
    SpaceShip1 = loadImage("space ship.png");
  }

  void display(int tempx, int tempy) {
    x = tempx;
    y = tempy;
    w = 100;
    image(SpaceShip1, x, y);
    SpaceShip1.resize(50, 50);
    image(SpaceShip1, x, y);
  }

  void move() {
  }

  boolean fire() {
    if (ammo>0) {
      ammo--;
      return true;
    } else {
      return false;
    }
  }

  boolean intersect(Rock rock) {
    float d = dist(x, y, rock.x, rock.y);
    if (d<rock.diam/2) {
      return true;
    } else {
      return false;
    }
  }
}
