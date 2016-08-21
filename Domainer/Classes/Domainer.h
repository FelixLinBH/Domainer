//
//  Domainer.h
//  Pods
//
//  Created by LBH on 2016/8/14.
//
//

#import <Foundation/Foundation.h>
#import "DomainMapping.h"
@interface Domainer : NSObject
@property (nonatomic) NSArray *domainSet;
+ (Domainer *)sharedInstance;
+ (void)setMapper:(NSDictionary *)dictionary;
@end
