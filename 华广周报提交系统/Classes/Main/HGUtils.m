//
//  HGUtils.m
//  HGIOS
//
//  Created by 孙 华 on 2016/10/28.
//  Copyright © 2016年 hg. All rights reserved.
//

#import "HGUtils.h"
#import "HGBaseUtils.h"
#import "ThemeModel.h"
#import "ReplyModel.h"
#import "YYTextView.h"
@implementation HGUtils
+(void)loginHGWithloginName:(NSString *)name andPassword:(NSString *)pwd andCallback:(Callback)callback{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:name forKey:@"loginName"];
    [params setObject:pwd forKey:@"password"];
    [HGBaseUtils Post:URL_LoginPath andParams:params andCallback:^(id obj) {
        if(obj){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:0 error:nil];
            NSNumber *result = [dic objectForKey:@"result"];
            
            if ([result isEqualToNumber:@(0)]) {
                NSDictionary * dataDic = [dic objectForKey:@"data"];
                callback(dataDic);
            }else if ([result isEqualToNumber:@(1)]){
                callback(@"用户不存在");
            }else{
                callback(@"发生未知错误");
            }
        }else{
            callback(@"错误");
        }
    }];
    
}
+(void)sendWeeklyWithTitle:(NSString *)title andContent:(NSString *)content andLoginName:(NSString *)loginname andCallback:(Callback)callback{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:title forKey:@"title"];
    [params setObject:content forKey:@"content"];
    [params setObject:loginname forKey:@"createdBy"];
    [HGBaseUtils Post:URL_SendWeekly andParams:params andCallback:^(id obj) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:0 error:nil];
        NSNumber *result = [dic objectForKey:@"result"];
        if ([result isEqualToNumber:@(0)]) {
            callback(@"周报提交失败");
        }else if ([result isEqualToNumber:@(-1)]){
            callback(@"发生未知错误");
        }else{
            callback(@"周报提交成功");
        }
    }];
}
+(void)getThemeWithPage:(NSInteger)page andCallBack:(Callback)callback
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    NSNumber *pn = [NSNumber numberWithInteger:page];
    NSNumber *ps = [NSNumber numberWithInteger:10];
    [params setObject:pn forKey:@"pageNum"];
    [params setObject:ps forKey:@"pageSize"];
    [HGBaseUtils Post:URL_GetTheme andParams:params andCallback:^(id obj) {
        if(obj){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:0 error:nil];
          
            NSArray *dataArr = [dic objectForKey:@"data"];
            NSArray *themes = [ThemeModel arrayOfModelsFromDictionaries:dataArr error:nil];
            callback(themes);
        }
    }];
    
}
+(void)replyThemeWithThemeID:(NSString *)themeID andContent:(NSString *)content andCreatedBy:(NSString *)createdBy andCallback:(Callback)callback{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:themeID forKey:@"themeId"];
    [params setObject:content forKey:@"content"];
    [params setObject:createdBy forKey:@"createdBy"];
    [HGBaseUtils Post:URL_ReplyTheme andParams:params andCallback:^(id obj) {
        if (obj) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:0 error:nil];
            NSNumber *result = [dic objectForKey:@"result"];
            if ([result isEqualToNumber:@(0)]) {
                callback(@"回复失败!");
            }else if ([result isEqualToNumber:@(-1)]){
                callback(@"发生未知错误!");
            }else if ([result isEqualToNumber:@(-99)]){
                callback(@"主题ID为空!");
            }
            else{
                callback(@"回复成功!");
            }
        }else{
            callback(@"请检查网络连接");
        }
    }];
}
+(void)editThemeWithTitle:(NSString *)title andContent:(NSString *)content andThemeId:(NSString *)themeId andCallback:(Callback)callback{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:title forKey:@"title"];
    [params setObject:content forKey:@"content"];
    [params setObject:themeId forKey:@"themeId"];
    [HGBaseUtils Post:URL_EditTheme andParams:params andCallback:^(id obj) {
        if (obj) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:0 error:nil];
            NSNumber *result = [dic objectForKey:@"result"];
            if ([result isEqualToNumber:@(0)]) {
                callback(@"修改失败!");
            }else if ([result isEqualToNumber:@(-1)]){
                callback(@"发生未知错误!");
            }else if ([result isEqualToNumber:@(-99)]){
                callback(@"主题ID为空!");
            }
            else{
                callback(@"修改成功!");
            }

        }else{
            callback(@"请检查网络连接");
        }
    }];
}
+(void)editReplyWithContent:(NSString *)content andReportNoteId:(NSString *)reportNoteId andCallback:(Callback)callback{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:content forKey:@"content"];
    [params setObject:reportNoteId forKey:@"reportNoteId"];
    [HGBaseUtils Post:URL_EditReply andParams:params andCallback:^(id obj) {
        if (obj) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:0 error:nil];
            NSNumber *result = [dic objectForKey:@"result"];
            if ([result isEqualToNumber:@(0)]) {
                callback(@"修改失败!");
            }else if ([result isEqualToNumber:@(-1)]){
                callback(@"发生未知错误!");
            }else if ([result isEqualToNumber:@(-99)]){
                callback(@"回复ID为空!");
            }
            else{
                callback(@"修改成功!");
            }
            
        }else{
            callback(@"请检查网络连接");
        }
        
    }];
}
+(void)getThemeAndReplyWithThemeID:(NSString *)themeId andCallback:(Callback)callback{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:themeId forKey:@"themeId"];
    [HGBaseUtils Post:URL_SearchTheme andParams:params andCallback:^(id obj) {
        if (obj) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:0 error:nil];
            
            NSArray *dataArr = [dic objectForKey:@"data"];
            NSArray *replys = [ReplyModel arrayOfModelsFromDictionaries:dataArr error:nil];
            callback(replys);
        }
    }];
}
+(void)deleteThemeWithThemeId:(NSString *)themeId andCallback:(Callback)callback{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:themeId forKey:@"themeId"];
    [HGBaseUtils Post:URL_DeleteTheme andParams:params andCallback:^(id obj) {
        if (obj) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:0 error:nil];
            NSNumber *result = [dic objectForKey:@"result"];
            if ([result isEqualToNumber:@(0)]) {
                callback(@"删除失败!");
            }else if ([result isEqualToNumber:@(-1)]){
                callback(@"发生未知错误!");
            }else if ([result isEqualToNumber:@(-99)]){
                callback(@"主题ID为空!");
            }
            else{
                callback(@"删除成功!");
            }
            
        }else{
            callback(@"请检查网络连接");
        }
    }];
}
+(void)deleteWithReportNoteId:(NSString *)reportNoteId andCallback:(Callback)callback{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:reportNoteId forKey:@"reportNoteId"];
    [HGBaseUtils Post:URL_DeleteReply andParams:params andCallback:^(id obj) {
        if (obj) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:0 error:nil];
            NSNumber *result = [dic objectForKey:@"result"];
            if ([result isEqualToNumber:@(0)]) {
                callback(@"删除失败!");
            }else if ([result isEqualToNumber:@(-1)]){
                callback(@"发生未知错误!");
            }else if ([result isEqualToNumber:@(-99)]){
                callback(@"主题ID为空!");
            }
            else{
                callback(@"删除成功!");
            }
            
        }else{
            callback(@"请检查网络连接");
        }
    }];
}
+(NSString *)parseTimeWithTimeStap:(NSDate *)timestap{
    long createTime = [timestap timeIntervalSince1970];
    //获取当前时间对象
    NSDate *nowDate = [NSDate date];
    
    long nowTime = [nowDate timeIntervalSince1970];
    long time = nowTime-createTime/1000;
    NSDate *created = [NSDate dateWithTimeIntervalSince1970:createTime/1000];
    if (time<60) {
        return @"刚刚";
    }else if (time<3600){
        return [NSString stringWithFormat:@"%ld分钟前",time/60];
    }else if (time<3600*24){
        return [NSString stringWithFormat:@"%ld小时前",time/3600];
    }else{
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"MM - dd HH:mm";
        return [fmt stringFromDate:created];
    }
    
}

+(float)contentHeight:(NSString *)text{
    float contentHeight = 0.0;
    YYTextView *tv = [[YYTextView alloc]initWithFrame:CGRectMake(8, 0, YSW-2*16, 0)];
    tv.font = [UIFont systemFontOfSize:16];
    if (text.length>0) {
        tv.text = text;
        contentHeight += tv.textLayout.textBoundingSize.height;
    }
    return contentHeight;
}
@end
