//
//  RankingCell.m
//  Moolah
//
//  Created by Tse-Chi Wang on 3/1/2014.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "RankingCell.h"
#define FONT_SOHO_STD(s) [UIFont fontWithName:@"Nexa Bold" size:s]



@implementation RankingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGSize size = self.contentView.frame.size;
        
        // Initialize Main Label
        self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0, 8.0, size.width-80, 10)];
        self.mainLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.mainLabel.numberOfLines = -1;
        // Configure Main Label
        [self.mainLabel setFont:FONT_SOHO_STD(20)];
        [self.mainLabel setTextAlignment:NSTextAlignmentLeft];
        [self.mainLabel setTextColor:[UIColor colorWithRed:83.00/255.00 green:83.00/255.00 blue:83.00/255.00 alpha:1]];
        [self.mainLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        
        // Initialize Amount Label
        self.amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 28.0, size.width-100.0, size.height - 6.0)];
        [self.amountLabel setTextAlignment:NSTextAlignmentLeft];
        self.amountLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.amountLabel.numberOfLines = 1;
        [self.amountLabel setFont:FONT_SOHO_STD(14)];
        [self.amountLabel setTextColor:[UIColor colorWithRed:128.88/255.00 green:128.88/255.00 blue:128.88/255.00 alpha:1]];
        [self.amountLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        
        // Initialize Boats
        self.upBoat = [UIButton buttonWithType:UIButtonTypeCustom];
        self.upBoat.frame = CGRectMake(12, 18, 31, 21);
        [self.upBoat setBackgroundImage:[UIImage imageNamed: @"upvote.png"] forState:UIControlStateNormal];
        [self.upBoat setBackgroundImage:[UIImage imageNamed: @"upvoteOn.png"] forState:UIControlStateSelected];
        self.upBoat.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        [self.upBoat addTarget:self action:@selector(upBoatPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.downBoat = [UIButton buttonWithType:UIButtonTypeCustom];
        self.downBoat.frame = CGRectMake(12, 52, 31, 21);
        [self.downBoat setBackgroundImage:[UIImage imageNamed: @"downvote.png"] forState:UIControlStateNormal];
        [self.downBoat setBackgroundImage:[UIImage imageNamed: @"downvoteOn.png"] forState:UIControlStateSelected];
        self.downBoat.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        [self.downBoat addTarget:self action:@selector(downBoatPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.infoButton.frame = CGRectMake(size.width-80, 52, 31, 21);
        [self.infoButton setBackgroundImage:[UIImage imageNamed: @"downvote.png"] forState:UIControlStateNormal];
        [self.infoButton addTarget:self action:@selector(infoPressed:) forControlEvents:UIControlEventTouchUpInside];

        // Add Labels to Content View
        [self.contentView addSubview:self.mainLabel];
        [self.contentView addSubview:self.amountLabel];
        [self.contentView addSubview:self.upBoat];
        [self.contentView addSubview:self.downBoat];
        [self.contentView addSubview:self.infoButton];
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

- (void) infoPressed:(id)sender {
    [self.delegate customCell:self infoPressed:sender];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
