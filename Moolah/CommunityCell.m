//
//  CommunityCell.m
//  Moolah
//
//  Created by Tse-Chi Wang on 3/1/2014.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "CommunityCell.h"
#define FONT_SOHO_STD(s) [UIFont fontWithName:@"Nexa Bold" size:s]

@implementation CommunityCell

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
        
        // Initialize Score Label
        self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 5.0, 50, size.height - 6.0)];
        [self.scoreLabel setTextAlignment:NSTextAlignmentCenter];
        self.scoreLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.scoreLabel.numberOfLines = 1;
        [self.scoreLabel setFont:FONT_SOHO_STD(30)];
        [self.scoreLabel setTextColor:[UIColor colorWithRed:83/255.00 green:83/255.00 blue:83/255.00 alpha:1]];
        [self.scoreLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        
        // Initialize Score Label
        self.upvoteLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, -3.0, 50, size.height/2 - 10.0)];
        [self.upvoteLabel setTextAlignment:NSTextAlignmentCenter];
        self.upvoteLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.upvoteLabel.numberOfLines = 1;
        [self.upvoteLabel setFont:FONT_SOHO_STD(12)];
        [self.upvoteLabel setTextColor:[UIColor orangeColor]];
        [self.upvoteLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        
        // Initialize Score Label
        self.downvoteLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 38.0, 50, size.height/2 - 10.0)];
        [self.downvoteLabel setTextAlignment:NSTextAlignmentCenter];
        self.downvoteLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.downvoteLabel.numberOfLines = 1;
        [self.downvoteLabel setFont:FONT_SOHO_STD(12)];
        [self.downvoteLabel setTextColor:[UIColor blueColor]];
        [self.downvoteLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        
        // Add Labels to Content View
        [self.contentView addSubview:self.mainLabel];
        [self.contentView addSubview:self.amountLabel];
        [self.contentView addSubview:self.scoreLabel];
        [self.contentView addSubview:self.upvoteLabel];
        [self.contentView addSubview:self.downvoteLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
