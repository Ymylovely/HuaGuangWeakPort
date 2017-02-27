//
//  LoginViewController.m
//  华广周报提交系统
//
//  Created by 孙 华 on 2016/11/2.
//  Copyright © 2016年 hg. All rights reserved.
//

#import "LoginViewController.h"

#import "MainTabBarController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;

@end

@implementation LoginViewController
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginBtn.layer.cornerRadius = 15;
    self.loginBtn.layer.masksToBounds = YES;
}
- (IBAction)login:(UIButton *)sender {
    if(self.username.text.length>0&&self.password.text.length>0){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.label.text = @"正在登录...";
        [HGUtils loginHGWithloginName:self.username.text andPassword:self.password.text andCallback:^(id callback) {
            [hud hideAnimated:YES];
            if ([callback isKindOfClass:[NSDictionary class]]) {
                
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud setObject:[callback objectForKey:@"loginName"] forKey:@"loginName"];
                [ud setObject:[callback objectForKey:@"username"] forKey:@"username"];
                [ud setObject:[callback objectForKey:@"userId"] forKey:@"userId"];
                [ud setObject:[callback objectForKey:@"password"] forKey:@"password"];
                NSString *head = [callback objectForKey:@"headPhoto"];
                NSString *headPath =[NSString stringWithFormat:@"http://www.huaguangsoft.com%@",head];
                [ud setObject:headPath forKey:@"headPhoto"];
                BOOL cc = [ud synchronize];
                if (cc) {
                
                    self.view.window.rootViewController = [MainTabBarController new];
                }else{
                    
                }
                
//                NSLog(@"%@",callback);
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:callback preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                }];
                [alert addAction:confirm];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }else{
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        }];
        [alert1 addAction:confirm];
        [self presentViewController:alert1 animated:YES completion:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
