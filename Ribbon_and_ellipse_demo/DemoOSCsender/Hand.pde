
class Hand{
  float lasttuix=0;
  float lasttuiy=0;
  float tuix=0;
  float tuiy=0;
  float tuipx=0;
  float tuipy=0;
  
  Hand(float x, float y, float px, float py) 
  {
    this.tuix = x;
    this.tuiy = y;
    this.tuipx=px;
    this.tuipy=py;
  }
  
  void setMouse(float x, float y, float px, float py) 
  {
    this.tuix = x;
    this.tuiy = y;
    this.tuipx=px;
    this.tuipy=py;
  }
}

