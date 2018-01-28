import cassette.audiofiles.*;

SoundFile music;
PImage McD;
float angle = 0;
PImage marsText;
PImage earthText;
int isPlaying = 1;
PShape globe;
int m = minute();
int s = second();
int h1 =0;
int m1 = 0;
int s1 = 0;
boolean useMars = true;
float JDN = 367 * year() - (7 * (year() + 5001 + (month() - 9)/7))/4 + (275 * month())/9 + day() + 1729777;
float JD = JDN + (hour()-12/24)+(minute()/1440)+(second()/86400);
float MSD = (JD - 2405522.0028779)/1.0274912517;
float h;
PFont font;
void setup() {
  fullScreen (P3D);
  noStroke();
  noFill();
  
  font = createFont("Centaur-48.vlw", 100); 
  marsText = loadImage("mars_1k_color.jpg");
  earthText = loadImage("earthmap1k.jpg");
  McD = loadImage("McD2.jpg");
  globe = createShape(SPHERE, 200);
  globe.setTexture(earthText);

  //canvas = createGraphics(width, height, P3D);
}
void draw() {
  angle += 0.01;
  background(#000000);
  //text(player.getDuration(),10,10);
  //text(player.getCurrentPosition(),10,30);
  // 3D part --------------------------------------------- 
  noStroke();
  rect(0, 0, 200, 200);
  pointLight(255, 255, 255, mouseX, mouseY, 1800);
  translate(width / 2-200, height / 2);
  rotate(angle, 0, 0.1, 0.0);
  shape(globe);
  //sphere(500);
  // 2D part / HUD  ---------------------------------------------
  // image(canvas, 0, 0);
  camera();
  //  hint(DISABLE_DEPTH_MASK);
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(MODEL);
  textAlign(CENTER);
  textFont(font);
  textSize(50);
  text(h, width/2 +250, height/2 + textAscent()-105 );
  text(hour() + ":" + minute() + ":" + second(), width/2 + 200, height/2 + textAscent());
  //text(mouseX + ", " + mouseY, mouseX, mouseY);
  hint(ENABLE_DEPTH_TEST);
}
public void mousePressed() {
  useMars = !useMars;
  globe = createShape(SPHERE, 200);
  if (useMars) {
    globe.setTexture(marsText);
    h = MSD;
    //music.stop();
  } else {
    globe.setTexture(earthText);
    h = JD;
    //music.stop();
  }
  if (mouseX<200 && mouseY<200) {
    music = new SoundFile(this, "M.mp3");
    music.loop();
    globe.setTexture(McD);
  }
}