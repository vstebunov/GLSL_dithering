PShape car;
PShader toon;
PGraphics img;

float x = 0;
float y = 0;
float step = 10;
float angle = -0.01f;

void setup() {
  size(800, 800, P3D);
  noStroke();
  
  car = loadShape("DodgeShaker.obj");
  car.rotateZ(PI);
  car.translate(200,-200,300);
    
  toon = loadShader("ToonVert.glsl"); 
  
  img = createGraphics(width, height, P3D);
  
  shapeMode(CENTER);
}


void draw() {
  car.rotateY(angle);
    
  img.beginDraw();  
  img.clear();
  img.background(0,0,0);
  img.ambientLight(51, 102, 126);
  img.pointLight(255, 255, 255, width / 2, height / 2, 100);    
  img.shape(car, width / 2 + 170 + x, height / 2 + 260 + y);  
  img.endDraw();
  
  
  clear();
  background(105,105,255);
  translate(width/2, height/2);
  
  shader(toon);
  
  beginShape();
  texture(img);
  vertex(-1 * width, -1 * height, 0, 0,   0);
  vertex(width, -1 * height, 0, width, 0);
  vertex(width,  height, 0, width, height);
  vertex(-1 * width,  height, 0, 0,   width);
  endShape(CLOSE);
  
}

void keyPressed() {  
  if (key == CODED) {
    println(x, y);
    if (keyCode == UP) {
      x = x + step;
    } else if (keyCode == DOWN) {
      x = x - step;
    } else if (keyCode == LEFT) {
      y = y + step;
    } else if (keyCode == RIGHT) {
      y = y - step;
    }
  }
}