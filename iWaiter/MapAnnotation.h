//
//  mapAnnotation.h
//  iWaiter
//
//  Created by RedScor Yuan on 2013/10/28.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "MapModel.h"

@interface MapAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic,strong) MapModel *mapModel;

- (id)initWithMapModel:(MapModel *)mapModel;

@end
