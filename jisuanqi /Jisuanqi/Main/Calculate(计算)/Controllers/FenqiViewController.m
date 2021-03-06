//
//  FenqiViewController.m
//  HaiLuoQianBao
//
//  Created by mac on 2018/7/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FenqiViewController.h"
//#import "RepaymentScheduleTableViewCell.h"
#import "FenQiTableViewCell.h"
@interface FenqiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView * tableView;        //
@end

@implementation FenqiViewController
//隐藏底部bottombar
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"分期计划";
       [self.navigationItem setHidesBackButton:YES];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, KScreenWidth, KScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
  
    
    UINib *nib2=[UINib nibWithNibName:@"RepaymentScheduleTableViewHeadView" bundle:nil];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:@"RepaymentScheduleTableViewHeadView"];

    UINib *nib4=[UINib nibWithNibName:@"FenQiTableViewCell" bundle:nil];
    [self.tableView registerNib:nib4 forCellReuseIdentifier:@"FenQiTableViewCell"];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
    
    UIButton *button=[[UIButton alloc]init];
//    button.frame=CGRectMake(0, KScreenHeight-44, KScreenWidth, 44);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setBackgroundColor:KBackgroundColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self.view bringSubviewToFront:button];

    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@44);
    }];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _model.mouthRepaymentArr.count+1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell=[[UITableViewCell alloc]init];
    long  index=indexPath.row;
    if (index==0) {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell=[tableView dequeueReusableCellWithIdentifier:@"RepaymentScheduleTableViewHeadView"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    FenQiTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"FenQiTableViewCell"];
    cell.periodsLabel.text=[NSString stringWithFormat:@"第%ld期",index];
    cell.repayLabel.text=[NSString stringWithFormat:@"%.2f",[_model.mouthRepaymentArr[index-1] floatValue]];
    cell.benLabel.text=[NSString stringWithFormat:@"%.2f",[_model.mouthBenArr[index-1] floatValue]];
    cell.rateLabel.text=[NSString stringWithFormat:@"%.2f",[_model.mouthRateArr[index-1] floatValue]];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //    cell.textLabel.text=[NSString stringWithFormat:@"%.2f",[_model.mouthRateArr[index-1] floatValue]];
    
    return cell;
    
}
-(void)dissMiss{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
