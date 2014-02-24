import processing.opengl.*;
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;

boolean TESTING = false;
boolean ribbon_demo = false;
boolean ellipse_demo = true;
boolean rect_demo = true;

int ribbonAmount = 1;
int ribbonParticleAmount = 20;
float randomness = .2;
RibbonManager[] ribbonManagers;
RibbonManager[] ribbonManager2;
int totalHandsReceiver=0;
int totalHandsBroadcaster=0;
int totalHands=0;
float tuipx=0;
float tuipy=0;
final int maxHands = 10;
Hand[] hands;
int handID=0;

void setup()
{
  size(940, 480, OPENGL);
  frameRate(25);
  background(255);
  
  // communicate to other computer's kinect through OSC on this port
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
  
  ribbonManagers = new RibbonManager[maxHands];
  ribbonManager2 = new RibbonManager[maxHands];
  for (int i=0;i<maxHands;i++){
    ribbonManagers[i] = new RibbonManager(ribbonAmount, ribbonParticleAmount, randomness, "rothko2.jpg",0,0); //these are the ribbons from the 1st mac connected to the display
    ribbonManagers[i].setRadiusMax(12);                 // default = 8
    ribbonManagers[i].setRadiusDivide(10);              // default = 10
    ribbonManagers[i].setGravity(.07);                   // default = .03
    ribbonManagers[i].setFriction(1.1);                  // default = 1.1
    ribbonManagers[i].setMaxDistance(40);               // default = 40
    ribbonManagers[i].setDrag(2.5);                      // default = 2
    ribbonManagers[i].setDragFlare( .015);                 // default = .008
    
    ribbonManagers[i].setRadiusMax(17);                 // default = 8
    ribbonManagers[i].setRadiusDivide(8);              // default = 10
    ribbonManagers[i].setGravity(.04);                   // default = .03
    ribbonManagers[i].setFriction(1.0);                  // default = 1.1
    ribbonManagers[i].setMaxDistance(30);               // default = 40
    ribbonManagers[i].setDrag(2.2);                      // default = 2
    ribbonManagers[i].setDragFlare( .04);                 // default = .008
  }
  for (int i=0;i<maxHands;i++){
    ribbonManager2[i] = new RibbonManager(ribbonAmount, ribbonParticleAmount, randomness, "rothko2.jpg",0,0); //these are the ribbons from the 1st mac connected to the display
    ribbonManager2[0].setRadiusMax(17);                 // default = 8
    ribbonManager2[0].setRadiusDivide(8);              // default = 10
    ribbonManager2[0].setGravity(.04);                   // default = .03
    ribbonManager2[0].setFriction(1.0);                  // default = 1.1
    ribbonManager2[0].setMaxDistance(30);               // default = 40
    ribbonManager2[0].setDrag(2.2);                      // default = 2
    ribbonManager2[0].setDragFlare( .04);                 // default = .008
  }
  hands = new Hand[maxHands];
  for (int i=0;i<maxHands;i++) hands[i] =  new Hand(0.0,0.0,0.0,0.0);
  // init TUIO
  initTUIO();
}                    
void draw()
{
  //variableEllipse(mouseX, mouseY, pmouseX, pmouseY);
  fill(255, 12);
  rect(0, 0, width, height);
  updateTUIO();
  for (int j=0; j<totalHandsReceiver; j++){
    if (ribbon_demo){
      if (ribbonManagers[j] != null){
        ribbonManagers[j].update(ribbonManagers[j].tuix*width, ribbonManagers[j].tuiy*height);
        //ribbonManager2.update(tuix + int(random(100)-50), tuiy + int(random(100)-50));
      }
    }else if(ellipse_demo){
      fill(random(255),random(255),random(255),random(100));
      if (hands != null)
        //variableEllipse(mouseX, mouseY, pmouseX, pmouseY);
        println("x="+hands[j].tuix+"y="+hands[j].tuiy+"px="+hands[j].tuipx+"py="+hands[j].tuipy);
        variableEllipse(hands[j].tuix, hands[j].tuiy, hands[j].tuipx, hands[j].tuipy);  
    }else if(rect_demo){
      fill(random(255),random(255),random(255),random(100));
      if (hands != null)
        variableRect(hands[j].tuix, hands[j].tuiy, hands[j].tuipx, hands[j].tuipy);  
    }
  }
  for (int j=0; j<totalHandsBroadcaster; j++){
   if (ribbon_demo){
    if (ribbonManager2[j] != null){
        ribbonManager2[j].update(ribbonManager2[j].tuix*width, ribbonManager2[j].tuiy*height);
        //ribbonManager2.update(tuix + int(random(100)-50), tuiy + int(random(100)-50));
      }
    }else if(ellipse_demo){
      fill(random(255),random(255),random(255),random(100));
      if (hands != null)
        variableEllipse(hands[j].tuix, hands[j].tuiy, hands[j].tuipx, hands[j].tuipy);  
    }else if(rect_demo){
      fill(random(255),random(255),random(255),random(100));
      if (hands != null)
        variableRect(hands[j].tuix, hands[j].tuiy, hands[j].tuipx, hands[j].tuipy);  
    }
    variableRect(hands[j].tuix, hands[j].tuiy, hands[j].tuipx, hands[j].tuipy);  
   }
}

void variableEllipse(float x, float y, float px, float py) 
{
   float speed = abs(x-px) + abs(y-py);
   noStroke();
   for (int i = 0; i < 10; i++)
   {
      fill(random(255),random(255),random(255),random(100));
      ellipse(x+ int(random(50)-25), y+ int(random(50)-25), speed/width + int(random(50)-25), speed/height + int(random(50)-25));
   }
}

void variableRect(float x, float y, float px, float py) 
{
  float speed = abs(x-px) + abs(y-py);
  noStroke();
  
  
  for (int i = 0; i < 20; i++)
  {
     fill(random(255),random(255),random(255),random(100));
     rect(x+ int(random(50)-25), y+ int(random(50)-25), speed/width + int(random(50)-25), speed/height + int(random(50)-25));
  }
}

void setTotHands(int numHands) 
{
  totalHandsReceiver = numHands;
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  totalHandsBroadcaster = theOscMessage.get(0).intValue();
  for (int i=0; i<totalHandsBroadcaster; i++){
    ribbonManager2[i].tuix = theOscMessage.get(i+1).floatValue();
    ribbonManager2[i].tuiy = theOscMessage.get(i+2).floatValue();
    ribbonManager2[i].tuipx = theOscMessage.get(i+3).floatValue();
    ribbonManager2[i].tuipy = theOscMessage.get(i+4).floatValue();
    hands[i].tuix  = theOscMessage.get(i+1).floatValue();
    hands[i].tuiy  = theOscMessage.get(i+2).floatValue();
    hands[i].tuipx = theOscMessage.get(i+3).floatValue();
    hands[i].tuipy = theOscMessage.get(i+4).floatValue();
}
  
}


void keyPressed() {
  if (key == '1') {
    ribbon_demo = true;
    ellipse_demo = false;
    rect_demo=false;
  } 
  else if (key == '2') {
    ribbon_demo = false;
    ellipse_demo = true;
    rect_demo=false;
  }
  else if (key == '3') {
    ribbon_demo = false;
    ellipse_demo = false;
    rect_demo=true;
  } 
}

