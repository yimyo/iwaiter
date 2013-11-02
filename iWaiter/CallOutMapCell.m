//
//  CallOutMapCell.m
//  iWaiter
//
//  Created by Mac on 13/11/2.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import "CallOutMapCell.h"

@implementation CallOutMapCell

@synthesize storeNameLable,storeTemperature,storePeopleNumber,storeScore;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Map_Pin_Box"]];
        
        [self addSubview:imageView];
        
        storeNameLable = [[UILabel alloc]init];
        storeNameLable.frame = CGRectMake(18, 5, 120, 13);
        storeNameLable.font = [UIFont systemFontOfSize:13];
        storeNameLable.textColor = [UIColor whiteColor];
        storeNameLable.backgroundColor = [UIColor clearColor];
        
        
        storeTemperature = [[UILabel alloc]init];
        storeTemperature.frame = CGRectMake(18, 25, 120, 13);
        storeTemperature.font = [UIFont systemFontOfSize:13];
        storeTemperature.textColor = [UIColor whiteColor];
        storeTemperature.backgroundColor = [UIColor clearColor];
        
        
        storePeopleNumber = [[UILabel alloc]init];
        storePeopleNumber.frame = CGRectMake(18, 45, 120, 13);
        storePeopleNumber.font = [UIFont systemFontOfSize:13];
        storePeopleNumber.textColor = [UIColor whiteColor];
        storePeopleNumber.backgroundColor = [UIColor clearColor];
        
        storeScore = [[UILabel alloc]init];
        storeScore.frame = CGRectMake(18, 65, 120, 13);
        storeScore.font = [UIFont systemFontOfSize:13];
        storeScore.textColor = [UIColor whiteColor];
        storeScore.backgroundColor = [UIColor clearColor];
        
        [self addSubview:storeNameLable];
        [self addSubview:storeTemperature];
        [self addSubview:storePeopleNumber];
        [self addSubview:storeScore];
        
        UIButton *testButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        testButton.frame = CGRectMake(0, 0, 120, 100);
        
        [testButton addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
        
        //testButton addTarget:self action:@selector(test) forControlEvents:
        
        [self addSubview:testButton];
        
        
    }
    return self;
}

-(void)test:(id)sender
{
    NSLog(@"OK");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
