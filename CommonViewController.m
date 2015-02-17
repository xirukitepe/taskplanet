//
//  CommonViewController.m
//  TaskPlanet
//
//  Created by Shiela S on 2/17/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import "CommonViewController.h"
#import "TableViewController.h"
#import "CreateToDoViewController.h"
#import "SettingsViewController.h"
#import "HomeViewController.h"
#import "NotificationsViewController.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - methods
-(NSArray *)initializeViews{
    TableViewController *tableViewController = [[TableViewController alloc] init];
    //ViewController *greetingView = [[ViewController alloc] init];
    CreateToDoViewController *createToDoController = [[CreateToDoViewController alloc] init];
    UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController: createToDoController];
    UINavigationController *navigationController2 = [[UINavigationController alloc] initWithRootViewController: tableViewController];
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] init];
    UINavigationController *navigationController3 = [[UINavigationController alloc] initWithRootViewController: settingsViewController];
    navigationController1.navigationBar.backgroundColor = [UIColor lightGrayColor];
    NotificationsViewController *notificationsViewController = [[NotificationsViewController alloc] init];
    UINavigationController *navigationController4 = [[UINavigationController alloc] initWithRootViewController: notificationsViewController];
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    NSArray *controllers = [NSArray arrayWithObjects: homeViewController, navigationController1, navigationController2, navigationController4, navigationController3, nil];
    return controllers;
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
