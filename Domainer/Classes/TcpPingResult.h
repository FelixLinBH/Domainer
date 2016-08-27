//
//  TcpPingResult.h
//  Pods
//
//  Created by LBH on 2016/8/19.
//
//

#import <Foundation/Foundation.h>

@interface TcpPingResult : NSObject
@property NSInteger code;
@property NSTimeInterval avgTime;
@property NSString *ip;
-(instancetype)initWithIp:(NSString *)ip Code:(NSInteger)code avgTime:(NSTimeInterval)avgTime;
@end
