#import "WaiterSearcher.h"

@implementation WaiterSearcher

//static NSInteger instanceNo=0;

//建立實體
static WaiterSearcher *sharedInstance = nil;
+ (WaiterSearcher *) sharedInstance
{
    if(!sharedInstance)
        {
//        instanceNo++;
//        NSLog(@"WaiterSearcher instanceNo:%li",(long)instanceNo);
        sharedInstance = [[self alloc] init];
        }
    return sharedInstance;
}

- (void)dealloc
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

-(void)setNotification
{
    //註冊通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"closeToWaiter" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCurrentWaiter:) name:@"closeToWaiter" object:nil];
}

//初始化藍芽與其他數據（建立開始掃）
-(void)initBluetooth
{
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    self.nDevices = [[NSMutableArray alloc]init];
    self.sensorTags = [[NSMutableArray alloc]init];
}

#pragma make Bluetooth Method
/** 更新狀態
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state)
    {
        case CBCentralManagerStatePoweredOn:{
            // Scans for any periphera
            //Disabling this filtering can have an adverse effect on battery life and should be used only if necessary.
//            NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber  numberWithBool:YES], CBCentralManagerScanOptionAllowDuplicatesKey, nil];
            [self.centralManager  scanForPeripheralsWithServices:nil options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : [NSNumber  numberWithBool:YES]}];
            
            NSLog(@"Scanning started");
            break;
        }
        default:
        NSLog(@"Central Manager did change state");
        break;
        
    }
    
}

/** 發現周邊裝置後
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"Discovered %@ at %@", peripheral, RSSI);
    NSLog(@"-------------------------------------------------------");
    
    //自己增加的(目前無用)
    peripheral.delegate = self;
    //    [central connectPeripheral:peripheral options:nil];
    [self.nDevices addObject:peripheral];
    
//    self.rssiLabel.text=[NSString stringWithFormat:@"RSSI %@",[RSSI stringValue]];
    

    
    //重點是這行....越近數字越大(正常都是在0以下)
    if ([RSSI integerValue]>-50 && [RSSI integerValue]<0) {
        NSLog(@"夠近了！");
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"closeToWaiter" object:[peripheral.identifier UUIDString]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"closeToWaiter" object:self userInfo:@{ @"BluetoothIDKey" : [peripheral.identifier UUIDString] }];
    }
    
    //抓取某個BT4.0感應器identifier
//    if ([[peripheral.identifier UUIDString]isEqual:@"457F357A-4019-0E1C-8AE6-0E4058CE5123"]) {
        //移動到某個位置
//    }
    
}

/** 代理方法:取得連線名單
 */
-(NSArray *)getWhoIsFound
{
    
    return @[];
}

@end
