//
//  RankingViewController.h
//  Moolah
//
//  Created by Tse-Chi Wang on 3/1/2014.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankingCell.h"
#import "Ranking.h"


@interface RankingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, Ranking, UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweetsArray;
@property (strong, nonatomic) NSMutableDictionary *votesDictionary;
- (IBAction)submitPressed:(id)sender;

//UI
@property (strong, nonatomic) UIView * bgOverlay;
@property (strong, nonatomic) UIView * censusView;

@property (strong, nonatomic) UILabel * gender;
@property (strong, nonatomic) UIPickerView * picker;

@end
