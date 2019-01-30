Population population;
Obstacle[] obstacles;
float endX;
float endY;


void setup() {
  endX = width/2;
  endY = height*0.1;
  obstacles = new Obstacle[75];
  for (int i = 0; i < obstacles.length; i++) {
   obstacles[i] = new Obstacle();
   obstacles[i].initilise();
  }
  
  population = new Population(1000);
  frameRate(100);
  size(800, 600);
}


void draw() {
  background(255);
  for (int i = 0; i < obstacles.length; i++) {
   obstacles[i].show();
  }
  goal();
  
  population.show();
  population.update();
  if (population.allDotsDead()) {
    population.calculateFitness();
    population.naturalSelection();
    population.evolution();
  }
  printGeneration(population.generation);
}

void goal() {
  fill(0, 255, 0);
  noStroke();
  ellipse(endX, endY, 10, 10);
}

void printGeneration(int generation) {
  fill(0);
  stroke(0);
  textSize(30);
  text("Generation: " + generation, 10, 30);
}
