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

- (struct sockaddr_in)getAddressWithHost:(NSString *)host{
    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    addr.sin_len = sizeof(addr);
    addr.sin_family = AF_INET;
    addr.sin_port = htons(80);
    addr.sin_addr.s_addr = inet_addr([host UTF8String]);
    if (addr.sin_addr.s_addr == INADDR_NONE) {
        struct hostent *hostent = gethostbyname([host UTF8String]);
        if (hostent == NULL || hostent->h_addr == NULL) {
            NSLog(@"DNS Failed");
        }
        addr.sin_addr = *(struct in_addr *)hostent->h_addr;
        return addr;
    }else{
        NSLog(@"INADDR_NONE");
    }
}

- (void)connectIPAdressWith:(struct sockaddr_in)addr{
    
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
    

}

- (void)runWithHost:(NSString *)host{
    struct sockaddr_in address = [self getAddressWithHost:host];
    
    [self connectIPAdressWith:address];
    
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

- (TcpPingResult *)buildResult:(NSInteger)code
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
    return [[TcpPingResult alloc]initWithCode:code avgTime:avg];
}


- (void)run {
    
}
@end
