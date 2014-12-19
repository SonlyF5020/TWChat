//
//  ViewController.m
//  TWChats
//
//  Created by lvjian on 12/16/14.
//  Copyright (c) 2014 lvjian. All rights reserved.
//

#import "JoinViewController.h"
#import"AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"
#import "MainViewController.h"

@interface JoinViewController ()

@end

@implementation JoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleJoinAction:(id)sender {
    NSString *name = self.nameField.text;
    NSLog(@"your name: %@", name);

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
            @"user[name]" : name,
            @"user[avator_url]" : @"http://tp4.sinaimg.cn/1655973031/180/5672535961/1"
    };

    [manager POST:@"http://192.168.43.69:3000/users.json"
       parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"welcome: %@", [responseObject objectForKey:@"name"]);

                [[NSUserDefaults standardUserDefaults] setObject:responseObject
                                                          forKey:@"currentUser"];
                [[NSUserDefaults standardUserDefaults] synchronize];

                MainViewController *mainController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                    instantiateViewControllerWithIdentifier:@"MainViewController"];

                [self presentViewController:mainController animated:YES completion:nil];

            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
@end
