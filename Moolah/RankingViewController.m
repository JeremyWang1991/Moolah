//
//  RankingViewController.m
//  Moolah
//
//  Created by Tse-Chi Wang on 3/1/2014.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "RankingViewController.h"
#import "GlobalVar.h"

@interface RankingViewController ()

@property bool voted;

@end

@implementation RankingViewController

CMPopTipView *roundRectButtonPopTipView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"fed_spending" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    self.tweetsArray = json;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.votesDictionary = (NSMutableDictionary *)[defaults objectForKey:@"votes"];
    if (!self.votesDictionary) {
        NSLog(@"%@", self.votesDictionary);
        self.votesDictionary = [[NSMutableDictionary alloc] init];
        for (int i = 0; i<self.tweetsArray.count;i++) {
            [self.votesDictionary setObject:[NSNumber numberWithInt:0] forKey:[[[self.tweetsArray objectAtIndex:i] objectForKey:@"id"] stringValue]];
        }
    }
    
 
    
}

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView {
    // User can tap CMPopTipView to dismiss it
    roundRectButtonPopTipView = nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tweetsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SettingsCell";
    
    RankingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[RankingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
    }
    
    NSString *tweet = [[self.tweetsArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    [cell.mainLabel setText:[NSString stringWithFormat:@"%d. %@", indexPath.row+1,tweet]];
    
    NSNumber *voteStatus = [self.votesDictionary objectForKey:[[[self.tweetsArray objectAtIndex:indexPath.row] objectForKey:@"id"] stringValue]];
    if(voteStatus.intValue==0) {
        [cell.upBoat setSelected:NO];
        [cell.downBoat setSelected:NO];
    }
    
    if(voteStatus.intValue==1) {
        [cell.upBoat setSelected:YES];
        [cell.downBoat setSelected:NO];
    }
    
    if(voteStatus.intValue==-1) {
        [cell.upBoat setSelected:NO];
        [cell.downBoat setSelected:YES];
    }
    
    NSNumber *tweet2 = [[self.tweetsArray objectAtIndex:indexPath.row] objectForKey:@"amount"];
    
    float percentage = [tweet2 intValue]/1732736.00;
    float milz = [tweet2 intValue]/1000.00;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    if (milz < 25) {
        [numberFormatter setMaximumFractionDigits:2];
    } else {
        [numberFormatter setMaximumFractionDigits:0];
    }
    
    NSString *monies = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:milz]];
    
    NSString *currency = [[NSString alloc] init];
    
    if (milz < 1500) {
        currency = [NSString stringWithFormat:@"~%@ M (%.3f%%)", monies,percentage];
    } else {
        currency = [NSString stringWithFormat:@"%@ M (%.1f%%)", monies,percentage];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    
    [cell.amountLabel setText:currency];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (nil == roundRectButtonPopTipView) {
//        roundRectButtonPopTipView = [[CMPopTipView alloc] initWithMessage:@"I am getting data from the server and displaying that data into my tableviewcell. but i want to load only 10 records at a time. for this purpose i am using limit-offset thing. but i'm not very much clear how to do this in ios. I am setting those limit-offset in NSUrl."];
//        roundRectButtonPopTipView.delegate = self;
//        roundRectButtonPopTipView.backgroundColor = [UIColor lightGrayColor];
//        roundRectButtonPopTipView.textColor = [UIColor darkTextColor];
//        
//        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//        
//        [roundRectButtonPopTipView presentPointingAtView:cell inView:self.view animated:YES];
//    }
//    else {
//        // Dismiss
//        [roundRectButtonPopTipView dismissAnimated:YES];
//        roundRectButtonPopTipView = nil;
//    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (nil != roundRectButtonPopTipView) {

    [roundRectButtonPopTipView dismissAnimated:YES];
    roundRectButtonPopTipView = nil;
    }
}



-(void) customCell:(UITableViewCell *)cell upBoated:(id)sender {
    int i = [self.tableView indexPathForCell:cell].row;

    [self.votesDictionary setObject:[NSNumber numberWithInt:1] forKey:[[[self.tweetsArray objectAtIndex:i] objectForKey:@"id"] stringValue]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.votesDictionary forKey:@"votes"];

    
}

-(void) customCell:(UITableViewCell *)cell downBoated:(id)sender {
    int i = [self.tableView indexPathForCell:cell].row;
    
    [self.votesDictionary setObject:[NSNumber numberWithInt:-1] forKey:[[[self.tweetsArray objectAtIndex:i] objectForKey:@"id"] stringValue]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.votesDictionary forKey:@"votes"];
}

-(void) customCell:(UITableViewCell *)cell infoPressed:(id)button {
    if (nil == roundRectButtonPopTipView) {
        NSString *msg = [[self.tweetsArray objectAtIndex:[[self.tableView indexPathForCell:cell] row]] objectForKey:@"description"];
        
        
        roundRectButtonPopTipView = [[CMPopTipView alloc] initWithMessage: msg];
        roundRectButtonPopTipView.delegate = self;
        roundRectButtonPopTipView.backgroundColor = [UIColor lightGrayColor];
        roundRectButtonPopTipView.textColor = [UIColor darkTextColor];
        
        [roundRectButtonPopTipView presentPointingAtView:cell inView:self.view animated:YES];
    }
    else {
        // Dismiss
        [roundRectButtonPopTipView dismissAnimated:YES];
        roundRectButtonPopTipView = nil;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)submitPressed:(id)sender {
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat screenWidth = screenRect.size.width;
//    CGFloat screenHeight = screenRect.size.height;
//    self.bgOverlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
//    [self.bgOverlay setBackgroundColor:[UIColor blackColor]];
//    [self.bgOverlay setAlpha:0];
//    self.censusView = [[UIView alloc] initWithFrame:CGRectMake(35, 60, 250, 300)];
//    [self.censusView setBackgroundColor:[UIColor whiteColor]];
//    [self.censusView setAlpha:0];
//    self.censusView.layer.cornerRadius = 20;
//    [self.view addSubview:self.bgOverlay];
//    [self.view addSubview:self.censusView];
//    [UIView animateWithDuration:0.3 animations:^{
//        [self.bgOverlay setAlpha:0.5];
//        [self.censusView setAlpha:1.0];
//    }];
//    
//    UILabel *requestCensus = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 190, 200)];
//    requestCensus.numberOfLines = 0;
//    requestCensus.textAlignment = NSTextAlignmentCenter;
//    requestCensus.text = @"Would you like to submit some demographic data along with your feedback?";
//    [requestCensus sizeToFit];
//    [self.censusView addSubview:requestCensus];
//    
//    UIButton *censusYes = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    censusYes.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [censusYes setTitle:@"Sure thing" forState:UIControlStateNormal];
//    censusYes.frame = CGRectMake(30, 130, 190, 30);
//    [self.censusView addSubview:censusYes];
    
//    UIPickerView *picker = [[UIPickerView alloc] init];
//    
//    
//    UIButton *censusNo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    censusNo.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [censusNo setTitle:@"No thanks, go without" forState:UIControlStateNormal];
//    censusNo.frame = CGRectMake(30, 180, 190, 30);
//    [self.censusView addSubview:censusNo];
//    [censusNo addTarget:self action:@selector(submitData) forControlEvents:UIControlEventTouchUpInside];
//    [censusNo addTarget:self action:@selector(removeCensusView) forControlEvents:UIControlEventTouchUpInside];
    
    self.voted = NO;
    for (NSString *key in self.votesDictionary) {
        if ([self.votesDictionary objectForKey:key] != [NSNumber numberWithInt:0]) {
            self.voted = YES;
        }
    }
    
    if (self.voted == YES) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Submit Feedback?"
                                                          message:@"Submit your feedback to the platform and see what others are saying?"
                                                         delegate:self
                                                cancelButtonTitle:@"Not yet"
                                                otherButtonTitles:@"Yes", nil];
        [message show];
    } else {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Proceed?"
                                                          message:@"Proceed to the community view without submitting any feedback?"
                                                         delegate:self
                                                cancelButtonTitle:@"No"
                                                otherButtonTitles:@"Yes", nil];
        [message show];
    }

    
//    [self submitData];
    
}

- (void)removeCensusView {
    for (UIView *view in @[self.bgOverlay, self.censusView]) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             [view setAlpha:0];
                         }
                         completion:^(BOOL finished) {
                             [view removeFromSuperview];
                         }];
    }
}

- (void)submitData {
    NSMutableDictionary *dicToSend = [[NSMutableDictionary alloc] init];
    [dicToSend setObject:self.votesDictionary forKey:@"votes"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [dicToSend setObject:[defaults objectForKey:@"UUID"] forKey:@"device_id"];
    
    //convert object to data
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dicToSend options:kNilOptions error:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://micfok-opendata.herokuapp.com/vote"];
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"POST"];
    
    [rq setHTTPBody:jsonData];
    
    [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [rq setValue:[NSString stringWithFormat:@"%ld", (long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    
    [NSURLConnection sendAsynchronousRequest:rq queue:queue completionHandler:^(NSURLResponse *rsp, NSData *data, NSError *err) {
        NSLog(@"POST sent!");
    }];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld", (long)buttonIndex);
    if (buttonIndex == 1) {
        if (self.voted == YES) {
            [self submitData];
        }
        //push to community view
        RankingViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CommunityViewController"];
//        [self.navigationController presentViewController:vc animated: completion:Nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint locationPoint = [[touches anyObject] locationInView:self.view];
    UIView* touchedView = [self.view hitTest:locationPoint withEvent:event];
    if (touchedView == self.bgOverlay) {
        [self removeCensusView];
    }
}

@end
