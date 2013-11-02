#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface WaiterSearcher : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *centralManager;
//@property (nonatomic, strong) NSMutableData *data;
@property (strong, nonatomic) CBPeripheral *discoveredPeripheral;

//@property (strong,nonatomic) UILabel *rssiLabel;
//@property (strong, nonatomic) UIView *boxView;

@property (strong,nonatomic) NSMutableArray *nDevices;
@property (strong,nonatomic) NSMutableArray *sensorTags;

@property (strong,nonatomic) NSString *currentWaiterCloseToPhone;

+ (WaiterSearcher *) sharedInstance;
-(void)initBluetooth;
@end
