class BackgroundBaseCircle {
  float x, y; // 円の中心座標
  float diameter; // 円の直径
  int r, g, b; // 色
  float strokeWidth = 2; // 線の太さ
  float index;

  BackgroundBaseCircle(float x, float y, float baseDiameter, int index, int totalCount) {
    this.x = x;
    this.y = y;
    this.index=index;
    this.diameter = pow(random(1), 2) * baseDiameter; // 外側の円ほど多く描画
    this.strokeWidth = map(index, 0, totalCount, 1, 4); // 線の太さを円の数に応じて変化
  }

  void display() {
    noFill(); // 塗りつぶしなし
    stroke(0,  index % 70, 100 - (index % 100)); // 線の色
    strokeWeight(strokeWidth); // 線の太さ
    ellipse(x, y, diameter, diameter); // 円を描画
  }
}
