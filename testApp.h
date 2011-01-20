#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "Ball.h"

#include "ofxXmlSettings.h"
#include "ofxHttpUtils.h"
#include <string>

#define NUM_STRINGS 10

class testApp : public ofxiPhoneApp{
	
public:
	void setup();
	void update();
	void draw();
	void exit();

	void touchDown(int x, int y, int id);
	void touchMoved(int x, int y, int id);
	void touchUp(int x, int y, int id);
	void touchDoubleTap(int x, int y, int id);
	
	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);
	
	Ball balls;
	
	//string vector
	vector <string> printStrings;
	
	 ofxHttpUtils httpUtils;
	
	void newResponse(ofxHttpResponse &response);
	
	ofxXmlSettings XML;
	
	string wrapString(string text, int width);
	
	ofTrueTypeFont verdana;
	
	int dataDrop;
	
	int numEntries;
	int displayEntries;
	
	bool switchData;
	
	
	int switchBallSize;
	int highLabel1;
	int highLabel2;

	int highLabel3;

	int highLabel4;

	
};
