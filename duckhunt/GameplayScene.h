//
//  GameplayScene.h
//  duckhunt
//
//  Created by Duncan Riefler on 8/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainMenuLayer.h"
#import "SkyLayer.h"
#import "GroundLayer.h"
#import "SpriteLayer.h"
#import "UILayer.h"

@interface GameplayScene : CCScene {
    SkyLayer * theSkyLayer;
    GroundLayer * theGroundLayer;
    SpriteLayer * theSpriteLayer;
    UILayer * theUILayer;
    
    int round;
    int wave;
    int ducksKilledThisRound;
    
    enum GameState {
        RoundBreak = 0,
        WaveState,
        WaveBreak,
        GameOver
    };
    enum GameState m_state;
}

- (void) update: (ccTime)dt;

- (void) startRoundBreak;
- (void) startWave;
- (void) startWaveBreak;
- (void) startGameOver;
- (void) exitScene;



@end
