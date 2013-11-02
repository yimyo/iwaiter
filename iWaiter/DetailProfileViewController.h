//
//  DetailProfileViewController.h
//  iWaiter
//
//  Created by RedScor Yuan on 2013/10/31.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaiterModel.h"


typedef NS_ENUM(NSUInteger, DetailCellType)
{
    MessageCellType,
    ImageCellType,
};

@interface DetailProfileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *aTableView;

@property (nonatomic , strong) WaiterModel *waiterModel; //個人資料
@property (nonatomic , strong) NSMutableArray *waiterData; //個人經由網路或其他資料
@property (nonatomic ,assign ,readonly)DetailCellType cellType;
@end
