import processing.serial.*;
Serial test;
int s = second(); 
int ans;
int p = 0;
int time = 1000;
int tt = 1;
PImage img;

int data, data2;
boolean yes = true;
boolean finish = false;
boolean word = true;
boolean GG = false;
int wx=400,wy=300;
int dx = 200; int dy = 150;
//0:下, 1:左, 2:右, 3:上
int direction=1;
//0~3循環圖片
int step=0;
//是否在移動
boolean moved=false;
//程式的設定




void setup() {
  size(800,600);
  background(0);

  frameRate(60);
  img = loadImage("p3_4.png");
  test = new Serial(this,"COM3",9600);
}
void draw() {

  background(255,255,255);

  textSize(32);
  text("Your time: "+time/100, 10, 30); 
  fill(0, 102, 153);
  text("Point:"+" "+p, 10, 90);


  fill(0,0,255);
  ellipse(dx,dy,20,20);
  noFill();
   
  image(img, wx, wy, 64, 96, step*32, direction*48, step*32+32,direction*48+48);

  if(keyPressed){
     if(key=='s') finish = true;
                  word = false;
                  GG = false;
  }
  else if(word){
     textSize(128);
     fill(0,255 , 0);
     text("ready?",200 ,300);
  }

  else if(GG){
     textSize(64);
     fill(100,255 , 100);
     text("total point:"+p,200 ,300);
     p=0;
  }



  if(finish){
    if(test.available()>0){
      ans = test.read();
      println(ans);
    }









  moved=true;

  if(step==0){
  
    if(ans==2) direction=3; 
    if(ans==1) direction=0;
    if(ans==4) direction=1;
    if(ans==5) direction=2;
  }



if(moved){
  step++;
  step=step%4;
  //在視窗上的移
  if(direction==0)wy+=4;
  if(direction==1)wx-=4;
  if(direction==2)wx+=4;
  if(direction==3)wy-=4;

  if(wx<0) wx=0;
  if(wx>750) wx=750;
  if(wy<0) wy=0;
  if(wy>510) wy=510;
}



  if(wx+16<dx+30&&wx+16>dx-30){
    if(wy+40>dy-30&&wy+40<dy+30){
      dx=(int)random(1,750);
      dy=(int)random(1,550);
      p+=1;
    }  
  }
 time--;
  if(time==0){
     GG = true;
     finish = false;
     time = 6000;
  }
  
  }
}
