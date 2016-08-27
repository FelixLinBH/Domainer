//
//  DNSMapping.m
//  Pods
//
//  Created by LBH on 2016/8/14.
//
//

#import "DNSMapping.h"
#import "TCPPing.h"

@implementation DNSMapping

-(instancetype)initWithHost:(NSString *)host{
    self = [super init];
    if (self) {
        _host = host;
    }
    return self;
}


-(void)connectHostWithComplete:(DNSCompleteHandler)complete{
    [TCPPing start:_host complete:^(TcpPingResult *r) {
        _avgTime = r.avgTime;
        _code = r.code;
        _ip = r.ip;
        if (complete) {
            complete();
        }
    }];
}
@end
