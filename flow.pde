int r = 5;
int number = 20;
int monoCount = 0;
int R, G, B;
boolean drawCircles = false;
float weight;
int count = 0;
PVector start, target;
PVector c, speed;
PVector startBackground, endBackground, currentBackground;
PVector speedBackground;
// red circle
PVector mouse, mouseS, mouseE;
PVector speedR;
float easingR = 0.047;

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
color white, water, pink, blue;
color color1, color2, color3, color4;

PVector currentFront, startFront, endFront, speedFront = new PVector();
float easingFront;

float lineStartX, lineStartY;
float lineEndX;
float lineEndY;
int backgroundCircleSize;

PVector blackRectStart;
PVector blackRectEnd;
float blackRectSpread = 10;
float blackRectEasing = 0.01;
float blackRectSpeedMeter = 0.001;
BlackRectMover blackRectMover;

RedFlower redflower;

void setup() {
  size(1440, 900); // キャンバスサイズを設定
  stroke(100);    // グレーの縁
  weight = random(1);
  strokeWeight(weight); // 線の太さをランダムに設定
  frameRate(120);
  //background(244, 235, 252);
  background(0, 0, 0);

  backgroundCircleSize=80;
  redflower= new RedFlower();

  int n = height/backgroundCircleSize+2; // 配列のサイズ
  float[] startY = new float[n];
  float[] endY = new float[n];

  for (int i = 0; i < n; i++) {
    startY[i] = i * backgroundCircleSize - backgroundCircleSize;  // startYの規則に従って設定
    endY[i] = i *backgroundCircleSize-backgroundCircleSize ;  // 規則に従った値
  }

  white = color(153, 220, 200);
  water = color(153, 255, 0, 255);
  pink = color(255, 0, 128, 255);
  blue = color(220, 230, 255);

  // draw background circle
  //NO.1
  noStroke(); // 円の輪郭を非表示

  int circleCountB = 1000; // 円の数
  float centerXB = width / 2; // 円の中心X座標
  float centerYB = height / 2; // 円の中心Y座標
  float baseDiameterB = dist(0, 0, width, height ); // 最大の円の直径

  // 円を直接描画
  for (int i = 0; i < circleCountB; i++) {
    // `BackgroundBaseCircle`のインスタンスを生成して描画
    new BackgroundBaseCircle(centerXB, centerYB, baseDiameterB, i, circleCountB).display();
  }

  //setup rotate
  translate(width / 2, height / 2); // キャンバスの中心を原点に設定

  int numRotations = 80; // 回転の回数
  float angleStep = TWO_PI / numRotations; // 回転角度のステップ
  float gap = 10; // 円と円の間隔
  float maxRadius = 70; // 最大の円の半径
  float minRadius = 20; // 最小の円の半径
  int countBack =0;

  int numCircles = int(dist(0, 0, width/2, height/2)/gap); // 円の数
  color whiteColor = color(200, 200, 200);
  color greenColor = color(184, 181, 209);
  color blueColor = color(244, 235, 252);
  float angleAccount=0;

  //No.1
  //gap = 5; // 円と円の間隔
  //numRotations=60;
  //minRadius=20;
  //maxRadius=150;
  //angleStep = TWO_PI / numRotations; // 回転角度のステップ
  //numCircles = int(dist(0, 0, width/2, height/2)/gap);
  //whiteColor=color(41, 36, 93);
  //blueColor=color(12, 8, 52);
  //greenColor=color(12, 8, 52);
  //strokeWeight(0.3);

  //redflower.setBackground(numCircles, minRadius, maxRadius, gap, whiteColor, blueColor, greenColor);

  //for (int i = 0; i < numRotations; i++) {
  //  pushMatrix(); // 座標系を保存
  //  angleAccount=angleAccount+angleStep;
  //  rotate(angleAccount); // 回転
  //  redflower.drawBackground();
  //  countBack+=1;
  //  popMatrix(); // 座標系を復元
  //}

  //No.2
  gap = 30; // 円と円の間隔
  numRotations=40;
  minRadius=55;
  maxRadius=0;
  angleStep = TWO_PI / numRotations; // 回転角度のステップ
  numCircles = int(dist(0, 0, width/2, height/2)/gap);
  whiteColor=color(244, 235, 252, 20);
  blueColor=color(184, 181, 209, 20);
  greenColor=color(200, 200, 200, 20);

  //whiteColor=color(238,255,18, 20);
  //blueColor=color(238,255,18, 20);
  //greenColor=color(238,255,18, 20);

  stroke(0);
  strokeWeight(1.5);
  redflower.setBackground(numCircles, minRadius, maxRadius, gap, whiteColor, blueColor, greenColor);
  for (int i = 0; i < numRotations; i++) {
    pushMatrix(); // 座標系を保存
    angleAccount=angleAccount+angleStep;
    rotate(angleAccount); // 回転
    redflower.drawBackground();
    countBack+=1;
    popMatrix(); // 座標系を復元
  }

  //NO.3
  gap = 60; // 円と円の間隔
  numRotations=20;
  minRadius=10;
  maxRadius=100;
  angleStep = TWO_PI / numRotations; // 回転角度のステップ
  numCircles = int(dist(0, 0, width/2, height/2)/gap);

  whiteColor=color(55, 10);
  blueColor=color(0, 10);
  greenColor=color(0, 10);

  strokeWeight(1.5);
  stroke(200);
  stroke(238, 255, 18, 50);

  redflower.setBackground(numCircles, minRadius, maxRadius, gap, whiteColor, blueColor, greenColor);

  for (int i = 0; i < numRotations; i++) {
    pushMatrix(); // 座標系を保存
    angleAccount=angleAccount+angleStep;
    rotate(angleAccount); // 回転
    redflower.drawBackground();
    countBack+=1;
    popMatrix(); // 座標系を復元
  }
  resetMatrix(); // 座標系をリセット（translateの解除）


  //red circle setup
  currentFront = new PVector();
  startFront = new PVector();
  endFront = new PVector();
  speedFront = new PVector();
  easingFront = 0.04;
  offsetVector = new PVector(1, -1);

  //draw balckrect
  blackRectSpread = 10;
  blackRectEasing = 0.01;
  blackRectSpeedMeter = 0.001;

  // 初期化
  blackRectStart = new PVector(width, height); // 開始位置
  blackRectEnd = new PVector(0, 0); // 終了位置
  blackRectMover = new BlackRectMover(blackRectStart, blackRectEnd, blackRectSpread, blackRectEasing, blackRectSpeedMeter);
  blackRectMover.update();

  //draw blue circle
  strokeWeight(1);
  int numberBlue=50;
  float radiusBlue=5;
  int randomjudge=2;
  noStroke();
  for (int i = 0; i < numberBlue; i++) {
    float random1 = random(1);
    int random2 = int(random(-randomjudge, randomjudge));
    int random3 = int(random(-randomjudge, randomjudge));
    
    fill(35, 35, 255);
    
    if (random1 < 0.95) {
      stroke(0);
      strokeWeight(2);
      if (i==0) {
        ellipse(width/2, height/2, radiusBlue * (numberBlue - i), radiusBlue * (numberBlue - i));
      } else {
        stroke(0);
        strokeWeight(0.5);
        noFill();
        ellipse(width/2+radiusBlue*random2, height/2+radiusBlue*random3, radiusBlue * (numberBlue - i), radiusBlue * (numberBlue - i));
      }
    }
  }


  //draw red circle
  startFront.set(0, 0);
  endFront.set(width, height);
  float mult=0.005;

  float r=7;
  redflower.initialize(startFront.x, startFront.y, endFront.x, endFront.y, mult, r);

  spread=10;
  float ratio = 0.3;
  int rectsize = 50;
  lineEndX=width/2;
  lineEndY=height/2;

  redflower.setRectangles(ratio, rectsize, lineEndX, lineEndY);
  redflower.drawRed();

  startFront.set(0, height*0.5);
  endFront.set(width*0.25, height);
  saveFrame("barabara.png");
}
