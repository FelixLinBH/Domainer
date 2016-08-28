//
//  NSURLRequest+Domainer.m
//  Pods
//
//  Created by LBH on 2016/8/28.
//
//

#import "NSURLRequest+Domainer.h"
#import "Domainer.h"
#import <objc/runtime.h>

@implementation NSURLRequest (Domainer)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(initWithURL:);
        SEL swizzledSelector = @selector(domainer_initWithURL:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling

- (instancetype)domainer_initWithURL:(NSURL *)URL{
    
    if ([[Domainer getMappingTable]objectForKey:[URL host]]) {
        NSString *newUrlString = [[URL absoluteString]stringByReplacingOccurrencesOfString:[URL host] withString:[[Domainer getMappingTable]objectForKey:[URL host]]];
        URL = [NSURL URLWithString:newUrlString];
    }
    return [self domainer_initWithURL:URL];

}

@end
