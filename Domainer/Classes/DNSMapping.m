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
        _avgTime = (NSInteger)r.avgTime;
        _code = (NSInteger)r.code;
        _ip = r.ip;
        if (complete) {
            complete();
        }
    }];
}

-(void)connectIPWithComplete:(DNSCompleteHandler)complete{
   [TCPPing startWithIP:_ip complete:^(TcpPingResult *r) {
       _avgTime = (NSInteger)r.avgTime;
       _code = (NSInteger)r.code;
       if (complete) {
           complete();
       }
   }];
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc.
    [encoder encodeDouble:(NSInteger)_avgTime forKey:@"avgTime"];
    [encoder encodeInteger:(NSInteger)_code forKey:@"code"];
    [encoder encodeObject:_ip forKey:@"ip"];
    [encoder encodeObject:_host forKey:@"host"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        _avgTime = [decoder decodeDoubleForKey:@"avgTime"];
        _code = [decoder decodeIntegerForKey:@"code"];
        _ip = [decoder decodeObjectForKey:@"ip"];
        _host = [decoder decodeObjectForKey:@"host"];
    }
    return self;
}

@end
