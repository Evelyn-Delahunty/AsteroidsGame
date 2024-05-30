class Asteroid extends Floater{
  Asteroid(){    //used to create full asteroids
    super();
    stroke = 0xFF0000FF;
    fill = 0x00000000;
    hV = (float)((Math.random() * 2 * PI) - PI) / 60;    //random rotation speed up to 30 rpm
    switch((int)(Math.random() * 2)){    //spawns asteroids on the farther vertical or horizontal edge w/ a biased random velocity, resulting in 75% of asteroids coming at the player from the farther edges
      case 0:    //spawns asteroids on horizontal edge
      x = (float)(Math.random() * wdt);
      xV = (float)((Math.random() - 0.5) * wdt / 50);
        if(player.y > hgt / 2){
          y = 0;
          yV = (float)((Math.random() - 0.25) * hgt / 100);
        }
        else{
          y = hgt;
          yV = (float)((0.25 - Math.random()) * hgt / 100);
        }
        break;
      case 1:    //spawns asteroids on vertical edge
        y = (float)(Math.random() * hgt);
        yV = (float)((Math.random() - 0.5) * hgt / 50);
        if(x > wdt / 2){
          x = 0;
          xV = (float)((Math.random() - 0.25) * wdt / 100);
        }
        else{
          x = wdt;
          xV = (float)((0.25 - Math.random()) * wdt / 100);
        }
        break;
    }
    xV *= difficulty;    //scales the velocity by difficulty
    yV *= difficulty;
    int verts = (int)(Math.random() * 5 + 4);    //number of vertices is random between 4 and 8
    vert = new float[verts][2];
    for(int i = 0; i < vert.length; i++){    //creates randomly shaped asteroids
      vert[i][0] = (float)(Math.random() * 20 + 30);    //r is random between 30 and 50
      vert[i][1] = (float)(2 * PI * ((float)i / vert.length) + (Math.random() * 0.1) - 0.05);    //points are mostly evenly spaced with some randomness
    }
  }
  
  Asteroid(float x_, float y_, float h_, float xV_, float yV_, float hV_, float[][] vert_){    //used to create fragments through the split method
    super(x_, y_, h_, xV_, yV_, hV_);
    vert = new float[vert_.length][2];
    for(int i = 0; i < vert_.length; i++){
      vert[i][0] = vert_[i][0];
      vert[i][1] = vert_[i][1];
    }
    stroke = 0xFF00FF00;
    fill = 0x00000000;
  }
  
  void split(){    //breaks an asteroid into fragments, each of which is a triangle formed by the center and two vertices of the asteroid
    for(int i = 0; i < vert.length; i++){
      float x0 = x + vert[i][0] * cos(aWrap(vert[i][1] + h));    //cartesian positions of the vertices
      float y0 = y + vert[i][0] * sin(aWrap(vert[i][1] + h));
      float x1, y1;
      if(i == vert.length - 1){
        x1 = x + vert[0][0] * cos(aWrap(vert[0][1] + h));
        y1 = y + vert[0][0] * sin(aWrap(vert[0][1] + h));
      }
      else{
        x1 = x + vert[i + 1][0] * cos(aWrap(vert[i + 1][1] + h));
        y1 = y + vert[i + 1][0] * sin(aWrap(vert[i + 1][1] + h));
      }
      float x_ = (x + x0 + x1) / 3;    //new centerpoint based on the average of the vertices
      float y_ = (y + y0 + y1) / 3;
      float[][] vert_ = new float[3][2];
      vert_[0][0] = dist(x_, y_, x, y);    //converts cartesian positions to polar positions relative to centerpoint
      vert_[0][1] = atan((y - y_) / (x - x_));
      vert_[1][0] = dist(x_, y_, x0, y0);
      vert_[1][1] = atan((y0 - y_) / (x0 - x_));
      vert_[2][0] = dist(x_, y_, x1, y1);
      vert_[2][1] = atan((y1 - y_) / (x1 - x_));
      float xV_ = xV + (x_ - x) / 30;    //preserves velocity while adding a small component launching the fragments away from each other
      float yV_ = yV + (y_ - y) / 30;
      float hV_ = (float)((Math.random() * 2 * PI) - PI) / 60;    //adds random spin
      Asteroid temp = new Asteroid(x_, y_, 0, xV_, yV_, hV_, vert_);
      fragments.add(temp);
    }
    removeAsteroid(this);
  }
}
