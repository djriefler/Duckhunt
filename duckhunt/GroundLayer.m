//
//  GroundLayer.m
//  duckhunt
//
//  Created by Duncan Riefler on 8/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GroundLayer.h"


@implementation GroundLayer

-(id) init
{
	if( (self=[super init]) ) {
        CCSprite *ground;
        
        // ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		ground = [CCSprite spriteWithFile:@"game_background.png"];
		
		ground.position = ccp(size.width/2,size.height/2);
		
		// add the image as a child to this Layer
		[self addChild: ground];
		
	}
	return self;
}

@end
