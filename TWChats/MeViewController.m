//
//  MeViewController.m
//  TWChats
//
//  Created by lvjian on 12/17/14.
//  Copyright (c) 2014 lvjian. All rights reserved.
//

#import "MeViewController.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>

@interface MeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *currentUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"];
    self.nameLabel.text = [currentUser objectForKey:@"name"];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[currentUser objectForKey:@"avator_url"]]
                            placeholderImage:[UIImage imageNamed:@"default_avatar.png"]];

    self.avatarImageView.layer.borderWidth = 4;
    self.avatarImageView.layer.borderColor = [UIColor yellowColor].CGColor;
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2.0;

    self.avatarImageView.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
