//
//  mapAnnotationView.m
//  iWaiter
//
//  Created by RedScor Yuan on 2013/10/29.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import "MapAnnotationView.h"
#import <QuartzCore/QuartzCore.h>
#import "MapAnnotation.h"
#import "MapModel.h"

@implementation MapAnnotationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self initViews];
    }
    return self;
}

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self initViews];
    }
    
    return self;
}

- (void)initViews{
    mainTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    mainTitle.font = [UIFont systemFontOfSize:12.0f];
    mainTitle.textColor = [UIColor blackColor];
    mainTitle.backgroundColor = [UIColor clearColor];
    mainTitle.numberOfLines = 2;
    
    subTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    subTitle.font = [UIFont systemFontOfSize:12.0f];
    subTitle.textColor = [UIColor blackColor];
    subTitle.backgroundColor = [UIColor clearColor];
    subTitle.numberOfLines = 3;
    
    celsius = [[UILabel alloc] initWithFrame:CGRectZero];
    celsius.font = [UIFont systemFontOfSize:12.0f];
    celsius.textColor = [UIColor whiteColor];
    celsius.backgroundColor = [UIColor clearColor];
    celsius.numberOfLines = 1;
    
    storeImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    storeImage.layer.borderColor = [UIColor whiteColor].CGColor;
    storeImage.layer.borderWidth = 1;
    
    [self addSubview:mainTitle];
    [self addSubview:subTitle];
    [self addSubview:celsius];
    [self addSubview:storeImage];
    
//    [self aaa];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];

    MapAnnotation *mapAnnotation = self.annotation;
    MapModel *mapModel = nil;
    if ([mapAnnotation isKindOfClass:[mapAnnotation class]]) {
        mapModel = mapAnnotation.mapModel;
    }
    
    //NSString *imageUrl = mapModel.storeImage;
    
    //背景圖片
    self.image = [UIImage imageNamed:@"Map_Pin_Box.png"];
    
    //主文字
    mainTitle.frame = CGRectMake(0, 0, 90, 20);
    mainTitle.text = mapModel.title;
    
    //副文字
    subTitle.frame = CGRectMake(0, 20, 90, 20);
    //subTitle.text = mapModel.subTitle;
}


//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//    
//    if(selected)
//    {
//        //Add your custom view to self...
//        [self initViews];
//
//    }
//    else
//    {
//        //Remove your custom view...
//        [mainTitle removeFromSuperview];
//        [subTitle removeFromSuperview];
//        [celsius removeFromSuperview];
//        [storeImage removeFromSuperview];
//        self.image = nil;
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
