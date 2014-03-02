//
//  CommunityCell.h
//  Moolah
//
//  Created by Tse-Chi Wang on 3/1/2014.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityCell : UITableViewCell {
}
@property (strong, nonatomic) UILabel *mainLabel;
@property (strong, nonatomic) UILabel *amountLabel;

@property (strong, nonatomic) UILabel *scoreLabel;
@property (strong, nonatomic) UILabel *upvoteLabel;
@property (strong, nonatomic) UILabel *downvoteLabel;

@end

