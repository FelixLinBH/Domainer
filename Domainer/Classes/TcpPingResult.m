//
//  TcpPingResult.m
//  Pods
//
//  Created by LBH on 2016/8/19.
//
//
#import "TcpPingResult.h"

@implementation TcpPingResult
-(instancetype)initWithIp:(NSString *)ip Code:(NSInteger)code avgTime:(NSTimeInterval)avgTime{
    self = [super init];
    if (self) {
        _ip = ip;
        _code = code;
        _avgTime = avgTime;
    }
    return self;
}
@end
