//
//  YHPresentDismissScaleBottomAnimated.m
//  YHTransitionKit
//
//  Created by chenyehong on 2022/4/1.
//

#import "YHPresentDismissScaleBottomAnimated.h"

@implementation YHPresentDismissScaleBottomAnimated

- (void)animateStart: (BOOL)isPush fromIv: (UIImageView*)fromIv toIv: (UIImageView*)toIv{
    CGRect toFrame = toIv.frame;
    if (isPush) {
        toFrame.origin.y += toFrame.size.height;
        toIv.frame = toFrame;
    } else {
        toIv.transform = CGAffineTransformMakeScale(0.95, 0.97);
    }
}

- (void)animateEnd: (BOOL)isPush fromIv: (UIImageView*)fromIv toIv: (UIImageView*)toIv{
    CGRect toFrame = toIv.frame;
    CGRect fromFrame = fromIv.frame;
    if (isPush) {
        toFrame.origin.y = 0;
        toIv.frame = toFrame;
        
        fromIv.transform = CGAffineTransformMakeScale(0.95, 0.97);
    } else {
        toIv.transform = CGAffineTransformIdentity;
        
        fromFrame.origin.y = fromFrame.size.height;
        fromIv.frame = fromFrame;
    }
}

@end
