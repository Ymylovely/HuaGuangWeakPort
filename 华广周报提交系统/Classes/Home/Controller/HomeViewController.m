//
//  HomeViewController.m
//  华广周报提交系统
//
//  Created by 孙 华 on 2016/11/2.
//  Copyright © 2016年 hg. All rights reserved.
//

#import "HomeViewController.h"
#import "SendViewController.h"
#import "ThemeDetailViewController.h"
#import "ThemeModel.h"
#import "ThemeCell.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray *themesArr;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)AFNetworkReachabilityManager *manager;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, YSW, YSH) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview: self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"ThemeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-fabu"] style:UIBarButtonItemStyleDone target:self action:@selector(gosendview)];
    [self loadWeekly];
    HomeViewController *vc = self;
//    [self.tableView addPullToRefreshWithActionHandler:^{
//        [vc loadWeekly];
//        [vc.tableView reloadData];
//        
//    }];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [vc loadMoreWeekly];
        [vc.tableView reloadData];
    }];
    
    
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    HomeViewController *vc = self;
    if (self.tableView.pullToRefreshView == nil) {
        
        [self.tableView addPullToRefreshWithActionHandler:^{
            [vc loadWeekly];
        }];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager manager];
    self.manager = manager;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch ((int)status) {
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(noNetwork) userInfo:nil repeats:NO];
                if (self.themesArr.count ==0) {
                    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/themes.arch"];
                    NSData *data = [NSData dataWithContentsOfFile:path];
                    if (data) {
                        self.themesArr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                        [self.tableView reloadData];
                    }
                }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"移动网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi网络");
                
                
                
                break;
        }
    }];
    [manager startMonitoring];
    
}
-(void)noNetwork{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无网络" message:@"请检查您的网络连接" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)gosendview{
    SendViewController *vc = [SendViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)loadMoreWeekly{
    [self.tableView.infiniteScrollingView stopAnimating];
}
-(void)loadWeekly{
    if (self.manager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        [self.tableView.pullToRefreshView stopAnimating];
        
    }
    [HGUtils getThemeWithPage:0 andCallBack:^(id callback) {
        self.themesArr = callback;
        NSLog(@"%@",callback);
        [self.tableView reloadData];
        [self.tableView.pullToRefreshView stopAnimating];
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.themesArr.count>0) {
        NSData *themesData = [NSKeyedArchiver archivedDataWithRootObject:self.themesArr];
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/themes.arch"];
        [themesData writeToFile:path atomically:YES];
        
    }
    return self.themesArr.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
      ThemeCell*cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
     cell.theme = self.themesArr[indexPath.row];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
     return cell;
 }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ThemeDetailViewController *vc = [ThemeDetailViewController new];
    vc.theme = self.themesArr[indexPath.row];
    vc.title = vc.theme.title;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
