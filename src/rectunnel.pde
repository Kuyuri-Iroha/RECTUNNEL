
class TunnelLayer {
  final float offsetSize = 650;
  static final float cycle = 2 * PI / (3 * 60);
  float size;
  float rota;
  boolean exist;
  int createFrame;
  int hue;
  
  TunnelLayer() {
    size = 0;
    rota = 0;
    exist = false;
    createFrame = 0;
    hue = 0;
  }
  
  void init() {
    size = 0;
    rota = 0;
    exist = true;
    createFrame = frameCount;
  }
  
  void update() {
    size = offsetSize - ((frameCount - createFrame) * 3);
    rota += cycle;
    if(2 * PI <= rota) {
      rota = 0;
    }
    hue = int(sin(rota) * 255);
    
    float limSize = 30;
    if(6 * 50 <= frameCount) {
      limSize = float(frameCount - (6 * 50)) / (4 * 50) * (offsetSize - 30) + 30;
    }
    if(size <= limSize) {
      exist = false;
    }
  }
  void draw() {
    stroke(250);
    strokeWeight(0.5);
    rotateZ(radians(sin(rota) * 90));
    rect(0, 0, size, size);
  }
  
}


TunnelLayer[] layers = new TunnelLayer[100];
float rota = 0;
boolean create = false;
float grobalRota = 0;

void setup() {
  size(1000, 1000, P3D);
  background(0);
  noFill();
  smooth();
  frameRate(50);
  
  for(int i = 0; i < layers.length; i++) {
    layers[i] = new TunnelLayer();
  }
}

void draw() {
  background(26);
  translate(width / 2, height / 2, 0);
  rotateZ(PI / 4);
  grobalRota += 2 * PI / (10 * 60);
  if(2 * PI <= grobalRota) {
    grobalRota = 0;
  }
  rotateZ(radians(sin(grobalRota) * 180));
  rectMode(CENTER);
  
  if(frameCount % 5 == 0) {
    create = true;
  }
  
  for(int i = 0; i < layers.length; i++) {
    if(!(layers[i].exist) && create) {
      layers[i].init();
      create = false;
    }
    
    layers[i].update();
    if(layers[i].exist) {
      pushMatrix();
      layers[i].draw();
      popMatrix();
    }
  }
  
  if(550 < frameCount) {
    exit();
  }
}
