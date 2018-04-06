import android.content.Intent;
import android.os.Bundle;
import android.view.MotionEvent;
import android.os.Environment;
import java.text.DecimalFormat;

import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;
import ketai.data.*;

KetaiBluetooth bt;
KetaiSQLite db;

String info = "";
String info2 = "";
String[] lines2;
KetaiList klist;
PVector remoteMouse = new PVector();
int prelength = -1;
int currentlength = 0;
boolean load = false;
int read = 0;
boolean loadP = false;

ArrayList<String> devicesDiscovered = new ArrayList();
boolean isConfiguring = true;
String bluetoothdata;

String UIText;

String msgToDraw = "no file set";
String dataFile = "";

PImage bg;
int bgNum = 0;
int showNum = 0;
int ram = 0;

PImage D;
PImage C;
PImage I;
PImage V;
PImage S;
PImage Back;
PImage Camera;
PFont font;
boolean bluetoothconnected = false;
int  page = 0;

PImage icon;
PImage background00;
PImage background01;
PImage background02;
PImage background03;
PImage background04;

int wallpaper = 0;

// change the screen size here;
float w = 1080.00/1080.00;
float h = 1920.00/1920.00;

KetaiGesture gesture;
//********************************************************************
// The following code is required to enable bluetooth at startup.
//********************************************************************
void onCreate(Bundle savedInstanceState) {
  super.onCreate(savedInstanceState);
  bt = new KetaiBluetooth(this);
}

void onActivityResult(int requestCode, int resultCode, Intent data) {
  bt.onActivityResult(requestCode, resultCode, data);
}
//********************************************************************
public boolean surfaceTouchEvent(MotionEvent event) {

  //call to keep mouseX, mouseY, etc updated
  super.surfaceTouchEvent(event);

  //forward event to class for processing
  return gesture.surfaceTouchEvent(event);
}

void setup()
{   
  fullScreen(P3D);
  orientation(PORTRAIT);
  println("width * "+w);
  println("height * "+h);
  stroke(255);
  font = loadFont("LithosPro-Regular-24.vlw");
  Pipassetup();
  ram = int(random(1,15));
  gesture = new KetaiGesture(this);
  bt.start();

  UIText =  "D - discover devices\n" +
    //"2 - make this device discoverable\n" +
    "\n"+
    "C - connect to listed bluetooth\n" +
    "\n"+
    //"4 - list paired devices\n" +
    "I - Bluetooth info\n";
    

}

void draw()
{
  if (page == 0)
  {
    ArrayList<String> names;
    background(#E1F3F8);
    // 4 buttons
    D = loadImage("Discover.png");
    //D.resize(int(D.width*w),int(D.height*h));
    image(D,width/2-400*w,250*h);
    C = loadImage("Connect.png");
    //C.resize(int(C.width*w),int(C.height*h));
    image(C,width/2-100*w,250*h);
    I = loadImage("Information.png");
    //I.resize(int(I.width*w),int(I.height*h));
    image(I,width/2+240*w,250*h);
    //based on last key pressed lets display
    //  appropriately
    if(mouseY <=390*h&&mouseY>=250*h&&mouseX<=width/2+380*w&&mouseX>=width/2+240*w){
    info = getBluetoothInformation();
    }
    else{
     if(bt.getConnectedDeviceNames().size()>0){
       bluetoothconnected = true;
       if(currentlength>0){
         info = "Loading.......";
         if(load){
             V = loadImage("Visualization.png");
             //V.resize(int(V.width*w),int(V.height*h));
             image(V,width/2-125*w,height-400*h);
           info = "File loaded!\n\n"+
                 "Press 'V' to see graph";
           }
          }
         else{
            info = "Bluetooth connected!\n\n"+
               "You can send file now";
           }
     }
        else{
        bluetoothconnected = false;
        info = "Discovered Devices:\n\n";
        names = bt.getDiscoveredDeviceNames();
         for (int i=0; i < names.size(); i++){
            info += "["+i+"] "+names.get(i).toString() + "\n\n";
          }
        }
    }
    fill(#91D6E2);
    noStroke();
    rect(width/2-400*w,550*h,800*w,800*h,50*w);
    fill(255);
    textFont(font,40*w);
    text(UIText + "\n\n\n\n" + info, width/2-350*w,650*h);}
  else
  {
      if(load){
        read ++;
        if(read ==1){        
        Pipasload(); 
        loadP = true;
          }
      }
      if(loadP){
        //changebackground();
        //colored background
        Pipasdraw();
        if(mousePressed){
           if(mouseY <=300*h&&mouseY>=220*h&&mouseX<=width-5*w&&mouseX>=width-200*w){
              bgNum++;
              bg = get();
              bg.save(getSdWritableFilePathOrNull ("/img-0"+ram+bgNum+".jpg"));
            }
        }
      }
  }
  drawUI();
}


//Call back method to manage data received
void onBluetoothDataEvent(String who, byte[] data)
{
  if (!bluetoothconnected)
    return;

  info2 += new String(data);
  if(info2.length() >0) {
  dataFile = getSdWritableFilePathOrNull("strings-0"+ram+showNum+".txt");
  if ( dataFile == null ){
        String errorMsg = "There was error getting SD card path. Maybe your device doesn't have SD card mounted at the moment";
        println(errorMsg);
        msgToDraw = errorMsg;
  }
  else{
    
      // now we can use save strings.
      String[] list = info2.split("\\n");
      saveStrings(dataFile, list);
      msgToDraw = "looks like we've managed to save strings to file: [" + dataFile + "]";
       currentlength = list.length;
        for(int i=0;i<list.length; i++){
          if(list[i].equals("<")) load =true;
         }
        println(currentlength);
        }
  }
}

String getBluetoothInformation()
{
  String btInfo = "";
  btInfo += "Discovering: " + bt.isDiscovering() + "\n";
  btInfo += "Device Discoverable: "+bt.isDiscoverable() + "\n\n";

  ArrayList<String> devices = bt.getConnectedDeviceNames();
  if(bt.getConnectedDeviceNames().size()>0){
    for (String device: devices)
    {
      btInfo+= "Connected Devices: \n"+device+"\n\n"+
            "You can send file now";
    }
  }
  else {
  btInfo+= "Try to connect again";
  }
  return btInfo;
}


String getSdWritableFilePathOrNull(String relativeFilename){
   File externalDir = Environment.getExternalStorageDirectory();
   if ( externalDir == null ){
      return null;
   }
   String sketchName= this.getClass().getSimpleName();
   //println("simple class (sketch) name is : " + sketchName );
   File sketchSdDir = new File(externalDir, sketchName);
   
   File finalDir =  new File(sketchSdDir, relativeFilename);
   return finalDir.getAbsolutePath();
}