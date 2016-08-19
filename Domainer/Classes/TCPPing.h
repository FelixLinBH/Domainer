//
//  TCPPing.h
//  Pods
//
//  Created by LBH on 2016/8/14.
//
//

#import <Foundation/Foundation.h>
#import "TcpPingResult.h"

typedef void (^TcpPingCompleteHandler)(TcpPingResult*);

@interface TCPPing : NSObject
@property (nonatomic) NSInteger count;
@property (readonly) TcpPingCompleteHandler complete;
@end
