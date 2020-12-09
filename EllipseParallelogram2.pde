int verticalTotal = 20;
int horizontalTotal = 10;
float buffer = 20;
float[] horizontalPoints;
float[] verticalPoints;
int count;
int count1;
boolean done;
boolean done1;
boolean done2;
boolean done11;
boolean done21;
boolean done22;
float param11, param12, param13, param14;
float param21, param22, param23, param24;
float param31, param32, param33, param34;
float param111, param112, param113, param114;
float param331, param332, param333, param334;   
float param441, param442, param443, param444;
float param551, param552, param553, param554;

void setup() {
  size(800, 800);
  done = false;
  done1 = false;
  done2 = false;
  done11 = false;
  done21 = false;
  done22 = false;

  count = horizontalTotal;
  count1 = verticalTotal/2;
  horizontalPoints = new float[horizontalTotal + 1];
  verticalPoints = new float[verticalTotal + 1];
  //background(255);
}

void draw() {
  background(255);
  frameRate(1);

  stroke(0);
  strokeWeight(2);
  line(buffer, height/2, width - buffer, height/2);
  line(width/2, buffer, width/2, height - buffer);

  for (int i = 0; i <= verticalTotal; i++) {
    float x = map(i, 0, verticalTotal, buffer, height - buffer);
    stroke(0, 0, 255);
    strokeWeight(4);
    point(width - buffer, x);
    point(buffer, x);
    verticalPoints[i] = x;
  }

  for (int i = 0; i <= horizontalTotal; i++) {
    float x = map(i, 0, horizontalTotal, buffer, width - buffer);
    stroke(0, 0, 255);
    strokeWeight(4);
    point(x, buffer);
    point(x, height - buffer);
    horizontalPoints[i] = x;
  }

  stroke(255, 0, 200);
  strokeWeight(2);

  if (!done) {
    param11 = width - buffer;
    param12 = height/2;
    param13 = horizontalPoints[count];
    param14 = buffer;
    line(width - buffer, height/2, horizontalPoints[count], buffer);
    count--;
    if (count < 0) {
      done = true;
      count = 0;
    }
  }

  if (done && !done1) {
    param111 = width - buffer;
    param112 = height/2;
    param113 = buffer;
    param114 = verticalPoints[count];
    line(width - buffer, height/2, buffer, verticalPoints[count]);
    count++;
    if (count > verticalTotal) {
      done1 = true;
      count = 0;
    }
  }

  if (done1) {
    param441 = width - buffer;
    param442 = height/2;
    param443 = horizontalPoints[count];
    param444 = height - buffer;
    line(width - buffer, height/2, horizontalPoints[count], height - buffer);
    count++;
    if (count > horizontalTotal) {
      done = false;
      done1 = false;
      count = horizontalTotal;
    }
  }

  if (!done11) {
    param21 = buffer;
    param22 = height/2;
    param23 = width - buffer;
    param24 = verticalPoints[count1];
    line(buffer, height/2, width - buffer, verticalPoints[count1]);
    count1--;
    lineLine(param11, param12, param13, param14, param21, param22, param23, param24);
    if (count1 < 0) {
      done11 = true;
      count1 = horizontalTotal;
    }
  }

  if (done11 && !done21) {
    param31 = buffer;
    param32 = height/2;
    param33 = horizontalPoints[count1];
    param34 = buffer;   
    line(buffer, height/2, horizontalPoints[count1], buffer);
    if (!done) {
      lineLine(param11, param12, param13, param14, param31, param32, param33, param34);
    }
    if (done && !done1) {
      lineLine(param111, param112, param113, param114, param31, param32, param33, param34);
    }
    count1--;
    if (count1 < 0) {
      done21 = true;
      count1 = 0;
    }
  }

  if (done21 && !done22) {
    param331 = buffer;
    param332 = height/2;
    param333 = horizontalPoints[count1];
    param334 = height - buffer;   
    line(buffer, height/2, horizontalPoints[count1], height - buffer);
    if (!done1) {
      lineLine(param111, param112, param113, param114, param331, param332, param333, param334);
    }
    if (done1) {
      lineLine(param441, param442, param443, param444, param331, param332, param333, param334);
    }
    count1++;
    if (count1 > horizontalTotal) {
      done22 = true;
      count1 = verticalTotal;
    }
  }

  if (done11 && done21 && done22) {
    param551 = buffer;
    param552 = height/2;
    param553 = width - buffer;
    param554 = verticalPoints[count1];
    line(buffer, height/2, width - buffer, verticalPoints[count1]);
    lineLine(param441, param442, param443, param444, param551, param552, param553, param554);
    count1--;
    if (count1 < verticalTotal/2) {
      done11 = false;
      done21 = false;
      done22 = false;
      count1 = verticalTotal/2;
      reset();
    }
  }

  stroke(0, 0, 255);
  strokeWeight(8);
  noFill();
  //fill(255, 0, 0, 5);
  beginShape();
  for (int i = 0; i < points.size(); i++) {
    PVector point = points.get(i);
    point(point.x, point.y);
    //vertex(point.x, point.y);
  }
  endShape();
}

void reset() {
  background(255);
  points = new ArrayList<PVector>();
}

ArrayList<PVector> points = new ArrayList<PVector>();
boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
    float intersectionX = x1 + (uA * (x2-x1));
    float intersectionY = y1 + (uA * (y2-y1));
    fill(255, 0, 0, 100);
    noStroke();
    //ellipse(intersectionX, intersectionY, 5, 5);
    points.add(new PVector(intersectionX, intersectionY));

    return true;
  }
  return false;
}
