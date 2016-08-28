//
//  DNSMapping.h
//  Pods
//
//  Created by LBH on 2016/8/14.
//
//

#import <Foundation/Foundation.h>

@interface DNSMapping : NSObject<NSCoding>

typedef void (^DNSCompleteHandler)(void);

@property (nonatomic) NSString *host;
@property (nonatomic) NSString *ip;
@property (nonatomic) NSTimeInterval avgTime;
@property (nonatomic) NSInteger code;
-(instancetype)initWithHost:(NSString *)host;
-(void)connectHostWithComplete:(DNSCompleteHandler)complete;
-(void)connectIPWithComplete:(DNSCompleteHandler)complete;
@end
