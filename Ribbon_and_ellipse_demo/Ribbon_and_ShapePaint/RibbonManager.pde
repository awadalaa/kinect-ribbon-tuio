class RibbonManager
{
  PImage img;
  int ribbonAmount;
  int ribbonParticleAmount;
  float randomness;
  String imgName;
  float tuix=0;
  float tuiy=0;
  float tuipx=0;
  float tuipy=0;
  Ribbon[] ribbons;       // ribbon array

  
  RibbonManager(int ribbonAmount, int ribbonParticleAmount, float randomness, String imgName, float tuix,float tuiy)
  {
    this.ribbonAmount = ribbonAmount;
    this.ribbonParticleAmount = ribbonParticleAmount;
    this.randomness = randomness;
    this.imgName = imgName;
    this.tuix = tuix;
    this.tuiy = tuiy;
    init();
  }
  
  void init()
  {
    img = loadImage(imgName);
    addRibbon();
  }



  void addRibbon()
  {
    ribbons = new Ribbon[ribbonAmount];
    for (int i = 0; i < ribbonAmount; i++)
    {
      int xpos = int(random(img.width));
      int ypos = int(random(img.height));
      color ribbonColor = img.get(xpos, ypos);
      println("xpos="+xpos+ ": ypos="+ypos);
      ribbons[i] = new Ribbon(ribbonParticleAmount, ribbonColor, randomness);
    }
  }
  
  void update(float currX, float currY) 
  {
    for (int i = 0; i < ribbonAmount; i++)
    {
      //float randX = currX + (randomness / 2) - random(randomness);
      //float randY = currY + (randomness / 2) - random(randomness);
      
      float randX = currX;
      float randY = currY;
      
      ribbons[i].update(randX, randY);
    }
  }
  
  void setRadiusMax(float value) { for (int i = 0; i < ribbonAmount; i++) { ribbons[i].radiusMax = value; } }
  void setRadiusDivide(float value) { for (int i = 0; i < ribbonAmount; i++) { ribbons[i].radiusDivide = value; } }
  void setGravity(float value) { for (int i = 0; i < ribbonAmount; i++) { ribbons[i].gravity = value; } }
  void setFriction(float value) { for (int i = 0; i < ribbonAmount; i++) { ribbons[i].friction = value; } }
  void setMaxDistance(int value) { for (int i = 0; i < ribbonAmount; i++) { ribbons[i].maxDistance = value; } }
  void setDrag(float value) { for (int i = 0; i < ribbonAmount; i++) { ribbons[i].drag = value; } }
  void setDragFlare(float value) { for (int i = 0; i < ribbonAmount; i++) { ribbons[i].dragFlare = value; } }
}
