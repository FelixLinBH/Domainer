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

+ (void)setMapper:(NSDictionary *)dictionary{
    [[self sharedInstance]setDomainMapping:dictionary];
}

#pragma mark - Implementation
- (void)setDomainMapping:(NSDictionary *)dictionary{
    
    _domainSet = [[NSArray alloc]initWithArray:nil];
//    _mapper = [[DomainMapping alloc]initWithDomainMapping:dictionary];
}


@end
