//
//  RankingCell.m
//  Moolah
//
//  Created by Tse-Chi Wang on 3/1/2014.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "RankingCell.h"

@implementation RankingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGSize size = self.contentView.frame.size;
        
        // Initialize Main Label
        self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0, 8.0, size.width/2, size.height - 16.0)];
        self.mainLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.mainLabel.numberOfLines = -1;
        // Configure Main Label
        [self.mainLabel setFont:[UIFont boldSystemFontOfSize:12]];
        [self.mainLabel setTextAlignment:NSTextAlignmentLeft];
        [self.mainLabel setTextColor:[UIColor orangeColor]];
        [self.mainLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        
        // Initialize Amount Label
        self.amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8.0, size.width-8.0, size.height - 16.0)];
        [self.amountLabel setTextAlignment:NSTextAlignmentRight];
        self.amountLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.amountLabel.numberOfLines = -1;
        [self.amountLabel setFont:[UIFont boldSystemFontOfSize:12]];
        [self.amountLabel setTextColor:[UIColor orangeColor]];
        [self.amountLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        
        // Initialize Boats
        self.upBoat = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.upBoat.frame = CGRectMake(0, 0, 50, 50);
        [self.upBoat setTitle:@"U" forState:UIControlStateNormal];
        [self.upBoat setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.upBoat setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        self.upBoat.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        [self.upBoat addTarget:self action:@selector(upBoatPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.downBoat = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.downBoat.frame = CGRectMake(0, size.height-4, 50, 50);
        [self.downBoat setTitle:@"D" forState:UIControlStateNormal];
        [self.downBoat setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.downBoat setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.downBoat.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        [self.downBoat addTarget:self action:@selector(downBoatPressed:) forControlEvents:UIControlEventTouchUpInside];

        // Add Labels to Content View
        [self.contentView addSubview:self.mainLabel];
        [self.contentView addSubview:self.amountLabel];
        [self.contentView addSubview:self.upBoat];
        [self.contentView addSubview:self.downBoat];
    }
    return self;
}

- (void) upBoatPressed:(id)sender {
    UIButton *button = sender;
    [self.downBoat setSelected:NO];
    [button setSelected:YES];
    
    [self.delegate customCell:self upBoated:sender];
}

- (void) downBoatPressed:(id)sender {
    UIButton *button = sender;
    [self.upBoat setSelected:NO];
    [button setSelected:YES];
    
    [self.delegate customCell:self downBoated:sender];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
