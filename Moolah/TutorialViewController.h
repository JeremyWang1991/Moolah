//
//  TutorialViewController.h
//  Moolah
//
//  Created by Michael Fok on 3/1/2014.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface TutorialViewController : UIViewController <UIPageViewControllerDataSource>

- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;


@end
