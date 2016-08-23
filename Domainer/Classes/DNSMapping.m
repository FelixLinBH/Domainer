//
//  DNSMapping.m
//  Pods
//
//  Created by LBH on 2016/8/14.
//
//

#import "DNSMapping.h"

@implementation DNSMapping

-(instancetype)initWithHost:(NSString *)host{
    self = [super init];
    if (self) {
        _host = host;
    }
    return self;
}
@end
