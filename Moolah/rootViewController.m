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
//        [defaults setBool:YES forKey:@"didTutorial"];
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        LoginViewController * vc = (LoginViewController *)[sb instantiateViewControllerWithIdentifier:@"login"];
        TutorialViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialViewController"];
        
        [self presentViewController:vc animated:NO completion:Nil];
        //        [self.navigationController presentViewController:vc animated:NO completion:nil];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
