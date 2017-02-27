//
//  ThemeModel.h
//  华广周报提交系统
//
//  Created by 孙 华 on 2016/11/3.
//  Copyright © 2016年 hg. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ThemeModel : JSONModel
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString  <Optional>*headPhoto;
@property (nonatomic,copy)NSDate *createdDate;
@property (nonatomic,copy)NSString *loginName;
@property (nonatomic,copy)NSString *themeId;
@property (nonatomic,copy)NSString *createdBy;

@end
