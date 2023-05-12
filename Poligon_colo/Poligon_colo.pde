ArrayList list = new ArrayList();
boolean stroke = true;
int distance = 80;
int pnum = 170;

void setup()
{
  //size(500, 1000);
  fullScreen();
  smooth();

  for (int i = 0; i < pnum; i++) {
    Particle P = new Particle(random(0, width), random(0, height), random(1, 6), 
      (int)random(0, 255), (int)random(0, 255), (int)random(0, 255));
    list.add(P);
  }
}

void draw()
{
  background(30);
  makeTriangles();
}

void mousePressed()
{
  stroke = !stroke;
}

void makeTriangles()
{
  for (int i = 0; i < list.size(); i++) {
    Particle a = (Particle) list.get(i);
    a.display();
    a.update();
    for (int j = i + 1; j < list.size(); j++) {
      Particle b = (Particle) list.get(j);
      b.update();
      if (dist(a.x, a.y, b.x, b.y) < distance) {
        for (int k = j + 1; k < list.size(); k++) {
          Particle c = (Particle) list.get(k);
          if (dist(c.x, c.y, b.x, b.y) < distance) {
            if (stroke) {
              stroke(255, 10);
              fill(c.R, c.G, c.B, 60);
            } else {
              noFill();
              strokeWeight(1);
              stroke(255, 35);
            }
            beginShape(TRIANGLES);
            vertex(a.x, a.y);
            vertex(b.x, b.y);
            vertex(c.x, c.y);
            endShape();
          }
          c.update();
        }
      }
    }
  }
}

class Particle 
{
  float x, y, r;
  color R, G, B;

  Particle(float x, float y, float r, color R, color G, color B) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.R = R;
    this.G = G;
    this.B = B;
  }

  void display() {
    pushStyle();
    noStroke();
    fill(this.R, this.G, this.B);
    ellipse(this.x, this.y, this.r, this.r);
    popStyle();
  }

  int i = 1, j = 1;

  void update() {
    this.x = this.x + j * 0.01;
    this.y = this.y + i * 0.01;

    if (this.y > height - this.r) {
      i = -1;
    }

    if (this.y < 0 + this.r) {
      i = 1;
    }

    if (this.x > width - this.r) {
      j = -1;
    }

    if (this.x < 0 + this.r) {
      j = 1;
    }
  }
}
