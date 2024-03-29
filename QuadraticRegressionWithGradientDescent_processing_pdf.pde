// this way is called the Stochastic Gradient Descent
ArrayList<PVector> points = new ArrayList<>();
float b0 = 1;
float b1 = 1;
float b2 = 1;

float learningRate = 0.0001;

void setup(){
  size(600, 600);
}

float x_coordinate = width/10;
float y_coordinate = height/10;

void draw(){
  background(155);

  for(int i = 0; i < points.size(); i++){
    noStroke();
    fill(255);
    float x = map(points.get(i).x, 0, x_coordinate, 0, width);
    float y = map(points.get(i).y, 0, y_coordinate, height, 0);
    ellipse(x, y, 10, 10);
  }
  for(int i = 0; i < 150; i++){ // to make the drawing faster.
    if(points.size() > 1){
      gradientDescent();
      drawQuad();
    }
  }
}

void mousePressed(){
  float x = map(mouseX, 0, width, 0, x_coordinate);
  float y = map(mouseY, 0, height, y_coordinate, 0);
  points.add(new PVector(x, y));
}

void gradientDescent(){
  int sz = points.size();
  for(int i = 0; i < sz; i++){
    float currX = points.get(i).x;
    float currY = points.get(i).y; // actual data "desired"
    float guess = f(currX);
    float error = currY - guess;
    // tweak the weights
    // the tweaking came from the partial derivatives of the function
    // to optimize the "cost function" in the first place.
    b0 += error * learningRate;
    b1 += error * currX * learningRate;
    b2 += error * currX*currX * learningRate; 
  }
}

float f(float x){ // the function
  return b0 + b1*x + b2*x*x;
}

void drawQuad(){
  // Draw the quadratic function
  beginShape();
  noFill();
  stroke(255, 0, 100);
  for(float x = 0; x < x_coordinate; x += 0.1){
    float y = f(x);
    float px = map(x, 0, x_coordinate, 0, width);
    float py = map(y, 0, y_coordinate, height, 0);
    vertex(px, py);
  }
  endShape();
}
