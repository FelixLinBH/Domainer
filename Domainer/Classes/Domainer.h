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
+ (Domainer *)sharedInstance;
+ (void)setMapper:(NSArray *)mappingArray;
@end
