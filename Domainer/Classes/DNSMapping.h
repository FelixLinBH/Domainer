//
//  DNSMapping.h
//  Pods
//
//  Created by LBH on 2016/8/14.
//
//

#import <Foundation/Foundation.h>

@interface DNSMapping : NSObject

@property (nonatomic) NSString *host;
@property (nonatomic) NSString *ip;
@property (readonly) NSTimeInterval avgTime;
@property (nonatomic) NSInteger *code;
-(instancetype)initWithHost:(NSString *)host;
-(void)connect;
@end
