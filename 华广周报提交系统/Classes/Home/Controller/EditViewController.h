//
//  EditViewController.h
//  华广周报提交系统
//
//  Created by 孙 华 on 2016/11/11.
//  Copyright © 2016年 hg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeModel.h"
#import "ReplyModel.h"
@interface EditViewController : UIViewController
@property (nonatomic,strong) ThemeModel *theme;
@property (nonatomic,strong) ReplyModel *reply;
@end
