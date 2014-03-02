//
//  SingletonState.m
//  ZombieGame
//
//  Created by Tse-Chi Wang on 12-08-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GlobalVar.h"

@implementation GlobalVar

- (id) init
{
    self = [super init]; 
	self.Inventory = [[NSMutableDictionary alloc] init];
    return self;
}

+(GlobalVar*)sharedInstance
{
    static GlobalVar *sharedInstance;
    
    @synchronized(self)
    {
        if(!sharedInstance)
        {
            sharedInstance = [[GlobalVar alloc] init];
            sharedInstance.Inventory = [[NSMutableDictionary alloc] init];

        }
    }
    
    return sharedInstance;
}

-(void)dealloc
{
}

@end
