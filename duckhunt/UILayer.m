//
//  UILayer.m
//  duckhunt
//
//  Created by Duncan Riefler on 9/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "UILayer.h"


@implementation UILayer

- (id)init
{
    self = [super init];
    if (self) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        m_RoundLabel = [CCLabelTTF labelWithString:@"Round 1" fontName:@"Marker Felt"
                                          fontSize:30];
        m_RoundLabel.position = ccp(size.width/2, size.height/2);
        m_RoundLabel.visible = NO;
        [self addChild: m_RoundLabel];
        
        m_WaveLabel = [CCLabelTTF labelWithString:@"Got 2/2 Ducks!" fontName:@"Marker Felt" fontSize:26];
        m_WaveLabel.position = ccp(size.width/2, size.height/2);
        m_WaveLabel.visible = NO;
        [self addChild:m_WaveLabel];
        
        m_GameOver = [CCLabelTTF labelWithString:@"Game Over" fontName:@"Marker Felt"
                                        fontSize:30];
        m_GameOver.position = ccp(size.width/2, size.height/2);
        m_GameOver.visible = NO;
        [self addChild: m_GameOver];
    }
    return self;
}
-(void) showRoundLabel:(int)num
{
    m_RoundLabel.string = [NSString stringWithFormat:@"Round %d", num];
    m_RoundLabel.visible = YES;
}

-(void) hideRoundLabel
{
    m_RoundLabel.visible = NO;
}

-(void) showWaveLabel:(int)num
{
    m_WaveLabel.string = [NSString stringWithFormat:@"Wave %d", num];
    m_WaveLabel.visible = YES;
}

-(void) hideWaveLabel
{
    m_WaveLabel.visible = NO;
}

-(void) showGameOverLabel
{
    m_GameOver.visible = YES;
}


@end
