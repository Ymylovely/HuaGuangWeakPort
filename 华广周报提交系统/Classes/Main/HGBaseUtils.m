//
//  HGBaseUtils.m
//  HGIOS
//
//  Created by 孙 华 on 2016/10/28.
//  Copyright © 2016年 hg. All rights reserved.
//

#import "HGBaseUtils.h"

@implementation HGBaseUtils
+(void)Get:(NSString *)path andParams:(NSDictionary *)dic andCallback:(HGCallback)callback{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(nil);
    }];
   
}
+(void)Post:(NSString *)path andParams:(NSDictionary *)dic andCallback:(HGCallback)callback{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:path parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *s = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",s);
        callback(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        callback(nil);
    }];
    
}
@end
