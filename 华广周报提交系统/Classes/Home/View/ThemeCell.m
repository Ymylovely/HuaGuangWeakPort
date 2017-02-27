//
//  ThemeCell.m
//  华广周报提交系统
//
//  Created by 孙 华 on 2016/11/3.
//  Copyright © 2016年 hg. All rights reserved.
//

#import "ThemeCell.h"
#import "HGUtils.h"
@implementation ThemeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headIV.layer.cornerRadius = 15;
    self.headIV.layer.masksToBounds = YES;
    self.backView.backgroundColor = kRGBA(242, 242, 242, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setTheme:(ThemeModel *)theme{
    _theme = theme;
    self.titleLabel.text = theme.title;
    self.contentLabel.text = theme.content;
    self.username.text =[NSString stringWithFormat:@"发布人:%@",theme.createdBy] ;
    NSString *imageUrl = [NSString stringWithFormat:@"http://www.huaguangsoft.com%@",theme.headPhoto];
    self.timeLabel.text = [HGUtils parseTimeWithTimeStap:theme.createdDate];
    [self.headIV sd_setImageWithURL:[NSURL URLWithString: imageUrl] placeholderImage:[UIImage imageNamed:@"images"]];
}

@end
