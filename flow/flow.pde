int r = 5;
int number = 20;
int monoCount = 0;
int R, G, B;
boolean drawCircles = false;
float weight;
int count = 0;
PVector start, target;
PVector c, speed;
PVector startBackground,endBackground,currentBackground;
PVector speedBackground;
// red circle
PVector mouse, mouseS, mouseE;
PVector speedR;
float easingR = 0.05;

float easing = 0.02;
PVector offsetVector;
int min, max;

float spread;

// 配列の仮の定義
float[] startY = {-50, 0, 50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 800, 850, 900, 1000};
float[] endY =  {-50, 0, 50, 100, 150, 250, 250, 350, 400, 400, 400, 450, 500, 600, 700, 750, 750, 750, 800, 900, 1000};

int countM = 0;
color white,water,pink,blue;

PVector currentFront,startFront,endFront,speedFront = new PVector();
float easingFront;

float lineStartX,lineStartY;
float lineEndX,lineEndY;

void setup() {
  size(450, 900); // キャンバスサイズを設定
  stroke(100);    // グレーの縁
  weight = random(1);
  strokeWeight(weight); // 線の太さをランダムに設定
  frameRate(120);
  background(254, 254, 200);
  easing = 0.017;
  
  white = color(153,220,200);
  water = color(153,255,0,255);
  pink = color(255,0,128,255);
  blue = color(220,230,255);
  
  // draw background circle
  for(int i=0;i<startY.length;i++){
    PVector startBackground = new PVector(0, startY[i]);
    PVector endBackground = new PVector(width, endY[i]);
    PVector currentBackground = new PVector(startBackground.x, startBackground.y);
    PVector speedBackground = PVector.sub(endBackground, startBackground).mult(easing);

    while(currentBackground.x <= width + 50) {
      
      strokeWeight(0.3);
      //noStroke();
      fill(255);
      ellipse(currentBackground.x, currentBackground.y - 5, 100, 100);
      
      //fill(255);
      //ellipse(currentBackground.x, currentBackground.y + 5, 100, 100);
      
      stroke(0);
      int randomColor=int(random(200,255));
      if(i<5){
        fill(240,240,randomColor);
      }else if(i<10){
        fill(236,randomColor,240);
      }else if(i<14){
        fill(randomColor,190,200);
      }else {
        fill(240,230,randomColor);
      }
      ellipse(currentBackground.x, currentBackground.y, 100, 100);
      
      currentBackground.add(speedBackground);
    }
  }
  
  //red circle setup
  currentFront = new PVector();
  startFront = new PVector();
  endFront = new PVector();
  speedFront = new PVector();
  easingFront = 0.045;
  offsetVector = new PVector(1, -1);
  
  //draw red circle
  startFront.set(0,height);
  endFront.set(width,0);
  currentFront.set(startFront);
  speedFront.set(PVector.sub(endFront,startFront));
  speedFront.normalize();
  speedFront.mult(30);
  
  spread=10;
  
  while(currentFront.x>-50&&currentFront.x<width+50&&currentFront.y>-50&&currentFront.y<height+50){
    
    //draw vertical spread
    offsetVector.set(speedFront);
    offsetVector.rotate(HALF_PI);
    offsetVector.normalize();
    
    
    spread=spread+300*easingFront;
    int randomSpread=int(random(-spread,spread));
    offsetVector.mult(randomSpread); 
    PVector movedPos = PVector.add(currentFront, offsetVector);
    
    lineStartX=movedPos.x;
      lineStartY=movedPos.y;
      lineEndX=width/2;
      lineEndY=height;
      
      stroke(240);
      strokeWeight(7);
      strokeCap(SQUARE);
      
      float ratio = 0.3;
      float midX = lineStartX + (lineEndX - lineStartX) * ratio;
      float midY = lineStartY + (lineEndY - lineStartY) * ratio;
      line(lineStartX,lineStartY,midX, midY);
    
    number =  int(random(7, 22));
      strokeWeight(1);
      for (int i = 0; i < number; i++) {
        float random1 = random(1);
        float random2 = random(1);
    
        fill(255, 35, 35); // 赤色で塗りつぶし
        if (random1 < 0.8) {
          stroke(80); // ストロークを太めに
        } else {
          stroke(50); // ストロークを細めに
        }
  
      if (random2 < 0.95) {
        stroke(0);
        strokeWeight(0.5);
        ellipse(movedPos.x, movedPos.y, r * (number - i), r * (number - i));
      }
    }
    currentFront.add(speedFront);
  }
}
