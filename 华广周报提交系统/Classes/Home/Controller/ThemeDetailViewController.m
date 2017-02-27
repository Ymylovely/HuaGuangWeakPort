//
//  ThemeDetailViewController.m
//  华广周报提交系统
//
//  Created by 孙 华 on 2016/11/4.
//  Copyright © 2016年 hg. All rights reserved.
//

#import "ThemeDetailViewController.h"
#import "ReplyCell.h"

@interface ThemeDetailViewController ()<UITableViewDelegate,UITableViewDataSource,ReplyCellDelegate,ReplyCellDeleteDelegate>

@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIView *replyView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *heightArray;
@property (nonatomic,strong)NSArray *replyArray;
@end

@implementation ThemeDetailViewController
-(void)choseDeleteBtn:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)choseReplyBtn:(UIButton *)button{
    [self.replyTF becomeFirstResponder];
}
-(NSMutableArray *)heightArray{
    if (!_heightArray) {
        _heightArray = [NSMutableArray array];
    }
    return  _heightArray;
}
- (IBAction)sendClicked:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if (self.replyTF.text.length>0)
    {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *currentName = [ud objectForKey:@"loginName"];
        [HGUtils replyThemeWithThemeID:self.theme.themeId andContent:self.replyTF.text andCreatedBy:currentName andCallback:^(id callback) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:callback preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [self loadReply];
                self.replyTF.text = @"";
                
            }];
            [alert addAction:confirm];
            [self presentViewController:alert animated:YES completion:nil];
        }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"回复内容不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ac];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
-(void)loadReply{
    [HGUtils getThemeAndReplyWithThemeID:self.theme.themeId andCallback:^(id callback) {
        self.replyArray = callback;
        [self.tableView reloadData];
        [self.tableView.pullToRefreshView stopAnimating];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, YSW, YSH - 114) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview: self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"ReplyCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ReplyCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell0"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.sendBtn.layer.cornerRadius = 3;
    self.sendBtn.layer.masksToBounds = YES;
    self.sendBtn.layer.borderWidth = 2;
    self.sendBtn.layer.borderColor = [kRGBA(124, 124, 124, 1) CGColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChangeAction:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self loadReply];
    ThemeDetailViewController *vc = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [vc loadReply];
        [vc.tableView reloadData];
    }];
    
}
-(void)keyboardChangeAction:(NSNotification *)noti{
    CGRect keyboardF = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if(keyboardF.origin.y == YSH){
        self.replyView.transform = CGAffineTransformIdentity;
        self.tableView.frame = CGRectMake(0, 64, YSW, YSH - 114);
//        [self.tableView setFrame:CGRectMake(0, 64, YSW, YSH-114)];
    }else{
        self.replyView.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
        [self.tableView setFrame:CGRectMake(0, 64, YSW, YSH-114-keyboardF.size.height)];
//        NSIndexPath *index = [NSIndexPath indexPathWithIndex:self.replyArray.count-1];
//        [self.tableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionBottom];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.replyArray.count+1;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     if (indexPath.row == 0) {
         ReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0" forIndexPath:indexPath];
         cell.loucengLabel.hidden = YES;
         cell.louzhuLabel.hidden = NO;
         cell.replyCount.hidden = YES;
         cell.replyCount.text = [NSString stringWithFormat:@"%ld",self.replyArray.count];
        if (self.replyArray.count!=0) {
            
            cell.replyCount.hidden = NO;
            cell.replyCount.text = [NSString stringWithFormat:@"%ld",self.replyArray.count];

         }
         cell.theme = self.theme;
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         cell.delegate = self;
         cell.deleteDelegate = self;
         return cell;
     }
    ReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.reply = self.replyArray[indexPath.row - 1];
     cell.loucengLabel.text = [NSString stringWithFormat:@"%ld楼",indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     
    cell.delegate = self;
    cell.deleteDelegate = self;
     
    
     return cell;
 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return [HGUtils contentHeight:self.theme.content]+80;
    }
    ReplyModel *reply = self.replyArray[indexPath.row -1];
    return [HGUtils contentHeight:reply.content]+80;
    
    
}


@end
