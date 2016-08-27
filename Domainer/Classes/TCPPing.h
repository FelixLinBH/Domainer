//
//  TCPPing.h
//  Pods
//
//  Created by LBH on 2016/8/14.
//
//

#import <Foundation/Foundation.h>
#import "TcpPingResult.h"
#define CONNECT_TIMES 3
#define TCP_PORT 80

typedef void (^TcpPingCompleteHandler)(TcpPingResult*);

@interface TCPPing : NSObject

@property (nonatomic) NSString *host;
@property (nonatomic) NSInteger count;
@property (nonatomic) NSInteger port;

@property (readonly) TcpPingCompleteHandler complete;

+ (instancetype)start:(NSString*)host
             complete:(TcpPingCompleteHandler)complete;

@end
