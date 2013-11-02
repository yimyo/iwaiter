//
//  MainMapViewController.h
//  iWaiter
//
//  Created by RedScor Yuan on 2013/10/28.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MainMapViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>


@property (nonatomic , strong) NSArray *data;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) CLLocationManager *locationManager;

@property (nonatomic , strong) NSMutableArray *mapData;

@end
