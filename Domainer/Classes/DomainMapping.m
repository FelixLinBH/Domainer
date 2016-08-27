//
//  DomainMapping.m
//  Pods
//
//  Created by LBH on 2016/8/21.
//
//

#import "DomainMapping.h"
#import "DNSMapping.h"

/*
 {
    "mainDomainName":"www.mainDomain.com",
    "mapping":[
        "www.domain1.com",
        "www.domain2.com"
    ]
 }
*/

@implementation DomainMapping
-(instancetype)initWithDomainMapping:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _domainName = dictionary[@"mainDomainName"];
        _dnsMappingMutableArray = [NSMutableArray new];
        for (NSString *domainString in dictionary[@"mapping"]) {
            DNSMapping *dnsMapping = [[DNSMapping alloc]initWithHost:domainString];
            [_dnsMappingMutableArray addObject:dnsMapping];
        }

    }
    return self;
}

-(void)findBestDomainWithCompleteHandler:(completeHandler)complete{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        dispatch_group_t dnsTcpPingGroup = dispatch_group_create();
        
        for (DNSMapping *item in _dnsMappingMutableArray) {
            dispatch_group_enter(dnsTcpPingGroup);
            [item connectHostWithComplete:^(void) {
                dispatch_group_leave(dnsTcpPingGroup);
            }];
        }
        
        dispatch_group_wait(dnsTcpPingGroup, DISPATCH_TIME_FOREVER);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 6
            
            if (complete) { // 7
                NSSortDescriptor * descriptor = [[NSSortDescriptor alloc] initWithKey:@"avgTime" ascending:YES];
                _dnsMappingMutableArray = [_dnsMappingMutableArray sortedArrayUsingDescriptors:@[descriptor]];
                DNSMapping *bestDomain = _dnsMappingMutableArray.firstObject;
                if (!isnan(bestDomain.avgTime)) {
                    //found best domain
                     NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:bestDomain];
                    
                    [[NSUserDefaults standardUserDefaults]setObject:encodedObject forKey:_domainName];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    //save NSUserDefaults
                    //swizzle NSURLRequest
                    complete(YES);
                }else{
                    complete(NO);
                }
                
            }
        });
    });
}

@end
