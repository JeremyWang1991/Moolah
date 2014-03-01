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
        self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, 8.0, size.width/2, size.height - 16.0)];
        self.mainLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.mainLabel.numberOfLines = -1;
        // Configure Main Label
        [self.mainLabel setFont:[UIFont boldSystemFontOfSize:12]];
        [self.mainLabel setTextAlignment:NSTextAlignmentLeft];
        [self.mainLabel setTextColor:[UIColor orangeColor]];
        [self.mainLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        
        // Initialize Amount Label
        self.amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, 8.0, size.width-16.0, size.height - 16.0)];
        [self.amountLabel setTextAlignment:NSTextAlignmentRight];
        self.amountLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.amountLabel.numberOfLines = -1;
        [self.amountLabel setFont:[UIFont boldSystemFontOfSize:12]];
        [self.amountLabel setTextColor:[UIColor orangeColor]];
        [self.amountLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        
        // Initialize Boats
        self.upBoat = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.upBoat.frame = CGRectMake(8, 8, 50, 50);
        [self.upBoat setTitle:@"U" forState:UIControlStateNormal];
        [self.upBoat setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.upBoat.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        
        // Add Labels to Content View
        [self.contentView addSubview:self.mainLabel];
        [self.contentView addSubview:self.amountLabel];
        [self.contentView addSubview:self.upBoat];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
