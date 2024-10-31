int r = 5;
int number = 20;
int monoCount=0;
int R,G,B;
boolean drawCircles = false;
float weight;
int count = 0;
PVector start, target;
PVector c, speed;
//red circle
PVector mouse,mouseS,mouseE;
PVector speedR;
float easingR;

float easing;
PVector offsetVector;
int min,max;

// 配列の仮の定義
float[] startY = {-50,0, 50, 100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,1000};
float[] endY =  {-50,0, 50, 100,150,250,250,350,400,400,400,450,500,600,700,750,750,750,800,900,1000};

int countM = 0;
void setup() {
  size(450, 900); // キャンバスサイズを設定
  stroke(100);    // グレーの縁
  weight = random(1);
  strokeWeight(weight); // 線の太さをランダムに設定
  frameRate(120);
//background circle
  start = new PVector();
  target = new PVector();
  c = new PVector();
  speed = new PVector();
  easing = 0.02;
  
  //red circle
  mouse = new PVector();
  mouseS = new PVector();
  mouseE = new PVector();
  speedR = new PVector();
  easingR = 0.05;

  offsetVector = new PVector(1, -1); // 右上方向を表すベクトル
  offsetVector.normalize(); // 正規化
  offsetVector.mult(100);

  // 初期位置設定
  start.set(0, startY[0]);
  c.set(0, startY[0]);
  target.set(width, endY[0]);
  speed.set(PVector.sub(target, start));
  speed.mult(easing);
  count = 0;
  
  background(254,254,200);
}

void draw() {
  c.add(speed);
  // 画面外に出たら次のターゲットに切り替え
  if (c.x >= width+50 && count < startY.length-1 ) {
    if(monoCount%2==0){
      monoCount+=1;
    }else{
    count++;
    monoCount+=1;
    }
    start.set(0, startY[count]);
    c.set(0, startY[count]);
    target.set(width, endY[count]);
    speed.set(PVector.sub(target, start));
    speed.mult(easing);
  }

  // 円を描画
  stroke(0);
  strokeWeight(1);
  if(count<=5){
    R = int(random(0,240));
    G = 256;
    B = 256;
  }else if(count > 5 && count <= 10){
    R = 256;
    G = int(random(0,240));
    B = 256;
  }else {
    R = 256;
    G = 256;
    B = int(random(200,240));
  }
  if(monoCount%2==0){
    noStroke();
    fill(0,0,0,20);
    ellipse(c.x,c.y-5,100,100);
  }else{
  strokeWeight(weight); 
  stroke(0);
  fill(R, G, B);
  ellipse(c.x, c.y, 100, 100);
  }
  
  
  //draw red circle
  if(countM>1){
    offsetVector.set(speedR.x,speedR.y);
    offsetVector.rotate(HALF_PI);
    offsetVector.normalize();           // ベクトルを正規化（長さを1にする）
    
    float random= getPowRandom(count,min,max,1.1);//yokohaba
    min =  min -5;
    max = max + 5;
    
    offsetVector.mult(random); 
    PVector movedPos = PVector.add(mouse, offsetVector);
    
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
  }
  mouse.add(speedR);
  speedR.set(PVector.sub(mouseE, mouseS));
  easingR=0.05+getNormalRandom(count,0,0.01);
  speedR.mult(easingR);
}

void mousePressed() {
  if (countM == 0) {
    mouseS.set(mouseX, mouseY);
    mouse.set(mouseX, mouseY);
  } else if (countM == 1) {
    mouseE.set(mouseX, mouseY);
    speedR.set(PVector.sub(mouseE, mouseS));
    speedR.mult(easingR);
  }
  countM++;
}

float getPowRandom(float input, float min, float max, float power) {
  float r = random(1);                       // 0から1までのランダム値
  float curvedValue = pow(input * r, power); // 入力に応じて値が変化
  return lerp(min, max, curvedValue);        // minからmaxにスケール
}

float getNormalRandom(float input, float min, float max) {
  float r = 2+input/-2; // 0からinputの範囲に集中するランダム値
  return lerp(min, max, r );              // minからmaxにスケール
}
