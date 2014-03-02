//
//  CommunityViewController.h
//  Moolah
//
//  Created by Tse-Chi Wang on 3/1/2014.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweetsArray;
@property (strong, nonatomic) NSArray *json;
@property (strong, nonatomic) NSMutableDictionary *votesDictionary;

@end
