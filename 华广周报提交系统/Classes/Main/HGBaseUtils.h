//
//  HGBaseUtils.h
//  HGIOS
//
//  Created by 孙 华 on 2016/10/28.
//  Copyright © 2016年 hg. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^HGCallback)(id obj);
@interface HGBaseUtils : NSObject
+(void)Get:(NSString *)path andParams:(NSDictionary *)dic andCallback:(HGCallback)callback;
+(void)Post:(NSString *)path andParams:(NSDictionary *)dic andCallback:(HGCallback)callback;
@end
