//
//  DetailProfileViewController.m
//  iWaiter
//
//  Created by RedScor Yuan on 2013/10/31.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import "DetailProfileViewController.h"
#import "WaiterModel.h"
#import "UIImageView+WebCache.h"
#import "DetailMessageCell.h"
#import <QuartzCore/QuartzCore.h>

@interface DetailProfileViewController ()

@end

@implementation DetailProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        

        //調整成透明的navigationBar
        /*[self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                      forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.view.backgroundColor = [UIColor clearColor];
         */

    }
    return self;
}

#pragma mark - Init View
- (void)initHeaderView:(WaiterModel *)waiterModel
{
    //headerView
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 176)];
    headView.backgroundColor = RGB(255, 89, 95);
   // headView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
 
    //Avatar Picture
    UIImageView *avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 20, 120, 120)];
    avatarImageView.layer.cornerRadius = roundf(avatarImageView.frame.size.width / 2);
    avatarImageView.layer.masksToBounds = YES;
    avatarImageView.backgroundColor = [UIColor clearColor];
    [avatarImageView setImageWithURL:[NSURL URLWithString:waiterModel.avatarImage] placeholderImage:[UIImage imageNamed:@""]];
    [headView addSubview:avatarImageView];
 
    self.aTableView.tableHeaderView = headView;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
    self.navigationController.navigationBar.tintColor = nil;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //調整成透明的navigationBar
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    //背景透明黑色
    UIView *blackBg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    blackBg.backgroundColor = RGB(255, 89, 95);
    [self.view insertSubview:blackBg belowSubview:self.aTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = self.waiterModel.name;
    
    self.aTableView.sectionHeaderHeight = 50;

    [self initHeaderView:self.waiterModel];
    
    
}

#pragma mark - Tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    static NSString *identifier = @"DetailMessageCell";
    DetailMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[DetailMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellType == MessageCellType) {
        return 100;
    }
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    sectionView.backgroundColor = RGB(255, 89, 95);
    //Name Label
    
    UIButton *followButton = [UIButton buttonWithType:UIButtonTypeCustom];
    followButton.frame = CGRectMake(105, 5, 110, 40);
    followButton.backgroundColor = [UIColor clearColor];
    followButton.layer.borderWidth = 2;
    followButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [followButton setTitle:@"Following" forState:UIControlStateNormal];
    [followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sectionView addSubview:followButton];
    
    return sectionView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
