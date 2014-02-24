/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;
final int maxHands = 10;
Hand[] hands;
int totHands=0;

void setup() {
  hands = new Hand[maxHands];
  for (int i=0;i<maxHands;i++) hands[i] =  new Hand(0.0,0.0,0.0,0.0);
  initTUIO();
  size(400,400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
  
}


void draw() {
  updateTUIO();
  background(0);  
}

void sendData() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("incoming tuidata");
  float[] tuidata = new float[totHands*4+1]; 
  
  tuidata[0] = totHands;
  for(int i=0; i<totHands; i++){
      tuidata[i*4+1] = hands[i].tuix;
      tuidata[i*4+2] = hands[i].tuiy;
      tuidata[i*4+3] = hands[i].tuipx;
      tuidata[i*4+4] = hands[i].tuipy;
    } 
    myMessage.add(tuidata); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
}

/*
// incoming osc message are forwarded to the oscEvent method. 
void oscEvent(OscMessage theOscMessage) {
  // print the address pattern and the typetag of the received OscMessage 
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}*/
