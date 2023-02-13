// Ben Urwin | Nov 28 2022| Spacegame
import processing.sound.*;
SoundFile blaster;
SpaceShip1 s1;
Timer rockTimer, puTimer;
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<PowerUp> powerups = new ArrayList<PowerUp>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
Star[] stars = new Star[100];
int score, level, rockRate, rockCount, rocksPassed;
boolean play;


void setup() {
  size(800, 800);
  s1 = new SpaceShip1();
  rockRate = 500;
  puTimer = new Timer(10000);
  puTimer.start();
  rockTimer = new Timer(rockRate);
  rockTimer = new Timer(int(random(600, 2000)));
  rockTimer.start();
  blaster = new SoundFile(this, "Blaster.wav");
  for (int i=0; i<stars.length; i++) {
    stars[i] = new Star();
  }

  score = 0;
  level = 1;
  rocksPassed = 0;
  play = false;
}
// Rendering stars
void draw() {
  if (!play) {
    startScreen();
  } else {
    //level handling
    if (frameCount % 1000 == 10) {
      level++;
      rockRate-=10;
    }
    background(128, 150, 0);
    infoPanel();
    for (int i=0; i<stars.length; i++) {
      stars[i].display();
      stars[i].move();
    }
    //add PowerUps
    if (puTimer.isFinished()) {
      powerups.add(new PowerUp());
      puTimer.start();
      println("PowerUps:" + rocks.size());
    }
    // rendering PowerUps and detecting ship collision
    for (int i = 0; i < powerups.size(); i++) {
      PowerUp pu = powerups.get(i);
      if (pu.intersect(s1)) {
        if (pu.type == 'H') {
          s1.health+=100;
        } else {
          s1.ammo+=100;
        }
        powerups.remove(pu);
        // add sound for explosion
        //consider adding rock health
      }
      if (pu.reachedBottom()) {
        powerups.remove(pu);
      } else {
        pu.display();
        pu.move();
      }
    }

    //add rocks
    if (rockTimer.isFinished()) {
      rocks.add(new Rock());
      rockTimer.start();
      println(rocks.size());
    }
    // rendering rocks and detecting ship collision
    for (int i = 0; i < rocks.size(); i++) {
      Rock r = rocks.get(i);
      if (s1.intersect(r)) {
        s1.health-=r.diam;
        rocks.remove(r);
        // add sound for explosion
        //consider adding rock health
        score+=r.diam;
        rocks.remove(r);
      }
      if (r.reachedBottom()) {
        rocksPassed++;
        rocks.remove(r);
      } else {
        r.display();
        r.move();
      }
    }

    //rendering lasers and detectign laser collision
    for (int i = 0; i < lasers.size(); i++) {
      Laser l = lasers.get(i);
      for (int j = 0; j < rocks.size(); j++) {
        Rock r = rocks.get(j);
        if (l.intersect(r)) {
          //add sound to collision
          //add animation to the collision
          r.diam-=30;
          if (r.diam<30) {
            rocks.remove(r);
          }

          lasers.remove(l);
          score+=r.diam;
        }
        if (l.reachedTop()) {
          lasers.remove(l);
        } else {
          l.display();
          l.move();
        }
      }
    }
    s1.display(mouseX, mouseY);
    infoPanel();

    //game over logic
    if (s1.health<1) {
      gameOver();
    }
  }
}


//add Laser based on event
void mousePressed() {
  blaster.stop();
  blaster.play();
  if (s1.fire()&& s1.turretCount == 1) {
    lasers.add(new Laser(s1.x, s1.y));
    s1.ammo--;
  } else if (s1.fire()&& s1.turretCount == 2) {
    lasers.add(new Laser(s1.x-20, s1.y));
    lasers.add(new Laser(s1.x+20, s1.y));
    s1.ammo = s1.ammo-2;
  } else if (s1.fire()&& s1.turretCount == 3) {
    lasers.add(new Laser(s1.x-20, s1.y));
    lasers.add(new Laser(s1.x+20, s1.y));
    lasers.add(new Laser(s1.x, s1.y));
    s1.ammo = s1.ammo-3;
  }
}
void startScreen() {
  background(0);
  fill(222);
  textAlign(CENTER);
  text("Press any key to begin...", width/2, height/2);
  if (mousePressed || keyPressed) {
    play = true;
  }
}

void gameOver() {
  background(0);
  fill(222);
  textAlign(CENTER);
  text("Game Over!", width/2, height/2);
  play = false;
  noLoop();
}

void infoPanel() {
  fill(35, 37);
  rectMode(CENTER);
  rect(width/2, 25, width, 50);
  fill(255);
  textSize(15);
  textAlign(CENTER);
  text("SPACEGAME" + " | Rocks Passed:" + rocksPassed +
    " | Health:" + s1.health +
    "| Level:" + level +
    " | Score:" + score +
    " | Ammo:" + s1.ammo, width/2, 35);
}
