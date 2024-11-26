class BlackRectMover {
  PVector blackRectCurrent;
  PVector blackRectSpeed;
  PVector blackRectOffset;
  PVector blackRectStart;
  PVector blackRectEnd;
  float blackRectSpread;
  float blackRectEasing;
  float blackRectSpeedMeter;

  BlackRectMover(PVector start, PVector end, float spread, float easing, float speedMeter) {
    this.blackRectStart = start.copy();
    this.blackRectEnd = end.copy();
    this.blackRectCurrent = start.copy();
    this.blackRectSpread = spread;
    this.blackRectEasing = easing;
    this.blackRectSpeedMeter = speedMeter;

    // `blackRectSpeed`ベクトルの計算
    this.blackRectSpeed = PVector.sub(blackRectEnd, blackRectStart).mult(blackRectSpeedMeter);

    // `blackRectOffset`を90度反転したベクトルで初期化
    this.blackRectOffset = blackRectSpeed.copy().rotate(HALF_PI).normalize();
  }

  void update() {
    while (blackRectCurrent.x > -50 && blackRectCurrent.x < width + 50 &&
      blackRectCurrent.y > -50 && blackRectCurrent.y < height + 50) {
      // スプレッドを調整して描画
      blackRectSpread += 400 * blackRectEasing;

      // ランダムなオフセットを計算
      int randomSpread = int(random(-blackRectSpread, blackRectSpread));
      PVector randomizedOffset = blackRectOffset.copy().mult(randomSpread);

      // 新しい位置を計算
      PVector movedPos = PVector.add(blackRectCurrent, randomizedOffset);

      // 長方形を描画
      drawBlackRectangles(50, movedPos.x, movedPos.y);

      // `blackRectCurrent`を更新
      blackRectCurrent.add(blackRectSpeed);
    }
  }

  void drawBlackRectangles(float radius, float rectx, float recty) {
    float rectStartX = rectx;
    float rectStartY = recty;
    float rectSizeBlack = radius;
    float blackRectRatio = 0.3;

    // 中心点を計算
    float midX = rectStartX + (width * 0.5 - rectStartX) * blackRectRatio;
    float midY = rectStartY + (height * 0.5 - rectStartY) * blackRectRatio;

    // 中心点までの角度と距離を計算
    float angle = atan2(midY - rectStartY, midX - rectStartX);
    float distance = dist(rectStartX, rectStartY, midX, midY);

    // 黒い長方形を描画
    fill(0);
    noStroke();
    pushMatrix();
    translate(rectStartX, rectStartY); // 長方形の基準点を移動
    rotate(angle + PI / 3); // 角度を回転
    rect(0, 0, distance, rectSizeBlack / 5); // 長方形を描画
    popMatrix();
  }
}
