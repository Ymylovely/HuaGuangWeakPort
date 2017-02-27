//
//  ThemeDetailViewController.h
//  华广周报提交系统
//
//  Created by 孙 华 on 2016/11/4.
//  Copyright © 2016年 hg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeModel.h"
@interface ThemeDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *replyTF;
@property (nonatomic,strong)ThemeModel *theme;
@end
