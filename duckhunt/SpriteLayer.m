//
//  SpriteLayer.m
//  duckhunt
//
//  Created by Duncan Riefler on 8/30/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SpriteLayer.h"
#import "SimpleAudioEngine.h"


@implementation SpriteLayer

@synthesize waveOver = m_waveOver, numBullets = m_numBullets, duckSpeed = m_duckSpeed, ducksKilled = m_ducksKilled;

- (id)init
{
    self = [super init];
    if (self) {
        size = [[CCDirector sharedDirector] winSize];
        myDucks = [[NSMutableArray alloc] init];
        self.isTouchEnabled = YES;
        m_waveOver = NO;
        m_numBullets = 3;
        m_ducksKilled = 0;
        m_duckSpeed = 200;
        
    }
    return self;
}

- (void) registerWithTouchDispatcher
{
    [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:INT_MIN +1 swallowsTouches:YES];
    
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (m_waveOver == NO) {
        m_numBullets -= 1;
        CGPoint location = [self convertTouchToNodeSpace:touch];
        [[SimpleAudioEngine sharedEngine] playEffect:@"shot.wav"];
        for (int i = 0; i < myDucks.count; i++) {
            if (CGRectContainsPoint([[myDucks objectAtIndex:i] rect], location)) {
                [self removeChild:[myDucks objectAtIndex:i] cleanup:YES];
                [myDucks removeObjectAtIndex:i];
                m_ducksKilled += 1;
                break;
            }
        }
        if (m_numBullets <= 0 || myDucks.count <= 0) {
            [self endWave];
        }
        return YES;
    }
    else
        return NO;
}

- (void) spawnDuck
{
    if (myDucks.count < 5) {
        Duck *newDuck = [Duck node];
        
        newDuck.speed = m_duckSpeed;
        
        CGPoint position;
        int origin = arc4random() % 4;
        int yval = arc4random() % (int) size.height/2;
        if (origin == 0) {
            position = ccp(0,yval);
        }
        else if (origin == 1) {
            position = ccp(size.width,yval);
        }
        else if (origin == 2) {
            position = ccp(size.width,size.height - yval);
        }
        else if (origin == 3) {
            position = ccp(0,size.height - yval);
        }
        CGPoint center = ccp(size.width/2, size.height/2);

        newDuck.position = position;
        CGPoint vector = ccpSub(center, position);
        newDuck.direction = ccpNormalize(vector);
        if (newDuck.direction.x < 0) {
            newDuck.flipX = YES;
        }
        [newDuck setupAnim];
        [self addChild:newDuck];
        [myDucks addObject:newDuck];
        
        
    }
}

- (void) startWave
{
    m_waveOver = NO;
    m_numBullets = 3;
    m_ducksKilled = 0;
    [self clearDucks];
    [self spawnDuck];
    [self spawnDuck];
    [self scheduleOnce:@selector(endWave) delay:8.0];
}

- (void) endWave
{
    [self unschedule:@selector(endWave)];
    m_waveOver = YES;
}

- (void) clearDucks
{
    while (myDucks.count > 0) {
        [self removeChild:[myDucks objectAtIndex:0] cleanup:YES];
        [myDucks removeObjectAtIndex:0];
    }
}

- (void) update:(ccTime)dt
{
    for (Duck *aDuck in myDucks) {
        [aDuck update:dt];
    }
}

- (void) dealloc
{
    [myDucks dealloc];
    [super dealloc];
}
@end
