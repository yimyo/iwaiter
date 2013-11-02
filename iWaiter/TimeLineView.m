//
//  TimeLineView.m
//  iWaiter
//
//  Created by RedScor Yuan on 2013/11/1.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import "TimeLineView.h"

@implementation TimeLineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx, 2.0);
    CGContextSetStrokeColorWithColor(ctx, RGB(202, 202, 202).CGColor);
    
    CGContextMoveToPoint(ctx, self.frame.size.width, self.frame.size.height);
    
    CGContextAddLineToPoint(ctx, 50, 0);
    
    CGContextStrokePath(ctx);

}


@end
