//
//  MainMapViewController.m
//  iWaiter
//
//  Created by RedScor Yuan on 2013/10/28.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import "MainMapViewController.h"
#import "MapModel.h"
#import "MapAnnotation.h"
#import "MapAnnotationView.h"
#import "WaiterMatchViewController.h"

#import "CalloutMapAnnotation.h"
#import "BasicMapAnnotation.h"
#import "CallOutAnnotationView.h"
#import "CallOutMapCell.h"

#import "DataService.h"

#import "BasicMapModel.h"

@interface MainMapViewController ()
{
//CalloutMapAnnotation *_calloutAnnotation;

    BasicMapModel *_calloutAnnotation;
    
    BasicMapModel *_previousdAnnotation;

}
@end

@implementation MainMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIImage *UIBarButtonListImage = [UIImage imageNamed:@"UIBarButtonList.png"];
    UIImage *UIBarButtonSearchImage = [UIImage imageNamed:@"UIBarButtonSearch.png"];
    
    UIBarButtonItem *UIBarButtonItemSearch = [[UIBarButtonItem alloc] initWithImage:UIBarButtonSearchImage style:UIBarButtonItemStylePlain target:self action:@selector(none:)];
    UIBarButtonItem *UIBarButtonItemList = [[UIBarButtonItem alloc] initWithImage:UIBarButtonListImage style:UIBarButtonItemStylePlain target:self action:@selector(none:)];
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItemSearch;
    self.navigationItem.leftBarButtonItem = UIBarButtonItemList;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //透明navigation bar
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    //假裝有顏色的navigation bar
    UIView *navigationBarBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 64)];
    navigationBarBgView.backgroundColor = [UIColor colorWithRed:1.00 green:0.35 blue:0.37 alpha:1.00];
    [self.view addSubview:navigationBarBgView];
    ;
    
    //設定navigation bar上文字顏色
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    //設定字體
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                 NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:22],
                                 NSKernAttributeName : @10};
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    
}

-(void)none:(id)sender
{
            WaiterMatchViewController *contorller = [[WaiterMatchViewController alloc]init];
    //
            [self.navigationController pushViewController:contorller animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"iWaiter";
    
//    //調整navigationBar顏色
//    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:1.00 green:0.35 blue:0.37 alpha:1.00];
//    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManager delegate
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
    
    [manager stopUpdatingLocation];
    
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    
	MKCoordinateSpan span = {0.1,0.1};
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region animated:YES];
    
    if (self.data == nil) {
        NSString *longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
        NSString *latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:longitude,@"long",latitude,@"lat", nil];
        
        
        //把坐標傳到api回傳結果 HttpRequestUrl ....
        [self didFinishLoadData];
    }
}

// iOS 7 Delegate
- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations{
    
    [self didFinishLoadData];

}

- (void)didFinishLoadData{
    
//    NSMutableArray *maps = [NSMutableArray arrayWithCapacity:3];
//
////    MapModel *mapModel = [[MapModel alloc]init];
////    mapModel.title = @"中正紀念堂";
////    mapModel.subTitle = @"蔣中正";
////    NSArray *arr =  @[@25.034712,@121.522041];
////    mapModel.geo = [NSDictionary dictionaryWithObject:arr forKey:@"coordinates"];
////    [maps addObject:mapModel];
//    
//    MapModel *mapModel1 = [[MapModel alloc]init];
//    mapModel1.title = @"國父紀念館";
//    mapModel1.subTitle = @"孫中山";
//    NSArray *arrGeo =  @[@25.039649,@121.55988];
//    mapModel1.geo = [NSDictionary dictionaryWithObject:arrGeo forKey:@"coordinates"];
//    [maps addObject:mapModel1];
//    
//    MapAnnotation *mapAnn = [[MapAnnotation alloc]initWithMapModel:mapModel1];
//    
//    [self.mapView addAnnotation:mapAnn];
    
    _mapData = [[NSMutableArray alloc]init];
    
    [DataService getData:nil callBlock:^(id data) {
        int count = 0;
        for (NSDictionary *dic in data) {
            
            if (count >= 20) {
                break ;
            }
            MapModel *mapModel = [[MapModel alloc]initWithDataDic:dic];
            if ([mapModel.X isKindOfClass:[NSNull class]]) {
                mapModel.X = @"";
            }
            if ([mapModel.Y isKindOfClass:[NSNull class]]) {
                mapModel.Y = @"";
            }
            CLLocationCoordinate2D coor;
            coor.latitude = [mapModel.Y doubleValue];
            coor.longitude = [mapModel.X doubleValue];
            mapModel.coordinate = coor;
            
            
            mapModel.rate = arc4random() % 5 ;
            mapModel.temperature = arc4random()% 10 + 20;
            mapModel.peopleNumber = arc4random() % 4 + 1;

            
            NSLog(@"trmmperature : %f" ,mapModel.temperature );
            
            [self.mapView addAnnotation:mapModel];
            [self.mapData addObject:mapModel];
            count ++;
        }
        //  NSLog(@"data : %@",self.mapData);
        //  [self.mapView addAnnotations:self.mapData];
    }];
    
}

#pragma mark - MKAnnotationView delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
//    if ([annotation isKindOfClass:[MKUserLocation class]]) {
//        return nil;
//    }
//    
//
//    
//    static NSString *indentify = @"MapAnnotationView";
//    MapAnnotationView *mapAnnotationView = (MapAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:indentify];
//    if (mapAnnotationView == nil) {
//        mapAnnotationView = [[MapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:indentify];
//    }
    
//    MKPinAnnotationView *mapPinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:indentify];
//    if (mapPinAnnotationView == nil) {
//        mapPinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:indentify];
//    }

    
//    [mapAnnotationView addObserver:self
//              forKeyPath:@"selected"
//                 options:NSKeyValueObservingOptionNew
//                 context:GMAP_ANNOTATION_SELECTED];
    
    //mapAnnotationView.image = [UIImage imageNamed:@"Map_Pin_4.png"];
    
    //mapAnnotationView.calloutOffset = CGPointMake(58, 36 + 22);
    
    
    //return mapAnnotationView;
    
    
    //------
    
    if ([annotation isKindOfClass:[BasicMapModel class]]) {
        
//        CallOutAnnotationView *annotationView = (CallOutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutView"];
//        if (!annotationView) {
        
            CallOutAnnotationView *annotationView = [[CallOutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutView"];
            
            CallOutMapCell  *cell = [[CallOutMapCell alloc]initWithFrame:CGRectMake(0, 0, 155, 72)];
            [annotationView.contentView addSubview:cell];
            
            //annotationView.image = [UIImage imageNamed:@"Map_Pin_3.png"];
            //cell.storeNameLable.text =
            
            //BasicMapModel *model = (BasicMapModel*)annotation;
            
            cell.storeNameLable.text = _calloutAnnotation.title;
            
            cell.storeTemperature.text = [NSString stringWithFormat:@"室內溫度: %.2f 度",_calloutAnnotation.temperature];
            
            //NSString *number = nil;
        
        //NSLog(@" 店內人數 %i",);
        
            if (_calloutAnnotation.peopleNumber == 1) {
                cell.storePeopleNumber.text = [NSString stringWithFormat:@"店內人數: 人少"];
            }else if (_calloutAnnotation.peopleNumber == 2) {
                cell.storePeopleNumber.text = [NSString stringWithFormat:@"店內人數: 適中"];
            }else if (_calloutAnnotation.peopleNumber == 3) {
                cell.storePeopleNumber.text = [NSString stringWithFormat:@"店內人數: 人多"];
            }else {
                cell.storePeopleNumber.text = [NSString stringWithFormat:@"店內人數: 額滿"];
            }
            
            cell.storeScore.text = [NSString stringWithFormat:@"服務評等 : %.2f ",_calloutAnnotation.rate];

        //}
        return annotationView;
	}
    else
        if ([annotation isKindOfClass:[MapModel class]]) {
        
        
        
        MKAnnotationView *annotationView =[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
        //CallOutAnnotationView *annotationView = (CallOutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutView"];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:@"CustomAnnotation"];
            annotationView.canShowCallout = NO;
            
            //annotationView = [[CallOutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutView"];
//            CallOutMapCell  *cell = [[CallOutMapCell alloc]initWithFrame:CGRectMake(0, 0, 155, 72)];
//            [annotationView.contentView addSubview:cell];
//            MapModel *model = (MapModel*)annotation;
            
            MapModel *_modle = (MapModel*) annotation;
            
//            if (_modle.peopleNumber == 0) {
//                <#statements#>
//            }
            annotationView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Map_Pin_%i.png",_modle.peopleNumber]];
        }
		
		return annotationView;
    }
	return nil;
}

//- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
//    for (UIView *annotationView in views) {
//        CGAffineTransform transform = annotationView.transform;
//        annotationView.transform = CGAffineTransformScale(transform, 0.7, 0.7);
//        annotationView.alpha = 0;
//        
//        [UIView animateWithDuration:0.4 animations:^{
//            annotationView.transform = CGAffineTransformScale(transform, 1.3, 1.3);
//            annotationView.alpha = 1;
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.4 animations:^{
//                annotationView.transform = CGAffineTransformIdentity;
//            }];
//        }];
//    }
//}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MapAnnotationView *)view {
    
    
//    if ([view.annotation isKindOfClass:[MapAnnotation class]]) {
//        // Selected the pin annotation.
//        MapAnnotationView *calloutAnnotation = [[MapAnnotationView alloc] init];
//        MapAnnotation *pinAnnotation = ((MapAnnotation *)view.annotation);
//        calloutAnnotation.mapAnnotation = pinAnnotation;
//        [mapView addAnnotation:calloutAnnotation.mapAnnotation];
//    }
    
    if ([view.annotation isKindOfClass:[MapModel class]])
    {
        if (_calloutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            return;
        }
        if (_calloutAnnotation) {
            [mapView removeAnnotation:_calloutAnnotation];
            _calloutAnnotation = nil;
        }
        
        
        
        for (MapModel *_modle in _mapData) {
            
            //MapModel *_modle =(MapModel*)[_mapData objectAtIndex:i];
            
            if (_modle.coordinate.latitude == view.annotation.coordinate.latitude &&
                _modle.coordinate.longitude == view.annotation.coordinate.longitude ) {
                //_calloutAnnotation = (BasicMapModel*) [_modle copy];
                
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     _modle.title,@"name",
                                     _modle.certification_category,@"certification_category",
                                     _modle.subtitle,@"display_addr",
                                     @"deptName",@"deptName",
                                     _modle.poi_addr,@"poi_addr",
                                     _modle.tel,@"tel",
                                     _modle.X,@"X",
                                     _modle.Y,@"Y",
                                     nil];
                
                NSLog(@"Name :%@ ",_modle.title);
                
                _calloutAnnotation = [[BasicMapModel alloc]initWithDataDic:dic];
                
                NSLog(@"_calloutAnnotation Name :%@ ",_calloutAnnotation.title);
                
                if ([_calloutAnnotation.X isKindOfClass:[NSNull class]]) {
                    _calloutAnnotation.X = @"";
                }
                if ([_calloutAnnotation.Y isKindOfClass:[NSNull class]]) {
                    _calloutAnnotation.Y = @"";
                }
                CLLocationCoordinate2D coor;
                coor.latitude = [_calloutAnnotation.Y doubleValue];
                coor.longitude = [_calloutAnnotation.X doubleValue];
                _calloutAnnotation.coordinate = coor;
                
                _calloutAnnotation.rate = arc4random() % 5 ;
                _calloutAnnotation.temperature = arc4random()% 10 + 20;
                _calloutAnnotation.peopleNumber = arc4random() % 4 + 1;
            }
        }
        
        

        //[[BasicMapModel alloc]initWithDataDic:dic];
        
//                               initWithLatitude:view.annotation.coordinate.latitude
//                               andLongitude:view.annotation.coordinate.longitude] ;
        [mapView addAnnotation:_calloutAnnotation];
        
//        annotationView = [[CallOutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutView"];
//        CallOutMapCell  *cell = [[CallOutMapCell alloc]initWithFrame:CGRectMake(0, 0, 155, 72)];
//        [annotationView.contentView addSubview:cell];
//        MapModel *model = (MapModel*)annotation;
//        cell.storeNameLable.text = model.title;

        
        
        
        
        [mapView setCenterCoordinate:_calloutAnnotation.coordinate animated:YES];
	}
//    if ([view.annotation isKindOfClass:[BasicMapModel class]])
//    {
//        WaiterMatchViewController *contorller = [[WaiterMatchViewController alloc]init];
//        
//        [self.navigationController pushViewController:contorller animated:YES];
//    }
    
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    if (_calloutAnnotation&& ![view isKindOfClass:[CallOutAnnotationView class]]) {
        if (_calloutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            [mapView removeAnnotation:_calloutAnnotation];
            _calloutAnnotation = nil;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)observeValueForKeyPath:(NSString *)keyPath
//                      ofObject:(id)object
//                        change:(NSDictionary *)change
//                       context:(void *)context{
//    
//    NSString *action = (NSString*)context;
//    
//    
//    if([action isEqualToString:GMAP_ANNOTATION_SELECTED]){
//        BOOL annotationAppeared = [[change valueForKey:@"new"] boolValue];
//        if (annotationAppeared) {
//            [self showAnnotation:((MyAnnotationView*) object).annotation];
//        }
//        else {
//            NSLog(@"annotation deselected %@", ((MyAnnotationView*) object).annotation.title);
//            [self hideAnnotation];
//        }
//    }
//}

@end
