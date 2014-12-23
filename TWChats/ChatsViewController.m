#import "ChatsViewController.h"
#import "UIImageView+WebCache.h"
#import "TPKeyboardAvoidingScrollView.h"
#import <Firebase/Firebase.h>

@interface ChatsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *messages;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@end

@implementation ChatsViewController  {
    NSDictionary *currentUser;
    Firebase *fb;
};

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = [self.chatWith objectForKey:@"name"];

    currentUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"];
    self.messages = [NSMutableArray arrayWithCapacity:12];
    self.messageField.delegate = self;

    self.automaticallyAdjustsScrollViewInsets = NO;

//    NSLog(@"scrollView: %@", [self.scrollView contentSize]);
    [self.scrollView contentSizeToFit];
    [self.scrollView setContentSize: [UIScreen mainScreen].bounds.size];

    self.scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50);
    self.bottomView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50,
            [UIScreen mainScreen].bounds.size.width, 50);

    NSLog(@"bottomSize: %f", self.bottomView.bounds.size.height);
    NSLog(@"tableView Point:(%f, %f)", self.tableView.bounds.origin.x, self.tableView.bounds.origin.y);
    NSLog(@"tableView: %f", self.tableView.bounds.size.height);
    NSLog(@"scrollView: %f", [self.scrollView contentSize].height);
    NSLog(@"nav: %f", self.navigationItem.titleView.frame.size.height);
    NSLog(@"screenHeight: %f", [UIScreen mainScreen].bounds.size.height);


    fb = [[Firebase alloc] initWithUrl:@"https://saochats.firebaseio.com/"];

    [fb observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        if (snapshot == nil) {
            return;
        }
        
        NSDictionary *msg = snapshot.value;
        
        
        
        NSLog(@"%@", msg);
        
        if ([msg[@"sender"] isEqualToString:_chatWith[@"name"]]
                        || [msg[@"to"] isEqualToString:currentUser[@"name"]]) {
            NSLog(@"%@", msg);
            NSLog(@"--currentName: %@", currentUser[@"name"]);
            NSLog(@"--chatWith: %@", _chatWith[@"name"]);
            
            [self.messages addObject:msg];
            [self.tableView reloadData];
        }
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)handleSendAction:(id)sender {

    NSString *content = [self.messageField.text copy];
    NSLog(@"send: %@", content);
    self.messageField.text = @"";

    NSDictionary *message = @{
            @"userId": [currentUser objectForKey:@"id"],
            @"sender": [currentUser objectForKey:@"name"],
            @"to": [_chatWith objectForKey:@"name"],
            @"avator_url": [currentUser objectForKey:@"avator_url"],
            @"text": content
    };

    [fb setValue:message];

    [self.messages addObject:message];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[_messages count] - 1 inSection:0]
                          atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"idMessageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier
                                                            forIndexPath:indexPath];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:identifier];
    }

    NSDictionary *msg = [self.messages objectAtIndex:indexPath.row];

    NSString *sender = [msg objectForKey:@"sender"];
    cell.textLabel.text = [msg objectForKey:@"text"];
    cell.detailTextLabel.text = sender;
    [cell.imageView sd_setImageWithURL:[msg objectForKey:@"avator_url"]
                      placeholderImage:[UIImage imageNamed:@"default_avatar.png"]];

    if ([sender isEqualToString:[currentUser objectForKey:@"name"]]) {
        cell.textLabel.textColor = [UIColor grayColor];
    } else {
        cell.textLabel.textColor = [UIColor greenColor];
    }

    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
