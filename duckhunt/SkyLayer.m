//
//  MyCocos2DClass.m
//  duckhunt
//
//  Created by Duncan Riefler on 8/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

// Import the interfaces
#import "SkyLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - SkyLayer

// HelloWorldLayer implementation
@implementation SkyLayer

// on "init" you need to initialize your instance
-(id) init
{
    self = [super initWithColor:ccc4(0, 191, 255, 255)];
	{
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		CCSprite *background;
		background = [CCSprite spriteWithFile:@"Default.png"];
		background.rotation = 90;
		
		background.position = ccp(size.height/2, size.width/2);
        
        theDog = [Dog node];
        [self addChild:theDog];
		
		// add the image as a child to this Layer
//		[self addChild: background];

//		//
//		// Leaderboards and Achievements
//		//
//		
//		// Default font size will be 28 points.
//		[CCMenuItemFont setFontSize:28];
//		
//		// Achievement Menu Item using blocks
//		CCMenuItem *itemNewGame = [CCMenuItemFont itemWithString:@"New Game" block:^(id sender) {
//			
//		}];
//		
//		CCMenu *menu = [CCMenu menuWithItems:itemNewGame, nil];
//		
//		[menu alignItemsVerticallyWithPadding:20];
//		[menu setPosition:ccp( size.height/2, size.width/2 - 125)];
//		
//		// Add the menu to the layer
//		[self addChild:menu];
        
	}
	return self;
}

- (void) showDog: (enum DogState) state
{
    [theDog showDog:state];
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
