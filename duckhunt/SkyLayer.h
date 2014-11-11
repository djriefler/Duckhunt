//
//  MyCocos2DClass.h
//  duckhunt
//
//  Created by Duncan Riefler on 8/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Dog.h"

// HelloWorldLayer
@interface SkyLayer : CCLayerColor
{
    Dog *theDog;
}

- (void) showDog: (enum DogState) state;

@end
