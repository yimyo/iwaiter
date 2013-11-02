//
//  mapAnnotation.m
//  iWaiter
//
//  Created by RedScor Yuan on 2013/10/28.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation


- (id)initWithMapModel:(MapModel *)mapModel{
    self = [super init];
    if (self) {
        self.mapModel = mapModel;
    }
    
    return self;
}

//- (void)setMapModel:(MapModel *)mapModel {
//    if (_mapModel != mapModel) {
////        [mapModel release];
//        _mapModel = mapModel;//[mapModel retain];
//    }
//    
//    NSDictionary *geoDic = mapModel.geo;
//    if ([geoDic isKindOfClass:[NSDictionary class]]) {
//        NSArray *geoArray = [geoDic objectForKey:@"coordinates"];
//        
//        if (geoArray.count == 2) {
//            float longitude = [[geoArray objectAtIndex:1] floatValue];
//            float latitude = [[geoArray objectAtIndex:0] floatValue];
//            _coordinate = CLLocationCoordinate2DMake(latitude, longitude);
//        }
//    }
//    
//}
@end
