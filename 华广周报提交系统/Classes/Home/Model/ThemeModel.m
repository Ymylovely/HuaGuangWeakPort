//
//  ThemeModel.m
//  华广周报提交系统
//
//  Created by 孙 华 on 2016/11/3.
//  Copyright © 2016年 hg. All rights reserved.
//

#import "ThemeModel.h"

@implementation ThemeModel
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.headPhoto forKey:@"headPhoto"];
    [aCoder encodeObject:self.createdDate forKey:@"createdDate"];
    [aCoder encodeObject:self.createdBy forKey:@"createdBy"];
    [aCoder encodeObject:self.themeId forKey:@"themeId"];
    [aCoder encodeObject:self.loginName forKey:@"loginName"];
}
-(nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.headPhoto = [aDecoder decodeObjectForKey:@"headPhoto"];
        self.createdDate = [aDecoder decodeObjectForKey:@"createdDate"];
        self.createdBy = [aDecoder decodeObjectForKey:@"createdBy"];
        self.themeId = [aDecoder decodeObjectForKey:@"themeId"];
        self.loginName = [aDecoder decodeObjectForKey:@"loginName"];
    }
    return self;
}
@end
