//
//  Duck.m
//  duckhunt
//
//  Created by Duncan Riefler on 9/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Duck.h"


@implementation Duck
@synthesize direction = m_direction, speed = m_speed;

- (id)init
{
    self = [super initWithFile:@"duck.png"];
    if (self) {
        [[CCSpriteFrameCache sharedSpriteFrameCache]
         addSpriteFramesWithFile:@"sprites.plist"];
        m_speed = 100;
    }
    return self;
}

- (CGRect) rect
{
    return CGRectMake(self.position.x - self.contentSize.width
                      * self.anchorPoint.x,
                      self.position.y - self.contentSize.height
                      * self.anchorPoint.y,
                      self.contentSize.width,
                      self.contentSize.height);
}

-(void) setupAnim
{
    CGPoint upVector = ccp(0,1);
    CGFloat dot = ccpDot(upVector,self.direction);

    NSMutableArray* files;
    if (dot > 0.7) {
        if (m_spriteState != up) m_spriteState = up;
        files = [NSMutableArray arrayWithObjects: @"duck-06.png",
                 @"duck-07.png", @"duck-08.png", nil];
    }
    else if (dot > 0.2) {
       if (m_spriteState != rising) m_spriteState = rising;
        files = [NSMutableArray arrayWithObjects: @"duck-03.png",
                 @"duck-04.png", @"duck-05.png", nil];
    }
    else {
        if (m_spriteState != standard) m_spriteState = standard;
        files = [NSMutableArray arrayWithObjects: @"duck-00.png",
                 @"duck-01.png", @"duck-02.png", nil];
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


- (void) update: (ccTime) dt
{
    if (self.position.x > [[CCDirector sharedDirector] winSize].width) {
        [self setPosition: ccp([[CCDirector sharedDirector] winSize].width, self.position.y)];
        m_direction.x = -m_direction.x;
        self.flipX = YES;
        [self setupAnim];
    }
    else if (self.position.x < 0) {
        [self setPosition: ccp(0, self.position.y)];
        m_direction.x = -m_direction.x;
        self.flipX = NO;
        [self setupAnim];
    }
    else if (self.position.y > [[CCDirector sharedDirector] winSize].height) {
        [self setPosition: ccp(self.position.x, [[CCDirector sharedDirector] winSize].height)];
        m_direction.y = -m_direction.y;
        [self setupAnim];
    }
    else if (self.position.y < 0) {
        [self setPosition: ccp(self.position.x, 0)];
        m_direction.y = -m_direction.y;
        [self setupAnim];
    }
    [self setPosition: ccpAdd(self.position, ccpMult(m_direction, m_speed*dt))];
}
@end
