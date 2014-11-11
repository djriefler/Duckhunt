//
//  GameplayScene.m
//  duckhunt
//
//  Created by Duncan Riefler on 8/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameplayScene.h"
#import "SimpleAudioEngine.h"

@implementation GameplayScene

-(id) init
{
	if( (self=[super init]) ) {
		theSkyLayer = [SkyLayer node];
        [self addChild: theSkyLayer z:0];
        theGroundLayer = [GroundLayer node];
        [self addChild: theGroundLayer z:1];
        theSpriteLayer = [SpriteLayer node];
        [self addChild:theSpriteLayer z:2];
        theUILayer = [UILayer node];
        [self addChild:theUILayer z:3];
        
        
        
        round = 0;
        wave = 0;
        ducksKilledThisRound = 0;
        
        [self schedule:@selector(update:)];
        [self startRoundBreak];
	}
	return self;
}

- (void) update: (ccTime)dt
{
    [theSpriteLayer update:dt];
    if (m_state == WaveState && [theSpriteLayer waveOver] == YES) {
        [self startWaveBreak];
    }
}

- (void) startRoundBreak
{
    m_state = RoundBreak;
    round++;
    wave = 1;
    ducksKilledThisRound = 0;
    [theSpriteLayer setDuckSpeed:200 + (1+round)*50];
    [theUILayer showRoundLabel:round];
    [theUILayer hideWaveLabel];
    if (round == 1) {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"start_game_music.mp3"
                                                         loop:NO];
    }
    else
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"next_round_music.mp3"
                                                         loop:NO];
    [self scheduleOnce:@selector(firstWave) delay:5];
    [self scheduleOnce:@selector(startWave) delay:7];
    
}

- (void) firstWave
{
    [theUILayer hideRoundLabel];
    [theUILayer showWaveLabel:wave];
}

- (void) startWave
{
    m_state = WaveState;
    wave++;
    [theSpriteLayer startWave];
    [theUILayer hideWaveLabel];
    [theUILayer hideRoundLabel];
    [self schedule:@selector(duckQuack) interval:0.25f];

}

- (void) startWaveBreak
{
    m_state = WaveBreak;
    [theSpriteLayer clearDucks];
    ducksKilledThisRound += [theSpriteLayer ducksKilled];
    if (wave != 6) {
        [theUILayer showWaveLabel:wave];
    }
    [self unschedule:@selector(duckQuack)];
    if ([theSpriteLayer ducksKilled] == 2) {
        [theSkyLayer showDog:TwoDucks];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"got_ducks_music.mp3"
                                                         loop:NO];
    }
    else if ([theSpriteLayer ducksKilled] == 1) {
        [theSkyLayer showDog:OneDuck];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"got_ducks_music.mp3"
                                                         loop:NO];
    }
    else if ([theSpriteLayer ducksKilled] == 0) {
        [theSkyLayer showDog:Laughing];
    }
    if (wave == 6) {
        if (ducksKilledThisRound < 6) {
            [self startGameOver];
            return;
        }
        else
            [self scheduleOnce:@selector(startRoundBreak) delay:3];
    }
    else
        [self scheduleOnce:@selector(startWave) delay:3];
    
}

- (void) startGameOver
{
    [theUILayer hideWaveLabel];
    [theUILayer showGameOverLabel];
    [theSkyLayer showDog:Laughing];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"game_over_music.mp3"
                                                     loop:NO];
    [self scheduleOnce:@selector(exitScene) delay:3];
}

-(void) exitScene
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[MainMenuLayer scene]]];
}

-(void) duckQuack
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"duck_quack.wav"];
}

@end
