float cameraR=300*sqrt(3);
float baseW=50;
float baseH=30;
float armW1=20;
float armL1=160;
float armW2=20;
float armL2=120;
float armW3=20;
float armL3=60;
float maniW=10;
float maniL=35;
float theta=PI/4;
float phi=PI/4;
float theta1=0;
float theta2=0;
float theta3=PI/2;
float theta4=PI/2;
float theta5=0;
float offset=0;
float dif1=PI/150;
float dif2=5;
float dif3=0.5;
float auto=0;
float t=0;
float t1=0.5;
float t2=2.5;
float t3=3;
float t4=4;
float t5=6;
float t6=7;
float mt6=8;
float t7=9;
float t8=11;
float t9=12;
float t10=12.5;
float t11=14.5;
float t12=15;

void setup(){
  size(500,500,P3D);
  background(255);
}

void draw(){
  //視点移動
  float cameraX=cameraR*sin(theta)*cos(phi);
  float cameraY=cameraR*sin(theta)*sin(phi);
  float cameraZ=cameraR*cos(theta);
  camera(cameraX,cameraY,cameraZ,0,0,0,0,0,-1);
  if(keyPressed){
    if(key=='w'){
      if(theta>0.02){
        theta=theta-dif1;
      }
      if(theta==0){
        theta=0.01;
      }
    }
    if(key=='s'){
      if(theta<=PI-0.02){
        theta=theta+dif1;
      }
      else{
        theta=PI-0.01;
      }
    }
    if(key=='d'){
      phi=phi-dif1;
    }
    if(key=='a'){
      phi=phi+dif1;
    }
    if(key=='v'){
      if(cameraR>0){
        cameraR=cameraR-dif2;
      }
      else{
        cameraR=0;
      }
    }
    if(key=='V'){
      cameraR=cameraR+dif2;
    }
  }
  
  background(255);
  pushMatrix();
  
  //台座
  rotateZ(theta1);
  fill(128);
  translate(0,0,baseH/2);
  box(baseW,baseW,baseH);
  
  //リンク１
  translate(0,0,baseH/2);
  rotateX(-theta2);
  translate(0,0,armL1/2);
  box(armW1,armW1,armL1);
  
  //リンク２
  translate(0,0,armL1/2-armW2/2);
  rotateX(-theta3);
  translate(0,0,armL2/2-armW2/2);
  box(armW2,armW2,armL2);
  
  //リンク３
  translate(0,0,armL2/2-armW3/2);
  rotateX(-theta4);
  translate(0,0,armL3/2-armW3/2);
  box(armW3,armW3,armL3);
  
  //マニピュレータとネジ
  translate(0,0,armL3/2-maniL/2+offset);
  rotateZ(-theta5);
  box(maniW,maniW,maniL);
  translate(0,0,maniL/2+maniW/2);
  box(maniL,maniW,maniW);
  if((auto==1||auto==0)&&((t>t1&&t<=t5)||(t>t7&&t<=t11))){
    fill(255,255,0);
    translate(0,0,maniW/2+3*maniL/2-10);
    box(maniW,maniW,maniL);
    translate(0,0,-maniW/2-3*maniL/2+10);
    fill(128);
  }
  translate(maniL/2-maniW/2,0,maniL/2+maniW/2);
  box(maniW,maniW,maniL);
  translate(-maniL+maniW,0,0);
  box(maniW,maniW,maniL);
  
  popMatrix();
  
  //ネジとネジ受け
  fill(64);
  translate(0,-175,140);
  box(50,50,50);
  if((auto==0&&t>t5&&t<=t7)||(auto==1&&t>t5&&t<=t7)){
    fill(255,255,0);
    translate(0,17.5,0);
    box(maniW,maniL,maniW);
    translate(0,-17.5,0);
    fill(64);
  }
  translate(0,325,-165);
  box(50,50,50);
  if((auto==0&&(t<=t1||t>t11))||(auto==1&&(t<=t1||t>t11))){
    fill(255,255,0);
    translate(0,0,17.5);
    box(maniW,maniW,maniL);
    translate(0,0,-17.5);
    fill(64);
  }
  
  //アームのマニュアル操作とリセット
  if(keyPressed){
    
    //アームの操作
    if(key=='q'){
      theta1=theta1+dif1;
    }
    if(key=='Q'){
      theta1=theta1-dif1;
    }
    if(key=='z'){
      theta2=theta2+dif1;
    }
    if(key=='Z'){
      theta2=theta2-dif1;
    }
    if(key=='x'){
      theta3=theta3+dif1;
    }
    if(key=='X'){
      theta3=theta3-dif1;
    }
    if(key=='c'){
      theta4=theta4+dif1;
    }
    if(key=='C'){
      theta4=theta4-dif1;
    }
    if(key=='e'){
      theta5=theta5+dif1;
    }
    if(key=='E'){
      theta5=theta5-dif1;
    }
    if(key=='f'){
      if(offset<maniL){
        offset=offset+dif3;
      }
      else{
        offset=maniL;
      }
    }
    if(key=='F'){
      if(offset>0){
        offset=offset-dif3;
      }
      else{
        offset=0;
      }
    }
    
    //リセット
    if(key=='r'){
      theta1=0;
      theta2=0;
      theta3=PI/2;
      theta4=PI/2;
      theta5=0;
      offset=0;
      t=0;
    }
    if(key=='R'){
      theta=PI/4;
      phi=PI/4;
      cameraR=300*sqrt(3);
    }
  }
  
  //オートモード
  if(keyPressed){
    if(key=='t'){
      auto=1;
    }
    if(key=='T'){
      auto=0;
    }
  }
  if(auto==1){
    t+=0.01;
    if(t<=t1){
      theta2=(PI/2-2*acos(3/sqrt(13)))*(t/t1);
      theta4=PI/2-(2*acos(2/sqrt(13))-PI/2)*(t/t1);
      offset=maniL*(t/t1);
    }
    if(t>t1&&t<=t2){
      theta5=-10*PI*((t-t1)/(t2-t1));
      offset=maniL-maniL*((t-t1)/(t2-t1));
    }
    if(t>t2&&t<=t3){
      theta2=PI/2-2*acos(3/sqrt(13))-(PI/2-2*acos(3/sqrt(13)))*((t-t2)/(t3-t2));
      theta4=PI-2*acos(2/sqrt(13))+(2*acos(2/sqrt(13))-PI/2)*((t-t2)/(t3-t2));
    }
    if(t>t3&&t<=t4){
      theta1=PI*((t-t3)/(t4-t3));
      theta2=-(acos(2/(5*sqrt(5)))+acos(sqrt(5)/3)-PI/2)*((t-t3)/(t4-t3));
      theta3=PI/2+(PI/2-asin(sqrt(5)/3))*((t-t3)/(t4-t3));
      theta4=PI/2-(PI/2+acos(11/(5*sqrt(5))))*((t-t3)/(t4-t3));
    }
    if(t>t4&&t<=t5+0.01){
      theta5=10*PI*((t-t4)/(t5-t4));
      offset=maniL*((t-t4)/(t5-t4));
    }
    if(t>t5&&t<=t6+0.01){
      theta1=PI-PI*((t-t5)/(t6-t5));
      theta2=-(acos(2/(5*sqrt(5)))+acos(sqrt(5)/3)-PI/2)+(acos(2/(5*sqrt(5)))+acos(sqrt(5)/3)-PI/2)*((t-t5)/(t6-t5));
      theta3=PI-asin(sqrt(5)/3)+(asin(sqrt(5)/3)-PI/2)*((t-t5)/(t6-t5));
      theta4=-acos(11/(5*sqrt(5)))+(acos(11/(5*sqrt(5)))+PI/2)*((t-t5)/(t6-t5));
      offset=maniL-maniL*((t-t5)/(t6-t5));
    }
    if(t>mt6&&t<=t7+0.01){
      theta1=PI*((t-mt6)/(t7-mt6));
      theta2=-(acos(2/(5*sqrt(5)))+acos(sqrt(5)/3)-PI/2)*((t-mt6)/(t7-mt6));
      theta3=PI/2+(PI/2-asin(sqrt(5)/3))*((t-mt6)/(t7-mt6));
      theta4=PI/2-(PI/2+acos(11/(5*sqrt(5))))*((t-mt6)/(t7-mt6));
      offset=maniL*((t-mt6)/(t7-mt6));
    }
    if(t>t7&&t<=t8+0.01){
      theta5=-10*PI*((t-t7)/(t8-t7));
      offset=maniL-maniL*((t-t7)/(t8-t7));
    }
    if(t>t8&&t<=t9+0.01){
      theta1=PI-PI*((t-t8)/(t9-t8));
      theta2=-(acos(2/(5*sqrt(5)))+acos(sqrt(5)/3)-PI/2)+(acos(2/(5*sqrt(5)))+acos(sqrt(5)/3)-PI/2)*((t-t8)/(t9-t8));
      theta3=PI-asin(sqrt(5)/3)+(asin(sqrt(5)/3)-PI/2)*((t-t8)/(t9-t8));
      theta4=-acos(11/(5*sqrt(5)))+(acos(11/(5*sqrt(5)))+PI/2)*((t-t8)/(t9-t8));
    }
    if(t>t9&&t<=t10){
      theta2=(PI/2-2*acos(3/sqrt(13)))*((t-t9)/(t10-t9));
      theta4=PI/2-(2*acos(2/sqrt(13))-PI/2)*((t-t9)/(t10-t9));
    }
    if(t>t10&&t<=t11+0.01){
      theta5=10*PI*((t-t10)/(t11-t10));
      offset=maniL*((t-t10)/(t11-t10));
    }
    if(t>t11&&t<=t12){
      theta2=PI/2-2*acos(3/sqrt(13))-(PI/2-2*acos(3/sqrt(13)))*((t-t11)/(t12-t11));
      theta4=PI-2*acos(2/sqrt(13))+(2*acos(2/sqrt(13))-PI/2)*((t-t11)/(t12-t11));
      offset=maniL-maniL*((t-t11)/(t12-t11));
    }
    if(t>t12+1){
      t=0;
    }
  }
}

  
