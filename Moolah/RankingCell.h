//
//  RankingCell.h
//  Moolah
//
//  Created by Tse-Chi Wang on 3/1/2014.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankingViewController.h"
#import "Ranking.h"


@interface RankingCell : UITableViewCell{
}
@property (strong, nonatomic) UILabel *mainLabel;
@property (strong, nonatomic) UILabel *amountLabel;

@property (strong, nonatomic) UIButton *upBoat;
@property (strong, nonatomic) UIButton *downBoat;
@property (strong, nonatomic) UIButton *infoButton;

@property (nonatomic, assign) id<Ranking> delegate;

@end

