#import <Foundation/Foundation.h>

@interface GlobalVar : NSObject
{
}

@property (nonatomic, retain) NSMutableArray *Inventory;

+ (GlobalVar*)sharedInstance;

@end
