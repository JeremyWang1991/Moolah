//
//  RankingViewController.m
//  Moolah
//
//  Created by Tse-Chi Wang on 3/1/2014.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "RankingViewController.h"
#import "RankingCell.h"

@interface RankingViewController ()

@end

@implementation RankingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"fed_spending" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    self.tweetsArray = json;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tweetsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SettingsCell";
    
    RankingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[RankingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

    }

    NSString *tweet = [[self.tweetsArray objectAtIndex:indexPath.row] objectForKey:@"program"];
    [cell.mainLabel setText:tweet];
    
    NSNumber *tweet2 = [[self.tweetsArray objectAtIndex:indexPath.row] objectForKey:@"amount"];
    
    NSString *currency = [NSString stringWithFormat:@"$%d", [tweet2 intValue]];

    
    [cell.amountLabel setText:currency];
    
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
