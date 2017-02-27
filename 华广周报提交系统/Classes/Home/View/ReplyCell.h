//
//  ReplyCell.h
//  华广周报提交系统
//
//  Created by 孙 华 on 2016/11/10.
//  Copyright © 2016年 hg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYTextView.h"
#import "ThemeModel.h"
#import "ReplyModel.h"
@protocol ReplyCellDelegate <NSObject>
-(void)choseReplyBtn:(UIButton *)button;
@end
@protocol ReplyCellDeleteDelegate <NSObject>
-(void)choseDeleteBtn:(UIButton *)button;
@end
@interface ReplyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *louzhuLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtb;
@property (nonatomic,strong)YYTextView *contentTV;
@property (nonatomic)float contentHeight;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;
@property (nonatomic,strong)ThemeModel *theme;
@property (nonatomic,strong)ReplyModel *reply;
- (IBAction)deleteAction:(UIButton *)sender;
@property (nonatomic,assign) id<ReplyCellDeleteDelegate>deleteDelegate;
@property (weak, nonatomic) IBOutlet UILabel *loucengLabel;
@property (nonatomic,assign) id<ReplyCellDelegate>delegate;
- (IBAction)checkAction:(UIButton *)sender;
@end
