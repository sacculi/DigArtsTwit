#pragma once

class Ball {
public:
	
	float theta;
	float multiSize;
	float augSize;
	float projSize;
	float compSize;
	
	void init(float _multiSize, float _augSize, float _projSize, float _compSize) {
		theta = 0;
		
		multiSize = _multiSize;
		augSize = _augSize;
		projSize = _projSize;
		compSize = _compSize;
		 
		//lets make our circles look a little nicer!
		ofSetCircleResolution(40);
		
		//for smooth animation, set vertical sync if we can
		ofSetVerticalSync(true);
		// also, frame rate:
		ofSetFrameRate(60);
		ofEnableAlphaBlending();
	}
	
    void update(float _multiSize, float _augSize, float _projSize, float _compSize) {
		
		multiSize = _multiSize;
		augSize = _augSize;
		projSize = _projSize;
		compSize = _compSize;
		//balls circling one another- from Shiffman tutorial. modded
	}
	
	void draw(){
		
		//centre ball with smaller black balls within
		ofFill();
		
		ofSetColor(160, 82, 45, theta);
		ofEllipse(0, 0, 60, 60);
		ofPushMatrix();
		ofRotate(theta, 0, 0, 1);
		ofSetColor(0, 0, 0);
		ofEllipse(0, 0, 10, 10);
		ofEllipse(-20, 0, 10, 10);
		ofEllipse(-16, -16, 10, 10);
		ofEllipse(16, 16, 10, 10);
		ofEllipse(-16, 16, 10, 10);
		ofEllipse(16, -16, 10, 10);
		ofEllipse(0, -20, 10, 10);
		ofEllipse(0, 20, 10, 10);
		ofEllipse(20, 0, 10, 10);
		ofPopMatrix();
		
		//ball 1 - multitouch switch = 1
		
		if (theta>50) {
			
		
		
		ofPushMatrix();
		ofRotate(-theta*4, 0, 0, 1);
		ofTranslate(40, 0, 0);
		ofFill();
		
		ofSetColor(255, 0, 0, theta*multiSize);
		ofEllipse(0, 0, multiSize, multiSize);
		
		ofNoFill();
		ofPopMatrix();
		}
		
		//ball 2 - augmented reality switch = 2
			
			if (theta>100) {
				
		
		ofPushMatrix();
		ofRotate(theta*2, 0, 0, 1);
		ofTranslate(60, 0, 0);
		ofFill();
		
		ofSetColor(0, 255, 0, theta*augSize);
		ofEllipse(0, 0, augSize, augSize);
		
		ofNoFill();
		ofPopMatrix();
		
			}
			
		//ball 3 - projection mapping switch = 3
		if (theta>150) {
			
			
			
			ofPushMatrix();
			ofRotate(-theta*6, 0, 0, 1);
			ofTranslate(80, 0, 0);
			ofFill();
			
			ofSetColor(0, 0, 255, theta*projSize);
			ofEllipse(0, 0, projSize, projSize);
			
			ofNoFill();
			ofPopMatrix();
		}
			
		//ball 4 - computer vision switch = 4
			if (theta>200) {
				
				
				ofPushMatrix();
				ofRotate(theta*4, 0, 0, 1);
				ofTranslate(100, 0, 0);
				ofFill();
				
				ofSetColor(255, 255, 0, theta*compSize);
				ofEllipse(0, 0, compSize, compSize);
				
				ofNoFill();
				ofPopMatrix();
			}		
				
				
		ofPopMatrix();
		
		ofDisableAlphaBlending();
		
		theta += 1;
		
		
		
		
	}			
		
};
