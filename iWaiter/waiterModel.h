//
//  waiterModel.h
//  iWaiter
//
//  Created by RedScor Yuan on 2013/10/29.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaiterModel : NSObject

@property (nonatomic,copy)NSString *avatarImage; // 頭像網址
@property (nonatomic,copy)NSString *name; //Waiter姓名
@property (nonatomic,copy)NSString *starNumber; //星星評分數
@property (nonatomic,copy)NSString *imageUrl; //圖片網址
@property (nonatomic,copy)NSString *dateLabel; //日期
@property (nonatomic,copy)NSString *bluetoothID; //所屬的藍牙裝置ID




@end
