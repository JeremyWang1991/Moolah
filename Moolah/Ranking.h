//
//  Ranking.h
//  Moolah
//
//  Created by Tse-Chi Wang on 3/1/2014.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RankingCell.h"

@protocol Ranking
-(void)customCell:(UITableViewCell*)cell upBoated:(id)button;
-(void)customCell:(UITableViewCell*)cell downBoated:(id)button;
-(void)customCell:(UITableViewCell*)cell infoPressed:(id)button;

@end