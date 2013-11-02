//
//  waiterMatchViewController.m
//  iWaiter
//
//  Created by RedScor Yuan on 2013/10/29.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import "WaiterMatchViewController.h"
#import "UIImageView+WebCache.h"
#import "WaiterModel.h"
#import "IwaiterProfileCell.h"
#import "DetailProfileViewController.h"
#import <QuartzCore/QuartzCore.h>

#import <Parse/Parse.h>
#import "WaiterSearcher.h"

@interface WaiterMatchViewController ()
@property(nonatomic, assign) NSInteger waiterCounts;
@property(nonatomic,strong) NSArray *waiterArray;
@property(nonatomic,strong) NSMutableArray *waiterIDArray;
@end

@implementation WaiterMatchViewController
@synthesize headerScrollview;
@synthesize aTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //頭部Scroolview的資料
        _headerData = [[NSMutableArray alloc]init];
        //自己的資料
        _myData = [[NSMutableArray alloc]init];
        //紀錄ScrollView滾到那個位置 預設為0
        _index = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title= @"title";
    
    self.aTableView.bounces  = NO;
    
    //------------
    
    //初始化數據
    _waiterIDArray=[[NSMutableArray alloc]init];
    
    //取得waiter的要求(取得server的資料)
    PFQuery *query = [PFQuery queryWithClassName:@"Waiter"];
    ////    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query orderByDescending:@"createdAt"];
    
    //取得所有成員（找server上所有服務生資料的方法）
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        _waiterArray=objects;
        //取得成員數目
        _waiterCounts=[_waiterArray count];
        
        NSLog(@"_waiterArray:%@",_waiterArray);
        //NSLog(@"_waiterCounts:%i",_waiterCounts);
        
        for (int i=0; i<_waiterCounts; i++) {
            
            NSLog(@"_waiterArray ID :%@", [_waiterArray[i] objectForKey:@"ID"]);
           
            NSLog(@"_waiterArray NAME :%@", [_waiterArray[i] objectForKey:@"name"]);
            
            NSLog(@"_waiterArray SHOP :%@", [_waiterArray[i] objectForKey:@"shop"]);
            
            WaiterModel *waiter = [[WaiterModel alloc]init];
            waiter.name = [_waiterArray[i] objectForKey:@"name"];
            waiter.avatarImage = [_waiterArray[i] objectForKey:@"imgUrl"];
            waiter.starNumber = @"3";
            waiter.bluetoothID = [_waiterArray[i] objectForKey:@"ID"];
            
            [_headerData addObject:waiter];
            
           
        }
        
        [self setHeaderUI];
        
        UIImageView *nowImageView = (UIImageView *)[headerScrollview viewWithTag:0];
        
        nowImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.5, 1.5);

        //------------------
        
        //啟動藍芽
        WaiterSearcher *ws = [WaiterSearcher sharedInstance];
        [ws initBluetooth];
        [self setNotification];
        
        //------------------
    }];
    
    //--------------
    
    //調整成透明的navigationBar
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    //背景透明黑色
//    UIView *blackBg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
//    blackBg.backgroundColor = [UIColor blackColor];
//    [self.view insertSubview:blackBg belowSubview:aTableView];
    
    UIButton *setimageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    setimageButton.frame = CGRectMake(0, 0, 320, 20);
    [setimageButton addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchUpInside];
    [setimageButton setTitle:@"相機" forState:UIControlStateNormal];
    [setimageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.aTableView.tableFooterView = setimageButton;
    
    

}

//監聽viewcontroller收到藍牙(waitersearcher)的訊息
-(void)setNotification
{
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"closeToWaiter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveCurrentWaiter:) name:@"closeToWaiter" object:nil];
}

-(void)moveCurrentWaiter:(NSNotification *) notification
{
    //取得ID就跟服務生的ID比對
    
    NSString *bluetoothID = [notification.userInfo objectForKey:@"BluetoothIDKey"];
    
    NSLog(@"~~~~~~~~~~~Get BlueTooth ID: %@",bluetoothID);
    
    for (int i=0; i<_waiterCounts; i++)
    {
        WaiterModel *_modle = (WaiterModel*)[_headerData objectAtIndex:i];
        
        //NSLog(@"_headerData : ID %@",_modle.bluetoothID);
        
        if ([bluetoothID isEqualToString:_modle.bluetoothID]) {
            NSLog(@"Match!!!Move!!!");
            [headerScrollview setContentOffset:CGPointMake(195*i,0) animated:YES];
            break;
        }
    }
    
}


- (void)setHeaderUI{
    
    NSInteger count = [_headerData count];
    //設置ScrollView0
//    headerScrollview.frame = CGRectMake(38, 104, 195, 100);
    [headerScrollview sizeToFit];
    self.headerScrollview.contentSize = CGSizeMake( 195 * count, 0);
    headerScrollview.showsHorizontalScrollIndicator = NO;
    headerScrollview.showsVerticalScrollIndicator = NO;
    headerScrollview.backgroundColor = [UIColor clearColor];
    headerScrollview.delegate = self;
    headerScrollview.bounces = NO;
    headerScrollview.tag = INT_MAX;
    headerScrollview.clipsToBounds = NO;
    headerScrollview.pagingEnabled = YES;
    
    
    [self.view addSubview:headerScrollview];
    //設定PageControl
//    self.pageControl.numberOfPages = count;
//    self.pageControl.currentPage = 0;
    
    //填充資料
    [self fillHeaderData:count];
    
}

- (void)fillHeaderData:(NSInteger)index
{
 
    for (int i = 0 ; i < [_headerData count]; i++) {
        
        WaiterModel *waitModel = [_headerData objectAtIndex:i];
        //圖片
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(195 * i + 75, -50, 100 , 100);
        imageView.tag = i;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
//        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = roundf(imageView.frame.size.width/2.0);
        imageView.layer.masksToBounds = YES;
        [imageView setImageWithURL:[NSURL URLWithString:waitModel.avatarImage] placeholderImage:[UIImage imageNamed:@""]];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToNewView:)];
        singleTap.numberOfTouchesRequired = 1;
        singleTap.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer:singleTap];
        
        [self.headerScrollview addSubview:imageView];
    }
}

- (void)requestData{
//    WaiterModel *waiter = [[WaiterModel alloc]init];
//    waiter.name = @"林志玲";
//    waiter.avatarImage = @"http://img.my.tv.cctv.com/attachments/2009/01/424445_200901051150051.jpg";
//    waiter.starNumber = @"3";
//    [_headerData addObject:waiter];
//    WaiterModel *waiter1 = [[WaiterModel alloc]init];
//
//    waiter1.name = @"李冰冰";
//    waiter1.avatarImage = @"http://photocdn.sohu.com/20050829/Img226812126.jpg";
//    waiter1.starNumber = @"5";
//    [_headerData addObject:waiter1];
//    WaiterModel *waiter2 = [[WaiterModel alloc]init];
//
//    waiter2.name = @"王心凌";
//    waiter2.avatarImage = @"http://t1.gstatic.com/images?q=tbn:ANd9GcRjhKNb75JQ6GyQnzOE_G0bKPn01pHd1GGbBZZ6izKXg4ddCvU2Hg";
//    waiter2.starNumber = @"5";
//    [_headerData addObject:waiter2];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    if (indexPath.row == 0) {
        static NSString *identifier = @"normalCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        [cell addSubview:self.headerScrollview];
        
        return cell;
    }else if (indexPath.row == 1){
        static NSString *customIdenty = @"IwaiterProfileCell";
    
       IwaiterProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:customIdenty];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:customIdenty owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.MyAvatarImage.layer.cornerRadius = roundf(cell.MyAvatarImage.frame.size.width/2.0);
        cell.MyAvatarImage.layer.masksToBounds = YES;
        
        [cell.MyAvatarImage setImageWithURL:[NSURL URLWithString:@"http://i2.sinaimg.cn/ent/v/j/2009-08-07/U3349P28T3D2643658F329DT20090807204255.jpg"] placeholderImage:[UIImage imageNamed:@""]];
        //CUICatalog: Invalid asset name supplied: , or invalid scale factor: 2.000000
        //placeholderImage 未給參數造成
        
        return cell;
    }
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
    
        return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 )
    {
        return 180;
    }
    else if (indexPath.row == 1)
    {
        return 200;
    }
    return 44;
}

- (void)pushToNewView:(UITapGestureRecognizer *)tapGesture{
    
    UIView *tapView = [tapGesture view];
    int viewTag = tapView.tag;
    
    WaiterModel *waiterModel = [self.headerData objectAtIndex:viewTag];
    
    DetailProfileViewController *detail = [[DetailProfileViewController alloc]init];
    detail.waiterModel = waiterModel;
    
    [self.navigationController pushViewController:detail animated:YES];
    
}

#pragma mark - UIActionSheet method & delegate
//選擇圖片/相機
- (void)selectImage {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    [actionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        //判斷是否有相機
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此設備沒有相機" delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }else {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:NULL];
        }
    }
    else if (buttonIndex == 1) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:NULL];
    }else if (buttonIndex == 2) {
        //取消按钮
        [actionSheet resignFirstResponder];
    }
    
}

#pragma mark - UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
//    if (self.sengImageButton == nil) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.layer.cornerRadius = 5;
//        button.layer.masksToBounds = YES;
//        button.frame = CGRectMake(5, 20, 25, 25);
//        [button addTarget:self action:@selector(imageAction:) forControlEvents:UIControlEventTouchUpInside];
//        self.sengImageButton = button;
//    }
//    
//    [self.sengImageButton setImage:self.image forState:UIControlStateNormal];
//    [self.editorBar addSubview:self.sengImageButton];
//    UIButton *button1 = [_buttons objectAtIndex:0];
//    UIButton *button2 = [_buttons objectAtIndex:1];
//    [UIView animateWithDuration:0.5 animations:^{
//        button1.transform = CGAffineTransformTranslate(button1.transform, 20, 0);
//        button2.transform = CGAffineTransformTranslate(button2.transform, 5, 0);
//    }];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - ScrollView Delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int current = scrollView.contentOffset.x / 195;
    
    if (current == 0 && scrollView.contentOffset.x == 0 ) {
        return;
    }
    
    if (_index == current) {
        return;
    }
    
    UIImageView *currentImageView = (UIImageView *)[scrollView viewWithTag:current];
    
    currentImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.5, 1.5);

    UIImageView *lastImageView = (UIImageView *)[scrollView viewWithTag:_index];
    lastImageView.transform = CGAffineTransformIdentity;


    _index = current;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
