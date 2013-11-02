//
//  CallOutMapCell.h
//  iWaiter
//
//  Created by Mac on 13/11/2.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallOutMapCell : UIView
@property(nonatomic,strong)UILabel *storeNameLable; //店名
@property(nonatomic,strong)UILabel *storeTemperature; //店內溫度
@property(nonatomic,strong)UILabel *storePeopleNumber; //店內人數
@property(nonatomic,strong)UILabel *storeScore; //店內分數

-(void)test:(id)sender;

@end
