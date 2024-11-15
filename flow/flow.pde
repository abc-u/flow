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

float easingBackground = 0.02;
PVector offsetVector;
int min, max;

float spread;

// 配列の仮の定義
float[] startY; 
//= {-50, 0, 50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 800, 850, 900, 1000};
float[] endY; 
//=  {-50, 0, 50, 100, 150, 250, 250, 350, 400, 400, 400, 450, 500, 600, 700, 750, 750, 750, 800, 900, 1000};

int countM = 0;
color white,water,pink,blue;
color color1,color2,color3,color4;

PVector currentFront,startFront,endFront,speedFront = new PVector();
float easingFront;

float lineStartX,lineStartY;
float []lineEndX = new float[3];
float []lineEndY = new float[3];
int backgroundCircleSize;

void setup() {
  size(450, 900); // キャンバスサイズを設定
  stroke(100);    // グレーの縁
  weight = random(1);
  strokeWeight(weight); // 線の太さをランダムに設定
  frameRate(120);
  background(244,235,252);
  
  backgroundCircleSize=80;
  
  int n = height/backgroundCircleSize+2; // 配列のサイズ
  float[] startY = new float[n];
  float[] endY = new float[n];
  
  for (int i = 0; i < n; i++) {
    startY[i] = i * backgroundCircleSize - backgroundCircleSize;  // startYの規則に従って設定
    endY[i] = i *backgroundCircleSize-backgroundCircleSize ;  // 規則に従った値
  }
  
  white = color(153,220,200);
  water = color(153,255,0,255);
  pink = color(255,0,128,255);
  blue = color(220,230,255);
  
  // draw background circle
  for(int i=0;i<startY.length;i++){
    easingBackground = backgroundCircleSize/dist(0, startY[i],width, endY[i]);
    PVector startBackground = new PVector(0, startY[i]);
    PVector endBackground = new PVector(width, endY[i]);
    PVector currentBackground = new PVector(startBackground.x, startBackground.y);
    PVector speedBackground = PVector.sub(endBackground, startBackground).mult(easingBackground);
    
    //int randomColor=int(random(200,255));
    if(currentBackground.y < height/4){
      color1 = color(0);
    }else if(currentBackground.y < height/4*2){
      //color1 = color(255);
    }else if(currentBackground.y < height/4*3){
      //color1 = color(0);
    }else {
      //color1 = color(255);
    }
      
    while(currentBackground.x <= width + 50) {
      
      //strokeWeight(1);
      noStroke();
      fill(232);
      //ellipse(currentBackground.x, currentBackground.y - 5, backgroundCircleSize, backgroundCircleSize);
      
      //fill(255);
      //ellipse(currentBackground.x, currentBackground.y + 5, 100, 100);
      noStroke();
      //stroke(0.1);
      fill(255);
      //strokeWeight(0.7);
      ellipse(currentBackground.x, currentBackground.y, backgroundCircleSize*0.9, backgroundCircleSize*0.9);
      fill(244,235,252);//white blue
      //fill(172,140,201);//purple
      //fill(191,162,216,100);
      ellipse(currentBackground.x, currentBackground.y, backgroundCircleSize*0.8, backgroundCircleSize*0.8);
      
      fill(244,235,252);
      ellipse(currentBackground.x+backgroundCircleSize/2, currentBackground.y+backgroundCircleSize/2,backgroundCircleSize*0.9, backgroundCircleSize*0.9);
      
      fill(255);
      ellipse(currentBackground.x+backgroundCircleSize/2, currentBackground.y+backgroundCircleSize/2,backgroundCircleSize*0.8, backgroundCircleSize*0.8);

      
      currentBackground.add(speedBackground);
    }
  }
  
  //red circle setup
  currentFront = new PVector();
  startFront = new PVector();
  endFront = new PVector();
  speedFront = new PVector();
  easingFront = 0.04;
  offsetVector = new PVector(1, -1);
  
  //draw red circle
  startFront.set(0,0);
  endFront.set(width,height);
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
    
    
    spread=spread+400*easingFront;
    int randomSpread=int(random(-spread,spread));
    offsetVector.mult(randomSpread); 
    PVector movedPos = PVector.add(currentFront, offsetVector);
    
      lineStartX=movedPos.x;
      lineStartY=movedPos.y;
      
      lineEndX[0]=width;
      lineEndY[0]=height/3;
      lineEndX[1]=endFront.x;
      lineEndY[1]=endFront.y;
      lineEndX[2]=0;
      lineEndY[2]=0;
      
      stroke(0);
      fill(255);
      strokeWeight(1);
      //strokeCap(SQUARE);
      //float ratio = 0.3;
      //float midX = lineStartX + (lineEndX - lineStartX) * ratio;
      //float midY = lineStartY + (lineEndY - lineStartY) * ratio;
      //line(lineStartX,lineStartY,midX, midY);
      float ratio = 0.4;
      
      for(int i=0;i<1;i++){
        float midX = lineStartX + (lineEndX[i] - lineStartX) * ratio;
        float midY = lineStartY + (lineEndY[i] - lineStartY) * ratio;
  
        float angle = atan2(midY - lineStartY, midX - lineStartX);
  
        float distance = dist(lineStartX, lineStartY, midX, midY);
        
        int rectsize = 9;
        
        fill(255);
        stroke(0);
        pushMatrix();
        translate(lineStartX, lineStartY);
        rotate(angle);
        rect(0, -rectsize / 2.0, distance, rectsize);
        popMatrix();
        
        fill(0);
        stroke(255);
        noStroke();
        pushMatrix();
        translate(lineStartX, lineStartY);
        rotate(angle+PI/3);
        rect(0, -rectsize / 2.0, distance, rectsize);
        popMatrix();
        
        fill(255);
        stroke(0);
        pushMatrix();
        translate(lineStartX, lineStartY);
        rotate(angle-PI);
        rect(0, -rectsize / 2.0, distance, rectsize);
        popMatrix();
      }
      
    
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
