//
//  YHNavigationFullScreenPopGesture.h
//  YHNavigationBarExample
//
//  Created by chenyehong on 2021/4/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHNavigationFullScreenPopGesture : UIPanGestureRecognizer

-(instancetype)initWithTarget:(id)target action:(SEL)action navigationController:(UINavigationController *)navigationController;

@end

NS_ASSUME_NONNULL_END
