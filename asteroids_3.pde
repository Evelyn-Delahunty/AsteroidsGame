float wdt = 2000;    //dimensions of window
float hgt = 1000;
int score = 0;
float difficulty = 0.1;    //changes spawn rate & speed of asteroids
float turnDrag = 1.05;    //how quickly the ship slows down, higher is faster
float moveDrag = 1.02;
Ship player = new Ship();
HashMap <Character, Boolean> keys = new HashMap <Character, Boolean>();    //stores state of control keys
ArrayList <Bullet> bullets = new ArrayList <Bullet>();
ArrayList <Asteroid> asteroids = new ArrayList <Asteroid>();    //large asteroids
ArrayList <Asteroid> fragments = new ArrayList <Asteroid>();    //small chunks that result when asteroids break up, no collision with each other and reduced point rewards

void setup(){
  windowResize((int)wdt, (int)hgt);
  frameRate(60);
  ellipseMode(RADIUS);
  rectMode(CORNERS);
  strokeWeight(2);
  keys.put('w', false);    //accelerates
  keys.put('a', false);    //turns left/right
  keys.put('d', false);
  keys.put(' ', false);    //shoots
}

void draw(){
  background(0);
  fill(0xFFFFFFFF);
  textSize(40);
  textAlign(LEFT, TOP);
  text("Score: " + score, 0, 0);    //print score
  controls();
  moveAll();
  collideAll();
  renderAll();
  addAsteroid();
  player.cooldown--;    //decrements the delay before the player can shoot again
  score++;    //score increases slightly for time survived
  difficulty = 0.1 + ((float)score) / 10000;    //update difficulty based on score
}

void keyPressed(){    //updates key hashtable
  keys.put(key, true);
}

void keyReleased(){
  keys.put(key, false);
}

void controls(){    //acts based on keys currently down
  if(keys.get('w')){
    player.thrust();
  }
  if(keys.get('a')){
    player.turnL();
  }
  if(keys.get('d')){
    player.turnR();
  }
  if(keys.get(' ')){
    player.shoot();
  }
}

void moveAll(){    //updates positions
  player.move();
  for(int i = 0; i < bullets.size(); i++){
    bullets.get(i).move();
  }
  for(int i = 0; i < asteroids.size(); i++){
    asteroids.get(i).move();
  }
  for(int i = 0; i < fragments.size(); i++){
    fragments.get(i).move();
  }
}

void renderAll(){    //draws entities
  player.show();
  for(int i = 0; i < bullets.size(); i++){
    bullets.get(i).show();
  }
  for(int i = 0; i < asteroids.size(); i++){
    asteroids.get(i).show();
  }
  for(int i = 0; i < fragments.size(); i++){
    fragments.get(i).show();
  }
}

void collideAll(){    //collision logic for all entities
  for(int i = 0; i < asteroids.size(); i++){    //collision for asteroids
    boolean next = false;    //true if the current asteroid has split/been destroyed, prevents index OOB errors
    for(int j = 0; j < bullets.size(); j++){    //collision between bullets and asteroids, awards 100 points for a hit and asteroids break up
      if(collide(asteroids.get(i), bullets.get(j))){
        asteroids.get(i).split();
        i--;
        next = true;
        bullets.remove(j);
        score += 100;
        break;
      }
    }
    if(!next){
      for(int j = i + 1; j < asteroids.size(); j++){    //collision between asteroids, awards no points and both asteroids split
        if(collide(asteroids.get(i), asteroids.get(j))){
          asteroids.get(i).split();
          i--;
          next = true;
          asteroids.get(j - 1).split();
          break;
        }
      }
    }
    if(!next){
      for(int j = 0; j < fragments.size(); j++){    //collision between asteroids and fragments, fragments disappear and asteroids are unaffected
        if(collide(asteroids.get(i), fragments.get(j))){
          fragments.remove(j);
          j--;
        }
      }
    }
    if(!next){
      if(collide(asteroids.get(i), player)){    //collision between asteroids and the player
        endGame();
      }
    }
  }
  for(int i = 0; i < fragments.size(); i++){    //collision for fragments, which behave the same as asteroids but award fewer points and don't collide with each other
    boolean next = false;    //true if the current fragment is destroyed, prevents index OOB errors
    for(int j = 0; j < bullets.size(); j++){    //collision between fragments and bullets, awards 20 points for a hit and reduces lifespan of bullets instead of immediately destroying them
      if(collide(fragments.get(i), bullets.get(j))){
        fragments.remove(i);
        i--;
        bullets.get(j).lifespan -= 15;
        score += 20;
        next = true;
        break;
      }
    }
    if(!next){
      if(collide(fragments.get(i), player)){    //collision between fragments and the player
        endGame();
      }
    }
  }
}

void addAsteroid(){  //adds asteroids according to difficulty
  if((int)(Math.random() * 10 / difficulty) == 0){
    Asteroid temp = new Asteroid();
    asteroids.add(temp);
  }
}

void removeAsteroid(Asteroid a0){
  asteroids.remove(a0);
}

void removeFragment(Asteroid a0){
  fragments.remove(a0);
}

void removeBullet(Bullet b0){
  bullets.remove(b0);
}

void endGame(){
  textSize(100);
  textAlign(CENTER, CENTER);
  text("Game Over!", wdt / 2, hgt / 2);
  stop();
}

boolean collide(Floater f0, Floater f1){    //determines if two entities are touching based on whether their edges intersect, or whether the center of one is inside the other
  float rMin = f0.vert[0][0];
  for(int i = 1; i < f0.vert.length; i++){    //finds the smallest radius value
    if(rMin > f0.vert[i][0]){
      rMin = f0.vert[i][0];
    }
  }
  for(int i = 0; i < f1.vert.length; i++){
    if(rMin > f1.vert[i][0]){
      rMin = f1.vert[i][0];
    }
  }
  if(dist(f0.x, f0.y, f1.x, f1.y) <= rMin){    //must be colliding if distance is less than smallest radius
    return true;
  }
  else{
    for(int i = 0; i < f0.vert.length; i++){
      float x00 = f0.x + f0.vert[i][0] * cos(aWrap(f0.vert[i][1] + f0.h));    //conversion to cartesian coordinates
      float y00 = f0.y + f0.vert[i][0] * sin(aWrap(f0.vert[i][1] + f0.h));
      float x01, y01;
      if(i == f0.vert.length - 1){    //handles the edge connecting the last and first vertices to prevent index OOB errors
        x01 = f0.x + f0.vert[0][0] * cos(aWrap(f0.vert[0][1] + f0.h));
        y01 = f0.y + f0.vert[0][0] * sin(aWrap(f0.vert[0][1] + f0.h));
      }
      else{
        x01 = f0.x + f0.vert[i + 1][0] * cos(aWrap(f0.vert[i + 1][1] + f0.h));
        y01 = f0.y + f0.vert[i + 1][0] * sin(aWrap(f0.vert[i + 1][1] + f0.h));
      }
      for(int j = 0; j < f1.vert.length; j++){
        float x10 = f1.x + f1.vert[j][0] * cos(aWrap(f1.vert[j][1] + f1.h));
        float y10 = f1.y + f1.vert[j][0] * sin(aWrap(f1.vert[j][1] + f1.h));
        float x11, y11;
        if(j == f1.vert.length - 1){    //handles the edge connecting the last and first vertices to prevent index OOB errors
          x11 = f1.x + f1.vert[0][0] * cos(aWrap(f1.vert[0][1] + f1.h));
          y11 = f1.y + f1.vert[0][0] * sin(aWrap(f1.vert[0][1] + f1.h));
        }
        else{
          x11 = f1.x + f1.vert[j + 1][0] * cos(aWrap(f1.vert[j + 1][1] + f1.h));
          y11 = f1.y + f1.vert[j + 1][0] * sin(aWrap(f1.vert[j + 1][1] + f1.h));
        }
        if(intersect(x00, y00, x01, y01, x10, y10, x11, y11)){
          return true;
        }
      }
    }
    return false;
  }
}

boolean intersect(float x00, float y00, float x01, float y01, float x10, float y10, float x11, float y11){    //given the points defining two line segments, returns true if they intersect
  if((x00 < x10 && x01 < x10 && x00 < x11 && x01 < x11) || (x00 > x10 && x01 > x10 && x00 > x11 && x01 > x11)){    //line segments cannot intersect if they don't share any of their domains
    return false;
  }
  else if(x00 == x01){    //separately handles vertical line segments to prevent /0 errors
    if(x10 == x11){
      if((y00 < y10 && y01 < y10 && y00 < y11 && y01 < y11) || (y00 > y10 && y01 > y10 && y00 > y11 && y01 > y11)){
        return false;
      }
      else{
        return true;
      }
    }
    else if((yAt(x00, x10, y10, x11, y11) < y00 && yAt(x00, x10, y10, x11, y11) < y01) || (yAt(x00, x10, y10, x11, y11) > y00 && yAt(x00, x10, y10, x11, y11) > y01)){
      return false;
    }
    else{
      return true;
    }
  }
  else if(x10 == x11){    //separately handles vertical line segments to prevent /0 errors
    if((yAt(x10, x00, y00, x01, y01) < y10 && yAt(x10, x00, y00, x01, y01) < y11) || (yAt(x10, x00, y00, x01, y01) > y10 && yAt(x10, x00, y00, x01, y01) > y11)){
      return false;
    }
    else{
      return true;
    }
  }
  else if((yAt(x00, x10, y10, x11, y11) > y00 && yAt(x01, x10, y10, x11, y11) > y01) || (yAt(x00, x10, y10, x11, y11) < y00 && yAt(x01, x10, y10, x11, y11) < y01)){    //if line segment 2 is above or below segment 1 at both 1's start and endpoint, they don't intersect
    return false;
  }
  else if((yAt(x10, x00, y00, x01, y01) > y10 && yAt(x11, x00, y00, x01, y01) > y11) || (yAt(x10, x00, y00, x01, y01) < y10 && yAt(x11, x00, y00, x01, y01) < y11)){    //if line segment 1 is above or below segment 2 at both 2's start and endpoint, they don't intersect
    return false;
  }
  else{    //since two nonparallel lines must intersect 1 and only 1 time, we can say that the segments of those lines cross as long as that intersection falls within the domains of our line segments, which must be true to pass the above checks
    return true;
  }
}

float yAt(float x, float x0, float y0, float x1, float y1){    //given two points that define a line segment, returns the y-value at a given x-value, even if this x-value is outside the line segment's domain (susceptible to /0 errors)
  float m = (y1 - y0) / (x1 - x0);
  float dx = x - x0;
  return y0 + dx * m;
}

float aWrap(float angle){    //wraps angles so they're between 0 and 2pi radians
  while(angle > 2 * PI){
    angle -= 2 * PI;
  }
  while(angle < 0){
    angle += 2 * PI;
  }
  return angle;
}
