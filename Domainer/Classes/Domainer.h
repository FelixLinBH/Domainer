//
//  Domainer.h
//  Pods
//
//  Created by LBH on 2016/8/14.
//
//

#import <Foundation/Foundation.h>
#import "DomainMapping.h"
typedef void (^completeHandler)(BOOL sucess, NSError *error);

@interface Domainer : NSObject
@property (copy, nonatomic) completeHandler completeHandler;
@property (nonatomic, strong) NSOperationQueue *queue;

+ (Domainer *)sharedInstance;
+ (void)setMapper:(NSArray *)mappingArray;
+ (void)setCompleteHandler:(void (^)(BOOL sucess, NSError *error))completeHandler;
+ (void)start;

@end
