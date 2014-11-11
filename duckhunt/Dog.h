//
//  Dog.h
//  duckhunt
//
//  Created by Duncan Riefler on 9/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Dog : CCSprite {
    enum DogState {
        Laughing = 0,
        OneDuck,
        TwoDucks
    };
    enum DogState m_dogState;
}

- (void) showDog: (enum DogState) state;
- (void) hideDog;

@end
