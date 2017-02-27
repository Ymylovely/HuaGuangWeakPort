//
//  HGUtils.h
//  HGIOS
//
//  Created by 孙 华 on 2016/10/28.
//  Copyright © 2016年 hg. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^block1)(id back);
typedef void (^Callback)(id callback);
@interface HGUtils : NSObject
+(void)callback:(block1)back;
+(void)loginHGWithloginName:(NSString *)name andPassword:(NSString *)pwd andCallback:(Callback)callback;
+(void)sendWeeklyWithTitle:(NSString *)title andContent:(NSString *)content andLoginName:(NSString *)loginname andCallback:(Callback)callback;
+(void)getThemeWithPage:(NSInteger)page andCallBack:(Callback)callback;
+(void)replyThemeWithThemeID:(NSString *)themeID andContent:(NSString *)content andCreatedBy:(NSString *)createdBy andCallback:(Callback)callback;
+(void)getThemeAndReplyWithThemeID:(NSString *)themeId andCallback:(Callback)callback;
+(void)editThemeWithTitle:(NSString *)title andContent:(NSString *)content andThemeId:(NSString *)themeId andCallback:(Callback)callback;
+(void)editReplyWithContent:(NSString *)content andReportNoteId:(NSString *)reportNoteId andCallback:(Callback)callback;
+(void)deleteThemeWithThemeId:(NSString *)themeId andCallback:(Callback)callback;
+(void)deleteWithReportNoteId:(NSString *)reportNoteId andCallback:(Callback)callback;
+(NSString *)parseTimeWithTimeStap:(NSDate *)timestap;
+(float)contentHeight:(NSString *)text;
@end
