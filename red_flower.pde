class RedFlower {
  int number;
  float r, radius;
  PVector movedPos;
  float ratio,rectsize;
  float lineEndX, lineEndY;

  RedFlower() {
    //this.number = int(random(7, 22));
    //this.r = radius;
  }

  void initialize(float startX, float startY, float endX, float endY, float speedMultiplier, float radius) {
    startFront.set(startX, startY);
    endFront.set(endX, endY);
    currentFront.set(startFront);
    speedFront.set(PVector.sub(endFront, startFront));
    speedFront.normalize();
    speedFront.mult(speedMultiplier);
    r = radius; // 半径を設定
  }

  void set(float x, float y) {
    this.movedPos = new PVector(x, y);
  }

  void drawCircle() {
    number = int(random(7, 20));
    radius = r;

    offsetVector.set(speedFront);
    offsetVector.rotate(HALF_PI);
    offsetVector.normalize();
    
    redflower.drawRectangles(r*number);
    
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
        ellipse(movedPos.x, movedPos.y, radius * (number - i), radius * (number - i));
      }
    }
  }
  void setRectangles(float ratioR, float rectsizeR, float lineEndXR, float lineEndYR) {
    ratio=ratioR;
    rectsize=rectsizeR;
    lineEndX=lineEndXR;
    lineEndY=lineEndYR;
  }
  void drawRectangles(float radius) {
    lineStartX=movedPos.x;
    lineStartY=movedPos.y;
    rectsize=radius;


    float midX = lineStartX + (lineEndX - lineStartX) * ratio;
    float midY = lineStartY + (lineEndY - lineStartY) * ratio;

    float angle = atan2(midY - lineStartY, midX - lineStartX);
    float distance = dist(lineStartX, lineStartY, midX, midY);

    // 1つ目の長方形
    fill(250);
    //stroke(0);
    noStroke();
    pushMatrix();

    int numCircles = int((distance / rectsize)*1); // 距離に応じて円の数を計算
    float stepX = (midX - lineStartX) / numCircles;
    float stepY = (midY - lineStartY) / numCircles;

    for (int i = 0; i <= numCircles; i++) {
      float x = lineStartX + stepX * i;
      float y = lineStartY + stepY * i;

      // 円のサイズを徐々に縮小
      float currentSize = lerp(rectsize, rectsize-rectsize*0.5 , i / float(numCircles));
      //float currentSize=rectsize;

      ellipse(x, y, currentSize, currentSize); // 直径に currentSize を使用
    }
    popMatrix();

    // 2つ目の長方形
    fill(0);
    noStroke();
    pushMatrix();
    translate(lineStartX, lineStartY);
    rotate(angle + PI / 3);
    rect(0, 0, distance, rectsize/5);
    popMatrix();

    //// 3つ目の長方形
    //fill(255);
    //stroke(0);
    //pushMatrix();
    //for (int i = 0; i <= numCircles; i++) {
    //  float x = lineStartX - stepX * i;
    //  float y = lineStartY - stepY * i;

    //  // 円のサイズを徐々に縮小
    //  //float currentSize = lerp(rectsize, rectsize+rectsize*0.7, i / float(numCircles));
    //  float currentSize=rectsize;

    //  ellipse(x, y, currentSize, currentSize); // 直径に currentSize を使用
    //}
    //popMatrix();
  }

  void drawRed() {
    while (currentFront.x > -50 && currentFront.x < width + 50 &&
      currentFront.y > -50 && currentFront.y < height + 50) {
      spread = spread + 400 * easingFront;
      int randomSpread = int(random(-spread, spread));
      offsetVector.mult(randomSpread);

      PVector movedPos = PVector.add(currentFront, offsetVector);
      redflower.set(movedPos.x, movedPos.y);

      // 円と長方形を描画
      redflower.drawCircle();

      currentFront.add(speedFront);
    }
  }
}
