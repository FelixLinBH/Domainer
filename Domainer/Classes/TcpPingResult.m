//
//  TcpPingResult.m
//  Pods
//
//  Created by LBH on 2016/8/19.
//
//
#import "TcpPingResult.h"

@implementation TcpPingResult
-(instancetype)initWithCode:(NSInteger)code avgTime:(NSTimeInterval)avgTime{
    self = [super init];
    if (self) {
        _code = code;
        _avgTime = avgTime;
    }
    return self;
}
@end
