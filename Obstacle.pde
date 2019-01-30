class Obstacle {
  PVector position;
  float size;

  void initilise() {
    position = new PVector(random(width), random(height));
    size = random(70, 100);
    while ((dist(position.x, position.y, endX, endY) <= size/2) || (dist(position.x, position.y, width/2, height*0.95) <= size/2)) {
      position = new PVector(random(width), random(height));
    }
  }

  void show() {
    fill(255);
    stroke(0);
    ellipse(position.x, position.y, size, size);
  }
}
