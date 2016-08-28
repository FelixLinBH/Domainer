//
//  TCPPing.m
//  Pods
//
//  Created by LBH on 2016/8/14.
//
//

#include <netinet/in.h>
#include <netinet/tcp.h>
#import <arpa/inet.h>
#import <netdb.h>
#import <netinet/in.h>
#import <sys/socket.h>
#import <unistd.h>

#import "TCPPing.h"

@implementation TCPPing

+ (instancetype)start:(NSString*)host
             complete:(TcpPingCompleteHandler)complete{
    TCPPing *ping = [[TCPPing alloc]init:host complete:complete count:CONNECT_TIMES port:TCP_PORT];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        [ping run];
    });
    return ping;
}

+ (instancetype)startWithIP:(NSString*)ip
             complete:(TcpPingCompleteHandler)complete{
    TCPPing *ping = [[TCPPing alloc]initIp:ip complete:complete count:CONNECT_TIMES port:TCP_PORT];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        [ping run];
    });
    return ping;
}

#pragma mark - Implementation
- (instancetype)init:(NSString *)host
            complete:(TcpPingCompleteHandler)complete
               count:(NSInteger)count
                port:(NSUInteger)port{
    if (self = [super init]) {
        _host = host;
        _complete = complete;
        _count = count;
        _port = port;
    }
    return self;
}

- (instancetype)initIp:(NSString *)ip
            complete:(TcpPingCompleteHandler)complete
               count:(NSInteger)count
                port:(NSUInteger)port{
    if (self = [super init]) {
        _ip = ip;
        _complete = complete;
        _count = count;
        _port = port;
    }
    return self;
}

- (int)connect:(struct sockaddr_in *)addr {
    int sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    if (sock == -1) {
        return errno;
    }
    int on = 1;
    setsockopt(sock, SOL_SOCKET, SO_NOSIGPIPE, &on, sizeof(on));
    setsockopt(sock, IPPROTO_TCP, TCP_NODELAY, (char *)&on, sizeof(on));
    
    struct timeval timeout;
    timeout.tv_sec = 10;
    timeout.tv_usec = 0;
    setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, (char *)&timeout, sizeof(timeout));
    setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&timeout, sizeof(timeout));
    
    if (connect(sock, (struct sockaddr *)addr, sizeof(struct sockaddr)) < 0) {
        int err = errno;
        close(sock);
        return err;
    }
    close(sock);
    return 0;
}

- (TcpPingResult *)buildResultIp:(NSString *)ip
                            code:(NSInteger)code
                        durations:(NSTimeInterval *)durations
                            count:(NSInteger)count {
    NSTimeInterval max = 0;
    NSTimeInterval min = 10000000;
    NSTimeInterval sum = 0;
    for (int i = 0; i < count; i++) {
        if (durations[i] > max) {
            max = durations[i];
        }
        if (durations[i] < min) {
            min = durations[i];
        }
        sum += durations[i];
    }
    
    NSTimeInterval avg = sum / count;
    avg = (isnan(avg))?FLT_MAX:avg;
    return [[TcpPingResult alloc]initWithIp:ip Code:code avgTime:avg];
}


- (void)run {
    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    if (!(_host || _ip) || !_port) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
            _complete([self buildResultIp:nil code:-3 durations:nil count:0]);
        });
        return;
    }
    if (_ip == nil) {
        addr.sin_len = sizeof(addr);
        addr.sin_family = AF_INET;
        addr.sin_port = htons(_port);
        addr.sin_addr.s_addr = inet_addr([_host UTF8String]);
        if (addr.sin_addr.s_addr == INADDR_NONE) {
            struct hostent *hostent = gethostbyname([_host UTF8String]);
            if (hostent == NULL || hostent->h_addr == NULL) {
                if (_complete != nil) {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
                        _complete([self buildResultIp:nil code:-1 durations:nil count:0]);
                    });
                }
                return;
            }
            addr.sin_addr = *(struct in_addr *)hostent->h_addr;
            
        }else{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
                _complete([self buildResultIp:nil code:-2 durations:nil count:0]);
                
            });
            return;
        }
    }else{
        addr.sin_addr = *(__bridge struct in_addr *)_ip;
    }
    
    NSTimeInterval *intervals = (NSTimeInterval *)malloc(sizeof(NSTimeInterval) * _count);
    int index = 0;
    int r = 0;
    do {
        NSDate *t1 = [NSDate date];
        r = [self connect:&addr];
        NSTimeInterval duration = [[NSDate date] timeIntervalSinceDate:t1];
        intervals[index] = duration * 1000;
        
        if (index < _count && r == 0) {
            [NSThread sleepForTimeInterval:0.1];
        }
    } while (++index < _count && r == 0);
    
    if (_complete) {
        NSInteger code = r;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
            _complete([self buildResultIp: [NSString stringWithUTF8String:inet_ntoa(addr.sin_addr)] code:code durations:intervals count:index]);
            
            
            free(intervals);
        });
    }


}
@end
