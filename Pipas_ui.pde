/*  UI-related functions */

void mousePressed()
{
  //println(w);
  //keyboard button -- toggle virtual keyboard
  if(bluetoothconnected && load){
    if(mouseY <=height-150*h&&mouseY>=1028-400*h&&mouseX<=width/2+125*w&&mouseX>=width/2-125*w){
        //if we're entering draw mode then clear canvas
        if(page == 0){
          page = 1;
          showNum++;
        }
    }
  }
  
  if(page == 0){
     //button Discover
    if(mouseY <=390*h&&mouseY>=250*h&&mouseX<=width/2-260*w&&mouseX>=width/2-400*w){
      bt.discoverDevices();
    }
    //list Discover bluetooth
    else if(mouseY <=390*h&&mouseY>=250*h&&mouseX<=width/2+40*w&&mouseX>=width/2-100*w){
       if (bt.getDiscoveredDeviceNames().size() > 0)
        klist = new KetaiList(this, bt.getDiscoveredDeviceNames());
    }
  }
  else if(page == 1){
     if(mouseY <=300*h&&mouseY>=220*h&&mouseX<=105*w&&mouseX>=5*w){
         //println("back");
          page = 0;
          }
  }
}

PImage colorset;
PImage bg01;
PImage bg02;
PImage bg03;
PImage bg04;
void drawUI()
{
  //Draw top shelf UI buttons

  pushStyle();
  fill(#91D6E2);
  noStroke();
  rect(0,0,width,200*h);
  //icon.resize(100,100);
  icon = loadImage("icon.png");
  //icon.resize(int(icon.width*w),int(icon.height*h));
  //image(icon,width/2-100*w,20*h);
  //rect(0, 0, width/3, 100);
  if(page == 1){
        Back = loadImage("back.png");
        //Back.resize(int(Back.width*w),int(Back.height*h));
        image(Back,5*w,220*h);
        Camera = loadImage("camera.png");
        //Camera.resize(int(Camera.width*w),int(Camera.height*h));
         image(Camera,width-120*w,220*h);
         fill(#E1F3F8);
         //rect(width/2-405,height-305,810,210,20);
         colorset = loadImage("color.png");
         //colorset.resize(int(colorset.width*w),int(colorset.height*h));
         textFont(font,30*w);
         text("XColor:",width/2-400*w,height-300*h);
         image(colorset,width/2-400*w,height-300*h);
         text("YColor:",width/2-400*w,height-200*h);
         image(colorset,width/2-400*w,height-200*h);
         text("ZColor:",width/2-400*w,height-100*h);
         image(colorset,width/2-400*w,height-100*h);
         noFill();
         stroke(#E1F3F8);
         strokeWeight(4);
         ellipse(width/2-164*w,276*h,100*w,100*h);
         ellipse(width/2-4*w,276*h,100*w,100*h);
         ellipse(width/2+156*w,276*h,100*w,100*h);
         ellipse(width/2+316*w,276*h,100*w,100*h);
         colorMode(HSB, 255);
         fill(backgroundHue, 200, 80);
         ellipse(width/2-324*w,276*h,100*w,100*h);
         colorMode(RGB);
         bg01 = loadImage("bg01.png");
         //bg01.resize(int(bg01.width*w),int(bg01.height*h));
         image(bg01,width/2-220*w,220*h);
         bg02 = loadImage("bg02.png");
         //bg02.resize(int(bg02.width*w),int(bg02.height*h));
         image(bg02,width/2-60*w,220*h);
         bg03 = loadImage("bg03.png");
         //bg03.resize(int(bg03.width*w),int(bg03.height*h));
         image(bg03,width/2+100*w,220*h);
         bg04 = loadImage("bg04.png");
         //bg04.resize(int(bg04.width*w),int(bg04.height*h));
         image(bg04,width/2+260*w,220*h);
  }
  popStyle();
}

void changebackground(){
          
         if(mouseY <=300*h&&mouseY>=200*h&&mouseX<=width/2-60*w&&mouseX>=width/2-220*w){
           wallpaper = 1;
         }
         else if(mouseY <=300*h&&mouseY>=200*h&&mouseX<=width/2+100*w&&mouseX>=width/2-60*w){
           wallpaper = 2;
         }
         else if(mouseY <=300*h&&mouseY>=200*h&&mouseX<=width/2+260*w&&mouseX>=width/2+100*w){
           wallpaper = 3;
         }
         else if(mouseY <=300*h&&mouseY>=200*h&&mouseX<=width/2+420*w&&mouseX>=width/2+260*w){
           wallpaper = 4;
         }
         else if(mouseY <=300*h&&mouseY>=200*h&&mouseX<=width/2-224*w&&mouseX>=width/2-324*w){
           wallpaper = 0;
         }

         if(wallpaper == 1){
          pushMatrix();
          background01 = loadImage("sky01.jpg");
          image(background01, 0, 0, width, height);
          popMatrix();
         } 
         else if(wallpaper == 2){
         pushMatrix();
         background02 = loadImage("sky02.jpg");
         image(background02, 0, 0, width, height);
         popMatrix();
         }
         else if(wallpaper == 3){
         pushMatrix();
         background03 = loadImage("sky03.jpg");
         image(background03, 0, 0, width, height);
         popMatrix();
         }
         else if(wallpaper == 4){
         pushMatrix();
         background04 = loadImage("sky04.jpg");
         image(background04, 0, 0, width, height);
         popMatrix();
         }
         else if(wallpaper == 0){
          colorMode(HSB, 255);
          background(backgroundHue, 200, 80);
          //tint(255, 200);
         }
}
float colorX = 0;
void changeGraphColor(){
    colorMode(RGB);
    if(mouseX<=width/2-100*w&mouseX>=width/2-400*w){
      colorX = map((mouseX-(width/2-400*w)),20*w,300*w,0,255);
      if(mouseY <=height-200*h&&mouseY>=height-300*h){
      //println(colorX);
      xCol = color(255,colorX,0);
      noFill();
      stroke(#E1F3F8);
      rect(mouseX-20*w,height-290*h,55*w,55*h,25*w);
      }
      else if(mouseY <=height-100*h&&mouseY>=height-200*h){
      yCol = color(255,colorX,0);
      noFill();
      stroke(#E1F3F8);
      rect(mouseX-20*w,height-190*h,55*w,55*h,25*w);
      }
      else if(mouseY <=height&&mouseY>=height-100*h){
      zCol = color(255,colorX,0);
      noFill();
      stroke(#E1F3F8);
      rect(mouseX-20*w,height-90*h,55*w,55*h,25*w);
      }
    }
    else if(mouseX<=width/2&&mouseX>=width/2-100*w){
      colorX = map((mouseX-(width/2-400*w)),300*w,400*h,255,0);
      if(mouseY <=height-200*h&&mouseY>=height-300*h){
      //println(colorX);
        xCol = color(colorX,255,0);
        noFill();
        stroke(#E1F3F8);
        rect(mouseX-20*w,height-290*h,55*w,55*h,25);
        }
        else if(mouseY <=height-100*h&&mouseY>=height-200*h){
        yCol = color(colorX,255,0);
        noFill();
        stroke(#E1F3F8);
        rect(mouseX-20*w,height-190*h,55*w,55*h,25*w);
        }
        else if(mouseY <=height&&mouseY>=height-100*h){
        zCol = color(colorX,255,0);
        noFill();
        stroke(#E1F3F8);
        rect(mouseX-20*w,height-90*h,55*w,55*h,25*w);
        }  
      }
    else if(mouseX<=width/2+150*w&&mouseX>=width/2){
      colorX = map((mouseX-(width/2-400*w)),400*w,550*h,0,255);
      if(mouseY <=height-200*h&&mouseY>=height-300*h){
      //println(colorX);
        xCol = color(0,255,colorX);
        noFill();
        stroke(#E1F3F8);
        rect(mouseX-20*w,height-290*h,55*w,55*h,25*w);
        }
        else if(mouseY <=height-100*h&&mouseY>=height-200*h){
        yCol = color(0,255,colorX);
        noFill();
        stroke(#E1F3F8);
        rect(mouseX-20*w,height-190*h,55*w,55*h,25*w);
        }
        else if(mouseY <=height&&mouseY>=height-100*h){
        zCol = color(0,255,colorX);
        noFill();
        stroke(#E1F3F8);
        rect(mouseX-20*w,height-90*h,55*w,55*h,25*w);
        }  
      }
    else if(mouseX<=width/2+280*w&&mouseX>=width/2+150*w){
      colorX = map((mouseX-(width/2-400*w)),550*w,680*h,255,0);
      if(mouseY <=height-200*h&&mouseY>=height-300*h){
      //println(colorX);
        xCol = color(0,colorX,255);
        noFill();
        stroke(#E1F3F8);
        rect(mouseX-20*w,height-290*h,55*w,55*h,25*w);
        }
        else if(mouseY <=height-100*h&&mouseY>=height-200*h){
        yCol = color(0,colorX,255);
        noFill();
        stroke(#E1F3F8);
        rect(mouseX-20*w,height-190*h,55*w,55*h,25*w);
        }
        else if(mouseY <=height&&mouseY>=height-100*h){
        zCol = color(0,colorX,255);
        noFill();
        stroke(#E1F3F8);
        rect(mouseX-20*w,height-90*h,55*w,55*h,25*w);
        }  
      }
    else if(mouseX<=width/2+400*w&&mouseX>=width/2+280*w){
      colorX = map((mouseX-(width/2-400*w)),680*w,800*h,0,200);
      if(mouseY <=height-200*h&&mouseY>=height-300*h){
      //println(colorX);
        xCol = color(colorX,0,255);
        noFill();
        stroke(#E1F3F8);
        rect(mouseX-20*w,height-290*h,55*w,55*h,25*w);
        }
        else if(mouseY <=height-100*h&&mouseY>=height-200*h){
        yCol = color(colorX,0,255);
        noFill();
        stroke(#E1F3F8);
        rect(mouseX-20*w,height-190*h,55*w,55*h,25*w);
        }
        else if(mouseY <=height&&mouseY>=height-100*h){
        zCol = color(colorX,0,255);
        noFill();
        stroke(#E1F3F8);
        rect(mouseX-20*w,height-90*h,55*w,55*h,25*w);
        }  
      }    
}

void onKetaiListSelection(KetaiList klist)
{
  String selection = klist.getSelection();
  bt.connectToDeviceByName(selection);
  //dispose of list for now
  klist = null;
}