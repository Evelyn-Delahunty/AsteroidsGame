class Bullet extends Floater{
  int lifespan;    //number of frames before the bullet is deleted
  
  Bullet(){
    super();
    lifespan = 60;
  }
  
  Bullet(float x_, float y_, float h_, float xV_, float yV_, float hV_){
    super(x_, y_, h_, xV_, yV_, hV_);
    vert = new float[5][2];
    vert[0][0] = 10;
    vert[0][1] = 0;
    vert[1][0] = 4;
    vert[1][1] = (float)(PI / 4);
    vert[2][0] = 5;
    vert[2][1] = (float)(3 * PI / 4);
    vert[3][0] = 5;
    vert[3][1] = (float)(5 * PI / 4);
    vert[4][0] = 4;
    vert[4][1] = (float)(7 * PI / 4);
    lifespan = 60;
    stroke = 0xFFFFFF00;
    fill = 0x00000000;
  }
  
  void move(){    //custom version of move that handles lifespan
    lifespan--;
    if(lifespan <= 0){
      removeBullet(this);
    }
    else{
      x += xV;
      y += yV;
      h += hV;
      while(x >= wdt){
        x -= wdt;
      }
      while(x < 0){
        x += wdt;
      }
      while(y >= hgt){
        y -= hgt;
      }
      while(y < 0){
        y += hgt;
      }
      h = aWrap(h);
    }
  }
}
