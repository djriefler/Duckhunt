//
//  Duck.h
//  duckhunt
//
//  Created by Duncan Riefler on 9/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Duck : CCSprite {
    int m_speed;
    CGPoint m_direction;
    enum SpriteState {
        standard = 0,
        rising,
        up
    };
    enum SpriteState m_spriteState;
}

@property CGPoint direction;
@property int speed;

- (void) update:(ccTime)dt;
- (CGRect) rect;
-(void) setupAnim;

@end
