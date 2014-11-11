//
//  UILayer.h
//  duckhunt
//
//  Created by Duncan Riefler on 9/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCLabelTTF.h"

@interface UILayer : CCLayer {
    CCLabelTTF* m_RoundLabel;
    CCLabelTTF* m_WaveLabel;
    CCLabelTTF* m_GameOver;
}

-(void) showRoundLabel:(int)num;
-(void) hideRoundLabel;
-(void) showWaveLabel:(int)num;
-(void) hideWaveLabel;
-(void) showGameOverLabel;

@end
