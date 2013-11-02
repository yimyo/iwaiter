//
//  DetailMessageCell.m
//  iWaiter
//
//  Created by RedScor Yuan on 2013/11/1.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import "DetailMessageCell.h"

@implementation DetailMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initTextView];
    }
    return self;
}

- (void)_initTextView
{
    messageLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.textColor = RGB(57,57,57);
    [self.contentView addSubview:messageLabel];
    
    dateLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.textColor = [UIColor whiteColor];
    
    timeLineView = [[TimeLineView alloc]initWithFrame:CGRectZero];
    timeLineView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:timeLineView];
    
    dateView = [[UIView alloc]initWithFrame:CGRectZero];
    dateView.backgroundColor = RGB(255, 89, 95);

    [self.contentView addSubview:dateView];
    [dateView addSubview:dateLabel];


    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //timeLine 線
    timeLineView.frame = CGRectMake(0, 0, 50, self.frame.size.height);
    
    //date label
    dateView.frame = CGRectMake(30, 10, 40, 40);
    dateView.layer.cornerRadius = roundf(dateView.frame.size.width / 2);
    dateView.layer.masksToBounds = YES;
    
    
}



@end
