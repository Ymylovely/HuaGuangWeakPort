//
//  OtherViewController.m
//  华广周报提交系统
//
//  Created by 孙 华 on 2016/11/2.
//  Copyright © 2016年 hg. All rights reserved.
//

#import "OtherViewController.h"
#import "LoginViewController.h"
@interface OtherViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *loginName;
@property (nonatomic,strong)NSArray *groups;
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    self.loginName.text = [ud objectForKey:@"loginName"];
    UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(YSW/8 * 3, 40, YSW/4, YSW/4)];
    iv.layer.cornerRadius = YSW/8;
    iv.layer.masksToBounds = YES;
    self.headView.backgroundColor = kRGBA(64, 143, 181, 1);
    [self.headView addSubview:iv];
    if ([ud objectForKey:@"headPhoto"]) {
//        NSString *imageUrl = [NSString stringWithFormat:@"http://192.168.1.137:8080%@",[ud objectForKey:@"headPhoto"]];
//        NSLog(@"%@",imageUrl);
        [iv sd_setImageWithURL:[NSURL URLWithString:[ud objectForKey:@"headPhoto"]] placeholderImage:[UIImage imageNamed:@"images"]];
    }else{
        iv.image = [UIImage imageNamed:@"images"];
    }
    [self.headView addSubview:iv];
    NSArray *g1 = @[@"修改密码",@"清除缓存"];
    NSArray *g2 = @[@"切换用户"];
    self.groups = @[g1,g2];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *group = self.groups[section];
    return group.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
     if (!cell) {
         cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
     }
     NSArray *group = self.groups[indexPath.section];
     cell.textLabel.text = group[indexPath.row];
     switch (indexPath.section) {
         case 0:
             if (indexPath.row==0) {
                 cell.imageView.image = [UIImage imageNamed:@"iconfont-xiugaimima"];
             }else{
                 cell.imageView.image = [UIImage imageNamed:@"iconfont-qingchuhuancun"];
             }
             break;
         case 1:
             cell.imageView.image = [UIImage imageNamed:@"iconfont-tuichu"];
             break;
     }
 
 return cell;
 }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"退出登录？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *back = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:nil forKey:@"loginName"];
        [ud setObject:nil forKey:@"username"];
        [ud setObject:nil forKey:@"userId"];
        [ud setObject:nil forKey:@"password"];
        [ud setObject:nil forKey:@"headPhoto"];
        NSLog(@"%@",[ud objectForKey:@"headPhoto"]);
        BOOL isSuccessful = [ud synchronize];
        if (isSuccessful) {
            self.view.window.rootViewController = [LoginViewController new];
        }
    }];
    [alert addAction:back];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(tintColor)])
    {
        CGFloat cornerRadius = 5.f;//圆角大小
        cell.backgroundColor = [UIColor clearColor];
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        CGMutablePathRef pathRef = CGPathCreateMutable();
        CGRect bounds = CGRectInset(cell.bounds, 5, 0);
        BOOL addLine = NO;
        
        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1)
        {
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            
        }
        else if (indexPath.row == 0)
        {   //最顶端的Cell（两个向下圆弧和一条线）
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            addLine = YES;
        }
        else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1)
        {   //最底端的Cell（两个向上的圆弧和一条线）
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
        }
        else
        {   //中间的Cell
            CGPathAddRect(pathRef, nil, bounds);
            addLine = YES;
        }
        layer.path = pathRef;
        CFRelease(pathRef);
        layer.fillColor = [UIColor whiteColor].CGColor; //cell的填充颜色
        layer.strokeColor = [UIColor lightGrayColor].CGColor; //cell 的边框颜色
        
        if (addLine == YES) {
            CALayer *lineLayer = [[CALayer alloc] init];
            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height-lineHeight, bounds.size.width, lineHeight);
            lineLayer.backgroundColor = [UIColor lightGrayColor].CGColor;        //绘制中间间隔线
            [layer addSublayer:lineLayer];
        }
        
        UIView *bgView = [[UIView alloc] initWithFrame:bounds];
        [bgView.layer insertSublayer:layer atIndex:0];
        bgView.backgroundColor = UIColor.clearColor;
        cell.backgroundView = bgView;
    }
}
@end
