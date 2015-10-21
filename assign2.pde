PImage bg1;
PImage bg2;
PImage hp;
PImage fighter;
PImage enemy;
PImage treasure;
PImage start1;
PImage start2;
PImage end1;
PImage end2;

int bg;
int enemy1,enemy2;
int tr1,tr2;
float blood;
float fx,fy;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

float speed =5;

final int GAME_START = 1;
final int GAME_RUN = 2;
final int GAME_LOSE = 3;
int gameState;

void setup () 
{
  size(640,480) ;  // must use this size.
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  hp = loadImage("img/hp.png");
  fighter = loadImage("img/fighter.png");
  enemy = loadImage("img/enemy.png");
  treasure = loadImage("img/treasure.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  
  //hp
  blood=40;
  
  //enemy
  enemy2=floor(random(60,440));
  
  //treasure
  tr1=floor(random(100,500));
  tr2=floor(random(60,400));
  
  //fighter
  fx=580;
  fy=240;
  
  gameState = GAME_START;
  
}

void draw () 
{
  switch(gameState){
    case GAME_START:
    
      image(start1,0,0);
      if(mouseX>200 && mouseX<450){
        if(mouseY>380 && mouseY<420){
          if(mousePressed){
          gameState=2;
      }else{
        image(start2,0,0);
          }
        }
      }
      break;
    
    case GAME_RUN:
    
      //background
      image(bg2,bg,0);
      image(bg1,bg-640,0);
      image(bg2,bg-1280,0);
      bg++;
      bg%=1280;
    
      //enemy
      image(enemy,enemy1,enemy2);
      enemy1+=4;
      enemy1%=640;
      
      if(fy < enemy2){
      enemy2 = enemy2 - 3;
      }
      
      if(fy > enemy2){
      enemy2 = enemy2 + 3;
      }
      
      if(fx<=enemy1+50 && fx>=enemy1-50 &&
         fy<=enemy2+50 && fy>=enemy2-50){ //crush
          blood -= 40;
          enemy1 = 0;
          enemy2 = floor(random(60,440));
          if(blood <= 0){
          gameState = 3;
          }
        
      }
  
      //hp
      fill(#FF0000);
      rect(20,15,blood,15);
      image(hp,10,10);
  
      //fighter
      image(fighter,fx,fy);
      
  
      //treasure
      image(treasure,tr1,tr2);
      
      if(fx<=tr1+50 && fx>=tr1-50
      && fy<=tr2+50 && fy>=tr2-50){  //get
        blood += 20;
        if(blood>=200){
          blood=200;
        }
        tr2=floor(random(60,400));
      }
  
      //fighter moving
       if (upPressed) {
         fy -= speed;
       }
       if (downPressed) {
         fy += speed;
       }
       if (leftPressed) {
         fx -= speed;
       }
       if (rightPressed) {
         fx += speed;
       }
   
       //fighter boundary detection
       if (fx > width-50) {
         fx = width-50;
       }
       if (fx < 0) {
         fx = 0;
       }
       if (fy > height-50) {
         fy = height-50;
       }
       if (fy < 0) {
         fy = 0;
       }
       break;
     
     case GAME_LOSE:
     
       image(end1,0,0);
       if(mouseX>200 && mouseX<450){
        if(mouseY>300 && mouseY<340){
          if(mousePressed){
            gameState=2;
            blood = 40;
            fx=width-50;
            fy=height/2;
        }else{
          image(end2,0,0);
            }
          }
        }
       break;
    
  }
    
}

void keyPressed() {
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
