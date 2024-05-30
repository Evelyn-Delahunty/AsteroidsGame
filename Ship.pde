class Ship extends Floater{
  int cooldown;    //how long the player must wait between shots, in frames
  
  Ship(){
    super(wdt / 2, hgt / 2, 0, 0, 0, 0);
    vert = new float[3][2];
    vert[0][0] = 20;
    vert[0][1] = 0;
    vert[1][0] = 10;
    vert[1][1] = (float)(4 * PI / 6);
    vert[2][0] = 10;
    vert[2][1] = (float)(8 * PI / 6);
    cooldown = 0;
    stroke = 0xFFFFFFFF;
    fill = 0x00000000;
  }
  
  void shoot(){    //fires if the cooldown has elapsed
    if(cooldown <= 0){
      Bullet bullet = new Bullet(x, y, h, xV + 20 * cos(h), yV + 20 * sin(h), 0);    //spawns a new bullet in the center of the ship with the ship's velocity + 20 in the direction the ship faces
      bullets.add(bullet);
      cooldown = 20;
    }
  }
  
  void thrust(){    //accelerates the ship
    xV += 0.5 * cos(h);
    yV += 0.5 * sin(h);
  }
  
  void move(){    //custom version of the move function, adds drag
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
    xV /= moveDrag;
    yV /= moveDrag;
    hV /= turnDrag;
  }
  
  void turnR(){
    hV += 0.01;
  }
  
  void turnL(){
    hV -= 0.01;
  }
}
