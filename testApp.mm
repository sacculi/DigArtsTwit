// Thanks to http://in.somniac.me/2010/01/openframeworks-http-requests-xml-parser/
// for the GET and POST XML tutorial..

#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	
	ofBackground(240,230,140);
	// register touch events
	ofxRegisterMultitouch(this);
	
	// initialize the accelerometer
	ofxAccelerometer.setup();
	
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
	
	// initialize all of the Ball particles
	balls.init(10,10,10,10);
	
	ofAddListener(httpUtils.newResponseEvent,this,&testApp::newResponse);
	httpUtils.start();

	
	verdana.loadFont("verdana.ttf", 12, true, true);
	
	dataDrop = 0;
	displayEntries = 0;
	
	switchData = false;
	switchBallSize = 0;
	
	highLabel1 = 40;
	highLabel2 = 40;
	highLabel3 = 40;
	highLabel4 = 40;
}


//--------------------------------------------------------------
void testApp::update() {
	
	printf("x = %f   y = %f \n", ofxAccelerometer.getForce().x, ofxAccelerometer.getForce().y);
	
	if (switchBallSize == 1) {
		balls.update(20+displayEntries, 10,10,10);
	} else if (switchBallSize == 2) {
		balls.update(10, 20+displayEntries, 10,10);
	} else if (switchBallSize == 3) {
		balls.update(10, 10, 20+displayEntries, 10);
	} else if (switchBallSize == 4){
		balls.update(10, 10, 10, 20+displayEntries);
		

	} else if (switchBallSize == 0) {
		balls.update(10, 10, 10, 10);
	}

		
}

//--------------------------------------------------------------
void testApp::draw() {
	
	ofPushStyle();
	
	ofSetColor(0, 0, 0);
	
// do the vector check...
	
	if (switchData == false) {
		
	
	
	if (printStrings.empty()){
		verdana.drawString("Please select category if not chosen", 0, 20);
		verdana.drawString("Red button below advances entries", 0, 40);
		verdana.drawString("Loading Data - Please Wait...", 0, 80);
	} else {
		string text;
		
		text = wrapString(printStrings.at(dataDrop), 180);
		
		
		
		verdana.drawString(text, 0, 20);
		
		//draw the page number bottom right
		char fpsStr[255]; // an array of chars
		
		sprintf(fpsStr, "Countdown: %i", displayEntries);
		
		ofDrawBitmapString(fpsStr, 200, 470);
		}
	}
		if (switchData == true) {
		
		verdana.drawString("Out of data - Press centre ball", 0, 40);
	}
	
	ofPopStyle();
     
	ofPushMatrix();
  	ofTranslate(ofGetWidth()/2, ofGetHeight()/2, 0);
	balls.draw();
	
	ofPopMatrix();
	
	//the move on circle in bottom left of screen
	ofSetColor(255, 0, 0);
	ofFill();
	ofEllipse(50, 430, 40, 40);
	
	
	ofEnableAlphaBlending();
	//drawing the technology type labels
	
	
	ofSetColor(255, 0, 0, highLabel1);
	ofRect(140, 325, 170, 20);
	ofSetColor(0, 0, 0);

	verdana.drawString("Multitouch", 145, 340);
	
	ofSetColor(0, 255, 0, highLabel2);
	ofRect(140, 355, 170, 20);
	ofSetColor(0, 0, 0);
	verdana.drawString("Augmented Reality", 145, 370);

	
	ofSetColor(0, 0, 255, highLabel3);
	ofRect(140, 385, 170, 20);
	ofSetColor(0, 0, 0);

	verdana.drawString("Projection Mapping", 145, 400);

	
	ofSetColor(255, 255, 0, highLabel4);
	ofRect(140, 415, 170, 20);
	ofSetColor(0, 0, 0);

	verdana.drawString("Computer Vision", 145, 430);
	ofDisableAlphaBlending();
}

//--------------------------------------------------------------
void testApp::exit() {
	printf("exit()\n");
}

//--------------------------------------------------------------
void testApp::touchDown(int x, int y, int id){
	printf("touch %i down at (%i,%i)\n", id, x,y);
		if (x >= 10 && x <= 80 && y >= 390 && y <= 470){
		
		//possible location check...
			dataDrop ++;
			displayEntries --;
			if (displayEntries <= 0) {
				switchData = true;
				displayEntries = 0;
			}
		
		
	}
	
	
	//reset if hit the centre ball
	
	
	if (x >= 100 && x <=220 && y >= 180 && y <= 300){
		printStrings.clear();
		setup();
	}
	
	//switching from labels
	
	if (x >= 140 && x <=310 && y >= 325  && y <= 345){
		
		//switch 1
		
		httpUtils.addUrl("http://search.twitter.com/search.atom?q=multitouch");
		
		switchBallSize = 1;
		
		highLabel1 = 255;
		highLabel2 = 40;
		highLabel3 = 40;
		highLabel4 = 40;
		
	}
	
	if (x >= 140 && x <= 310 && y >= 355 && y <= 375){
		
		//switch 2
		
		httpUtils.addUrl("http://search.twitter.com/search.atom?q=augmented reality");
		
		switchBallSize = 2;
		
		highLabel2 = 255;
		highLabel1 = 40;
		highLabel3 = 40;
		highLabel4 = 40;
	}
	
	if (x >= 140 && x <= 310 && y >= 385 && y <= 405){
		
		//switch 3
		httpUtils.addUrl("http://search.twitter.com/search.atom?q=projection mapping");

		switchBallSize = 3;
		
		
		highLabel3 = 255;
		highLabel1 = 40;
		highLabel2 = 40;
		highLabel4 = 40;
		
		
	}
	
	if (x >= 140 && x <= 310 && y >= 415 && y <= 435){
		
		//switch 4
		
		httpUtils.addUrl("http://search.twitter.com/search.atom?q=computer vision");

		switchBallSize = 4;
		
		highLabel4 = 255;
		highLabel1 = 40;
		highLabel2 = 40;
		highLabel3 = 40;
		
	}
	
}

//--------------------------------------------------------------
void testApp::touchMoved(int x, int y, int id){
	printf("touch %i moved at (%i,%i)\n", id, x, y);
	//balls[id].moveTo(x, y);
}

//--------------------------------------------------------------
void testApp::touchUp(int x, int y, int id){
	printf("touch %i up at (%i,%i)\n", id, x, y);
	
		
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(int x, int y, int id){
	printf("touch %i double tap at (%i,%i)\n", id, x, y);
		
}

//--------------------------------------------------------------
void testApp::lostFocus() {
}

//--------------------------------------------------------------
void testApp::gotFocus() {
}

//--------------------------------------------------------------
void testApp::gotMemoryWarning() {
}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){
}

//--------------------------------------------------------------

void testApp::newResponse(ofxHttpResponse &response) {
    // printf("%s\n", response.responseBody.c_str());
	
    XML.loadFromBuffer(response.responseBody); // parse string
    XML.pushTag("feed"); // change relative root to <feed>
	
    numEntries = XML.getNumTags("entry");
	
	displayEntries = numEntries;
    // iterate through <entry> tags
    for (int i = 0; i < numEntries; i++) {
		
				string tempString;
		tempString = XML.getValue("entry:title", "", i).c_str();
		printStrings.push_back(tempString);
		
	
       printf("%s\n", XML.getValue("entry:title", "", i).c_str());
		
				
    }
    XML.popTag(); // move out of <feed>
	
	
	
	
}

//--------------------------------------------------------------
string testApp::wrapString(string text, int width) {
	
	string typeWrapped = "";
	string tempString = "";
	vector <string> words = ofSplitString(text, " ");
	
	for(int i=0; i<words.size(); i++) {
		
		string wrd = words[i];
		
		tempString += wrd + " ";
		int stringwidth = verdana.stringWidth(tempString);
		if(stringwidth >= width) {
			tempString = "";
			typeWrapped += "\n";
		}
		
		typeWrapped += wrd + " ";
	}
	
	return typeWrapped;
	
}
