//
//  Domainer.m
//  Pods
//
//  Created by LBH on 2016/8/14.
//
//

#import "Domainer.h"


@implementation Domainer

+ (Domainer *)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

+ (void)setMapper:(NSArray *)mappingArray{
    [[self sharedInstance]setMapper:mappingArray];
}

+ (void)setCompleteHandler:(void (^)(BOOL sucess, NSError *error))completeHandler{
    [[self sharedInstance]setCompleteHandler:completeHandler];
}

+ (void)start{
    [[self sharedInstance]run];
}

#pragma mark - Implementation
- (instancetype)init{
    self = [super init];
    if (self) {
        _queue = [[NSOperationQueue alloc]init];
        _queue.maxConcurrentOperationCount = 2;
    }
    return self;
}

- (void)setMapper:(NSArray *)mappingArray{
    for (NSDictionary *item in mappingArray) {
        DomainMapping *mapping = [[DomainMapping alloc]initWithDomainMapping:item];
        [_queue addOperation:mapping];
    }
    
}

- (void)run{
    
    if (_completeHandler) {
        
    }
}


@end
