//
//  YHNavigationScaleAnimated.m
//  YHNavigationBarExample
//
//  Created by chenyehong on 2022/3/4.
//

#import "YHNavigationScaleAnimated.h"

@implementation YHNavigationScaleAnimated

- (void)animateStart: (BOOL)isPush fromIv: (UIImageView*)fromIv toIv: (UIImageView*)toIv{
    CGRect toFrame = toIv.frame;
    if (isPush) {
        toFrame.origin.x += toFrame.size.width;
        toIv.frame = toFrame;
    } else {
        toIv.transform = CGAffineTransformMakeScale(0.95, 0.97);
    }
}

- (void)animateEnd: (BOOL)isPush fromIv: (UIImageView*)fromIv toIv: (UIImageView*)toIv{
    CGRect toFrame = toIv.frame;
    CGRect fromFrame = fromIv.frame;
    if (isPush) {
        toFrame.origin.x = 0;
        toIv.frame = toFrame;
        
        fromIv.transform = CGAffineTransformMakeScale(0.95, 0.97);
    } else {
        toIv.transform = CGAffineTransformIdentity;
        
        fromFrame.origin.x = fromFrame.size.width;
        fromIv.frame = fromFrame;
    }
}

@end
