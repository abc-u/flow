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
color white, water, pink, blue;
color color1, color2, color3, color4;

PVector currentFront, startFront, endFront, speedFront = new PVector();
float easingFront;

float lineStartX, lineStartY;
float lineEndX;
float lineEndY;
int backgroundCircleSize;

RedFlower redflower;

void setup() {
  size(1440, 900); // キャンバスサイズを設定
  stroke(100);    // グレーの縁
  weight = random(1);
  strokeWeight(weight); // 線の太さをランダムに設定
  frameRate(120);
  background(244, 235, 252);

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

  background(255); // 背景色を白に設定
  fill(0, 150, 255); // 円の塗りつぶし色を設定
  noStroke(); // 円の輪郭を非表示

  translate(width / 2, height / 2); // キャンバスの中心を原点に設定

  int numRotations = 80; // 回転の回数
  float angleStep = TWO_PI / numRotations; // 回転角度のステップ
  float gap = 30; // 円と円の間隔
  float maxRadius = 70; // 最大の円の半径
  float minRadius = 20; // 最小の円の半径
  int countBack =0;

  int numCircles = int(dist(0, 0, width/2, height/2)/gap); // 円の数
  color whiteColor = color(200, 200, 200);
  color greenColor = color(184, 181, 209);
  color blueColor = color(244, 235, 252);

  for (int i = 0; i < numRotations; i++) {
    pushMatrix(); // 座標系を保存
    rotate(i * angleStep); // 回転
    // 円を描画
    for (int j = 0; j < numCircles; j++) {
      float radius = lerp(minRadius, maxRadius, j / float(numCircles - 1));
      float y = -j * gap;
      if (j%2==0) {
        fill(244, 235, 252);
      } else {
        fill(whiteColor);
      }
      //noStroke();
      stroke(0);
      ellipse(0, y, radius * 2, radius * 2);
      if (j%2==0) {
        color c = lerpColor(blueColor, whiteColor, j / float(numCircles - 1));
        fill(c);
      } else {
        //fill(244, 235, 252);
        fill(255);
        color c = lerpColor(whiteColor, greenColor, j / float(numCircles - 1));
        fill(c);
      }
      //noStroke();
      stroke(0);
      strokeWeight(1.5);
      ellipse(0, y, radius * 1.7, radius * 1.7);
    }
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

  //draw red circle
  startFront.set(0, 0);
  endFront.set(width, height);
  float mult=1;
  
  float r=7;
  redflower.initialize(startFront.x, startFront.y, endFront.x, endFront.y, mult, r);


  spread=10;
  float ratio = 0.4;
  int rectsize = 50;
  lineEndX=width/2;
  lineEndY=height/2;
  
  redflower.setRectangles(ratio, rectsize, lineEndX, lineEndY);
  redflower.drawRed();
  
  startFront.set(0, height*0.5);
  endFront.set(width*0.25, height);
  saveFrame("barabara.png");
}
