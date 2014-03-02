#import "CommunityViewController.h"
#import "CommunityCell.h"

@interface CommunityViewController ()

@end

@implementation CommunityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
	self.tableView.delegate = self;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"fed_spending" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://micfok-opendata.herokuapp.com/community"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                         timeoutInterval:30.0];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *zata,
                                               NSError *connectionError) {
                                   self.json = [NSJSONSerialization JSONObjectWithData:zata options:kNilOptions error:nil];
                               self.tweetsArray = self.json;

                               NSLog(@"Returned");
                               [self.tableView reloadData];
                           }];
    
//    self.votesDictionary = [[NSMutableDictionary alloc] init];
//    
//    
//    
//    
//    for (int i = 0; i<self.tweetsArray.count;i++) {
//        [self.votesDictionary setObject:[NSNumber numberWithInt:0] forKey:[[[self.tweetsArray objectAtIndex:i] objectForKey:@"id"] stringValue]];
//    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tweetsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SettingsCell";
    
    CommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[CommunityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *tweet = [[self.tweetsArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    [cell.mainLabel setText:tweet];
    
    
    NSNumber *tweet2 = [[self.tweetsArray objectAtIndex:indexPath.row] objectForKey:@"amount"];
    
    float percentage = [tweet2 intValue]/2232736.00;
    float milz = [tweet2 intValue]/1000.00;
    
//    NSString *currency = [NSString stringWithFormat:@"$%.1f Million\n(%.2f%%)", milz,percentage];
    
//    float percentage = [tweet2 intValue]/2232736.00;
//    float milz = [tweet2 intValue]/1000.00;
    
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
    
    
    
    NSString *tweet3 = [[self.tweetsArray objectAtIndex:indexPath.row] objectForKey:@"score"];
    [cell.scoreLabel setText:tweet3];

    [cell.amountLabel setText:currency];
    
    int upvotes = [[[self.tweetsArray objectAtIndex:indexPath.row] objectForKey:@"upvotes"] intValue];
    
    NSString *upvoteString = [NSString stringWithFormat:@"+%d", upvotes];
    
    [cell.upvoteLabel setText:upvoteString];
    
    int downvotes = [[[self.tweetsArray objectAtIndex:indexPath.row] objectForKey:@"downvotes"] intValue];
    
    NSString *downvoteString = [NSString stringWithFormat:@"-%d", downvotes];
    
    [cell.downvoteLabel setText:downvoteString];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
