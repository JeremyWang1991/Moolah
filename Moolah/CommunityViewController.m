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
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SettingsCell";
    
    CommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[CommunityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *tweet = [[self.tweetsArray objectAtIndex:indexPath.row] objectForKey:@"score"];
    [cell.mainLabel setText:tweet];
    
    
    NSNumber *tweet2 = [[self.tweetsArray objectAtIndex:indexPath.row] objectForKey:@"amount"];
    
    float percentage = [tweet2 intValue]/2232736.00;
    float milz = [tweet2 intValue]/1000.00;
    
    NSString *currency = [NSString stringWithFormat:@"$%.1f Million\n(%.2f%%)", milz,percentage];
    
    
    [cell.amountLabel setText:currency];
    
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
