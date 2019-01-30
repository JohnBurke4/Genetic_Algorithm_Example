class Population {
  Bot[] bots;
  float fitnessSum;
  int generation = 1;
  int bestBot;
  int minStep = 400;

  Population(int size) {
    bots = new Bot[size];
    for (int i = 0; i < size; i++)
    {
      bots[i] = new Bot();
    }
  }

  void show() {
    for (int i = 0; i < bots.length; i++) {
      bots[i].show();
    }
  }
  void update() {
    for (int i = 0; i < bots.length; i++) {
      if (bots[i].brain.step > minStep)
      {
        bots[i].dead = true;
      } else
      {
        bots[i].update();
      }
    }
  }

  void calculateFitness() {
    for (int i = 0; i < bots.length; i++) {
      bots[i].calculateFitness();
    }
  }

  boolean allDotsDead() {
    for (int i = 0; i < bots.length; i++) {
      if (!bots[i].dead && !bots[i].reachedGoal) {
        return false;
      }
    }
    return true;
  }

  void naturalSelection() {
    Bot[] newBots = new Bot[bots.length];
    calculateFitnessSum();
    setBestBot();
    newBots[0] = bots[bestBot].cloneParent();
    newBots[0].isBest = true;

    for (int i = 1; i < newBots.length; i++) {
      Bot parent = selectParent();
      newBots[i] = parent.cloneParent();
    }

    bots = newBots.clone();
    generation++;
  }


  void calculateFitnessSum() {
    fitnessSum = 0;
    for (int i = 0; i < bots.length; i++) {
      fitnessSum += bots[i].fitness;
    }
  }


  Bot selectParent() {
    float rand = random(fitnessSum);
    float runningSum = 0;

    for (int i = 0; i < bots.length; i++) {
      runningSum += bots[i].fitness;
      if (runningSum > rand) {
        return bots[i];
      }
    }
    return null;
  }

  void evolution() {
    for (int i = 1; i < bots.length; i++) {
      bots[i].brain.mutate();
    }
  }

  void setBestBot() {
    float max = 0;
    int maxIndex = 0;

    for (int i = 0; i < bots.length; i++) {
      if (bots[i].fitness > max) {
        max = bots[i].fitness;
        maxIndex = i;
      }
    }
    bestBot = maxIndex;

    if (bots[bestBot].reachedGoal) {
      minStep = bots[bestBot].brain.step;
      System.out.println("step: " + minStep);
    }
  }
}
