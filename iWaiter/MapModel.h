//
//  MapModel.h
//  iWaiter
//
//  Created by RedScor Yuan on 2013/10/29.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import "BaseModel.h"
#import <MapKit/MapKit.h>

@interface MapModel : BaseModel<MKAnnotation>

@property (nonatomic,copy) NSString *title; //店名
@property (nonatomic,copy) NSString *certification_category; //分類
@property (nonatomic,copy) NSString *tel;
@property (nonatomic,copy) NSString *subtitle; //地址
@property (nonatomic,copy) NSString *poi_addr; //詳細地址(包括樓層)
@property (nonatomic,copy) NSString *X; //經度
@property (nonatomic,copy) NSString *Y; //緯度



@property(nonatomic) int peopleNumber;
@property(nonatomic) float temperature;
@property(nonatomic) float rate;

@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
