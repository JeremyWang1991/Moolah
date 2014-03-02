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
    self.votesDictionary = [[NSMutableDictionary alloc] init];
    
    
    
    
    for (int i = 0; i<self.tweetsArray.count;i++) {
        [self.votesDictionary setObject:[NSNumber numberWithInt:0] forKey:[[[self.tweetsArray objectAtIndex:i] objectForKey:@"id"] stringValue]];
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
    
    float percentage = [tweet2 intValue]/2232736.00;
    float milz = [tweet2 intValue]/1000.00;
    
    NSString *currency = [NSString stringWithFormat:@"$%.1f Million (%.3f%%)", milz,percentage];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    
    [cell.amountLabel setText:currency];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (nil == roundRectButtonPopTipView) {
        roundRectButtonPopTipView = [[CMPopTipView alloc] initWithMessage:@"I am getting data from the server and displaying that data into my tableviewcell. but i want to load only 10 records at a time. for this purpose i am using limit-offset thing. but i'm not very much clear how to do this in ios. I am setting those limit-offset in NSUrl."];
        roundRectButtonPopTipView.delegate = self;
        roundRectButtonPopTipView.backgroundColor = [UIColor lightGrayColor];
        roundRectButtonPopTipView.textColor = [UIColor darkTextColor];
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        [roundRectButtonPopTipView presentPointingAtView:cell inView:self.view animated:YES];
    }
    else {
        // Dismiss
        [roundRectButtonPopTipView dismissAnimated:YES];
        roundRectButtonPopTipView = nil;
    }
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

}

-(void) customCell:(UITableViewCell *)cell downBoated:(id)sender {
    int i = [self.tableView indexPathForCell:cell].row;
    
    [self.votesDictionary setObject:[NSNumber numberWithInt:-1] forKey:[[[self.tweetsArray objectAtIndex:i] objectForKey:@"id"] stringValue]];
}

-(void) customCell:(UITableViewCell *)cell infoPressed:(id)button {
    if (nil == roundRectButtonPopTipView) {
        roundRectButtonPopTipView = [[CMPopTipView alloc] initWithMessage:@"I am getting data from the server and displaying that data into my tableviewcell. but i want to load only 10 records at a time. for this purpose i am using limit-offset thing. but i'm not very much clear how to do this in ios. I am setting those limit-offset in NSUrl."];
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
    NSMutableDictionary *dicToSend = [[NSMutableDictionary alloc] init];
    [dicToSend setObject:self.votesDictionary forKey:@"votes"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [dicToSend setObject:[defaults objectForKey:@"UUID"] forKey:@"device_id"];
    
    
    
    
    
    //convert object to data
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dicToSend options:kNilOptions error:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://31bee7a9.ngrok.com/vote"];
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
@end
