//
//  UINavigationController+YHTransition.m
//  YHTransitionKit
//
//  Created by chenyehong on 2022/3/31.
//

#import "UINavigationController+YHTransition.h"
#import <objc/runtime.h>
#import "YHNavigationDelegateObject.h"

@interface UINavigationController()

@property (strong, nonatomic) YHNavigationDelegateObject *delegateObject;

@end

@implementation UINavigationController (YHTransition)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        void (^hookBlock)(SEL originalSEL, SEL swizzledSEL) = ^(SEL originalSEL, SEL swizzledSEL){
            Class class = [self class];
            Method originalMethod = class_getInstanceMethod(class, originalSEL);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
            BOOL didAddMethod =
            class_addMethod(class,
                            originalSEL,
                            method_getImplementation(swizzledMethod),
                            method_getTypeEncoding(swizzledMethod));
            
            if (didAddMethod) {
                class_replaceMethod(class,
                                    swizzledSEL,
                                    method_getImplementation(originalMethod),
                                    method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        };
        
        hookBlock(@selector(viewDidLoad), @selector(yh_viewDidLoad));
    });
}

- (void)yh_viewDidLoad{
    [self yh_viewDidLoad];
    self.delegateObject = [[YHNavigationDelegateObject alloc] initWithNavigationController:self];
}

// Mark - Getter & Setter
-(YHNavigationInteractivePopType)yh_interactivePopType{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

-(void)setYh_interactivePopType:(YHNavigationInteractivePopType)yh_interactivePopType{
    objc_setAssociatedObject(self, @selector(yh_interactivePopType), @(yh_interactivePopType), OBJC_ASSOCIATION_ASSIGN);
}

-(id<UIViewControllerAnimatedTransitioning>)yh_pushPopAnimated{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setYh_pushPopAnimated:(id<UIViewControllerAnimatedTransitioning>)yh_pushPopAnimated{
    objc_setAssociatedObject(self, @selector(yh_pushPopAnimated), yh_pushPopAnimated, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setDelegateObject:(YHNavigationDelegateObject *)delegateObject{
    objc_setAssociatedObject(self, @selector(delegateObject), delegateObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
