// Ben Urwin | Nov 2022 | Calculator Project

Button[] numButtons = new Button[10];
Button[] opButtons = new Button[12];
String dVal = "0.0";
char op = ' ';
float l, r, result;
boolean left = true;

void setup() {
  size(355, 400);
  numButtons[0] = new Button(45, 365, 60, 60, '0');
  numButtons[1] = new Button(45, 300, 60, 60, '1');
  numButtons[2] = new Button(110, 300, 60, 60, '2');
  numButtons[3] = new Button(175, 300, 60, 60, '3');
  numButtons[4] = new Button(45, 235, 60, 60, '4');
  numButtons[5] = new Button(110, 235, 60, 60, '5');
  numButtons[6] = new Button(175, 235, 60, 60, '6');
  numButtons[7] = new Button(45, 170, 60, 60, '7');
  numButtons[8] = new Button(110, 170, 60, 60, '8');
  numButtons[9] = new Button(175, 170, 60, 60, '9');
  opButtons[0] = new Button(45, 105, 60, 60, 'C');
  opButtons[1] = new Button(110, 105, 60, 60, '±');
  opButtons[2] = new Button(175, 105, 60, 60, '%');
  opButtons[3] = new Button(240, 105, 60, 60, '÷');
  opButtons[4] = new Button(240, 170, 60, 60, 'x');
  opButtons[5] = new Button(240, 235, 60, 60, '-');
  opButtons[6] = new Button(240, 300, 60, 60, '+');
  opButtons[7] = new Button(115, 375, 40, 40, '.');
  opButtons[8] = new Button(235, 365, 185, 60, '=');
  //opButtons[9] = new Button(170, 35, 300, 60, '.');
  opButtons[9] = new Button(305, 105, 60, 60, '^');
  opButtons[10] = new Button(305, 170, 60, 60, '√');
  opButtons[11] = new Button(305, 235, 60, 60, 'π');
 // opButtons[12] = new Button(305, 300, 60, 60, '?');
}

void draw() {
  background(0, 50, 20);
  for (int i=0; i<numButtons.length; i++) {
    numButtons[i].display();
    numButtons[i].hover(mouseX, mouseY);
  }
  for (int i=0; i<opButtons.length; i++) {
    opButtons[i].display();
    opButtons[i].hover(mouseX, mouseY);
  }
  updateDisplay();
}
void mouseReleased() {
  for (int i=0; i<numButtons.length; i++) {
    if (numButtons[i].on) {
      if (dVal.equals("0.0")) {
        dVal = str(numButtons[i].val);
      } else {
        dVal += str(numButtons[i].val);
      }
      if (left) {
        l = float(dVal);
      } else {
        r = float(dVal);
      }
    }
  }
  for (int i=0; i<opButtons.length; i++) {
    if (opButtons[i].on && opButtons[i].val =='C') {
      dVal = "0.0";
      op = ' ';
      l = 0.0;
      r=0.0;
      result = 0.0;
      left = true;
    } else if (opButtons [i].on && opButtons[i].val =='+') {
      op= '+';
       dVal = "0.0";
      left = false;
    } else if (opButtons [i].on && opButtons[i].val =='-') {
      op= '-';
       dVal = "0.0";
      left = false;
    } else if (opButtons [i].on && opButtons[i].val =='÷') {
      op= '/';
       dVal = "0.0";
      left = false;
    } else if (opButtons [i].on && opButtons[i].val =='x') {
      op= 'x';
       dVal = "0.0";
      left = false;
    } else if (opButtons [i].on && opButtons[i].val =='^') {
      op= '^'; 
       dVal = "0.0";
      left = false;
    } else if (opButtons [i].on && opButtons[i].val =='√') {
      op= '√';
       dVal = "0.0";
      left = false;
    } else if (opButtons [i].on && opButtons[i].val =='=') {
      performCalculation();
    }
  }
  {

    println("L:" + l + "Op:" + op + " R:" + r + "result:" + result + " left: " + left);
  }
}
void updateDisplay() {
  fill(127);
  rect(175, 40, 320, 65);
  fill(255);
  text(dVal, width-70, 60);
}
void performCalculation() {
  if (op == '+') {
    result = l + r;
  } else if (op == '-') {
    result = l - r;
  } else if (op == 'x') {
    result = l * r;
  } else if (op == '/') {
    result = l/r;
  }
  dVal = str(result);
  l = result;
  left  = true;
}
