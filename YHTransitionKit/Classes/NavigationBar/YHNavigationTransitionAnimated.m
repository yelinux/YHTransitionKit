//
//  YHNavigationTransitionAnimated.m
//  YHNavigationBarExample
//
//  Created by chenyehong on 2021/4/19.
//

#import "YHNavigationTransitionAnimated.h"

@implementation YHNavigationTransitionAnimated

- (void)animateStart: (BOOL)isPush fromIv: (UIImageView*)fromIv toIv: (UIImageView*)toIv{
    CGRect toFrame = toIv.frame;
    if (isPush) {
        toFrame.origin.x += toFrame.size.width;
        toIv.frame = toFrame;
    } else {
        toFrame.origin.x -= 0.3 * toFrame.size.width;
        toIv.frame = toFrame;
    }
}

- (void)animateEnd: (BOOL)isPush fromIv: (UIImageView*)fromIv toIv: (UIImageView*)toIv{
    CGRect toFrame = toIv.frame;
    CGRect fromFrame = fromIv.frame;
    if (isPush) {
        toFrame.origin.x = 0;
        toIv.frame = toFrame;
        
        fromFrame.origin.x -= 0.3 * fromFrame.size.width;
        fromIv.frame = fromFrame;
    } else {
        toFrame.origin.x = 0;
        toIv.frame = toFrame;
        
        fromFrame.origin.x = fromFrame.size.width;
        fromIv.frame = fromFrame;
    }
}

@end
