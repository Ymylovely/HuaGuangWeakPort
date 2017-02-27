//
//  EditViewController.m
//  华广周报提交系统
//
//  Created by 孙 华 on 2016/11/11.
//  Copyright © 2016年 hg. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentTF;
@property (weak, nonatomic) IBOutlet UITextField *titleTV;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@end

@implementation EditViewController
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)cancelClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)finishedClicked:(UIButton *)sender {
    if (self.reply.createdBy) {
        if (self.contentTF.text>0){
            [HGUtils editReplyWithContent:self.contentTF.text andReportNoteId:self.reply.reportNoteId andCallback:^(id callback) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:callback preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *back = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                }];
                [alert addAction:back];
                [alert addAction:confirm];
                [self presentViewController:alert animated:YES completion:nil];
            }];
        }else{
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"内容不能为空！" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            }];
            [alert1 addAction:confirm];
            [self presentViewController:alert1 animated:YES completion:nil];
        }
    }else{
    if (self.titleTV.text.length>0&&self.contentTF.text>0) {
        [HGUtils editThemeWithTitle:self.titleTV.text andContent:self.contentTF.text andThemeId:self.theme.themeId andCallback:^(id callback) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:callback preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *back = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            }];
            [alert addAction:back];
            [alert addAction:confirm];
            [self presentViewController:alert animated:YES completion:nil];
            
        }];
    }else{
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"请仔细填写！" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        }];
        [alert1 addAction:confirm];
        [self presentViewController:alert1 animated:YES completion:nil];
    }
}
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.reply.createdBy){
        self.titleTV.hidden = YES;
    }
    self.cancelBtn.layer.cornerRadius = self.finishBtn.layer.cornerRadius = 15;
    self.cancelBtn.layer.masksToBounds = self.finishBtn.layer.masksToBounds = self.contentTF.layer.masksToBounds = YES;
    self.contentTF.layer.borderWidth = 2;
    self.contentTF.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
