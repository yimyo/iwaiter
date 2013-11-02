//
//  DetailMessageCell.h
//  iWaiter
//
//  Created by RedScor Yuan on 2013/11/1.
//  Copyright (c) 2013年 RedScor Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeLineView.h"

@interface DetailMessageCell : UITableViewCell
{
    UILabel *messageLabel;
    UIView *dateView;
    UILabel *dateLabel;
    TimeLineView *timeLineView;
}

@end
