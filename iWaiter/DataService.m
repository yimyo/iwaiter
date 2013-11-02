//
//  DataService.m
//  Glympse
//
//  Created by RedScor Yuan on 13-4-22.
//  Copyright (c) 2012年 http://redscor.github.io  All rights reserved.
//

#import "DataService.h"
#import "ASIFormDataRequest.h"

@implementation DataService

//test 用
+ (void)getData:(NSDictionary *)params callBlock:(CompleteBlock)block
{
	NSString *url = @"http://data.taipei.gov.tw/opendata/apply/json/MDY2RERBMTctQTE4Mi00OEU5LUI2M0YtRTg0NTQ1NUEzM0Mw";
	[self startRequest:nil url:url finishBlock:block];
}

//Google 搜尋地點
/*
 網址 https://maps.googleapis.com/maps/api/place/textsearch/json?query=+
使用者輸入文字(URL_UTF8轉碼過) + "&sensor=true&key=" + BROWSER_KEY
"&sensor=true&key=" +
BROWSER_KEY = AIzaSyDiDv8QPGDxmpqspZyBtPvwgJXxZBTDU2I
*/

#define BROSWER_KEY @"AIzaSyDiDv8QPGDxmpqspZyBtPvwgJXxZBTDU2I"
#define GoogleUrl @"https://maps.googleapis.com/maps/api/place/textsearch/json?query="
+ (void)googleSearchInfo:(NSDictionary *)params callBlock:(CompleteBlock)block
{
	NSString *userInputText = [params objectForKey:@"text"];
	float lat = [[[NSUserDefaults standardUserDefaults]objectForKey:@"lat"]floatValue];
	float lng = [[[NSUserDefaults standardUserDefaults]objectForKey:@"lng"]floatValue];

	
	
	NSString *sUrl = [NSString stringWithFormat:@"%@%@&location=%f,%f&radius=5000&rankby=distance&language=zhTW&sensor=true&key=%@",GoogleUrl,userInputText,lat,lng,BROSWER_KEY];
	
	[self startRequest:nil url:sUrl finishBlock:block];
	
}

#pragma mark -
#pragma mark - 發送網路請求並解析數據
+ (void)startRequest:(NSDictionary *)params
				 url:(NSString *)urlString
		 finishBlock:(CompleteBlock)block{
	
	//新建一個網路請求,__block 避免重複retain
    ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
	
	if (params == nil) {
		[request setRequestMethod:@"GET"];
		//加密
	//	[request addRequestHeader:@"X-test-Good" value:(NSString*)generateCheckValue(urlString,@"")];
		
	}else{
		[request setRequestMethod:@"POST"];
		for (NSString *key in params) {
			NSString *value = [params objectForKey:key];
			[request setPostValue:value forKey:key];
		}
	}
	
	[request setTimeOutSeconds:60];
	//網路完成後調用的Block
	[request setCompletionBlock:^{
		//印出解析的JSON字串
//		NSString *responesString = request.responseString;
//		NSLog(@"URL : %@",request.url);
//		NSLog(@"JSON : %@",responesString);
		
		//獲取加載完後的數據
		NSData *responseData = [request responseData];
//		UIDevice *device = [UIDevice currentDevice];//當前設備
//		NSString *version =[device systemVersion]; //當前設備系統版本
		
		id ret = nil;
		
		//判斷是否支持iOS 5 的JSON解析方法
		if (NSClassFromString(@"NSJSONSerialization")) {
			//調用內建iOS JSON解析函數
			NSError *error = nil;
			
			/*
			 * ============options 值有三種=============
			 * NSJSONReadingMutableLeaves		輸出Mutable型態的NSString
			 * NSJSONReadingMutableContainers	輸出Mutable型態的Dictionary or Array
			 * NSJSONReadingAllowFragments		表示允許最外層的root object不為NSArray或者								NSDictionary
			 */
			ret = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
		}else{
			//5.0以下調用JSONKit解析
			//ret = [responseData objectFromJSONData];
		}
		
		//回調(block)解析後的數據 誰調用該方法 數據就回調給誰
		//NSLog(@"ret = %@",ret);
		block(ret);
		//將block釋放 否則會造成循環引用(有COPY才需要釋放)
		//	Block_release(block);
	}];
	
	//失敗調用的Block
	[request setFailedBlock:^{
		
		block(nil);
	//	Block_release(block);


	}];
	[request startAsynchronous];
}


@end
