//
//  DomainMapping.h
//  Pods
//
//  Created by LBH on 2016/8/21.
//
//

#import <Foundation/Foundation.h>

@interface DomainMapping : NSObject
@property (nonatomic) NSString *domainName;
@property (nonatomic, readonly) NSArray *dnsMappingArray;
-(instancetype)initWithDomainMapping:(NSDictionary *)dictionary;
@end
