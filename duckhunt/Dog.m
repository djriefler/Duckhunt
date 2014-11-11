//
//  Dog.m
//  duckhunt
//
//  Created by Duncan Riefler on 9/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Dog.h"
#import "SimpleAudioEngine.h"


@implementation Dog

- (id)init
{
    self = [super init];
    if (self) {
        [[CCSpriteFrameCache sharedSpriteFrameCache]
         addSpriteFramesWithFile:@"sprites.plist"];
         CGSize size = [[CCDirector sharedDirector] winSize];

        [self setPosition:ccp(size.width/2,0)];
        [self setVisible:YES];
    }
    return self;
}

- (void) showDog: (enum DogState) state
{
    m_dogState = state;
    if (state == Laughing) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"dog_laugh.wav"];
    }
    [self setupAnim];
    [self runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(0,80)]];
    [self scheduleOnce:@selector(hideDog) delay:2.5f];
}

-(void) hideDog
{
    [self runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(0,-80)]];
}

-(void) setupAnim
{
    
    NSMutableArray* files;
    if (m_dogState == Laughing) {
        files = [NSMutableArray arrayWithObjects: @"dog-laugh-00.png",
                 @"dog-laugh-01.png", nil];
    }
    else if (m_dogState == OneDuck) {
        files = [NSMutableArray arrayWithObjects: @"dog-caught-00.png", nil];
    }
    else if (m_dogState == TwoDucks) {
        files = [NSMutableArray arrayWithObjects: @"dog-caught-01.png", nil];
    }
    
    NSMutableArray* frames = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < files.count; i++)
    {
        NSString* file = [files objectAtIndex:i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:file];
        [frames addObject:frame];
    }
    
    [self stopAllActions];
    
    // Start new animation
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
    [self runAction:repeat];
}

@end
