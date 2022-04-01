//
//  UIViewController+YHNavigation.m
//  YHNavigationBarExample
//
//  Created by chenyehong on 2021/4/19.
//

#import "UIViewController+YHNavigation.h"
#import <objc/runtime.h>

API_AVAILABLE(ios(13.0))
UINavigationBarAppearance *getStandardAppearanceBlock(UINavigationBar *navigationBar){
    if (!navigationBar.standardAppearance) {
        UINavigationBarAppearance *appearnace = [[UINavigationBarAppearance alloc] init];
        [appearnace configureWithOpaqueBackground];
        navigationBar.standardAppearance = appearnace;
    }
    return navigationBar.standardAppearance;
}

API_AVAILABLE(ios(13.0))
UINavigationBarAppearance *getScrollEdgeAppearanceBlock(UINavigationBar *navigationBar){
    if (!navigationBar.scrollEdgeAppearance) {
        UINavigationBarAppearance *appearnace = [[UINavigationBarAppearance alloc] init];
        [appearnace configureWithOpaqueBackground];
        navigationBar.scrollEdgeAppearance = appearnace;
    }
    return navigationBar.scrollEdgeAppearance;
}

@implementation UIViewController (YHNavigation)

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
        
        hookBlock(@selector(viewWillAppear:), @selector(yh_viewWillAppear:));
    });
}

-(void)yh_viewWillAppear:(BOOL)animated{
    [self yh_viewWillAppear:animated];
    if (self.navigationController) {
        if (self.yh_prefersNavigationBarType != YHViewControllerNavigationBarTypeNone) {
            [self.navigationController setNavigationBarHidden:self.yh_prefersNavigationBarType == YHViewControllerNavigationBarTypeHidden animated:YES];
        }
        UIColor *backgroundColor = self.yh_navBackgroundColor ? self.yh_navBackgroundColor : self.navigationController.yh_navBackgroundColor;
        [self setNavigationBarBackgroundColor:backgroundColor];
        NSDictionary<NSAttributedStringKey,id> *titleTextAttributes = self.yh_titleTextAttributes ? self.yh_titleTextAttributes : self.navigationController.yh_titleTextAttributes;
        [self setNavigationBarTitleTextAttributes:titleTextAttributes];
        UIImage *backgroundImage = self.yh_backgroundImage ? self.yh_backgroundImage : self.navigationController.yh_backgroundImage;
        [self setNavigationBarBackgroundImage:backgroundImage];
        UIColor *shadowColor = self.yh_shadowColor ? self.yh_shadowColor : self.navigationController.yh_shadowColor;
        [self setNavigationBarShadowColor:shadowColor];
    }
}

-(void)setNavigationBarBackgroundColor: (UIColor*)color{
    if (color) {
        if (@available(iOS 13.0, *)) {
            getStandardAppearanceBlock(self.navigationController.navigationBar).backgroundColor = color;
            getScrollEdgeAppearanceBlock(self.navigationController.navigationBar).backgroundColor = color;
            
            if ([self isKindOfClass:[UINavigationController class]]) {
                getStandardAppearanceBlock(((UINavigationController*)self).navigationBar).backgroundColor = color;
                getScrollEdgeAppearanceBlock(((UINavigationController*)self).navigationBar).backgroundColor = color;
            }
        } else {
            // Fallback on earlier versions
            [self.navigationController.navigationBar setBarTintColor:color];
            if ([self isKindOfClass:[UINavigationController class]]) {
                [((UINavigationController*)self).navigationBar setBarTintColor:color];
            }
        }
    }
}

-(void)setNavigationBarBackgroundImage: (UIImage*)image{
    if (@available(iOS 13.0, *)) {
        getStandardAppearanceBlock(self.navigationController.navigationBar).backgroundImage = image;
        getScrollEdgeAppearanceBlock(self.navigationController.navigationBar).backgroundImage = image;
        
        if ([self isKindOfClass:[UINavigationController class]]) {
            getStandardAppearanceBlock(((UINavigationController*)self).navigationBar).backgroundImage = image;
            getScrollEdgeAppearanceBlock(((UINavigationController*)self).navigationBar).backgroundImage = image;
        }
    } else {
        // Fallback on earlier versions
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        if ([self isKindOfClass:[UINavigationController class]]) {
            [((UINavigationController*)self).navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        }
    }
}

-(void)setNavigationBarTitleTextAttributes: (NSDictionary<NSAttributedStringKey,id> *)titleTextAttributes{
    if (titleTextAttributes) {
        if (@available(iOS 13.0, *)) {
            getStandardAppearanceBlock(self.navigationController.navigationBar).titleTextAttributes = titleTextAttributes;
            getScrollEdgeAppearanceBlock(self.navigationController.navigationBar).titleTextAttributes = titleTextAttributes;
            if ([self isKindOfClass:[UINavigationController class]]) {
                getStandardAppearanceBlock(((UINavigationController*)self).navigationBar).titleTextAttributes = titleTextAttributes;
                getScrollEdgeAppearanceBlock(((UINavigationController*)self).navigationBar).titleTextAttributes = titleTextAttributes;
            }
        } else {
            // Fallback on earlier versions
            [self.navigationController.navigationBar setTitleTextAttributes:titleTextAttributes];
            if ([self isKindOfClass:[UINavigationController class]]) {
                [((UINavigationController*)self).navigationBar setTitleTextAttributes:titleTextAttributes];
            }
        }
    }
}

-(void)setNavigationBarShadowColor: (UIColor*)shadowColor{
    if (shadowColor) {
        if (@available(iOS 13.0, *)) {
            getStandardAppearanceBlock(self.navigationController.navigationBar).shadowColor = shadowColor;
            getScrollEdgeAppearanceBlock(self.navigationController.navigationBar).shadowColor = shadowColor;
            if ([self isKindOfClass:[UINavigationController class]]) {
                getStandardAppearanceBlock(((UINavigationController*)self).navigationBar).shadowColor = shadowColor;
                getScrollEdgeAppearanceBlock(((UINavigationController*)self).navigationBar).shadowColor = shadowColor;
            }
        } else {
            // Fallback on earlier versions
            UIImage *(^imageWithColorBlock)(UIColor* color) = ^(UIColor* color){
                CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
                UIGraphicsBeginImageContext(rect.size);
                CGContextRef context = UIGraphicsGetCurrentContext();

                CGContextSetFillColorWithColor(context, [color CGColor]);
                CGContextFillRect(context, rect);

                UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                return image;
            };
            
            [self.navigationController.navigationBar setShadowImage:imageWithColorBlock(shadowColor)];
            if ([self isKindOfClass:[UINavigationController class]]) {
                [((UINavigationController*)self).navigationBar setShadowImage:imageWithColorBlock(shadowColor)];
            }
        }
    }
}

-(YHViewControllerNavigationBarType)yh_prefersNavigationBarType{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

-(void)setYh_prefersNavigationBarType:(YHViewControllerNavigationBarType)yh_prefersNavigationBarType{
    objc_setAssociatedObject(self, @selector(yh_prefersNavigationBarType), @(yh_prefersNavigationBarType), OBJC_ASSOCIATION_ASSIGN);
    if (self.navigationController.topViewController == self && yh_prefersNavigationBarType != YHViewControllerNavigationBarTypeNone) {
        [self.navigationController setNavigationBarHidden:(yh_prefersNavigationBarType == YHViewControllerNavigationBarTypeHidden) animated:YES];
    }
}

- (YHViewControllerInteractivePopType)yh_interactivePopType{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

-(void)setYh_interactivePopType:(YHViewControllerInteractivePopType)type{
    objc_setAssociatedObject(self, @selector(yh_interactivePopType), @(type), OBJC_ASSOCIATION_ASSIGN);
}

-(UIColor *)yh_navBackgroundColor{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setYh_navBackgroundColor:(UIColor *)yh_navBackgroundColor{
    objc_setAssociatedObject(self, @selector(yh_navBackgroundColor), yh_navBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNavigationBarBackgroundColor:yh_navBackgroundColor];
}

-(NSDictionary<NSAttributedStringKey,id> *)yh_titleTextAttributes{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setYh_titleTextAttributes:(NSDictionary<NSAttributedStringKey,id> *)yh_titleTextAttributes{
    objc_setAssociatedObject(self, @selector(yh_titleTextAttributes), yh_titleTextAttributes, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setNavigationBarTitleTextAttributes:yh_titleTextAttributes];
}

-(UIImage *)yh_backgroundImage{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setYh_backgroundImage:(UIImage *)yh_backgroundImage{
    objc_setAssociatedObject(self, @selector(yh_backgroundImage), yh_backgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNavigationBarBackgroundImage:yh_backgroundImage];
}

-(UIColor *)yh_shadowColor{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setYh_shadowColor:(UIColor *)yh_shadowColor{
    objc_setAssociatedObject(self, @selector(yh_shadowColor), yh_shadowColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNavigationBarShadowColor:yh_shadowColor];
}

@end
