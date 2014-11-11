//
//  SpriteLayer.h
//  duckhunt
//
//  Created by Duncan Riefler on 8/30/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Duck.h"

@interface SpriteLayer : CCLayer {
    NSMutableArray * myDucks;
    CGSize size;
    BOOL m_waveOver;
    int m_numBullets;
    int m_ducksKilled;
    int m_duckSpeed;
}

@property BOOL waveOver;
@property int numBullets;
@property int ducksKilled;
@property int duckSpeed;

- (void) update:(ccTime)dt;
- (void) spawnDuck;
- (void) startWave;
- (void) endWave;
- (void) clearDucks;

@end
