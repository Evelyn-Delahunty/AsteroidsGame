class Floater{
  float x, y, h, xV, yV, hV;    //coordinates and velocities for the position and heading of the centerpoint
  color stroke, fill;
  float[][] vert;    //array of polar coords for vertices of entity relative to centerpoint, first is r, second is theta
  
  Floater(){
    x = 0;
    y = 0;
    h = 0;
    xV = 0;
    yV = 0;
    hV = 0;
    stroke = 0x00000000;
    fill = 0x00000000;
  }
  
  Floater(float x_, float y_, float h_, float xV_, float yV_, float hV_){
    x = x_;
    y = y_;
    h = h_;
    xV = xV_;
    yV = yV_;
    hV = hV_;
    stroke = 0x00000000;
    fill = 0x00000000;
  }
  
  Floater(float x_, float y_, float h_, float xV_, float yV_, float hV_, color stroke_, color fill_, float[][] vert_){
    x = x_;
    y = y_;
    h = h_;
    xV = xV_;
    yV = yV_;
    hV = hV_;
    stroke = stroke_;
    fill = fill_;
    vert = new float[vert_.length][2];
    for(int i = 0; i < vert.length; i++){
      vert[i][0] = vert_[i][0];
      vert[i][1] = vert_[i][1];
    }
  }
  
  void move(){
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
  
  void show(){
    stroke(stroke);
    fill(fill);
    for(int i = 0; i < vert.length - 1; i++){    //draws all sides except the connection between the last and first vertices
      float x0 = x + vert[i][0] * cos(aWrap(vert[i][1] + h));    //cartesian locations of the vertices on screen, accounting for heading
      float y0 = y + vert[i][0] * sin(aWrap(vert[i][1] + h));
      float x1 = x + vert[i + 1][0] * cos(aWrap(vert[i + 1][1] + h));
      float y1 = y + vert[i + 1][0] * sin(aWrap(vert[i + 1][1] + h));
      line(x0, y0, x1, y1);
    }
    float x0 = x + vert[vert.length - 1][0] * cos(aWrap(vert[vert.length - 1][1] + h));    //cartesian locations of the vertices on screen, accounting for heading
    float y0 = y + vert[vert.length - 1][0] * sin(aWrap(vert[vert.length - 1][1] + h));
    float x1 = x + vert[0][0] * cos(aWrap(vert[0][1] + h));
    float y1 = y + vert[0][0] * sin(aWrap(vert[0][1] + h));
    line(x0, y0, x1, y1);    //connection between last and first vertices
  }
}
