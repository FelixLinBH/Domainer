//
//  Domainer.m
//  Pods
//
//  Created by LBH on 2016/8/14.
//
//

#import "Domainer.h"
#import "NSURLRequest+Domainer.h"

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

+ (void)runWithCompleteHandler:(void (^)(BOOL sucess, NSArray *noResolvedDomain))completeHandler{
    [[self sharedInstance]runWithCompleteHandler:completeHandler];
}

+ (NSDictionary *)getMappingTable{
    return [[self sharedInstance]mappingTable];
}

#pragma mark - Implementation
- (instancetype)init{
    self = [super init];
    if (self) {
        _domainArray = [[NSMutableArray alloc]init];
        _mappingTable = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)setMapper:(NSArray *)mappingArray{
    for (NSDictionary *item in mappingArray) {
        DomainMapping *mapping = [[DomainMapping alloc]initWithDomainMapping:item];
        [_domainArray addObject:mapping];
    }
}

- (void)runWithCompleteHandler:(void (^)(BOOL sucess, NSArray *noResolvedDomain))completeHandler{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSMutableArray *noResolvedDomain = [[NSMutableArray alloc]init];
        dispatch_group_t mappingGroup = dispatch_group_create();
        for (DomainMapping *item in _domainArray) {
            dispatch_group_enter(mappingGroup);
            [item findBestDomainWithCompleteHandler:^(BOOL sucess,DNSMapping* dnsMapping) {
                if (!sucess) {
                    [noResolvedDomain addObject:item];
                }else{
                    [_mappingTable setObject:dnsMapping.ip forKey:item.domainName];
                }
                
                dispatch_group_leave(mappingGroup);
            }];
        }
        dispatch_group_wait(mappingGroup, DISPATCH_TIME_FOREVER);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeHandler) {
                if ([noResolvedDomain count]) {
                    completeHandler(NO,noResolvedDomain);
                }else{
                    
                    completeHandler(YES,nil);
                }
            }
        });
    });
}




@end
