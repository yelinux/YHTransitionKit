//
//  UIGestureRecognizer+YHDismiss.m
//  YHTransitionKit
//
//  Created by chenyehong on 2022/4/1.
//

#import "UIGestureRecognizer+YHDismiss.h"
#import <objc/runtime.h>

@interface YHWeakObjectContainer : NSObject

@property (nonatomic, readonly, weak) id weakObject;
- (instancetype)initWeakObject:(id)object;

@end

@implementation UIGestureRecognizer (YHDismiss)

-(id<YHDismissProcessDelegate>)dismissDelegate{
    YHWeakObjectContainer *container = objc_getAssociatedObject(self, _cmd);
    return container.weakObject;
}

-(void)setDismissDelegate:(id<YHDismissProcessDelegate>)dismissDelegate{
    YHWeakObjectContainer *container = [[YHWeakObjectContainer alloc] initWeakObject:dismissDelegate];
    objc_setAssociatedObject(self, @selector(dismissDelegate), container, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation YHWeakObjectContainer

-(instancetype)initWeakObject:(id)object{
    if (self = [super init]) {
        _weakObject = object;
    }
    return self;
}

@end
