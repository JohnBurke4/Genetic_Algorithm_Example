class Bot {
  PVector position;
  PVector velocity;
  PVector acceleration;
  Brain brain;
  boolean dead = false;
  float fitness;
  boolean reachedGoal = false;
  boolean isBest = false;


  Bot() {
    brain = new Brain(400);
    position = new PVector(width/2, height*0.95);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }


  void show() {
    stroke(0);
    if (isBest)
    {
      fill(255, 0, 0); 
      ellipse(position.x, position.y, 10, 10);
    } else 
    {
      fill(0);
      ellipse(position.x, position.y, 4, 4);
    }
  }

  void move() {
    if (brain.directions.length > brain.step)
    {
      acceleration = brain.directions[brain.step];
      brain.step++;
    } else 
    {
      dead = true;
    }

    position.add(velocity);
    velocity.add(acceleration);
    velocity.limit(10);
  }

  void update() {
    if (!dead && !reachedGoal)
    {
      move();
      //System.out.println(position.x);
      //System.out.println(position.y);

      if (position.x <= 5 || position.x >= width-1 || position.y >= height -5 || position.y <= 5) 
      {
        dead = true;
      } //else if (position.x > obsX-(obsW/2) && position.x < obsX+(obsW/2) && position.y > obsY-(obsH/2) && position.y < obsY-(obsH/2))
      else if (dist(position.x, position.y, endX, endY) <= 5.0) {
        reachedGoal = true;
      } else {
        for (int i = 0; i < obstacles.length; i++) {
          if (dist(position.x, position.y, obstacles[i].position.x, obstacles[i].position.y) <= obstacles[i].size/2)
          {
            dead = true;
          }
        }
      }
    } else 
    {
      //fitness = 0;
    }
  }

  void calculateFitness() {
    if (reachedGoal) {
      fitness = 1.0/(float)(brain.step * brain.step);
      fitness += 1;
    } else
    {
      float distanceToGoal = dist(position.x, position.y, endX, endY);
      fitness = 1.0/(distanceToGoal*distanceToGoal);
    }
  }

  Bot cloneParent() {
    Bot baby = new Bot();
    baby.brain = brain.clone();
    return baby;
  }
}
