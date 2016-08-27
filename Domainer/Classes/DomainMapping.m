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

-(void)run{
    for (DNSMapping *item in _dnsMappingMutableArray) {
        [item connectHostWithComplete:^(DNSMapping *dnsMapping) {
            
        }];
    }
}
@end
