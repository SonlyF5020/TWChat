//
//  MainViewController.m
//  TWChats
//
//  Created by lvjian on 12/17/14.
//  Copyright (c) 2014 lvjian. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *currentUser =
            [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"];

    self.nameLabel.text = [currentUser objectForKey:@"name"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
