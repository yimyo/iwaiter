//
//  waiterMatchViewController.h
//  iWaiter
//
//  Created by RedScor Yuan on 2013/10/29.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaiterMatchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,strong)IBOutlet UITableView *aTableView;
@property (nonatomic,strong)NSMutableArray *headerData; //scrollView Data
@property (nonatomic,strong)NSMutableArray *myData; //自己的Data
@property (nonatomic,assign)int index;
@property (nonatomic,strong)IBOutlet UIScrollView *headerScrollview;

@property (nonatomic,strong)UIImage *image; //照相/相簿的image


@end
