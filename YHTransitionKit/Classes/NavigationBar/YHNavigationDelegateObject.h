//
//  YHNavigationDelegateObject.h
//  YHNavigationBarExample
//
//  Created by chenyehong on 2021/4/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHNavigationDelegateObject : NSObject<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

-(instancetype)initWithNavigationController: (UINavigationController *)navigationController;

@end

NS_ASSUME_NONNULL_END
