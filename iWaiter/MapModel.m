//
//  MapModel.m
//  iWaiter
//
//  Created by RedScor Yuan on 2013/10/29.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import "MapModel.h"

@implementation MapModel
@synthesize title,certification_category,subtitle,poi_addr,tel,X,Y;

-(NSDictionary *)attributeMapDictionary{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"name",@"title",
                         @"certification_category",@"certification_category",
                         @"display_addr",@"subtitle",
                         @"deptName",@"deptName",
                         @"poi_addr",@"poi_addr",
                         @"tel",@"tel",
                         @"X",@"X",
                         @"Y",@"Y",
                         nil];
    
    return dic;
    
}
@end
