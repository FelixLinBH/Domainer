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
@property (copy, nonatomic) NSMutableArray *domainArray;

+ (Domainer *)sharedInstance;
+ (void)setMapper:(NSArray *)mappingArray;
+ (void)runWithCompleteHandler:(void (^)(BOOL sucess, NSArray *noResolvedDomain))completeHandler;

@end
