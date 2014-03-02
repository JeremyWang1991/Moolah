//
//  rootViewController.m
//  Moolah
//
//  Created by Michael Fok on 3/2/2014.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "rootViewController.h"
#import "TutorialViewController.h"

@interface rootViewController ()

@end

@implementation rootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Boolean didTutorial = (Boolean)[defaults objectForKey:@"didTutorial"];
    if (!didTutorial) {
        [defaults setBool:YES forKey:@"didTutorial"];
        TutorialViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialViewController"];
        [self.navigationController presentViewController:vc animated:NO completion:Nil];
    }

    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor whiteColor],UITextAttributeTextColor, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)unwindtoViewController:(UIStoryboardSegue *)segue
{
    NSLog(@"unwindtoViewController triggered");
}

@end
