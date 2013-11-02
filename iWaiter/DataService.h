//
//  DataService.h
//  Glympse
//
//  Created by RedScor Yuan on 13-4-22.
//  Copyright (c) 2012年 http://redscor.github.io  All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompleteBlock)(id data);

@interface DataService : NSObject

@property (copy, nonatomic) CompleteBlock completeBlock;

+ (void)startRequest:(NSDictionary *)params url:(NSString *)urlString finishBlock:(CompleteBlock)block;
+ (void)getData:(NSDictionary *)params callBlock:(CompleteBlock)block;
+ (void)googleSearchInfo:(NSDictionary *)params callBlock:(CompleteBlock)block;

@end
