//
//  ReplyCell.m
//  华广周报提交系统
//
//  Created by 孙 华 on 2016/11/10.
//  Copyright © 2016年 hg. All rights reserved.
//

#import "ReplyCell.h"
#import "HGUtils.h"
#import "UIViewExt.h"
#import "ThemeDetailViewController.h"
#import "MainTabBarController.h"
#import "EditViewController.h"
#import "MainNavigationController.h"
@implementation ReplyCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
}
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.headIV.layer.cornerRadius = 15;
    self.headIV.layer.masksToBounds = YES;
    self.replyCount.layer.cornerRadius = 9;
    self.replyCount.layer.masksToBounds = YES;
    self.contentTV = [[YYTextView alloc]initWithFrame:CGRectMake(8, 40, YSW-2*8, 0)];
    self.contentTV.userInteractionEnabled = NO;
    self.contentTV.font = [UIFont systemFontOfSize:14];
    self.contentTV.textAlignment = NSTextAlignmentLeft;
    self.contentTV.editable = NO;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    self.contentTV.attributedText = [[NSAttributedString alloc] initWithString:@"abcdef" attributes:attributes];
    
    [self.contentView addSubview:self.contentTV];
}
- (IBAction)deleteBtn:(UIButton *)sender {
    
}
-(void)setTheme:(ThemeModel *)theme{
    _theme = theme;
    self.nameLabel.text = theme.loginName;
    self.contentTV.text = theme.content;
    self.contentHeight = [HGUtils contentHeight:theme.content]+80;
    self.contentTV.textColor = kRGBA(147, 147, 147, 1);
    if (theme.content.length>0) {
        self.contentTV.height = self.contentTV.textLayout.textBoundingSize.height;
    }else{
        self.contentTV.height = 0;
    }
    NSString *imageUrl = [NSString stringWithFormat:@"http://www.huaguangsoft.com%@",theme.headPhoto];
    self.timeLabel.text = [HGUtils parseTimeWithTimeStap:theme.createdDate];
    [self.headIV sd_setImageWithURL:[NSURL URLWithString: imageUrl] placeholderImage:[UIImage imageNamed:@"images"]];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *username = [ud objectForKey:@"loginName"];
    if ([theme.loginName isEqualToString:username]) {
        self.deleteBtn.hidden = NO;
        self.editBtb.hidden = NO;
    }
    self.replyBtn.hidden = NO;
}
-(void)deleteAction:(UIButton *)sender{
    ThemeDetailViewController *tvc = [[ThemeDetailViewController alloc]init];
    MainTabBarController * tab = (MainTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    MainNavigationController *navi = [[MainNavigationController alloc]initWithRootViewController:tvc];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定删除？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if (self.theme.themeId) {
            [HGUtils deleteThemeWithThemeId:self.theme.themeId andCallback:^(id callback) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:callback preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    if ([_deleteDelegate respondsToSelector:@selector(choseDeleteBtn:)]){
                        sender.tag = self.tag;
                        [_deleteDelegate choseDeleteBtn:sender];
                        
                    }
                }];
                [alert addAction:confirm];
                [tab presentViewController:alert animated:YES completion:nil];
                
                
            }];
        }else{
            [HGUtils deleteWithReportNoteId:self.reply.reportNoteId andCallback:^(id callback) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:callback preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    
                }];
                [alert addAction:confirm];
                [tab presentViewController:alert animated:YES completion:nil];
            }];
        }
        
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [alert addAction:confirm];
    [tab presentViewController:alert animated:YES completion:nil];

    
}
-(void)checkAction:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(choseReplyBtn:)]) {
        sender.tag = self.tag;
        [_delegate choseReplyBtn:sender];
    }
}
- (IBAction)replyBtn:(UIButton *)sender {

    
}
-(void)setReply:(ReplyModel *)reply{
    _reply = reply;
    self.nameLabel.text = reply.loginName;
    self.contentTV.text = reply.content;
    self.contentHeight = [HGUtils contentHeight:reply.content]+80;
    self.contentTV.textColor = kRGBA(147, 147, 147, 1);
    if (reply.content.length>0) {
        self.contentTV.height = self.contentTV.textLayout.textBoundingSize.height;
    }else{
        self.contentTV.height = 0;
    }
    NSString *imageUrl = [NSString stringWithFormat:@"http://www.huaguangsoft.com%@",reply.headPhoto];
    self.timeLabel.text = [HGUtils parseTimeWithTimeStap:reply.createdDate];
    [self.headIV sd_setImageWithURL:[NSURL URLWithString: imageUrl] placeholderImage:[UIImage imageNamed:@"images"]];
    self.louzhuLabel.hidden = YES;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *username = [ud objectForKey:@"loginName"];
    if ([reply.loginName isEqualToString:username]) {
        self.deleteBtn.hidden = NO;
        self.editBtb.hidden = NO;
    }
}
- (IBAction)editBtnClicked:(UIButton *)sender {
    EditViewController *vc = [EditViewController new];
    vc.theme = self.theme;
    vc.reply = self.reply;
    ThemeDetailViewController *tvc =(ThemeDetailViewController *) [UIApplication sharedApplication].keyWindow.rootViewController;
    [tvc presentViewController:vc animated:YES completion:nil];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
