//
//  YHPresentDismissBaseAnimated.h
//  YHTransitionKit
//
//  Created by chenyehong on 2022/3/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHPresentDismissBaseAnimated : NSObject<UIViewControllerAnimatedTransitioning>

- (void)animateStart: (BOOL)isPush fromIv: (UIImageView*)fromIv toIv: (UIImageView*)toIv;
- (void)animateEnd: (BOOL)isPush fromIv: (UIImageView*)fromIv toIv: (UIImageView*)toIv;

@end

NS_ASSUME_NONNULL_END
