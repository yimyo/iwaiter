//
//  mapAnnotationView.h
//  iWaiter
//
//  Created by RedScor Yuan on 2013/10/29.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MapAnnotation.h"

@interface MapAnnotationView : MKAnnotationView
{
    UILabel *mainTitle;
    UILabel *subTitle;
    UILabel *celsius;
    UIImageView *storeImage;
}
@property (nonatomic,strong)MapAnnotation *mapAnnotation;
@end
