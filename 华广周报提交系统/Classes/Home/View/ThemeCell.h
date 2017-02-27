//
//  ThemeCell.h
//  华广周报提交系统
//
//  Created by 孙 华 on 2016/11/3.
//  Copyright © 2016年 hg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeCell.h"
#import "ThemeModel.h"
@interface ThemeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic,strong)ThemeModel *theme;
@end
