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

int spread;

// 配列の仮の定義
float[] startY = {-50, 0, 50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 800, 850, 900, 1000};
float[] endY =  {-50, 0, 50, 100, 150, 250, 250, 350, 400, 400, 400, 450, 500, 600, 700, 750, 750, 750, 800, 900, 1000};

int countM = 0;
color white,water,pink,blue;

PVector currentFront,startFront,endFront,speedFront = new PVector();
float easingFront;

void setup() {
  size(450, 900); // キャンバスサイズを設定
  stroke(100);    // グレーの縁
  weight = random(1);
  strokeWeight(weight); // 線の太さをランダムに設定
  frameRate(120);
  background(254, 254, 200);
  
  white = color(153,220,200);
  water = color(153,255,0,255);
  pink = color(255,0,128,255);
  blue = color(220,230,255);
  
  // 背景の円の描画
  for(int i=0;i<startY.length;i++){
    PVector startBackground = new PVector(0, startY[i]);
    PVector endBackground = new PVector(width, endY[i]);
    PVector currentBackground = new PVector(startBackground.x, startBackground.y);
    PVector speedBackground = PVector.sub(endBackground, startBackground).mult(easing);

    while(currentBackground.x <= width + 50) {
      
      strokeWeight(0.5);
      //noStroke();
      fill(255);
      ellipse(currentBackground.x, currentBackground.y - 5, 100, 100);
      
      //fill(255);
      //ellipse(currentBackground.x, currentBackground.y + 5, 100, 100);
      
      stroke(0);
      if(i<5){
        fill(white);
      }else if(i<10){
        fill(water);
      }else if(i<14){
        fill(pink);
      }else {
        fill(blue);
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
  startFront.set(0,0);
  endFront.set(width,height);
  currentFront.set(0,0);
  speedFront.set(PVector.sub(endFront,startFront));
  speedFront.normalize();
  speedFront.mult(30);
  
  spread=50;
  
  while(currentFront.x>-50&&currentFront.x<width+50&&currentFront.y>-50&&currentFront.y<height+50){
    
    offsetVector.set(speedFront);
    offsetVector.rotate(HALF_PI);
    offsetVector.normalize();
    
    spread=spread+10;
    int random=int(random(-spread,spread));
    offsetVector.mult(random); 
    PVector movedPos = PVector.add(currentFront, offsetVector);
    
    number = int(random(7, 20));
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
        ellipse(movedPos.x, movedPos.y, r * (number - i), r * (number - i));
      }
    }
    currentFront.add(speedFront);
  }
}
