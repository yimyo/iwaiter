//
//  BaseModel.h
//  RedScor
//  所有對象實體的Root Class
//  Created by RedScor Yuan on 13-4-22.
//  Copyright (c) 2012年 http://redscor.github.io  All rights reserved.
//




#import <Foundation/Foundation.h>

@interface BaseModel :NSObject <NSCoding> {
    
}
- (id)initWithDataDic:(NSDictionary*)data;
- (NSDictionary*)attributeMapDictionary;
- (void)setAttributes:(NSDictionary*)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData*)getArchivedData;

- (NSString *)CleanString:(NSString *)str; //清除\n和\r的字符串

@end

