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
@property (nonatomic) NSInteger weight;

@property (readonly) NSTimeInterval maxTime;
@property (readonly) NSTimeInterval minTime;
@property (readonly) NSTimeInterval avgTime;
@property (readonly) NSInteger count;

@end
