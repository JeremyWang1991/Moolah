//
//  PageContentViewController.h
//  Moolah
//
//  Created by Michael Fok on 3/1/2014.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

//UI
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

//Properties
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;


@end
