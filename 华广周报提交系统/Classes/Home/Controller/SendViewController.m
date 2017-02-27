//
//  SendViewController.m
//  华广周报提交系统
//
//  Created by 孙 华 on 2016/11/2.
//  Copyright © 2016年 hg. All rights reserved.
//

#import "SendViewController.h"
#import "HGUtils.h"
@interface SendViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UITextView *detailTV;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation SendViewController
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
- (IBAction)cancelClicked:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)sendClicked:(id)sender {
    [self.view endEditing:YES];
    if (self.titleTF.text.length>0&&self.detailTV.text.length>0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *loginName = [ud objectForKey:@"loginName"];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.label.text = @"正在发送...";
        [HGUtils sendWeeklyWithTitle:self.titleTF.text andContent:self.detailTV.text andLoginName:loginName andCallback:^(id callback) {
            [hud hideAnimated:YES];
            if([callback isKindOfClass:[NSString class]]){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:callback message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                }];
                [alert addAction:confirm];
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        }];

    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题和详情均不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self.titleTF becomeFirstResponder];
        }];
        [alert addAction:confirm];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交周报";
    [self.titleTF becomeFirstResponder];
    self.sendBtn.layer.cornerRadius = self.cancelBtn.layer.cornerRadius = 15;
    self.sendBtn.layer.masksToBounds = self.sendBtn.layer.masksToBounds = YES;
    self.titleTF.delegate = self;
    self.detailTV.delegate = self;
    self.detailTV.layer.borderWidth = 2;
    self.detailTV.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.detailTV.layer.masksToBounds = YES;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"清空" style:UIBarButtonItemStyleDone target:self action:@selector(deleteDetail)];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}
-(void)deleteDetail{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"清空文本？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.titleTF.text = @"";
        self.detailTV.text = @"";
        [self.view endEditing:YES];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [ac addAction:action1];
    [ac addAction:action2];
    [self presentViewController:ac animated:YES completion:nil];
    
}
@end
